-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/EndlessdragonView.lua

module("logic.extensions.infinitefuture.view.EndlessdragonView", package.seeall)

local EndlessdragonView = class("EndlessdragonView", ViewComponent)
local PageIndex

function EndlessdragonView:ctor()
	EndlessdragonView.super.ctor(self)
end

function EndlessdragonView:unbindEvents()
	EndlessdragonView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTry:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function EndlessdragonView:bindEvents()
	EndlessdragonView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		PageIndex = nil

		self:close()
	end, self)
	self._btnTry:AddClickListener(function()
		FuncOpenController.instance:openFunc(149, 10314)
	end, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "emberlessDragonChapter_rule")
	end, self)
end

function EndlessdragonView:buildUI()
	EndlessdragonView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnTry = self:getBtn("btnTry")
	self._btnTip = self:getBtn("btnTip")
	self._container = self:getGo("container")
	self._openDate = self:getTxt("time/txt")
	self._petVerifyRed = self:getGo("btnPetVerify/redPoint")
	self._goldBarCon = self:getGo("goldBarCon")
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

function EndlessdragonView:onExit()
	EndlessdragonView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._tabs[1].redPoint)
end

function EndlessdragonView:onEnter()
	EndlessdragonView.super.onEnter(self)

	local curPage = self:getFirstParam()

	curPage = curPage and curPage or PageIndex or 1

	self:_onClickTab(curPage)

	self._openDate.text = TimeGateController.instance:getActTimeShow(InfinitefutureModel.instance.endlessActIds[1])

	local objList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.GodDiamondCoin
		},
		{
			id = "4:137",
			showAdd = true
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
	RedPointController.instance:regRedPoint(self._tabs[1].redPoint, RedPointModel.ID_HUD_ENDLESS)
end

function EndlessdragonView:_onClickTab(index)
	if index == 1 then
		self:showTabAt(self._container, ViewName.EndlessdchallengeView)
	elseif index == 2 then
		self:showTabAt(self._container, ViewName.EndlessdlotteryView)
	elseif index == 3 then
		self:showTabAt(self._container, ViewName.EventtasksummaryView, 142002)
	elseif index == 4 then
		self:showTabAt(self._container, ViewName.EndlessbuyskinView)
	end

	for i = 1, 4 do
		self._tabs[i].selected:SetActive(i == index)
	end

	PageIndex = index
end

return EndlessdragonView
