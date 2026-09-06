-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/view/OriginDreamTeamSaintKnightTabExt.lua

module("logic.extensions.groupregress.view.OriginDreamTeamSaintKnightTabExt", package.seeall)

local OriginDreamTeamSaintKnightTabExt = class("OriginDreamTeamSaintKnightTabExt")

function OriginDreamTeamSaintKnightTabExt:ctor(ownerView)
	self._ownerView = ownerView
end

function OriginDreamTeamSaintKnightTabExt:buildUI()
	local ownerView = self._ownerView

	self._btnWish = ownerView:getGo("btnWish")
	self._openTime = ownerView:getGo("openTime")
	self._txtOpenTime = ownerView:getTxt("openTime/txt")
	self._itemTotalGet = ownerView:getGo("itemTotalGet")
	self._txtItemTotalGet = ownerView:getTxt("itemTotalGet/txt")

	GameUtil.SetActive(self._itemTotalGet, false)
end

function OriginDreamTeamSaintKnightTabExt:bindEvents()
	GameUtil.addClickHandler(self._btnWish, self._onClickBtnWish, self)
end

function OriginDreamTeamSaintKnightTabExt:unbindEvents()
	GameUtil.rmClickHandler(self._btnWish)
end

function OriginDreamTeamSaintKnightTabExt:onAfterEnterFrame()
	self:_updateOpenTime()

	local activityId = self:_getSaintKnightTaskActivityId()

	if activityId > 0 then
		SaintKnightTaskController.instance:sendWorldTasksGetInfoReq(activityId)
	end
end

function OriginDreamTeamSaintKnightTabExt:onUpdateRightEx(tabData)
	local data = tabData and tabData.data

	if data then
		if not data.exTabParams then
			local str = ""

			if self._txtItemTotalGet then
				self._txtItemTotalGet.text = str
			end

			GameUtil.SetActive(self._itemTotalGet, not string.nilorempty(str))
		end
	end
end

function OriginDreamTeamSaintKnightTabExt:onUpdateTabCellEx(view, cell, tabData, tag)
	local data = tabData and tabData.data
	local params = data and data.exJsonTabParams

	if params then
		if not params.tabName then
			local tabName = ""
			local newTag = goutil.findChild(cell, "newTag")
			local txtTag = goutil.findChildTextComponent(cell, "newTag/txtTag")

			if txtTag then
				txtTag.text = tabName
			end

			GameUtil.SetActive(newTag, not string.nilorempty(tabName))
		end
	end
end

function OriginDreamTeamSaintKnightTabExt:_onClickBtnWish()
	local text = lang(SaintKnightTaskConfig.instance:getSktCommonValue("BLESSINGWORD_KEY"))
	local btnText = "确定"
	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openTipWindow("提示", text, nil, btnText, alignment)
end

function OriginDreamTeamSaintKnightTabExt:_updateOpenTime()
	local activityId = self:_getSaintKnightTaskActivityId()

	if activityId <= 0 then
		GameUtil.SetActive(self._openTime, false)

		return
	end

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SaintKnightTask, activityId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	self._txtOpenTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)

	GameUtil.SetActive(self._openTime, true)
end

function OriginDreamTeamSaintKnightTabExt:_getSaintKnightTaskActivityId()
	return SaintKnightTaskController.instance:getActivityId()
end

return OriginDreamTeamSaintKnightTabExt
