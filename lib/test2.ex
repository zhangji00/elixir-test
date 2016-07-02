defmodule Test2 do
    defmacro zhangji(args,do_block) do
        quote do 
           IO.puts unquote(args)
        end 
    end
end

