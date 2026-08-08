
-- 公共逻辑处理

local Player = require "Player_dataConvert"
require "CommonConstant"

CommonLogic = {}

local initUnitSettings = {
	aid = 0,
	sex = 0,
	name = "",
	head = 0,
	borntime = 0,
}

function CommonLogic.LoadPlayerInitSettings()
	return clone(initUnitSettings)
end

function CommonLogic.CheckNameLegal(name)
	name = name:trim()
	local len = name:utflen()
	LuaLogger.d("%d %d", len, Config.VipMaxNameLen)
	if len > Config.VipMaxNameLen then
		return false, ActionFailReason.NameTooLong
	elseif len < Config.MinNameLen then
		return false, ActionFailReason.NameTooShort
	end

	return true
end

function CommonLogic.CopyPropsByKey(src, dest, keys)
	for i,v in ipairs(keys) do
		dest[v] = src[v]
	end

	return dest
end

function CommonLogic.CopyProps(src, dest, func)
	if func then
		for k,v in pairs(src) do
			if func(k, v) then
				dest[k] = v
			end
		end
	else
		for k,v in pairs(src) do
			dest[k] = v
		end
	end

	return dest
end

function CommonLogic.CopyPropsWithCon(src, dest, con)
	return CommonLogic.CopyProps(src, dest, function (key, value)
    	local v = Player.SerialiseValues[key]
        return v and v[con]
	end)
end

function CommonLogic.GetPropsWithCon(src, con)
	return CommonLogic.CopyPropsWithCon(src, {}, con)
end

-- mgr表示是manager那里过来的命令
function CommonLogic.GMProcess(processor, str, user, mgr)
	local array = str:split(" ")
	local cmdCnt = #array
	
	if cmdCnt == 0 then
		return false, ActionFailReason.GmNoCommand
	end
	local cmdName = array[1]
	if cmdName:startswith(".") and cmdName:len() > 1 then
		cmdName = cmdName:sub(2)
		local cmd = processor[cmdName]
    	local ok, res, notifymsg
		if cmd then
			if mgr or processor.IsLevelValid(cmdName, user.gmLevel) then
	        	ok, res, notifymsg = cmd(user, select(2, table.unpack(array)))
	        else
	        	return false, ActionFailReason.GmNotEnoughLevel
	        end
	    else
	        return false, ActionFailReason.GmNoCommand
	    end

        return ok, res, notifymsg
	end

	return false, ActionFailReason.GmNoEnoughParam
end

-- function CommonLogic.GetBattleSimData(battleData, user)
-- 	local friends, i1 = getBattleUnits(battleData.friends, user)
-- 	local enemies, i2 = getBattleUnits(battleData.enemies, user)
-- 	local operateIndex = i1 or i2
-- 	local battleSimData = { friends = friends, enemies = enemies, operateIndex = operateIndex }

-- 	return battleSimData
-- end

function CommonLogic.GetResInfo(res)
	local str = ""
	if res.ret and res.ret ~= ActionFailReason.None then
		str = Config.GetFailReasonStr(res.ret) -- "Res:" ..
	end

	if res.info and res.info:len() > 0 then
		str = string.format("%s info:%s", str, res.info)
	end

	return str
end

function CommonLogic.GetErr(ret, info)
	if istable(ret) then
		return ret
	else
		return { ret = ret or ActionFailReason.None, info = info or "0" }
	end
end

function CommonLogic.GetIncludeErr(ret, info)
	return { res = CommonLogic.GetErr(ret, info) }
end

function CommonLogic.IsRetOk(ret)
	return not ret or ret == ActionFailReason.None
end

--通用比较方法
---@param value1 any 比对值1
---@param value2 any 比对值2
---@param type integer 比对类型
---@return boolean
function CommonLogic.CompareTwoValue(value1, value2, type)
	if (type == GE.ConditionCompareType.Equal) then
		return value1 == value2
	elseif (type == GE.ConditionCompareType.Bigger) then
		return value1 > value2
	elseif (type == GE.ConditionCompareType.BiggerOrEqual) then
		return value1 >= value2
	elseif (type == GE.ConditionCompareType.Smaller) then
		return value1 < value2
	elseif (type == GE.ConditionCompareType.SmallerOrEqual) then
		return value1 <= value2
	elseif (type == GE.ConditionCompareType.NotEqual) then
		return value1 ~= value2
	-- elseif (type == GE.ConditionCompareType.Invert) then
	-- 	return not (value1 == value2)
	else
		LuaLogger.ds("CommonLogic.CompareTwoValue wrong ConditionCompareType", type)
		return false
	end
end

return CommonLogic