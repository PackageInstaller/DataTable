local this = {};


function this:GetDelayUtil()
	if(not self.delayUtil) then
		local go = CSAPI.CreateGO("DelayUtil");
		self.delayUtil = ComUtil.GetLuaTable(go);
	end
	
	return self.delayUtil;
end

--计时器
--delay：首次调用延迟
--interal：两次调用间隔
--count：调用次数。负数：无限
function this:Timer(func, caller, delay, interal, count, param1, param2, param3, param4, param5)
	if(func == nil) then
		LogError("调用方法为空，强行报错");
		LogError(a.b);
	end
	
	local go = CSAPI.CreateGO("LuaTimer");
	self.luaArr = self.luaArr or {};
	local lua = self.luaArr[go];
	if(not lua) then
		lua = ComUtil.GetLuaTable(go);
		self.luaArr[go] = lua;
	end
	
	lua.Timer(func, caller, delay, interal, count, param1, param2, param3, param4, param5);
	
	return lua;
end


function this:Call(func, caller, delay, param1, param2, param3, param4, param5)
	if(func == nil) then
		LogError("调用方法为空，强行报错");
		LogError(a.b);
	end
	
	local delayUtil = self:GetDelayUtil();
	delayUtil.DelayCall(func, caller, delay, param1, param2, param3, param4, param5);
	
	--    local go = CSAPI.CreateGO("LuaDelayCaller");
	--    self.luaArr = self.luaArr or {};
	--    local lua = self.luaArr[go];
	--    if(not lua)then
	--        lua = ComUtil.GetLuaTable(go);
	--        self.luaArr[go] = lua;
	--    end
	--    lua.ApplyCall(func,caller,delay,param1,param2,param3,param4,param5);
end

function this:ApplyCallBackFunc(func, caller, param1, param2, param3, param4, param5)
	if(func == nil) then
		LogError("调用方法为空，强行报错");
		LogError(a.b);
	end
	
	local go = CSAPI.CreateGO("LuaDelayCaller");
	self.luaArr = self.luaArr or {};
	local lua = self.luaArr[go];
	if(not lua) then
		lua = ComUtil.GetLuaTable(go);
		self.luaArr[go] = lua;
	end
	lua.SetCall(func, caller, param1, param2, param3, param4, param5);
	return lua;
end

--两个列表是否相同
function this.TableListIsSame(tabList1, tabList2)
	if(tabList1 ~= nil and tabList2 ~= nil) then
		local count1 = 0
		for i, v in pairs(tabList1) do
			count1 = count1 + 1
		end
		local count2 = 0
		for i, v in pairs(tabList2) do
			count2 = count2 + 1
		end
		--比较长度
		if(count1 ~= count2) then
			return false
		else
			--比较内容
			for i, v in pairs(tabList1) do
				if(tabList2[i] ~= nil) then
					local isSame = this.TableIsSame(v, tabList2[i])
                    if(not isSame) then
                        return false
                    end
				else
					return false
				end		
			end
			return true
		end
	else
		return false
	end
end
--[[
--两个table是否相同(不判断函数)
function this.TableIsSame(tab1, tab2)
	if(tab1 ~= nil and tab2 ~= nil) then
		for i, v in pairs(tab1) do
			if(tab2[i] ~= nil) then
				local isSame = true
				if(type(v) == "number") or(type(v) == "string") or(type(v) == "boolean") then
					isSame = tab2[i] == v
				elseif(type(v) == "table") then
					isSame = this.TableIsSame(v, tab2[i])
				end
				if(not isSame) then
					return false
				end
			else
				return false
			end
		end
		return true
	else
		return false
	end
end
]]
--两个table是否相同
function this.TableIsSame(a, b)
    if a == b then return true end  -- 同一个地址
    if type(a)~='table' or type(b)~='table' then return false end

    -- 遍历 a 的所有键
    for k, v in pairs(a) do
        if not this.TableIsSame(v, b[k]) then
            return false
        end
    end

    -- 检查 b 有没有多出来的键
    for k, v in pairs(b) do
        if not this.TableIsSame(v, a[k]) then
            return false
        end
    end

    return true
end

--翻转列表 
function this.Reverse(datas)
	local len = #datas
	for i = 0, (len-1)/2 do
        local temp = datas[i+1]
        datas[i+1] = datas[len-i]
        datas[len-i] = temp 
    end
    return datas
end

--数值 保留2为小数
function this.Round2Num(num)
    if(num and num ~= 0) then 
        return math.floor(num * 100 + 0.5) / 100
    end 
    return num 
end

return this; 