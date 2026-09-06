-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/view/DivineisaacclgstageView.lua

module("logic.extensions.divineisaacclg.view.DivineisaacclgstageView", package.seeall)

local DivineisaacclgstageView = class("DivineisaacclgstageView", ViewComponent)

function DivineisaacclgstageView:ctor()
	DivineisaacclgstageView.super.ctor(self)
end

function DivineisaacclgstageView:unbindEvents()
	DivineisaacclgstageView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnJump3:RemoveClickListener()
	self._btnJump1:RemoveClickListener()
	self._btnJump2:RemoveClickListener()
	self._btnJump4:RemoveClickListener()
end

function DivineisaacclgstageView:bindEvents()
	DivineisaacclgstageView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnJump3:AddClickListener(self._onClickbtnJump3, self)
	self._btnJump1:AddClickListener(self._onClickbtnJump1, self)
	self._btnJump2:AddClickListener(self._onClickbtnJump2, self)
	self._btnJump4:AddClickListener(self._onClickbtnJump4, self)
end

function DivineisaacclgstageView:buildUI()
	DivineisaacclgstageView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._tabtableviewGo = self:getGo("tabtableview")
	self._tabtablecellGo = self:getGo("tabtablecell")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnJump3 = self:getBtn("jumpBtnCol/btnJump3")
	self._btnJump1 = self:getBtn("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getBtn("jumpBtnCol/btnJump2")
	self._btnJump4 = self:getBtn("jumpBtnCol/btnJump4")
	self._tabscrollerList = ScrollerList.create(self._tabtableviewGo, self._tabtablecellGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))

	self._itemGo = self:getGo("rule/item")
	self._txtDesc = self:getTxt("rule/tableview/viewport/txtDesc")
	self._txtNum = self:getTxt("rule/txtNum")
	self._contentTr = self:getGo("tabtableview/viewport/content").transform

	self._tabscrollerList:regReloadFinish(function()
		local y = (self._currPhaseId - 1) * 140

		Framework.TransformUtil.SetAnchoredPos(self._contentTr, 0, y)
		self:_onUpdatePosition()
	end)

	self._receiveGo = self:getGo("rule/receiveGo")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
end

function DivineisaacclgstageView:onExit()
	DivineisaacclgstageView.super.onExit(self)
	self._tabscrollerList:dispose()
	self._scrollerList:dispose()
	MaterialMgr.resetAll(self._itemGo)
end

function DivineisaacclgstageView:onEnter()
	DivineisaacclgstageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineIsaacClgInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.DivineIsaacClgResetRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.DivineIsaacClgProducePuppetRes, self._updateUI, self)

	self._activityId = self:getFirstParam()
	self._isFirstEnter = true
	self._stageCfgs = DivineisaacclgConfig.instance:getStageCfgs(self._activityId)
	self._phaseCfgs = DivineisaacclgConfig.instance:getPhaseCfgs(self._activityId)

	self:_updateUI()
end

function DivineisaacclgstageView:_updateUI()
	self._info = DivineisaacclgModel.instance:getInfo(self._activityId)
	self._currPhaseId = self._info.bestPhaseId >= #self._stageCfgs and self._info.bestPhaseId or self._info.bestPhaseId + 1
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	self:_updateTabs()
	self:_onClickTabBtn(self._currPhaseId)
	self:_updateRewardState()
end

function DivineisaacclgstageView:_updateTabs()
	self._tabscrollerList:reloadData(self._phaseCfgs)
end

function DivineisaacclgstageView:_updateStageView()
	self:_updateFormations()
	self:_updateRule()
end

function DivineisaacclgstageView:_updateFormations()
	local cfgs = self._stageCfgs[self._currPhaseId]

	self._scrollerList:reloadData(cfgs)
end

