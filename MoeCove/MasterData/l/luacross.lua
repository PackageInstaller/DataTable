
table.unpack = table.unpack or unpack

if _VERSION == "Lua 5.1" then
	local _p = pairs;

	function pairs(t, ...)
		local meta = getmetatable(t)
		local func = _p
		if meta and meta.__pairs and type(meta.__pairs) == "function" then
			func = meta.__pairs
		end
		return func(t, ...)
	end
else
	loadstring = load
end
------------------------ Lua/LuaJit ------------------------
-- if 9^33 == 27^22 then  -- this check is valid for x86/x64 only
--   print("vanilla Lua")
-- else
--   print("LuaJIT")
-- end

------------------------ Lua/LuaJit ------------------------
-- math.randomseed(-999)
-- local dd = math.random()
-- if math.abs(dd - 0.90163884395886) < 0.000000001 then print "lua"
-- else print "luaJit" end

------------------------ Lua Version ------------------------
-- local i_min = 0
-- while arg[ i_min ] do i_min = i_min - 1 end
-- local lua_exe = arg[ i_min + 1 ]

-- local command = lua_exe .. [[ -v 2>&1]] -- Windows-specific
-- local fh = assert( io.popen( command ) )
-- local version = fh:read '*a'
-- fh:close()

-- -- use version in the code below

-- print( version )
-- print( version:match '(%d%.%d%.%d)' )

------------------------ Lua Version ------------------------
-- if _ENV then 
--   print("above Lua 5.2")
-- else
--   print("below Lua 5.1")
-- end