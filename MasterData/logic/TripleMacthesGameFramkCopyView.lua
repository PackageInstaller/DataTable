-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/TripleMacthesGameFramkCopyView.lua

module("logic.extensions.triplemacthesgame.view.TripleMacthesGameFramkCopyView", package.seeall)

local TripleMacthesGameFramkCopyView = class("TripleMacthesGameFramkCopyView", ViewComponent)

function TripleMacthesGameFramkCopyView:buildUI()
	TripleMacthesGameFramkCopyView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtTotalScore = self:getTxt("txtTotalScore")
	self._txtStep = self:getTxt("txtStep")
	self._tableView = self:getGo("tableview")
	self._tableCell = self:getGo("tablecell")
	self._btnBubble = self:getGo("btnBubble")
	self._bubble = self:getGo("bubble")
	self._txtBubble = self:getTxt("bubble/img/txt")
	self._PanelPrize = self:getGo("PanelPrize")
	self._con = self:getGo("con")
	self._customInput = UICustomInput.Get(self._bubble)
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function TripleMacthesGameFramkCopyView:unbindEvents()
	TripleMacthesGameFramkCopyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBubble)
	GameUtil.rmClickHandler(self._btnTip)
	self._customInput:RemoveListener()
end

function TripleMacthesGameFramkCopyView:bindEvents()
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnBubble, self._onClickBulle, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	self._customInput:AddListener(self._onClickBubbleInput, self)
end

function TripleMacthesGameFramkCopyView:onEnter()
	TripleMacthesGameFramkCopyView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RemoveCell, self._removeCell, self)
	self.addGEvent(self, GlobalNotify.StepOver, self._stepOver, self)
	self.addGEvent(self, GlobalNotify.ThreeMathesComboFish, self._comboFinish, self)
	self.addGEvent(self, GlobalNotify.TripleMacthesGameStart, self._PM_TripleMacthesGameStart, self)
	self.addGEvent(self, GlobalNotify.TripleMacthesGameBuyStep, self._PM_TripleMacthesGameBuyStep, self)
	self.addGEvent(self, GlobalNotify.TripleMacthesClearSpecialEnd, self._onClearSpecialEnd, self)
	GameUtil.SetActive(self._PanelPrize, false)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])
	self._finishCallBack = params[3]

	local ruleCfg = RulesConfig.instance:getRuleCo("triple_macthes_game_rule")

	self._txtBubble.text = ruleCfg.rules

	TripleMachesGameController.instance:tourArenaStartGame(self._activityId, self._stageId)
end

function TripleMacthesGameFramkCopyView:onExit()
	TripleMacthesGameFramkCopyView.super.onExit(self)
	self._tableList:dispose()
end

function TripleMacthesGameFramkCopyView:_refreshView()
	self._txtStep.text = TripleMacthesModel.instance:getStep()
	self._txtTotalScore.text = TripleMacthesModel.instance:getTotalScore()

	local list = TripleMacthesModel.instance:getTargetGroup()

	self._tableList:reloadData(list)
end

function TripleMacthesGameFramkCopyView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imageGo = goutil.findChild(go, "img")
	local txt = goutil.findChildTextComponent(go, "txt")
	local txtColorChange = goutil.findChildComponent(go, "txt", "UITextColorChange")
	local imageComplete = goutil.findChild(go, "imgComplete")
	local txtAddScore = goutil.findChildTextComponent(go, "txtAddScore")

	uGuiUtil.clearImage(imageGo)
	GameUtil.SetActive(imageComplete, false)

	txtAddScore.text = langPara("+%d积分", data.score)

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
		else
			txtColorChange:SetState(1)
		end

		GameUtil.SetActive(imageComplete, needCount <= collectCount)

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
		else
			txtColorChange:SetState(1)
		end

		GameUtil.SetActive(imageComplete, needCount <= collectCount)

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

function TripleMacthesGameFramkCopyView:_clearCell(cell)
	local go = cell.gameObject
	local imageGo = goutil.findChild(go, "img")

	uGuiUtil.clearImage(imageGo)
end

function TripleMacthesGameFramkCopyView:_removeCell()
	self:_refreshView()
end

function TripleMacthesGameFramkCopyView:_stepOver()
	self:_refreshView()

	if TripleMacthesModel.instance:getStep() <= 0 then
		GameUtil.SetActive(self._PanelPrize, true)
		GlobalDispatcher:dispatch(GlobalNotify.TripleMacthesClearSpecial)
	end
end

function TripleMacthesGameFramkCopyView:_comboFinish(combo)
	TripleMacthesModel.instance:setCombo(combo)
end

function TripleMacthesGameFramkCopyView:_onClickClose()
	if TripleMachesGameController.instance:isCanDoAction() then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("退出后将直接结算，是否退出游戏"), function()
			TripleMacthesGameModel.instance:waitMoveRes()
			GlobalDispatcher:dispatch(GlobalNotify.TripleMacthesClearSelAllEffect)
			UIStateManager.instance:push(ViewName.TripleMacthesResultCopyView, self._finishCallBack)
		end)
	else
		TipsFacade.instance:openCommonTips(lang("请在计算得分后进行操作"))
	end
end

function TripleMacthesGameFramkCopyView:_onClickTip()
	TipsFacade.instance:openRulesView("triple_macthes_game_play_rule")
end

function TripleMacthesGameFramkCopyView:_onClickBulle()
	GameUtil.SetActive(self._bubble, true)
end

function TripleMacthesGameFramkCopyView:_onClickBubbleInput()
	if not hover then
		GameUtil.SetActive(self._bubble, false)
	end
end

function TripleMacthesGameFramkCopyView:_onClearSpecialEnd()
	TripleMacthesGameModel.instance:waitMoveRes()
	GameUtil.SetActive(self._PanelPrize, false)
	UIStateManager.instance:push(ViewName.TripleMacthesResultCopyView, self._finishCallBack)
end

function TripleMacthesGameFramkCopyView:_PM_TripleMacthesGameStart()
	TripleMacthesGameModel.instance:getMoveRes()
	self:_refreshView()
end

function TripleMacthesGameFramkCopyView:_PM_TripleMacthesGameBuyStep()
	TripleMacthesGameModel.instance:getMoveRes()
	self:_refreshView()
end

return TripleMacthesGameFramkCopyView
