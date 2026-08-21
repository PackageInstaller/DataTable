-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signin/util/WelfareSigninUtil.lua

module("logic.extensions.signin.util.WelfareSigninUtil", package.seeall)

local WelfareSigninUtil = {}

function WelfareSigninUtil.sortSigninMo(orgTable)
	local result = {}

	if orgTable then
		local keyLst = {}

		for k, v in pairs(orgTable) do
			table.insert(keyLst, {
				key = k,
				val = v
			})
		end

		table.sort(keyLst, function(a, b)
			return tonumber(a.val:getActivity()) < tonumber(b.val:getActivity())
		end)

		for key, value in pairs(keyLst) do
			local val = value.val

			table.insert(result, val)
		end
	end

	return result
end

function WelfareSigninUtil.getSignInTitleName(actId)
	local name = ""

	if actId == WelfareSigninEnum.DailySignActId then
		name = lang("tip_sign_title_normal")
	else
		name = lang("tip_sign_title_seven")
	end

	return name
end

function WelfareSigninUtil.getSignInActFormula(actId)
	local formula = 0

	if actId == WelfareSigninEnum.DailySignActId then
		formula = WelfareSigninConfig.instance:getConstByKey("DailySignInLandladyFormula")
	else
		local actMo = ActivityModel.instance:getActivityById(actId)

		if actMo then
			formula = actMo:getConfigId()
		else
			formula = 2
		end
	end

	return formula
end

function WelfareSigninUtil.getSignInActRemainTime(actId)
	local day, hour, minute, second = 0, 0, 0, 0
	local currentTime = ServerTime.now()
	local endTime
	local actMo = ActivityModel.instance:getActivityById(actId)

	if actMo then
		endTime = actMo:getSignInActEndTime()
	else
		endTime = nil
	end

	if endTime then
		local leftTime = endTime - currentTime

		day = math.floor(leftTime / 86400)
		hour = math.floor((leftTime - day * 86400) / 3600)
		minute = math.floor((leftTime - day * 86400 - hour * 60 * 60) / 60)
		second = leftTime - day * 86400 - hour * 60 * 60

		printWarn(string.format("<color=#00C864>签到活动[%s]，endTime[%s],currentTime[%s],day[%s]hour[%s]minute[%s]</color>", actId, endTime, currentTime, day, hour, minute))
	else
		printWarn(string.format("<color=#00C864>无法找到签到活动[%s]，剩余时间将返回0</color>", actId))
	end

	return day, hour, minute, second
end

function WelfareSigninUtil.getSignInActIsOpen(actId)
	if not WelfareUtil.isSystemOpen() then
		return false
	end

	if actId == WelfareSigninEnum.DailySignActId then
		local systemKey = GameEnum.SystemEnum.WelfareSignInDaily

		return SystemOpenFacade.instance:isOpen(systemKey, false)
	else
		local actMo = ActivityModel.instance:getActivityById(actId)

		if actMo then
			return actMo:getIsOpen()
		else
			return false
		end
	end
end

function WelfareSigninUtil.fakeSignIn(actId)
	local maxSigned = 7

	if actId == WelfareSigninEnum.DailySignActId then
		maxSigned = 28
	end

	local curMo = WelfareSigninModel.instance:getSignInMo(actId)
	local totalSigned = curMo:getTotalSigned()

	if maxSigned <= totalSigned then
		return
	end

	print("<color=#00C864>假装签到了一天</color>")

	local params = {
		optType = actId == WelfareSigninEnum.DailySignActId and GameEnum.OptionType.SIGN_IN_DAILY or GameEnum.OptionType.SIGN_IN_HISTORY,
		actualAddItems = {}
	}

	table.insert(params.actualAddItems, ItemData.New({
		itemId = 1002001,
		count = 1
	}))
	GlobalDispatcher:dispatchEvent(EventType.GAIN_ITEM_ADD_EVENT, params)
	curMo:fakeSign()
	WelfareSigninModel.instance:updateSigninInfoFromClient(curMo, true)
end

function WelfareSigninUtil.fakeCreateSignAct(actId, logicType, planId)
	printError("假装 签到活动 增加->", actId)

	local nowTime = ServerTime.now()
	local endTime = nowTime + 604800 - 3670
	local logic = logicType

	WelfareUtil.fakeCreateActivity(actId, logic, planId, nowTime, endTime, "")

	local fakeSevenDay = WelfareSigninMo.New()

	fakeSevenDay:createFakeData(actId)
	WelfareSigninModel.instance:updateSigninInfoFromClient(fakeSevenDay, true)
end

function WelfareSigninUtil.client2ServerDay(day)
	return day - 1
end

function WelfareSigninUtil.server2ClientDay(day)
	return day + 1
end

return WelfareSigninUtil
