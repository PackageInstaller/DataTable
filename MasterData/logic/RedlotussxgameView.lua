-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redlotusdinnerparty/view/RedlotussxgameView.lua

module("logic.extensions.redlotusdinnerparty.view.RedlotussxgameView", package.seeall)

local RedlotussxgameView = class("RedlotussxgameView", SxGameNewView)

function RedlotussxgameView:ctor()
	RedlotussxgameView.super.ctor(self)
end

function RedlotussxgameView:unbindEvents()
	RedlotussxgameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function RedlotussxgameView:bindEvents()
	RedlotussxgameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClicpRule, self)
end

function RedlotussxgameView:buildUI()
	RedlotussxgameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtScore = self:getTxt("score/txtScore")
	self._Txt_Step = self:getTxt("steps/txtScore")
	self._txtDesc = self:getTxt("rule/txtDesc/Viewport/Content")
	self.ExtTime = self:getGo("Panel/ExtTime")
	self._Pnl_Result = self:getGo("Panel/Pnl_Result")

	Framework.LuaComponentContainer.Add(self._Pnl_Result.gameObject, RedlotusSxGameResultView)
end

function RedlotussxgameView:onExit()
	RedlotussxgameView.super.onExit(self)
end

function RedlotussxgameView:onEnter()
	self:addGlobalEvent()
	self:_initGame()

	self._txtDesc.text = RedLotusDinnerPartyConfig.instance:getCommonValue("SX_GAME_RULE")
end

function RedlotussxgameView:_onClicpRule()
	TipsFacade.instance:openRulesView("RedlotussxgameView_rule")
end

function RedlotussxgameView:_onQuitCallBack()
	local giftArr = SxGameModel.instance:getGiftArr()
	local count = checknumber(giftArr[SxGameCellType.Red]) + checknumber(giftArr[SxGameCellType.Yellow]) + checknumber(giftArr[SxGameCellType.Green]) + checknumber(giftArr[SxGameCellType.Purple])

	RedLotusDinnerPartyController.instance:sendEndGame(self._activityId, self._gameId, 1, count, self._clientKey, self._serverKey)
	self:close()
	GlobalDispatcher:dispatch("open_redlotusgala_view")
end

function RedlotussxgameView:_initGame()
	local params = self:getOpenParam()

	self._activityId = params[1]
	self._gameId = params[2]
	self._clientKey = params[3]
	self._serverKey = params[4]

	local actCfg = RedLotusDinnerPartyConfig.instance:getActivityCfgById(self._activityId) or {}
	local performPlanId = actCfg.performPlanId
	local perCfg = RedLotusDinnerPartyConfig.instance:getPerformPlanCfg(performPlanId, self._gameId) or {}
	local stageId = perCfg.stageId
	local stageCfg = RedLotusDinnerPartyConfig.instance:getSxGameStageCfg(stageId)
	local sxGameResultView = Framework.LuaComponentContainer.Get(self._Pnl_Result.gameObject, RedlotusSxGameResultView)

	if sxGameResultView then
		sxGameResultView:initParam(perCfg, GameUtil.handler(self._onQuitCallBack, self))
	end

	SxGameModel.instance:initGameMapArr()
	SxGameModel.instance:resetGameMapByStageCfg(stageCfg)

	self._cellArr = SxGameModel.instance:getGameMapArr()

	SxGameModel.instance:removeAction()

	self._cells = {}

	self:_initCells()
	self:_refreshGift()

	self._Txt_Step.text = tostring(SxGameModel.instance:getCurStep())

	GameUtil.SetActive(self.ExtTime, false)
	self._Pnl_Result.gameObject:SetActive(false)
end

function RedlotussxgameView:_refreshGift()
	local giftArr = SxGameModel.instance:getGiftArr()

	self._txtScore.text = checknumber(giftArr[SxGameCellType.Red]) + checknumber(giftArr[SxGameCellType.Yellow]) + checknumber(giftArr[SxGameCellType.Green]) + checknumber(giftArr[SxGameCellType.Purple])
end

function RedlotussxgameView:_nextStep()
	SxGameModel.instance:reduceStep()

	self._Txt_Step.text = tostring(SxGameModel.instance:getCurStep())
end

function RedlotussxgameView:_checkGameOverByStep()
	local sxGameResultView = Framework.LuaComponentContainer.Get(self._Pnl_Result.gameObject, RedlotusSxGameResultView)

	if SxGameModel.instance:getCurStep() == 0 and sxGameResultView then
		local cell = SxGameModel.instance:getSpecialCell()

		if cell == nil then
			GameUtil.SetActive(self.ExtTime, false)
			GameUtil.expandRectTransform(self._Pnl_Result.transform)
			sxGameResultView:showResultView()
			GameUtil.expandRectTransform(self._Pnl_Result.transform)
		else
			GameUtil.SetActive(self.ExtTime, true)
			GameUtil.expandRectTransform(self.ExtTime.transform)
			SxGameController.instance:addAction(cell)
		end
	else
		printInfo("没获取到对象")
	end
end

function RedlotussxgameView:_getCellResPath(sxGameCellMO)
	local _cellRes

	if sxGameCellMO._type == SxGameCellType.Red then
		_cellRes = "ui/views/sxgame/item_rou.prefab"
	elseif sxGameCellMO._type == SxGameCellType.Yellow then
		_cellRes = "ui/views/sxgame/item_mianfen.prefab"
	elseif sxGameCellMO._type == SxGameCellType.Green then
		_cellRes = "ui/views/sxgame/item_qingcai.prefab"
	elseif sxGameCellMO._type == SxGameCellType.Purple then
		_cellRes = "ui/views/sxgame/item_jidan.prefab"
	elseif sxGameCellMO._type == SxGameCellType.Flash then
		_cellRes = "ui/views/sxgame/itemflash.prefab"
	elseif sxGameCellMO._type == SxGameCellType.Bloom then
		_cellRes = "ui/views/sxgame/itembloom.prefab"
	elseif sxGameCellMO._type == SxGameCellType.FlashShu then
		_cellRes = "ui/views/sxgame/itemshuflash.prefab"
	elseif sxGameCellMO._type == SxGameCellType.Blue then
		_cellRes = "ui/views/sxgame/item_lanmei.prefab"
	elseif sxGameCellMO._type == SxGameCellType.MoveForward then
		_cellRes = "ui/views/sxgame/itemforward.prefab"
	elseif sxGameCellMO._type == SxGameCellType.MoveBack then
		_cellRes = "ui/views/sxgame/itemback.prefab"
	elseif sxGameCellMO._type == SxGameCellType.Block then
		_cellRes = "ui/views/sxgame/itemblock.prefab"
	end

	return _cellRes
end

return RedlotussxgameView