function DivineisaacclgstageView:_updateRule()
	local phaseCfg = DivineisaacclgConfig.instance:getPhaseCfg(self._activityId, self._currPhaseId)

	self._txtDesc.text = phaseCfg.ruleDesc
	self._txtNum.text = string.format("%s/%s", self._info.curPhase.puppetNum, phaseCfg.puppetNum)

	MaterialMgr.setCellByCfg(phaseCfg.prize, self._itemGo)
end

function DivineisaacclgstageView:_updateTabCell(view, cell, phaseCfg, tag)
	local btn = Framework.ButtonAdapter.Get(goutil.findChild(cell.gameObject, "btn"))
	local goLockGo = goutil.findChild(cell.gameObject, "btn/lockGo")
	local goPassGo = goutil.findChild(cell.gameObject, "btn/passGo")
	local goSelect = goutil.findChild(cell.gameObject, "btn/select")
	local txtNotSelect = goutil.findChildTextComponent(cell.gameObject, "btn/txtNotSelect")
	local txtSelect = goutil.findChildTextComponent(cell.gameObject, "btn/txtSelect")
	local isCurr = phaseCfg.phaseId == self._currPhaseId

	goutil.setActive(goPassGo, phaseCfg.phaseId <= self._info.bestPhaseId)
	goutil.setActive(goSelect, phaseCfg.phaseId <= self._info.bestPhaseId)
	goutil.setActive(goLockGo, phaseCfg.phaseId > self._info.bestPhaseId + 1)

	if isCurr then
		txtSelect.text = string.format("第%s关", phaseCfg.phaseId)
		txtNotSelect.text = ""
	else
		txtNotSelect.text = string.format("第%s关", phaseCfg.phaseId)
		txtSelect.text = ""
	end

	btn:AddClickListener(function()
		self:_onClickTabBtn(phaseCfg.phaseId)
	end)
end

function DivineisaacclgstageView:_onClickTabBtn(phaseId)
	if phaseId <= self._info.bestPhaseId and phaseId < #self._stageCfgs then
		FloatWordMgr.instance:show("已通关")

		return
	end

	if phaseId > self._info.bestPhaseId + 1 then
		FloatWordMgr.instance:show("通关前面关卡后开启")

		return
	end

	self._currPhaseId = phaseId

	self._tabscrollerList:refresh()
	self:_updateStageView()
end

function DivineisaacclgstageView:_clearTabCell(cell)
	return
end

