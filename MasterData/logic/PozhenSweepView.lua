-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breakformation/view/PozhenSweepView.lua

module("logic.extensions.breakformation.view.PozhenSweepView", package.seeall)

local PozhenSweepView = class("PozhenSweepView", TableViewComponent)

function PozhenSweepView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function PozhenSweepView:unbindEvents()
	PozhenSweepView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
end

function PozhenSweepView:bindEvents()
	PozhenSweepView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
end

function PozhenSweepView:onExit()
	PozhenSweepView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ItemGetViewDoClosed, self._onItemViewClosed, self)

	for _, v in ipairs(self._itemPoints) do
		MaterialMgr.resetAll()
	end

	if self._needDispatch then
		print("dispatch UpdatePozhenMainView")
		GlobalDispatcher:dispatch(GlobalNotify.UpdatePozhenMainView)
	end

	self._needDispatch = false
end

function PozhenSweepView:buildUI()
	PozhenSweepView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnSure = self:getBtn("btnSure")
	self._btnAdd = self:getBtn("ticket/btnAdd")
	self._imgTicket = self:getGo("ticket/txtTicket/icon")
	self._txtTicketNum = self:getTxt("ticket/txtTicket")
end

local matType, matId, matNum

function PozhenSweepView:onEnter()
	PozhenSweepView.super.onEnter(self)

	local quickPassCost = BreakFormationConfig.instance:getBreakParmCfg("quickPassCost").paramVal

	matType, matId, _ = unpack(string.splitToNumber(quickPassCost, ":"))

	MaterialMgr.setIcon(self._imgTicket, matType, matId)
	self:_updateList()
end

function PozhenSweepView:_updateList()
	self._curViewDatas = BreakFormationModel.instance:getFormationCards()
	self._lastOpenIndex = 0
	self._itemPoints = {}

	for i = 1, #self._curViewDatas do
		local data = self._curViewDatas[i]
		local score = BreakFormationModel.instance:GetPozhanScorelistByType(true, data.index)

		self._selectedData = data

		if not score or score < 0 then
			break
		end
	end

	self._lastOpenIndex = self._selectedData.index

	self:reloadData()

	self._txtTicketNum.text = MaterialModel.instance:getMaterialsNumber(matType, matId)
end

function PozhenSweepView:_onReloadFinish()
	if self._donotNeedCenterOn then
		self._donotNeedCenterOn = false

		return
	end

	local centerIdx = self._lastOpenIndex - 1

	centerIdx = math.max(0, centerIdx)

	self._tableview:MoveCellToCebter(centerIdx)
end

local scoreIdxList = {
	"D",
	"C",
	"B",
	"A",
	"S"
}

function PozhenSweepView:_updateCell(view, cell, data)
	cell = cell.gameObject

	local imgScore = goutil.findChild(cell, "score/imgScore")
	local lock = goutil.findChild(cell, "lock")
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local btn = Framework.ButtonAdapter.Get(cell)
	local cfg = BreakFormationConfig.instance:getMonsterCfg(data.teamId, data.monsterId)
	local prizes = string.split(cfg.prize, "#")

	for i = 1, 2 do
		local itemPoint = goutil.findChild(cell, "reward_" .. i)

		MaterialMgr.setCellByCfg(prizes[i], itemPoint)
		table.insert(self._itemPoints, itemPoint)
	end

	local score = BreakFormationModel.instance:GetPozhanScorelistByType(true, data.index)
	local selected = data.index == self._selectedData.index
	local isOpen = data.index <= self._lastOpenIndex

	lock:SetActive(not isOpen)
	imgSelect:SetActive(selected)
	imgScore:SetActive(score > 0)

	if score > 0 then
		local scoreIdx = self:getScoreIdx(score)

		GameUtil.setUIImageSpriteIdx(imgScore, scoreIdx - 1)
	end

	txtLevel.text = string.format("第%d关", data.index)

	btn:AddClickListener(function()
		self:_onClickCell(data)
	end)
end

function PozhenSweepView:getScoreIdx(score)
	local periodId = BreakFormationModel.instance.periodId
	local cfg = BreakFormationConfig.instance:getTeamCfg(periodId)
	local key = BreakFormationConfig.instance:getScoreName(cfg.scoreProcessor, score)

	return table.indexof(scoreIdxList, string.upper(key))
end

function PozhenSweepView:_onClickClose()
	self:close()
end

function PozhenSweepView:_onClickAdd()
	MaterialMgr.openGetSource(matType, matId)
end

function PozhenSweepView:_onClickSure()
	local index = self._selectedData.index
	local score = BreakFormationModel.instance:GetPozhanScorelistByType(true, index)
	local scoreIdx = self:getScoreIdx(score)
	local isOpen = index <= self._lastOpenIndex

	if not isOpen then
		FloatWordMgr.instance:show("关卡暂未开启，请先通过前面关卡！")

		return
	end

	if scoreIdx and scoreIdx >= 4 then
		FloatWordMgr.instance:show("当前评分已大于等于A，无需快速通关哦")

		return
	end

	if score >= 0 then
		self:_checkAndSendReq()
	else
		BreakFormationController.instance:checkCanFight(index, function()
			self:_checkAndSendReq()
		end)
	end
end

function PozhenSweepView:_checkAndSendReq()
	local isEnough = MaterialModel.instance:IsEnough(matType, matId, 1)

	if not isEnough then
		FloatWordMgr.instance:show("道具不足")
		MaterialMgr.openGetSource(matType, matId)

		return
	end

	local periodId = BreakFormationModel.instance.periodId
	local monsterId = self._selectedData.monsterId

	if self._selectedData.index ~= self._lastOpenIndex then
		self._donotNeedCenterOn = true
	end

	BreachFormationAgent.instance:sendPM_BreachFormationQuickPassReq(periodId, monsterId, self._onQuickPassRes, self)
end

function PozhenSweepView:_onQuickPassRes(msg)
	GlobalDispatcher:addListener(GlobalNotify.ItemGetViewDoClosed, self._onItemViewClosed, self)
	BreakFormationController.instance:onQuickPassRes(msg)
	self:_updateList()

	self._needDispatch = true

	BreakFormationController.instance:localNotify("onDataLoaded")
end

function PozhenSweepView:_onItemViewClosed()
	GlobalDispatcher:removeListener(GlobalNotify.ItemGetViewDoClosed, self._onItemViewClosed, self)
	self:_playNewEffect()
end

function PozhenSweepView:_playNewEffect()
	local newScoreIdx = BreakFormationModel.instance:getNewScoreIdx()

	if checknumber(newScoreIdx) <= 0 then
		return
	end

	BreakFormationModel.instance:resetNewScoreIdx()
	UIEffectManager.instance:stopEffect(self._boxRefreshEffect)

	local idx = 1

	for k, v in ipairs(self._curViewDatas) do
		if newScoreIdx == v.index then
			idx = k

			break
		end
	end

	local centerCell = self._tableview:GetCellAtIndex(idx - 1)

	if centerCell then
		local imgScore = goutil.findChild(centerCell.gameObject, "score/imgScore")
		local effect_path = "fx_ui_assignmentview/fx_ui_assignmentview_treasurechesteffects.prefab"

		self._boxRefreshEffect = UIEffectManager.instance:playEffect(self, effect_path)

		self._boxRefreshEffect:setParent(imgScore.transform)
		self._boxRefreshEffect:setScale(0.4)
		self._boxRefreshEffect:setLocalPos()
	end
end

function PozhenSweepView:_onClickCell(data)
	self._selectedData = data
	self._donotNeedCenterOn = true

	self:reloadData()
end

return PozhenSweepView
