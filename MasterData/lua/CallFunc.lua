
-- 分割字符串
function SplitString(str, p1)
	local r = {}
	
	if str == nil then return r end
	if p1 == nil then p1 = " " end

	local str1 = str
	while str1 do
		local str2 = str1

		local n = string.find(str2, p1)
		if n == nil then r[#r+1] = str2 return r end

		r[#r+1] = string.sub(str2, 1, n-1)
		str1 = string.sub(str2, n+1, #str2)
	end

	return r
end

function GetFunction(func)

	if #func == 1 then 
		--print("22222222222", _G[func[1]], arg)unpack()
		return _G[func[1]]
	elseif #func == 2 and _G[func[1]] then 
		return _G[func[1]][func[2]], _G[func[1]]
	else
		LogError("格式错误")
	end	
end

function CallRecv(func, arg)
    -- Log( func)
    -- Log( arg)
	local tfunc = SplitString(func, ":")
	local fun, obj = GetFunction(tfunc)
    --Log(fun)
	if not fun then 
		Log(func)
		Log(arg)
		return Log( "not function") 
	end 

	--Log(func)
	--Log(arg)

	local result, errmsg
	if obj then 
		result, errmsg = xpcall(fun, function(errmsg) LogError("报错信息:"..(errmsg or "").."\n堆栈:"..debug.traceback()) end,obj, arg)  
	else
		result, errmsg = xpcall(fun, function(errmsg) LogError("报错信息:"..(errmsg or "").."\n堆栈:"..debug.traceback()) end, arg)
	end

	-- if errmsg then LogError("CallRecv errmsg "..errmsg) end
	if not result and errmsg then
		LogError("CallRecv errmsg "..errmsg)
		Log(tfunc)
		Log(arg)
	end

	return errmsg
end

------------------------------------------
-- test
--function LoginGame(proto)
--	print("LoginGame    ", proto.name,  proto.level)
--end

--LoginProto = {}

--function LoginProto:LoginGame(proto)
--	print("LoginProto:LoginGame    ", proto.name,  proto.level)
--end