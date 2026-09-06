-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyparty/controller/FamilyPartyController.lua

module("logic.extensions.familyparty.controller.FamilyPartyController", package.seeall)

local FamilyPartyController = class("FamilyPartyController", BaseController)

function FamilyPartyController:ctor()
	return
end

function FamilyPartyController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.FamilyPartyNotifyPartyBeginRes, self._onNotifyPartyBeginRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilyPartyNotifyPartyEndRes, self._onNotifyPartyEndRes, self)
	GlobalDispatcher:addListener(FamilyController.GetMyFamilySimpleDataRes, self._onGetMyFamilySimpleInfoRes, self)
end

function FamilyPartyController:onReset()
	return
end

function FamilyPartyController:_onNotifyPartyBeginRes()
	FloatWordMgr.instance:show("家族宴会开启成功")
	printInfo("test 家族宴会开启成功")

	local partyTimeMillis = FamilyPartyModel.instance:getPartyStartTime()

	self:showPartyInMainUI(partyTimeMillis)
end

function FamilyPartyController:_onNotifyPartyEndRes()
	FloatWordMgr.instance:show("家族宴会结束")
	printInfo("test 家族宴会结束")
	self:closePartyInMainUI()
end

function FamilyPartyController:_onGetMyFamilySimpleInfoRes(msg)
	local startTime = self:getSettingPartyStartTime()

	FamilyPartyModel.instance:setPartyTimeMillis(startTime * 1000)

	local partyTimeMillis = FamilyPartyModel.instance:getPartyStartTime()

	self:showPartyInMainUI(partyTimeMillis)
end

function FamilyPartyController:showPartyInMainUI(showTime)
	local isActivated = true
	local endTime = showTime + checknumber(FamilyPartyConfig.instance:getCommonValue("PARTY_PERIOD_MINUTES")) * 60

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_FAMILY_PARTY, isActivated, true, showTime, endTime)
end

function FamilyPartyController:closePartyInMainUI()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_FAMILY_PARTY, false)
end

function FamilyPartyController:onClickFamilyPartyTab()
	if FamilyPartyModel.instance:isPartyOpening() then
		FloatWordMgr.instance:show("已在宴会场景")
	else
		FloatWordMgr.instance:show("宴会未开启")
	end
end

function FamilyPartyController:getSettingPartyStartTime()
	local str = FamilyPartyConfig.instance:getCommonValue("FIXED_OPEN_PARTY_DAY_TIME")
	local arr = string.split(str, "@")
	local openWeekStr = arr[1]
	local openTimeStr = arr[2]
	local hourAndMinute = string.split(openTimeStr, ":")
	local weekIndexList = string.split(openWeekStr, "#")
	local settingHour = checknumber(hourAndMinute[1])
	local settingMinute = checknumber(hourAndMinute[2])
	local duration = checknumber(FamilyPartyConfig.instance:getCommonValue("PARTY_PERIOD_MINUTES"))
	local curTimestamp = ServerTime.now()
	local curDate = GameUtil.time2date(curTimestamp)
	local startWDay = curDate.wday
	local endWDay = curDate.wday + 6
	local addDay = 0

	for i = startWDay, endWDay do
		local tempWDay = (i - 1) % 7 + 1

		for j, weekIndex in ipairs(weekIndexList) do
			local wday = weekIndex % 7 + 1
			local isEqualWeek = tempWDay == wday

			if isEqualWeek then
				local settingEndTime = GameUtil.date2time(curDate.year, curDate.month, curDate.day + addDay, settingHour, settingMinute + duration, 0)

				if curTimestamp < settingEndTime then
					return (GameUtil.date2time(curDate.year, curDate.month, curDate.day + addDay, settingHour, settingMinute, 0))
				end
			end
		end

		addDay = addDay + 1
	end

	return 0
end

FamilyPartyController.instance = FamilyPartyController.New()

return FamilyPartyController
