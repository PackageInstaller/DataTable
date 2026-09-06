-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/FiredragonView.lua

module("logic.extensions.infinitefuture.view.FiredragonView", package.seeall)

local FiredragonView = class("FiredragonView", ViewComponent)
local PageIndex

function FiredragonView:ctor()
	FiredragonView.super.ctor(self)
end

function FiredragonView:unbindEvents()
	FiredragonView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._wishBtn:RemoveClickListener()
end

function FiredragonView:bindEvents()
	FiredragonView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		PageIndex = nil

		self:close()
	end, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "fireDimensionDragon_rule")
	end, self)
	self._wishBtn:AddClickListener(self.onCLickWish, self)
end

function FiredragonView:buildUI()
	FiredragonView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._container = self:getGo("container")
	self._openDate = self:getTxt("time/txt")
	self._goldBarCon = self:getGo("goldBarCon")
	self._wishBtn = self:getBtn("wishBtn")
	self._tabs = {}

	for i = 1, 4 do
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

function FiredragonView:onExit()
	FiredragonView.super.onExit(self)
end

function FiredragonView:onEnter()
	FiredragonView.super.onEnter(self)

	local curPage = self:getFirstParam()

	curPage = curPage and curPage or PageIndex or 1

	self:_onClickTab(curPage)

	local activityId = 123006

	self._openDate.text = TimeGateController.instance:getActTimeShow(activityId)

	local objList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.GodDiamondCoin
		},
		{
			showAdd = true,
			id = InfinitefutureConfig.instance:getCommonCfg("challenge_currency")
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function FiredragonView:_onClickTab(index)
	if index == 1 then
		self:showTabAt(self._container, ViewName.FiredragonchallengeView)
	elseif index == 2 then
		self:showTabAt(self._container, ViewName.FiredragonlotteryView)
	elseif index == 3 then
		local actid = checknumber(InfinitefutureConfig.instance:getCommonCfg("activity_task"))

		self:showTabAt(self._container, ViewName.EventtasksummaryView, actid)
	elseif index == 4 then
		self:showTabAt(self._container, ViewName.EndlessbuyskinView)
	end

	for i = 1, 4 do
		self._tabs[i].selected:SetActive(i == index)
	end

	PageIndex = index
end

function FiredragonView:onCLickWish()
	local curActId = checknumber(InfinitefutureConfig.instance:getCommonCfg("activity_luck_draw_firedragon"))
	local actType = math.floor(curActId / 1000)
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(actType, curActId)

	if isInTime then
		FuncOpenController.instance:openFunc(191, actType, curActId)
	end
end

return FiredragonView
