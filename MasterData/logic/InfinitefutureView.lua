-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinitefutureView.lua

module("logic.extensions.infinitefuture.view.InfinitefutureView", package.seeall)

local InfinitefutureView = class("InfinitefutureView", ViewComponent)

InfinitefutureView.PageIndex = nil

function InfinitefutureView:ctor()
	InfinitefutureView.super.ctor(self)
end

function InfinitefutureView:unbindEvents()
	InfinitefutureView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTry:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function InfinitefutureView:bindEvents()
	InfinitefutureView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		self:_resetConstPageIndex()
		self:close()
	end, self)
	self._btnTry:AddClickListener(self._onClickTry, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function InfinitefutureView:buildUI()
	InfinitefutureView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnTry = self:getBtn("btnTry")
	self._btnTip = self:getBtn("btnTip")
	self._container = self:getGo("container")
	self._openDate = self:getTxt("time/txt")
	self._goldBarCon = self:getGo("goldBarCon")
	self._tabs = {}

	for i = 1, 3 do
		local tab = {}
		local name = "btnTab" .. i
		local go = self:getGo(name)

		tab.btn = self:getBtn(name)

		tab.btn:AddClickListener(function()
			self:_onClickTab(i)
		end)

		tab.selected = goutil.findChild(go, "selected")
		tab.redPoint = goutil.findChild(go, "imgPoint")

		table.insert(self._tabs, tab)
	end
end

function InfinitefutureView:onExit()
	InfinitefutureView.super.onExit(self)
end

function InfinitefutureView:setIds()
	InfinitefutureModel.instance.curActId = 123001
	InfinitefutureModel.instance.curPetId = 16005
end

function InfinitefutureView:onEnter()
	InfinitefutureView.super.onEnter(self)

	local curPage = self:getFirstParam()

	self:setIds()

	curPage = curPage and curPage or self:_getConstPageIndex() or 1

	self:_onClickTab(curPage)

	local activityCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.EndlessChallenge, InfinitefutureModel.instance.curActId)
	local startTime = GameUtil.string2date(activityCfg.startTime)
	local endTime = GameUtil.string2date(activityCfg.endTime)

	self._openDate.text = TimeGateController.instance:getActTimeShow(InfinitefutureModel.instance.curActId)

	local objList = {
		{
			showAdd = false,
			id = GameEnum.GoldType.GodDiamondCoin
		},
		{
			id = "4:135",
			showAdd = false
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function InfinitefutureView:_onClickTab(index)
	if index == 1 then
		self:showTabAt(self._container, ViewName.InfinfuchallengeView)
	elseif index == 2 then
		self:showTabAt(self._container, ViewName.InfinfulotteryView)
	elseif index == 3 then
		self:showTabAt(self._container, ViewName.InfinfushopView)
	end

	for i = 1, 3 do
		self._tabs[i].selected:SetActive(i == index)
	end

	InfinitefutureView.PageIndex = index
end

function InfinitefutureView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "infiniteFuture_rule")
end

function InfinitefutureView:_onClickTry()
	FuncOpenController.instance:openFunc(149, InfinitefutureModel.instance.curPetId)
end

function InfinitefutureView:_getConstPageIndex()
	return InfinitefutureView.PageIndex
end

function InfinitefutureView:_resetConstPageIndex()
	InfinitefutureView.PageIndex = nil
end

return InfinitefutureView
