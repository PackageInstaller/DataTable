-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunwu/view/KunWuExtView.lua

module("logic.extensions.kunwu.view.KunWuExtView", package.seeall)

local KunWuExtView = class("KunWuExtView", ViewComponent)

function KunWuExtView:buildUI()
	KunWuExtView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtTopRule = self:getTxt("ruleTitle/scrView/Viewport/Content")
	self._bottomRule = self:getGo("bottomRule")
	self._txtBottomRule = self:getTxt("bottomRule/Text")
	self._btnUpCell = self:getGo("upcell/btn")
	self._passUpCell = self:getGo("upcell/btn/pass")
	self._btnDownCell = self:getGo("downcell/btn")
	self._passDownCell = self:getGo("downcell/btn/pass")
	self._btnReset = self:getGo("btnReset")
	self._cells = self:getGo("cells")
	self._challengeCellList = {}

	for i = 1, self._cells.transform.childCount do
		local curCell = {}
		local curCellGo = goutil.findChild(self._cells, "challengeCell" .. i)
		local curFmt = goutil.findChild(curCellGo, "stageFmt/fmt")
		local pass = goutil.findChild(curCellGo, "stageFmt/pass")
		local btnChallenge = goutil.findChild(curCellGo, "btnChallenge")
		local buffTopGo = goutil.findChild(curCellGo, "titleTop")
		local upGo = goutil.findChild(curCellGo, "buff/up")
		local imgBuff1 = goutil.findChild(curCellGo, "buff/up/imgBuff1")
		local imgBuffChange1 = imgBuff1:GetComponent(ComponentType.UIImageSpriteChange)
		local imgBuff2 = goutil.findChild(curCellGo, "buff/up/imgBuff2")
		local imgBuffChange2 = imgBuff2:GetComponent(ComponentType.UIImageSpriteChange)
		local imgBuff3 = goutil.findChild(curCellGo, "buff/up/imgBuff3")
		local imgBuffChange3 = imgBuff3:GetComponent(ComponentType.UIImageSpriteChange)
		local txtBuffTop = goutil.findChildTextComponent(curCellGo, "titleTop/Text")
		local txtbuffDesc = goutil.findChildTextComponent(curCellGo, "buff/buffDesc")

		curCell.go = curCellGo
		curCell.fmt = curFmt
		curCell.pass = pass
		curCell.btnChallenge = btnChallenge
		curCell.buffTopGo = buffTopGo
		curCell.txtBuffTop = txtBuffTop
		curCell.txtbuffDesc = txtbuffDesc
		curCell.txtScore = goutil.findChildTextComponent(curCellGo, "score/txt")
		curCell.txtBtnChallenge = goutil.findChildTextComponent(curCellGo, "btnChallenge/txt")
		curCell.upGo = upGo
		curCell.imgBuffs = {
			imgBuff1,
			imgBuff2,
			imgBuff3
		}
		curCell.imgBuffChanges = {
			imgBuffChange1,
			imgBuffChange2,
			imgBuffChange3
		}

		table.insert(self._challengeCellList, curCell)
	end
end

function KunWuExtView:bindEvents()
	KunWuExtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnUpCell, self._onClickBtnUpCell, self)
	GameUtil.addClickHandler(self._btnDownCell, self._onClickBtnDownCell, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)

	for idx, cell in ipairs(self._challengeCellList) do
		GameUtil.addClickHandler(cell.btnChallenge, GameUtil.handler(self._onClickBtnChallenge, self, idx))
	end
end

function KunWuExtView:unbindEvents()
	KunWuExtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnUpCell)
	GameUtil.rmClickHandler(self._btnDownCell)
	GameUtil.rmClickHandler(self._btnReset)

	for idx, cell in ipairs(self._challengeCellList) do
		GameUtil.rmClickHandler(cell.btnChallenge)
	end
end

function KunWuExtView:onEnter()
	KunWuExtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_KunWuClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_KunWuResetExtremeClgPhaseRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_KunWuClgConfirmRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = KunWuController.instance:getActivityId()
	end

	self._actCfg = KunWuConfig.instance:getKunWuActData(self._activityId)
	self._curPhaseId = KunWuModel.instance:getExtPhaseId(self._activityId)

	if KunWuModel.instance:getChangeSetIdStackLength() > 0 then
		local changeSetId = KunWuModel.instance:popChangeSetId()

		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end

	self:_onUpdate()
end

function KunWuExtView:onExit()
	KunWuExtView.super.onExit(self)

	for i, cell in ipairs(self._challengeCellList) do
		self:_clearFmt(cell.fmt)
	end

	KunWuModel.instance:setExtPhaseId(self._curPhaseId)
end

function KunWuExtView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function KunWuExtView:_updateData()
	return
end

function KunWuExtView:_updateUI()
	self:_updateRules()
	self:_updateFmt()
	self:_updatePhaseUI()
end

function KunWuExtView:_updateRules()
	local curTopRule = KunWuConfig.instance:getExtStageTopRule(self._activityId, self._curPhaseId)
	local curBottomRule = KunWuConfig.instance:getExtStageBottomRule(self._activityId, self._curPhaseId)
	local curTotalScore = KunWuModel.instance:getExtPhaseTotalScore(self._activityId, self._curPhaseId)
	local curTargetSumValue = KunWuConfig.instance:getExtStageTargetSumValue(self._activityId, self._curPhaseId)

	curBottomRule = curBottomRule .. "(<color=#FF0000FF>" .. curTotalScore .. "</color>/" .. curTargetSumValue .. ")"
	self._txtTopRule.text = curTopRule
	self._txtBottomRule.text = curBottomRule

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._bottomRule.transform)
end