function DivineisaacclgstageView:_updateCell(view, cell, stageCfg, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local passGo = goutil.findChild(cell.gameObject, "passGo")
	local attrIcon = goutil.findChild(cell.gameObject, "attrcell/icon"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtHistory = goutil.findChildTextComponent(cell.gameObject, "history/txtHistory")
	local posList = {}

	for i = 1, 9 do
		local petPosCell = {}

		petPosCell.go = goutil.findChild(cell.gameObject, "formation/cell_" .. i)
		petPosCell.con = goutil.findChild(petPosCell.go, "con")
		posList[i] = petPosCell
	end

	local isPass = false

	self:_petPosReset(posList)
	goutil.setActive(passGo, isPass)

	local creepsCfgs = DivineisaacclgConfig.instance:getCreepsCfgs(stageCfg.creepsMasterId)

	for i, v in ipairs(creepsCfgs) do
		local cellCfg = creepsCfgs[i]

		if cellCfg.posId > 0 then
			GameUtil.SetActive(posList[cellCfg.posId].go, true)

			local faceId = checknumber(cellCfg.faceId) > 0 and checknumber(cellCfg.faceId) or cellCfg.raceId
			local modelCo = CharacterConfig.instance:getModelCo(faceId)

			uGuiUtil.setSpriteToImage(posList[cellCfg.posId].con, uGuiUtil.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		end
	end

	btn:AddClickListener(function()
		if isPass then
			FloatWordMgr.instance:show("已通关")

			return
		end

		local fmtMo = DivineisaacclgModel.instance:getFmtMo()

		fmtMo:initParams(self._activityId, stageCfg.phaseId, stageCfg.stageId, stageCfg.creepsMasterId)
		CustomFmtController.instance:showMissionView(fmtMo)
		DivineisaacclgModel.instance:setClgStageId(stageCfg.phaseId, stageCfg.stageId)
	end)
	attrIcon:SetState(GameEnum.Races[stageCfg.enemyAttr] - 1)

	txtHistory.text = string.format("历史最高：%s", DivineisaacclgModel.instance:getStageMetalNum(self._activityId, stageCfg.stageId))
end

function DivineisaacclgstageView:_petPosReset(posList)
	for i = 1, #posList do
		GameUtil.SetActive(posList[i].go, false)
		uGuiUtil.clearImage(posList[i].con)
	end
end

function DivineisaacclgstageView:_clearCell(cell)
	return
end

function DivineisaacclgstageView:_onClickbtnTip()
	local challengeCfg = DivineisaacclgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function DivineisaacclgstageView:_onClickbtnClose()
	self:close()
end

function DivineisaacclgstageView:_onClickbtnJump1()
	UIStateManager.instance:push(ViewName.DivineisaacclgfactoryView, self._activityId, self._currPhaseId)
end

function DivineisaacclgstageView:_onClickbtnJump2()
	UIStateManager.instance:push(ViewName.DivineisaacclgmixruleView)
end

function DivineisaacclgstageView:_onClickbtnJump3()
	UIStateManager.instance:push(ViewName.DivineisaacclgbuffdescView, self._activityId, self._currPhaseId)
end

function DivineisaacclgstageView:_onClickbtnJump4()
	local isHit = false
	local info = DivineisaacclgModel.instance:getInfo(self._activityId)

	for i, v in ipairs(info.curPhase.puppet) do
		if v.num ~= 0 then
			isHit = true

			break
		end
	end

	if not isHit then
		for i, v in ipairs(info.curPhase.metals) do
			if v.num ~= 0 then
				isHit = true

				break
			end
		end
	end

	if not isHit then
		FloatWordMgr.instance:show("无需重置")
	else
		TipsFacade.instance:openPopupWindow("提示", "重置后本层所有的关卡进度以及所得的合金、傀儡数量都会清空，是否确定重置？", function()
			DivineIsaacClgAgent.instance:sendPM_DivineIsaacClgResetReq(self._activityId, self._currPhaseId)
		end)
	end
end

function DivineisaacclgstageView:_onUpdatePosition()
	local tableView = self._tabscrollerList:getView()
	local count = tableView:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableView:GetCellByIndex(i)

		if cell then
			local x, y = Framework.TransformUtil.GetAnchoredPos(cell.transform, 0, 0)
			local offsetX = self:_getSmoothX(y)
			local tr = goutil.findChild(cell.gameObject, "btn").transform

			Framework.TransformUtil.SetAnchoredPos(tr, offsetX, 0)
		end
	end
end

function DivineisaacclgstageView:_getSmoothX(y)
	local _, con_y = Framework.TransformUtil.GetAnchoredPos(self._contentTr, 0, 0)
	local num = math.abs(y + con_y + 250)

	if num <= 50 then
		return 0
	end

	if num <= 150 then
		return -23
	end

	return -65
end

function DivineisaacclgstageView:_updateRewardState()
	self._info = DivineisaacclgModel.instance:getInfo(self._activityId)

	local isGain = self._info.bestPhaseId >= #self._stageCfgs

	goutil.setActive(self._receiveGo, isGain)
end

function DivineisaacclgstageView:_onReloadFinish()
	if self._isFirstEnter then
		self._isFirstEnter = false

		local phaseId, stageId = DivineisaacclgModel.instance:getClgSatgeId()
		local cfgs = self._stageCfgs[self._currPhaseId]

		for i, v in ipairs(cfgs) do
			if v.phaseId == phaseId and v.stageId == stageId then
				self._scrollerList:MoveCellToBegin(i - 1)

				break
			end
		end
	end
end

return DivineisaacclgstageView
