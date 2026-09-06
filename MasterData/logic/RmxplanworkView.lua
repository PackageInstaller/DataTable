-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanworkView.lua

module("logic.extensions.richmanxplan.view.RmxplanworkView", package.seeall)

local RmxplanworkView = class("RmxplanworkView", ViewComponent)

function RmxplanworkView:ctor()
	RmxplanworkView.super.ctor(self)
end

function RmxplanworkView:unbindEvents()
	RmxplanworkView.super.unbindEvents(self)
	self._btnPet:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnGain:RemoveClickListener()
end

function RmxplanworkView:bindEvents()
	RmxplanworkView.super.bindEvents(self)
	self._btnPet:AddClickListener(self._onClickbtnPet, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnGain:AddClickListener(self._onClickbtnGain, self)
end

function RmxplanworkView:buildUI()
	RmxplanworkView.super.buildUI(self)

	self._btnPet = self:getBtn("btnPet")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnGain = self:getBtn("btnGain")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtIncome = self:getTxt("rate/txtIncome")
	self._txtMat = self:getTxt("matCell/txtMat")
end

function RmxplanworkView:onExit()
	RmxplanworkView.super.onExit(self)
	self._scrollerList:dispose()
	removetimer(self._updateIncome, self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function RmxplanworkView:onEnter()
	RmxplanworkView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self.addGEvent(self, GlobalNotify.RichManXPlanWorkInfoRes, self._update, self)
	self.addGEvent(self, GlobalNotify.RichManXPlanWorkGainRes, self._update, self)
	self.addGEvent(self, GlobalNotify.RichManXPlanWorkUnlockRes, self._update, self)
	self.addGEvent(self, GlobalNotify.RichManXPlanWorkSetPetRes, self._update, self)
	self.addGEvent(self, GlobalNotify.RichManXPlanWorkPetStarLevelUpRes, self._update, self)
	settimer(60, self._updateIncome, self, true)
	RichManXPlanAgent.instance:sendPM_RichManXPlanWorkInfoReq(self._activityId)
	self:_setEffect()
end

function RmxplanworkView:_update()
	self:_updateData()
	self:_updateUI()
end

function RmxplanworkView:_updateData()
	self._workCfgs = RichmanxplanConfig.instance:getWorkCfgs(self._activityId)
end

function RmxplanworkView:_updateUI()
	self._info = RichmanxplanModel.instance:getWorkInfo()

	if not self._info then
		return
	end

	self:_updateWorkPositions()
	self:_updateIncome()
	self:_updateMat()
end

function RmxplanworkView:_updateWorkPositions()
	self._scrollerList:reloadData(self._workCfgs)
end

function RmxplanworkView:_onClickbtnPet()
	UIStateManager.instance:push(ViewName.RmxplanpetsView, self._activityId)
end

function RmxplanworkView:_onClickbtnClose()
	self:close()
end

function RmxplanworkView:_onClickbtnTip()
	local ruleKey = RichmanxplanConfig.instance:getRuleKey(self._activityId, "dagongRule")

	TipsFacade.instance:openRulesView(ruleKey)
end

function RmxplanworkView:_onClickbtnGain()
	local incomeValue = self:_getIncomeValue()

	if incomeValue > 0 then
		RichManXPlanAgent.instance:sendPM_RichManXPlanWorkGainReq(self._activityId)
	else
		FloatWordMgr.instance:show("暂时没产生收益")
	end
end

function RmxplanworkView:_updateCell(view, cell, workCfg, tag)
	local btnChange = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnChange")
	local btnBg = Framework.ButtonAdapter.GetFrom(cell.gameObject, "bg")
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local goBottomLock = goutil.findChild(cell.gameObject, "bottom/lock")
	local goLock = goutil.findChild(cell.gameObject, "lock")
	local goNotPet = goutil.findChild(cell.gameObject, "notPet")
	local goUnlock = goutil.findChild(cell.gameObject, "bottom/unlock")
	local txtLockDesc = goutil.findChildTextComponent(cell.gameObject, "bottom/lock/txtDesc")
	local txtUnlockDesc = goutil.findChildTextComponent(cell.gameObject, "bottom/unlock/txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local btnLock = Framework.ButtonAdapter.GetFrom(cell.gameObject, "lock/btnLock")
	local goExclusive = goutil.findChild(cell, "exclusive")
	local posData = RichmanxplanModel.instance:getWorkPosData(self._activityId, workCfg.posId)
	local isUnlock = posData and posData.isUnlock
	local hasPet = posData and posData.petId > 0

	goutil.setActive(goBottomLock, not isUnlock)
	goutil.setActive(goLock, not isUnlock)
	goutil.setActive(goUnlock, isUnlock)
	goutil.setActive(goNotPet, isUnlock and not hasPet)
	goutil.setActive(goIcon, isUnlock and hasPet)
	goutil.setActive(btnChange.gameObject, hasPet)
	goutil.setActive(goExclusive, false)

	txtName.text = workCfg.workName

	if isUnlock then
		local efficiency = 0

		if hasPet then
			local petData = RichmanxplanModel.instance:getPetData(posData.petId)
			local isExclusive = RichmanxplanConfig.instance:checkIsExclusive(self._activityId, workCfg.posId, petData.raceId)

			goutil.setActive(goExclusive, isExclusive)

			efficiency = RichmanxplanConfig.instance:getPetWorkEfficiency(self._activityId, petData.starLevel, isExclusive)
		end

		txtUnlockDesc.text = string.format("+%s/小时", workCfg.baseIncome * 60 * (1 + efficiency))
	else
		txtLockDesc.text = string.format("%s解锁", workCfg.unlockCost)
	end

	if isUnlock and hasPet then
		local petData = RichmanxplanModel.instance:getPetData(posData.petId)
		local petCfg = RichmanxplanConfig.instance:getPetCfg(self._activityId, petData.raceId)
		local modelCo = CharacterConfig.instance:getModelCo(petCfg.linkRaceId)

		uGuiUtil.setSpriteToImage(goIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	end

	btnChange:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RmxplanselectpetView, self._activityId, workCfg.posId, posData.petId)
	end)
	btnLock:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RmxplanunlockworkposView, self._activityId, workCfg.posId)
	end)
	btnBg:AddClickListener(function()
		if not isUnlock or hasPet then
			return
		end

		UIStateManager.instance:push(ViewName.RmxplanselectpetView, self._activityId, workCfg.posId)
	end)
