-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/prelogic/PreLogicInitializer.lua

module("logiccommon.common.prelogic.PreLogicInitializer", package.seeall)

local PreLogicInitializer = class("PreLogicInitializer")

function PreLogicInitializer:init()
	self:_enableHas128()
	self:replaceOSTime()
end

function PreLogicInitializer:replaceOSTime()
	local gameVersionCode = checknumber(BootstrapUtil.getGameVersionCode())

	if (Framework.OSDef.RunOS == Framework.OSDef.IOS or Framework.OSDef.RunOS == Framework.OSDef.Android or nil) and (gameVersionCode == 0 or gameVersionCode > 200) then
		forcePrint(">>>>>>>>>>>>replaceOSTime:ON ,gameVersionCode:", gameVersionCode)
		self:___replaceOSTime()
	else
		forcePrint(">>>>>>>>>>>>replaceOSTime:OFF ,gameVersionCode:", gameVersionCode)
		self:___replaceOSTimeSimple()
	end
end

function PreLogicInitializer:___replaceOSTimeSimple()
	local orig_os_time = os.time

	function os.time(obj)
		local ttt = orig_os_time(obj)

		if ttt == nil and checknumber(obj.year) >= 2038 then
			local tmp = clone(obj)

			tmp.year = 2037
			ttt = orig_os_time(tmp)
		end

		return ttt
	end
end

function PreLogicInitializer:___replaceOSTime()
	local orig_os_time = os.time

	function os.time(obj)
		local ttt = orig_os_time(obj)

		if ttt == nil then
			local dt

			ttt = tonumber(obj and type(obj) == "table" and TimeHelper.GetTimeStampDT(checknumber(obj.year), checknumber(obj.month), checknumber(obj.day), checknumber(obj.hour), checknumber(obj.min), checknumber(obj.sec)) or TimeHelper.GetTimeStampNow())
		end

		return ttt
	end

	local orig_os_date = os.date

	function os.date(str, time)
		local obj = orig_os_date(str, time)

		if obj == nil then
			time = time or os.time()

			local dt

			if string.find(str, "!") == 1 then
				str = string.sub(str, 2)
				dt = TimeHelper.GetDateTime(time)
			else
				dt = TimeHelper.GetDateTimeToLocal(time)
			end

			obj = str == "*t" and {
				isdst = false,
				year = dt.Year,
				month = dt.Month,
				day = dt.Day,
				hour = dt.Hour,
				min = dt.Minute,
				sec = dt.Second,
				yday = dt.DayOfYear,
				wday = TimeHelper.GetDateTimeDayOfWeek(dt)
			} or TimeHelper.GetTimeFormat(dt, str)
		end

		return obj
	end
end

function PreLogicInitializer:_enableHas128()
	local IS_UNITY_CACHE_ENABLE_KEY = "IS_UNITY_CACHE_ENABLE_KEY"

	Framework.LocalStorage.Instance:SetInt(IS_UNITY_CACHE_ENABLE_KEY, 0)
	Framework.ResourceCache.Instance:EnableUnityCachingSystem(false)
end

PreLogicInitializer.instance = PreLogicInitializer.New()

return PreLogicInitializer
