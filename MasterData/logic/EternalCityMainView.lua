-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityMainView.lua

module("logic.extensions.eternalcity.view.EternalCityMainView", package.seeall)

local EternalCityMainView = class("EternalCityMainView", ViewComponent)

function EternalCityMainView:buildUI()
	EternalCityMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._goldBarCon = self:getGo("goldBarCon")
	self._btnBuild = self:getGo("btnBuild")
	self._btnStage = self:getGo("btnStage")
	self._btnPetShop = self:getGo("btnPetShop")
	self._redPointBtnPetShop = self:getGo("btnPetShop/redPoint")
	self._btnShop = self:getGo("jumpBtnCol/btnShop")
	self._btnTask = self:getGo("jumpBtnCol/btnTask")
	self._redBtnTask = self:getGo("jumpBtnCol/btnTask/redPoint")
	self._btnProsperity = self:getGo("jumpBtnCol/btnProsperity")
	self._redPointBtnProsperity = self:getGo("jumpBtnCol/btnProsperity/redPoint")
	self._btnRank = self:getGo("jumpBtnCol/btnRank")
	self._redBtnRank = self:getGo("jumpBtnCol/btnRank/redPoint")
end

function EternalCityMainView:bindEvents()
	EternalCityMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnBuild, self._onClickBtnBuild, self)
	GameUtil.addClickHandler(self._btnStage, self._onClickBtnStage, self)
	GameUtil.addClickHandler(self._btnPetShop, self._onClickBtnPetShop, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
	GameUtil.addClickHandler(self._btnProsperity, self._onClickBtnProsperity, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
end

function EternalCityMainView:unbindEvents()
	EternalCityMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBuild)
	GameUtil.rmClickHandler(self._btnStage)
	GameUtil.rmClickHandler(self._btnPetShop)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnProsperity)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
end

function EternalCityMainView:onEnter()
	EternalCityMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = EternalCityController.instance:getActivityId()
	end

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = EternalCityController.instance:getSubMo(self._activityId)
	self._actData = EternalCityConfig.instance:getActivityData(self._activityId)
	self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)

	RedPointController.instance:regRedPoint(self._redPointBtnPetShop, RedPointModel.ID_ETERNALCITY_PETSHOP)
	RedPointController.instance:regRedPoint(self._redPointBtnProsperity, RedPointModel.ID_ETERNALCITY_PROSPERITY)

	local taskRedId = EventTaskSummaryController.instance:getCurRedIdByActivityId(self._activityId)

	if taskRedId > 0 then
		RedPointController.instance:regRedPoint(self._redBtnTask, taskRedId)
	end

	self.addGEvent(self, GlobalNotify.HandlePM_EternalCityInfoRes, self._onUpdate, self)
	EternalCityController.instance:sendPM_EternalCityInfoReq(self._activityId)
	settimer(30, self._onTicking, self, true)
	self:_onTicking()

	local key = string.format("EternalCityMainView_First_Task_%s", self._activityId)

	GameUtil.doCallbackWhenFirst(key, function()
		self:_onClickBtnTask()
	end)
end

function EternalCityMainView:onExit()
	EternalCityMainView.super.onExit(self)
	removetimer(self._onTicking, self)
	RedPointController.instance:unregRedPoint(self._redPointBtnPetShop)
	RedPointController.instance:unregRedPoint(self._redPointBtnProsperity)
	RedPointController.instance:unregRedPoint(self._redBtnTask)
end

function EternalCityMainView:_onTicking()
	local isCanGainProfit = EternalCityController.instance:isCanGainProfit(self._activityId)

	if isCanGainProfit ~= self._isCanGainProfit then
		self._isCanGainProfit = isCanGainProfit

		EternalCityController.instance:updateRedOfProsperity(self._activityId)
	end
end

function EternalCityMainView:_onUpdate()
	return
end

function EternalCityMainView:_onClickBtnTip()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function EternalCityMainView:_onClickBtnBuild()
	UIStateManager.instance:push(ViewName.EternalCityBagView, self._activityId)
end

function EternalCityMainView:_onClickBtnStage()
	if self._subMo:isPassAllStages() then
		UIStateManager.instance:push(ViewName.EternalCityBossView, self._activityId)
	else
		UIStateManager.instance:push(ViewName.EternalCityStageView, self._activityId)
	end
end

function EternalCityMainView:_onClickBtnPetShop()
	UIStateManager.instance:push(ViewName.EternalCityPetShopView, self._activityId)
end

function EternalCityMainView:_onClickBtnTask()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId)
end

function EternalCityMainView:_onClickBtnProsperity()
	UIStateManager.instance:push(ViewName.EternalCityProsperityView, self._activityId)
end

function EternalCityMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.EternalCityRankView, self._activityId)
end

function EternalCityMainView:_onClickBtnShop()
	local key = string.format("func#191#557#%s", self._activityId)

	GotoMgr.gotoByString(key)
end

return EternalCityMainView
