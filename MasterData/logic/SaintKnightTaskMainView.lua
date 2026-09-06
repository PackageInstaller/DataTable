-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabframework/view/saintknighttask/SaintKnightTaskMainView.lua

module("logic.extensions.tabframework.view.saintknighttask.SaintKnightTaskMainView", package.seeall)

local SaintKnightTaskMainView = class("SaintKnightTaskMainView", TabFrameWorkMainView)

function SaintKnightTaskMainView:buildUI()
	SaintKnightTaskMainView.super.buildUI(self)

	self._itemTotalGet = goutil.findChild(self.mainGO, "itemTotalGet")
	self._txtItemTotalGet = goutil.findChildTextComponent(self.mainGO, "itemTotalGet/txt")
	self._openTime = goutil.findChild(self.mainGO, "openTime")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._btnWish = goutil.findChild(self.mainGO, "btnWish")
end

function SaintKnightTaskMainView:bindEvents()
	SaintKnightTaskMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnWish, self._onClickBtnWish, self)
end

function SaintKnightTaskMainView:unbindEvents()
	SaintKnightTaskMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnWish)
end

function SaintKnightTaskMainView:onEnter()
	SaintKnightTaskMainView.super.onEnter(self)
	SaintKnightTaskController.instance:sendWorldTasksGetInfoReq(self._frameId)
end

function SaintKnightTaskMainView:_getFrameId()
	return SaintKnightTaskController.instance:getActivityId()
end

function SaintKnightTaskMainView:_onSetUI()
	SaintKnightTaskMainView.super._onSetUI(self)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SaintKnightTask, self._frameId)
	local startDate, endDate = os.date("*t", startTime), os.date("*t", endTime)

	self._txtOpenTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

function SaintKnightTaskMainView:_onUpdateUIEx()
	local curInfo = self:_getHeadTabViewInfo(self._curHeadTabIndex)
	local str = curInfo.data.exTabParams

	self._txtItemTotalGet.text = str

	GameUtil.SetActive(self._itemTotalGet, not string.nilorempty(str))
end

function SaintKnightTaskMainView:_onClickBtnWish()
	local text = lang(SaintKnightTaskConfig.instance:getSktCommonValue("BLESSINGWORD_KEY"))
	local func
	local btnText = "确定"
	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openTipWindow("提示", text, func, btnText, alignment)
end

function SaintKnightTaskMainView:_updateHeadTabCell(mainGo, headTabIndex)
	SaintKnightTaskMainView.super._updateHeadTabCell(self, mainGo, headTabIndex)

	local headInfo = self:_getHeadTabViewInfo(headTabIndex)
	local rec = goutil.findChild(mainGo, "rec")
	local txtRec = goutil.findChildTextComponent(mainGo, "rec/txt")
	local params = headInfo.data.exJsonTabParams

	if params then
		if not params.tabName then
			local tabName = ""

			if string.nilorempty(tabName) then
				GameUtil.SetActive(rec, false)
			else
				txtRec.text = params.tabName

				GameUtil.SetActive(rec, true)
				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rec:GetComponent(goutil.Type_RectTransform))
			end
		end
	end
end

return SaintKnightTaskMainView