end

function RmxplanworkView:_clearCell(cell)
	local goIcon = goutil.findChild(cell.gameObject, "icon")

	uGuiUtil.clearImage(goIcon)
end

function RmxplanworkView:_updateIncome()
	local incomeValue = self:_getIncomeValue()
	local storage = RichmanxplanConfig.instance:getWorkStorage(self._activityId)

	self._txtIncome.text = string.format("%s/%s", incomeValue, storage)
end

function RmxplanworkView:_getIncomeValue()
	local workInfo = RichmanxplanModel.instance:getWorkInfo()

	if not workInfo then
		return 0
	end

	local incomeValue = 0
	local storage = RichmanxplanConfig.instance:getWorkStorage(self._activityId)
	local nowMs = ServerTime.nowMs()

	for i, v in ipairs(self._workCfgs) do
		local data = RichmanxplanModel.instance:getWorkPosData(self._activityId, v.posId)

		if data and data.isUnlock then
			local incomeMin = math.floor((nowMs - checknumber(data.settleTimeMillis)) / 60000)
			local efficiency = 0

			if incomeMin >= 1 then
				if data.petId > 0 then
					local petData = RichmanxplanModel.instance:getPetData(data.petId)
					local isExclusive = RichmanxplanConfig.instance:checkIsExclusive(self._activityId, v.posId, petData.raceId)

					efficiency = RichmanxplanConfig.instance:getPetWorkEfficiency(self._activityId, petData.starLevel, isExclusive)
				end

				incomeValue = incomeValue + v.baseIncome * incomeMin * (1 + efficiency)
			end
		end
	end

	incomeValue = math.min(storage, incomeValue)

	return incomeValue
end

function RmxplanworkView:_updateMat()
	local info = RichmanxplanModel.instance:getInfo(self._activityId)

	self._txtMat.text = info.score
end

function RmxplanworkView:_setEffect()
	local effName = "20240531/dafuweng/fx_ui_tongyongfenwei_dfw.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self.mainGO.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0, 0)
end

return RmxplanworkView