function KunWuExtView:_updatePhaseUI()
	local phaseOnePass = KunWuModel.instance:hasPassedPhase(self._activityId, 1)
	local phaseTwoPass = KunWuModel.instance:hasPassedPhase(self._activityId, 2)

	GameUtil.SetActive(self._passUpCell, phaseOnePass)
	GameUtil.SetActive(self._passDownCell, phaseTwoPass)
end

function KunWuExtView:_updateFmt()
	local buffs = KunWuModel.instance:getExtBuffs(self._activityId, self._curPhaseId)

	for stageIdx, cell in ipairs(self._challengeCellList) do
		local curTopBuffList = buffs and buffs[stageIdx]
		local buffChangeIds = {}

		if curTopBuffList then
			for i, buff in ipairs(curTopBuffList) do
				local idx = GameEnum.Races[buff]

				table.insert(buffChangeIds, idx)
			end
		end

		local topDesc = KunWuConfig.instance:getExtStageBuffDesc(self._activityId, self._curPhaseId, stageIdx)
		local creepsId = KunWuConfig.instance:getExtCreepsId(self._activityId, self._curPhaseId, stageIdx)
		local creepCfg = KunWuConfig.instance:getKunWuCreepsData(creepsId)
		local curScore = KunWuModel.instance:getExtStageScore(self._activityId, self._curPhaseId, stageIdx)
		local curButtomScoreStr = KunWuConfig.instance:getExtStageBottomWord(self._activityId, self._curPhaseId, stageIdx)
		local curStageIsPass = KunWuModel.instance:hasChallengedStage(self._activityId, self._curPhaseId, stageIdx)

		self:_setFmt(cell.fmt, creepCfg)

		if curStageIsPass then
			GameUtil.SetActive(cell.upGo, false)
		else
			GameUtil.SetActive(cell.upGo, true)

			for idx, buffGo in ipairs(cell.imgBuffs) do
				local canShowGo = idx <= #curTopBuffList
				local buffChange = cell.imgBuffChanges[idx]

				GameUtil.SetActive(buffGo, canShowGo)
				buffChange:SetState(checknumber(buffChangeIds[idx]) - 1)
			end
		end

		cell.txtbuffDesc.text = topDesc
		cell.txtScore.text = curButtomScoreStr .. curScore
		cell.txtBtnChallenge.text = curStageIsPass and "已通关" or "进入挑战"

		GameUtil.SetActive(cell.pass, curStageIsPass)
		GameUtil.SetActive(cell.buffTopGo, not curStageIsPass)
	end
end

function KunWuExtView:_setFmt(fmtView, cfg)
	local map = {}

	for _, data in ipairs(cfg) do
		map[data.posId] = data
	end

	for posId = 1, 9 do
		local creepsData = map[posId]
		local go = fmtView.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
		GameUtil.SetActive(go, false)

		if creepsData then
			MaterialMgr.setIcon(con, MatType.PET_SKIN, (checknumber(creepsData.faceId) > 0 or nil) and checknumber(creepsData.faceId))
			GameUtil.SetActive(go, true)
			GameUtil.SetActive(con, true)
		end
	end
end

function KunWuExtView:_clearFmt(fmt)
	for posId = 1, 9 do
		local go = fmt.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
	end
end

function KunWuExtView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyExtrem

	TipsFacade.instance:openRulesView(key)
end

function KunWuExtView:_onClickBtnUpCell()
	if KunWuModel.instance:hasPassedPhase(self._activityId, 1) then
		FloatWordMgr.instance:show("该层已达成通关条件")

		return
	end

	self._curPhaseId = 1

	self:_onUpdate()
end

function KunWuExtView:_onClickBtnDownCell()
	if KunWuModel.instance:hasPassedPhase(self._activityId, 2) then
		FloatWordMgr.instance:show("该层已达成通关条件")

		return
	end

	self._curPhaseId = 2

	self:_onUpdate()
end

function KunWuExtView:_onClickBtnChallenge(idx)
	local passAllPhase = KunWuModel.instance:hasPassedAllPhase(self._activityId)

	if passAllPhase then
		FloatWordMgr.instance:show("已完成该挑战，无需再次挑战")

		return
	end

	if KunWuModel.instance:hasChallengedStage(self._activityId, self._curPhaseId, idx) then
		FloatWordMgr.instance:show("重置后才可重新挑战")

		return
	end

	KunWuController.instance:enterExtBattleClg(self._activityId, self._curPhaseId, idx)
end

function KunWuExtView:_onClickBtnReset()
	local passAllPhase = KunWuModel.instance:hasPassedAllPhase(self._activityId)

	if passAllPhase then
		FloatWordMgr.instance:show("已完成该挑战，无需重置")

		return
	end

	local hasNoChallenged = KunWuModel.instance:extPhaseHasNoChallenged(self._activityId, self._curPhaseId)

	if hasNoChallenged then
		FloatWordMgr.instance:show("本层暂无成绩，无需重置")

		return
	end

	local tipStr = "是否重置本层关卡？"

	local function okFunc()
		KunWuController.instance:sendPM_KunWuResetExtremeClgPhaseReq(self._activityId, self._curPhaseId)
	end

	TipsFacade.instance:openPopupWindowWithX("提示", tipStr, okFunc, nil, "确认", "取消")
end

return KunWuExtView
