-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miruikeintroduce/view/MiruikeMainView.lua

module("logic.extensions.miruikeintroduce.view.MiruikeMainView", package.seeall)

local MiruikeMainView = class("MiruikeMainView", ViewComponent)

function MiruikeMainView:ctor()
	MiruikeMainView.super.ctor(self)
end

function MiruikeMainView:unbindEvents()
	MiruikeMainView.super.unbindEvents(self)
	self:_removeListeners()
end

function MiruikeMainView:bindEvents()
	MiruikeMainView.super.bindEvents(self)
	self:_addLiteners()
end

function MiruikeMainView:buildUI()
	MiruikeMainView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._container = self:getGo("container")
	self._tabs = {}

	for i = 1, 2 do
		local tab = {}
		local name = "btnTab" .. i
		local go = self:getGo(name)

		tab.btn = self:getBtn(name)

		tab.btn:AddClickListener(function()
			self:_onClickTab(i)
		end)

		tab.selected = goutil.findChild(go, "select")

		table.insert(self._tabs, tab)
	end

	self._activityId = checkint(MiruikeIntroduceConfig.instance:getCommonValue("MAIN_ACT_ID"))
end

function MiruikeMainView:onExit()
	MiruikeMainView.super.onExit(self)
end

function MiruikeMainView:onEnter()
	MiruikeMainView.super.onEnter(self)

	local curPage = self:getFirstParam()

	curPage = curPage and checkint(curPage) or 1

	self:_onClickTab(curPage)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.WelfareSummary, self._activityId)

	self._startTimestamp = startTime

	self:_setActivityTime(startTime, endTime)
	self:_setMoney()
end

function MiruikeMainView:_setActivityTime(startTime, endTime)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function MiruikeMainView:_setGoldBarCon()
	local btn_list = {
		{
			showAdd = false,
			id = GameEnum.GoldType.GodDiamondCoin
		}
	}

	MainUIController.instance:showGlodBar(self.goldBarCon, self._viewPresentor, btn_list)
end

function MiruikeMainView:_removeListeners()
	self._btnTip:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnClose)

	for i = 1, 2 do
		local tab = self._tabs[i]

		tab.btn:RemoveClickListener()
	end
end

function MiruikeMainView:_addLiteners()
	self._btnTip:AddClickListener(self._onClickTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function MiruikeMainView:_onClickTab(index)
	local data = MiruikeIntroduceConfig.instance:getCfgByTab(index)

	self:showTabAt(self._container, data.viewname, data.parameter)

	for i = 1, 2 do
		self._tabs[i].selected:SetActive(i == index)
	end
end

function MiruikeMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "miracleGuide_rule")
end

function MiruikeMainView:_setMoney()
	local btnList = {
		{
			showAdd = false,
			id = GameEnum.GoldType.GodDiamondCoin
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
end

return MiruikeMainView
