-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/TripleMacthesResultView.lua

module("logic.extensions.triplemacthesgame.view.TripleMacthesResultView", package.seeall)

local TripleMacthesResultView = class("TripleMacthesResultView", ViewComponent)

function TripleMacthesResultView:ctor()
	TripleMacthesResultView.super.ctor(self)
end

function TripleMacthesResultView:unbindEvents()
	TripleMacthesResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSave)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnAddStep)
end

function TripleMacthesResultView:bindEvents()
	TripleMacthesResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSave, self._onClickSave, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
	GameUtil.addClickHandler(self._btnAddStep, self._onClickStep, self)
end

function TripleMacthesResultView:buildUI()
	TripleMacthesResultView.super.buildUI(self)

	self._btnSave = self:getGo("btnSave")
	self._btnCancel = self:getGo("btnCancel")
	self._btnAddStep = self:getGo("btnAddStep")
	self._itemScrollerview = self:getGo("itemScrollerview")
	self._targetScrollerview = self:getGo("targetScrollerview")
	self._targetCell = self:getGo("targetCell")
	self._itemCon = self:getGo("itemCon")
	self._txtTime = self:getTxt("btnAddStep/txtTime")
	self._txtScore = self:getTxt("txtScore")
	self._targetTableList = ScrollerList.create(self._targetScrollerview, self._targetCell, GameUtil.handler(self._updateTargetCell, self), GameUtil.handler(self._clearTargetCell, self))
	self._itemTableList = ScrollerList.create(self._itemScrollerview, self._itemCon, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	self._targetTableList:setCenterMode(true)
	self._itemTableList:setCenterMode(true)
end

function TripleMacthesResultView:onExit()
	TripleMacthesResultView.super.onExit(self)
	self._targetTableList:dispose()
	self._itemTableList:dispose()
end

function TripleMacthesResultView:onEnter()
	TripleMacthesResultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.TripleMacthesGameBuyStep, self._PM_TripleMacthesGameBuyStep, self)
	self.addGEvent(self, GlobalNotify.TripleMacthesGameEnd, self._PM_TripleMacthesGameEnd, self)

	local score = TripleMacthesModel.instance:getTotalScore()

	self._txtScore.text = score

	local targetList = TripleMacthesModel.instance:getTargetGroup()

	self._targetTableList:reloadData(targetList)

	self._activityId = TripleMacthesModel.instance:getActivityId()

	local prizeCfg = TripleMachesGameConfig.instance:getPrizeCfgByScore(self._activityId, score)

	self._itemTableList:reloadData((prizeCfg and not string.nilorempty(prizeCfg.prize) or nil) and string.split(prizeCfg.prize, "#"))

	self._activityId = TripleMacthesModel.instance:getActivityId()
	self._actCfg = TripleMachesGameConfig.instance:getActivityCfgById(self._activityId)
	self._txtTime.text = string.format("%d/%d", math.max(self._actCfg.dailyBuyStepLimit - TripleMacthesModel.instance:getDailyBuyStepTimes(), 0), self._actCfg.dailyBuyStepLimit)

	goutil.setActive(self._btnAddStep.gameObject, self._actCfg.dailyBuyStepLimit > 0)
end

