defmodule Uninstall do 
    require Amnesia
    use Amnesia
    def delete do 
        IO.puts "delete the existed db.."
        IO.inspect Amnesia.start
        IO.inspect Database.destroy
        IO.inspect Amnesia.stop
        IO.inspect Amnesia.Schema.destroy
    end
end 
defmodule Install do
    require Amnesia
    use Amnesia
    import Uninstall
    def init do 
        case Amnesia.Schema.create do
           {:error,_} -> 
                         delete
                         IO.inspect Amnesia.start 
                         IO.inspect Database.create(disk: [node]) # or for RAM – Database.create(ram: [node])
                         IO.inspect Database.wait
                         IO.puts "successful done" 
            :ok ->
                     IO.inspect Amnesia.start 
                     IO.inspect Database.create(disk: [node]) # or for RAM – Database.create(ram: [node])
                     IO.inspect Database.wait
                     IO.puts "successful done" 
        end 
    end
end 
defmodule Test1Test do
  use ExUnit.Case
  use Database
  # import Test1
  require  Test2#Test2 是自己定义的，在使用前就必须require,暂时不知道原因
  import HTTPotion
  import Loop
  import Install
  doctest Test1
  test "test for my test" do
    init 
    Amnesia.transaction do
        %Battery{timestamp: 0, percentage: 67, status: "Charging"} |> Battery.write
        r = %Battery{timestamp: 12, percentage: 75, status: "Discharging"} 
        r |> Battery.write 
        # is equal to
        # Battery.write(r)
    end
    Amnesia.transaction do
        IO.inspect Battery.read(0)      
        IO.inspect Battery.read(12)       
    end
    IO.inspect "module is #{__MODULE__}"
    IO.puts "enviroment is #{inspect __ENV__}"
    r = get "www.baidu.com"#instead to use HTTPotion.get,its ok to do like this 
    IO.inspect r.status_code
    IO.puts "test my test for the first time"  
    Test1.zhang 1 do#这里就不需要import或者require
         1 -> IO.puts "my first macro definition congratulation!,now you can use the macro in elixir have fun with it"
         _ -> IO.puts "nothing"
    end 
    Test2.zhangji 123 do 
    end 
    # while 1,do: IO.puts "while...."
    #函数式编程语言不能改变变量状态，所以不能在while循环内部增减条件变量的值以退出循环
    while count do#除非count是圧栈式的弹出变量，否则与1无异，也就是说count决定不了while的退出
       #IO.puts "this is macro test,it will print 10 times"
       # count=count-1 不能这样来跳出循环
       # IO.puts count
       # if count==0,do: break
       #break       
       Enum.each 1..10,fn x ->
          :timer.sleep 10
          IO.puts "this is a  macro test,it will be printed 10 times"
       if x==10,do: break#这里的break其实就是Loop模块的break函数
       end       
    end
    map=%Usr{}
    IO.inspect map
    map1=%Usr{a: 2}
    IO.inspect map1
    map2=%{map|a: 3}# | 使用来更新map用的
    IO.inspect map2
    assert 1 + 1 == 2
  end
  def count,do: 1
  # def count,do: [Enum.each(10..0,fn x ->IO.puts(x)  end)]
end
