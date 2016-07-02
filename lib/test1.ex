defmodule Test1 do
    defmacro zhang(args,do_block) do
        quote do 
            case unquote(args),unquote(do_block)
        end 
    end
end
defmodule Loop do 
    defmacro while(expr,do_block)do
        quote do
             try do
                 for _ <- Stream.cycle([:ok]) do
                      if unquote(expr),do: [unquote(do_block)],else: [Loop.break]
                 end
             catch :break -> :ok
             end
        end
    end
   def break,do: throw(:break)
end
defmodule Usr do
    defstruct a: 1,b: 2,c: 3
end