function TripleMacthesResultView:_updateTargetCell(view, cell, data, tag)
	local go = cell.gameObject
	local imageGo = goutil.findChild(go, "img")
	local txt = goutil.findChildTextComponent(go, "txtNum")
	local txtColorChange = goutil.findChildComponent(go, "txtNum", "UITextColorChange")
	local imgComplete = goutil.findChild(go, "imgComplete")
	local txtScore = goutil.findChildTextComponent(go, "txtAddScore")

	txtScore.text = langPara("+%d积分", data.score)

	uGuiUtil.clearImage(imageGo)

	if data.type == "Collect" then
		local removeCellType = TripleMacthesGameModel.instance:getRemoveCellType()
		local collectCount = 0
		local arr = string.split(data.params, "#")
		local needCount = checknumber(arr[2])
		local typesArr = string.split(arr[1], ":")
		local firstType = checknumber(typesArr[1])

		for j, typeStr in ipairs(typesArr) do
			local type = checknumber(typeStr)

			if removeCellType and removeCellType[type] then
				collectCount = collectCount + removeCellType[type]
			end
		end

		if needCount <= collectCount then
			txtColorChange:SetState(0)
			GameUtil.SetActive(imgComplete, true)
		else
			txtColorChange:SetState(1)
			GameUtil.SetActive(imgComplete, false)
		end

		txt.text = string.format("%d/%d", math.min(collectCount, needCount), needCount)

		local blockCfg = TripleMachesGameConfig.instance:getBlockInfo(firstType)
		local iconReplace = TripleMacthesGameModel.instance:getIconReplaceCfg()

		if iconReplace[firstType] then
			uGuiUtil.setSpriteToImage(imageGo, nil, GameUrl.getBigbgFolderUrl("triplemacthes", iconReplace[firstType].icon))
		elseif blockCfg and not string.nilorempty(blockCfg.icon) then
			uGuiUtil.setSpriteToImage(imageGo, nil, GameUrl.getBigbgFolderUrl("triplemacthes", blockCfg.icon))
		end
	elseif data.type == "CreateSpeical" then
		local createCellType = TripleMacthesGameModel.instance:getCreateCellType()
		local collectCount = 0
		local arr = string.split(data.params, "#")
		local needCount = checknumber(arr[2])
		local typesArr = string.split(arr[1], ":")
		local firstType = checknumber(typesArr[1])

		for j, typeStr in ipairs(typesArr) do
			local type = checknumber(typeStr)

			if createCellType and createCellType[type] then
				collectCount = collectCount + createCellType[type]
			end
		end

		if needCount <= collectCount then
			txtColorChange:SetState(0)
			GameUtil.SetActive(imgComplete, true)
		else
			txtColorChange:SetState(1)
			GameUtil.SetActive(imgComplete, false)
		end

		txt.text = string.format("%d/%d", math.min(collectCount, needCount), needCount)

		local blockCfg = TripleMachesGameConfig.instance:getBlockInfo(firstType)
		local iconReplace = TripleMacthesGameModel.instance:getIconReplaceCfg()

		if iconReplace[firstType] then
			uGuiUtil.setSpriteToImage(imageGo, nil, GameUrl.getBigbgFolderUrl("triplemacthes", iconReplace[firstType].icon))
		elseif blockCfg and not string.nilorempty(blockCfg.icon) then
			uGuiUtil.setSpriteToImage(imageGo, nil, GameUrl.getBigbgFolderUrl("triplemacthes", blockCfg.icon))
		end
	end
end

function TripleMacthesResultView:_clearTargetCell(cell)
	local go = cell.gameObject
	local imageGo = goutil.findChild(go, "img")

	uGuiUtil.clearImage(imageGo)
end

function TripleMacthesResultView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function TripleMacthesResultView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function TripleMacthesResultView:_onClickSave()
	TripleMachesGameController.instance:sendPM_TripleMatchesGameEndGameReq(self._activityId, TripleMacthesModel.instance:getStageId(), TripleMacthesModel.instance:getTotalScore(), true)
end

function TripleMacthesResultView:_onClickCancel()
	TripleMachesGameController.instance:sendPM_TripleMatchesGameEndGameReq(self._activityId, TripleMacthesModel.instance:getStageId(), TripleMacthesModel.instance:getTotalScore(), false)
end

function TripleMacthesResultView:_onClickStep()
	local time = TripleMacthesModel.instance:getDailyBuyStepTimes()

	if time < self._actCfg.dailyBuyStepLimit then
		local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.buyStepCost)
		local buyTimeInOnGame = TripleMacthesModel.instance:getBuyStepCount()
		local matName = MaterialMgr.getMaterialsName(matType, matId)
		local content = langPara("确定花费%d%s购买%d次行动步数？\n每天最多可购买%d次，还能购买%d次", matNum, matName, self._actCfg.addBuyStep, self._actCfg.dailyBuyStepLimit, self._actCfg.dailyBuyStepLimit - TripleMacthesModel.instance:getDailyBuyStepTimes())

		TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
			if (buyTimeInOnGame + 1) * matNum <= MaterialModel.instance:getMaterialsNumber(matType, matId) then
				TripleMatchesGameAgent.instance:sendPM_TripleMatchesGameBuyStepReq(self._activityId, 1)
			else
				FloatWordMgr.instance:show(langPara("%s不足", matName))
			end
		end)
	else
		FloatWordMgr.instance:show(lang("购买次数不足"))
	end
end

function TripleMacthesResultView:_PM_TripleMacthesGameBuyStep()
	self:close()
end

function TripleMacthesResultView:_PM_TripleMacthesGameEnd()
	self:close()
	UIStateManager.instance:popByName(ViewName.TripleMacthesGameView)
end

return TripleMacthesResultView
