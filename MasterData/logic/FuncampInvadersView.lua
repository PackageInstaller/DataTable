-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/FuncampInvadersView.lua

module("logic.extensions.funcamp.view.FuncampInvadersView", package.seeall)

local FuncampInvadersView = class("FuncampInvadersView", ViewComponent)

function FuncampInvadersView:ctor()
	FuncampInvadersView.super.ctor(self)
end

function FuncampInvadersView:unbindEvents()
	FuncampInvadersView.super.unbindEvents(self)
	self._findBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
	self._addTimes:RemoveClickListener()
end

function FuncampInvadersView:bindEvents()
	FuncampInvadersView.super.bindEvents(self)
	self._findBtn:AddClickListener(self._onClickFind, self)
	self._addTimes:AddClickListener(self._onclickAddTimes, self)
	self._closeBtn:AddClickListener(function()
		self:close()
	end)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "funcampinvadersview_rule")
	end)
end

function FuncampInvadersView:onExit()
	FuncampInvadersView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampFindNpc, self._startFind, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampBuyTimeRes, self.refreshTxt, self)
	GlobalDispatcher:removeListener(GlobalNotify.FunCampGetPlayInfoRes, self.refreshTxt, self)
end

function FuncampInvadersView:buildUI()
	FuncampInvadersView.super.buildUI(self)

	self._findBtn = self:getBtn("findBtn")
	self._closeBtn = self:getBtn("btnClose")
	self._addTimes = self:getBtn("times/addTimes")
	self._tipsBtn = self:getBtn("btnTips")
	self._times = self:getTxt("times")
	self._goldBarCon = self:getGo("goldBarCon")
	self.tableview = self:getGo("reward/tableview")
	self.cell = self:getGo("reward/cell")
	self._scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function FuncampInvadersView:onEnter()
	FuncampInvadersView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampFindNpc, self._startFind, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampBuyTimeRes, self.refreshTxt, self)
	GlobalDispatcher:addListener(GlobalNotify.FunCampGetPlayInfoRes, self.refreshTxt, self)
	self:_setCurrency()
	FunCampController.instance:overRemoveNpc()

	self._activityId = FunCampModel.instance:getActivityId()

	FunCampAgent.instance:sendPM_CB_GetInfoReq(self._activityId)
	FunCampAgent.instance:sendPM_CB_GetPlayInfoReq(self._activityId)

	self._actId = FunCampModel.instance:getActivityId()

	local actCfg = FunCampNpcConfig.instance:getCfgById(self._actId)

	self._cfgActivity = FunCampConfig.instance:getActivityCfg(self._actId)
	self._prizeViewPlanId = self._cfgActivity.prizeViewPlanId
	self._maxTimes = actCfg.dailyTimes

	self:refreshTxt()
	self:_setRewardPreview()
	self:isCloseAddBtn()
end

function FuncampInvadersView:_setCurrency()
	local currency = CampGameConfig.instance:getParams("CURRENCY")
	local infos = string.split(currency, "#")
	local objList = {}

	for i, v in ipairs(infos) do
		local param = {
			showAdd = true,
			id = v
		}

		table.insert(objList, param)
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function FuncampInvadersView:GotoNpcCrossScene(npcId, onfinished, onfinishedObj)
	if TaskController.instance._escortCallBack then
		return
	end

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	TaskController.instance:foreceClearState()

	if mainPlayer then
		mainPlayer:gotoNpcCrossSceneWithFullScenePath(npcId)
	end
end

function FuncampInvadersView:_onClickFind()
	local curGameTime = FunCampModel.instance:getIntrusionTimes()
	local maxGameTime = FunCampModel.instance:getMaxIntrusionBuyTimes(self._maxTimes)

	if maxGameTime <= curGameTime then
		FloatWordMgr.instance:show("游戏次数已用尽，请先购买游戏次数")

		return
	end

	if FunCampModel.instance:getCurSceneId() <= 0 then
		FunCampController.instance:sendPM_CB_FindReq(self._activityId)
	else
		self:_startFind()
	end
end

function FuncampInvadersView:_startFind()
	FunCampController.instance:startFind()
end

function FuncampInvadersView:_onclickAddTimes()
	local curGameTime = FunCampModel.instance:getIntrusionTimes()
	local maxGameTime = FunCampModel.instance:getMaxIntrusionBuyTimes(self._maxTimes)
	local maxBuyTime = FunCampNpcConfig.instance:getGameBuyMax()
	local isLeftTime = curGameTime < maxGameTime

	if isLeftTime then
		FloatWordMgr.instance:show("次数用完才可购买哦")

		return
	elseif maxGameTime >= maxBuyTime + checknumber(self._maxTimes) then
		FloatWordMgr.instance:show("已经没有购买次数了")

		return
	end

	local buyTimes = FunCampModel.instance:getIntrusionBuyTimes()
	local cfg = FunCampNpcConfig.instance:getGameBuyCost(buyTimes + 1)
	local type, id, count = MaterialMgr.getMatParams(cfg.cost)
	local content = langPara("是否花费%s*%s购买入侵次数？", MaterialMgr.getMaterialsName(type, id), count)

	TipsFacade.instance:openPopupCostMatViewNew(type, id, count, content, function()
		FunCampAgent.instance:sendPM_CB_BuyTimeReq(self._activityId, FunCampModel.BuyType2)
	end)
end

function FuncampInvadersView:refreshTxt()
	local todayTimes = FunCampModel.instance:getIntrusionTimes()
	local todayAllTimes = FunCampModel.instance:getMaxIntrusionBuyTimes(self._maxTimes)

	self._times.text = langPara("今日次数：%s/%s", todayAllTimes - todayTimes, self._maxTimes)
end

function FuncampInvadersView:_setRewardPreview()
	local cfgStr = FunCampConfig.instance:getPrizeStr(self._prizeViewPlanId, "PRIZE_INTRUDER")
	local list = MaterialMgr.changeItemStrArr(cfgStr)

	self._scrollList:reloadData(list)
end

function FuncampInvadersView:_updateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function FuncampInvadersView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function FuncampInvadersView:isCloseAddBtn()
	goutil.setActive(self._addTimes.gameObject, false)
end

return FuncampInvadersView
