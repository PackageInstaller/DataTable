-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InflamedMotherView.lua

module("logic.extensions.infinitefuture.view.InflamedMotherView", package.seeall)

local InflamedMotherView = class("InflamedMotherView", ViewComponent)
local PageIndex

function InflamedMotherView:ctor()
	InflamedMotherView.super.ctor(self)

	self._curActId = 112008
end

function InflamedMotherView:unbindEvents()
	InflamedMotherView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTry:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	GameUtil.rmClickHandler(self.wishBtn)
end

function InflamedMotherView:bindEvents()
	InflamedMotherView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		PageIndex = nil

		self:close()
	end, self)
	self._btnTry:AddClickListener(function()
		FuncOpenController.instance:openFunc(149, 10314)
	end, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "inflamedmothChapter_rule")
	end, self)
	GameUtil.addClickHandler(self.wishBtn, self.onCLickWish, self)
end

function InflamedMotherView:buildUI()
	InflamedMotherView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnTry = self:getBtn("btnTry")
	self._btnTip = self:getBtn("btnTip")
	self._container = self:getGo("container")
	self._openDate = self:getTxt("time/txt")
	self._petVerifyRed = self:getGo("btnPetVerify/redPoint")
	self._goldBarCon = self:getGo("goldBarCon")
	self.wishBtn = self:getGo("wishBtn")
	self._tabs = {}

	for i = 1, 4 do
		local tab = {}
		local name = "btnTab" .. i
		local go = self:getGo(name)

		tab.btn = self:getBtn(name)

		tab.btn:RemoveClickListener()
		tab.btn:AddClickListener(function()
			self:_onClickTab(i)
		end)

		tab.selected = goutil.findChild(go, "selected")
		tab.redPoint = goutil.findChild(go, "imgPoint")

		table.insert(self._tabs, tab)
	end
end

function InflamedMotherView:onExit()
	InflamedMotherView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._tabs[1].redPoint)
	RedPointController.instance:unregRedPoint(self._tabs[3].redPoint)
end

function InflamedMotherView:onEnter()
	InflamedMotherView.super.onEnter(self)

	local curPage = self:getFirstParam()

	curPage = curPage and curPage or PageIndex or 2

	self:_onClickTab(curPage)

	self._openDate.text = TimeGateController.instance:getActTimeShow(self._curActId)

	local objList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.GodDiamondCoin
		},
		{
			showAdd = true,
			id = InfinitefutureConfig.instance:getCommonCfg("challenge_currency_weileita")
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
	RedPointController.instance:regRedPoint(self._tabs[1].redPoint, RedPointModel.ID_VIRETA_CHALLENGE)
	RedPointController.instance:regRedPoint(self._tabs[3].redPoint, 280)
	self:_firstOpenActivity()
end

function InflamedMotherView:_firstOpenActivity()
	local plotId = 4270003

	if not GameUtil.getUserData("InflamedMotherVieweplotid" .. plotId) then
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, plotId, StoryModel.StoryType.SCCopy)
		GameUtil.saveUserData("InflamedMotherVieweplotid" .. plotId, "1")
	end
end

function InflamedMotherView:_onClickTab(index)
	if index == 1 then
		self:showTabAt(self._container, ViewName.InflameChallengeView)
	elseif index == 2 then
		self:showTabAt(self._container, ViewName.InflamedlotteryView)
	elseif index == 3 then
		self:showTabAt(self._container, ViewName.EventtasksummaryView, 142004)
	elseif index == 4 then
		self:showTabAt(self._container, ViewName.EndlessbuyskinView)
	end

	for i = 1, 4 do
		self._tabs[i].selected:SetActive(i == index)
	end

	PageIndex = index
end

function InflamedMotherView:onCLickWish()
	local actType = math.floor(self._curActId / 1000)
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(actType, self._curActId)

	if isInTime then
		FuncOpenController.instance:openFunc(191, actType, self._curActId)
	end
end

return InflamedMotherView
