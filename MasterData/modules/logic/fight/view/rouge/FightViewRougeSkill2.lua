-- chunkname: @modules/logic/fight/view/rouge/FightViewRougeSkill2.lua

module("modules.logic.fight.view.rouge.FightViewRougeSkill2", package.seeall)

local FightViewRougeSkill2 = class("FightViewRougeSkill2", BaseViewExtended)
local State = {
	Detail = 2,
	Simple = 1
}

FightViewRougeSkill2.ItemWidth = 95
FightViewRougeSkill2.InitWidth = 167

function FightViewRougeSkill2:onInitView()
	self.animator = gohelper.findChildAnim(self.viewGO, "heroSkill")
	self.goSimple = gohelper.findChild(self.viewGO, "heroSkill/#go_simple")
	self.bgRectTr = gohelper.findChildComponent(self.viewGO, "heroSkill/#go_simple/bg", gohelper.Type_RectTransform)
	self.clickArea = gohelper.findChild(self.goSimple, "clickArea")
	self.clickAreaRectTr = self.clickArea:GetComponent(gohelper.Type_RectTransform)
	self.click = gohelper.getClickWithDefaultAudio(self.clickArea)
	self.txtSimpleCount = gohelper.findChildText(self.goSimple, "skillicon/#txt_simpleCurCount")
	self.txtSimpleCountMax = gohelper.findChildText(self.goSimple, "skillicon/max/txtmax")
	self.goSkillItem = gohelper.findChild(self.goSimple, "skillContent/skillitem")

	gohelper.setActive(self.goSkillItem, false)

	self.goDetail = gohelper.findChild(self.viewGO, "heroSkill/#go_detail")
	self.detailClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "heroSkill/#go_detail")
	self.txtDetailCount = gohelper.findChildText(self.goDetail, "#txt_detailCurCount")
	self.goDescItem = gohelper.findChild(self.goDetail, "skillDescContent/detailitem")

	gohelper.setActive(self.goDescItem, false)

	self.skillItemList = {}
	self.descItemList = {}
	self.preAddPower = 0

	local career = FightHelper.getRouge2Career()
	local careerCo = career and lua_rouge2_career.configDict[career]

	if careerCo then
		self.maxShowPower = careerCo.MpMax or 100
	end

	self:initConfig()
end

function FightViewRougeSkill2:initConfig()
	self.skillId2Co = {}

	for _, co in ipairs(lua_rouge2_active_skill.configList) do
		self.skillId2Co[co.skillId] = co
	end
end

function FightViewRougeSkill2:addEvents()
	self.click:AddClickListener(self.onClickSimple, self)
	self.detailClick:AddClickListener(self.onClickDescBg, self)
	self.addEventCb(self, FightController.instance, FightEvent.StartPlayClothSkill, self._onStartPlayClothSkill, self)
	self.addEventCb(self, FightController.instance, FightEvent.PushTeamInfo, self.refreshUI, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChanged, self)
	self.addEventCb(self, FightController.instance, FightEvent.AddPlayOperationData, self.onAddPlayOperationData, self)
	self.addEventCb(self, FightController.instance, FightEvent.CancelOperation, self.onCancelOperation, self)
end

function FightViewRougeSkill2:removeEvents()
	self.click:RemoveClickListener()
	self.detailClick:RemoveClickListener()
end

function FightViewRougeSkill2:onClickDescBg()
	self:switchToSimple()
end

function FightViewRougeSkill2:onCancelOperation()
	self.preAddPower = 0

	self:refreshUI()
end

local PopMusicAddPower = 15

function FightViewRougeSkill2:onAddPlayOperationData(op)
	if not op:isPlayCard() then
		return
	end

	if not FightRouge2MusicBehaviourHelper.hasMusicNote(op) then
		return
	end

	self.preAddPower = self.preAddPower + PopMusicAddPower

	self:refreshUI()
end

function FightViewRougeSkill2:onStageChanged(stage)
	if stage == FightStageMgr.StageType.Play then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	self.preAddPower = 0

	self:refreshUI()
end

function FightViewRougeSkill2:_onStartPlayClothSkill()
	self:refreshUI()
end

function FightViewRougeSkill2:refreshUI()
	self:refreshPower()
	self:refreshSkillItem()
	self:refreshDescItem()
end

function FightViewRougeSkill2:onClickSimple()
	local skillList = FightModel.instance:getClothSkillList()

	if not skillList or #skillList == 0 then
		return
	end

	if self.state == State.Detail then
		self:switchToSimple()

		return
	end

	self:switchToDetail()
end

function FightViewRougeSkill2:onClickDesc(skillInfo)
	self:switchToSimple()

	if FightDataHelper.lockOperateMgr:isLock() then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightViewHandCard.blockOperate or FightDataHelper.stateMgr:getIsAuto() then
		return
	end

	if FightDataHelper.stageMgr:getCurStage() ~= FightStageMgr.StageType.Operate then
		return
	end

	local ops = FightDataHelper.operationDataMgr:getOpList()

	if #ops > 0 then
		GameFacade.showToast(ToastEnum.RougeSkillNeedCancelOperation)

		return
	end

	if skillInfo.cd > 0 then
		GameFacade.showToast(ToastEnum.UseSkill2)

		return
	end

	local power = FightModel.instance.power

	if power < skillInfo.needPower then
		GameFacade.showToast(ToastEnum.RougeSkillMagicNotEnough)

		return
	end

	local canUse = self:checkCanUseSkill(skillInfo)

	if not canUse then
		return
	end

	self._toUseSkillId = skillInfo.skillId
	self._fromId = nil
	self._toId = FightDataHelper.operationDataMgr.curSelectEntityId

	self:_sendUseClothSkill()
end

function FightViewRougeSkill2:_sendUseClothSkill()
	TaskDispatcher.runDelay(self._sendUseClothSkillRequest, self, 0.33)
	self:_blockClick()
end

function FightViewRougeSkill2:_sendUseClothSkillRequest()
	FightRpc.instance:sendUseClothSkillRequest(self._toUseSkillId, self._fromId, self._toId, FightEnum.ClothSkillType.Rouge2)
end

function FightViewRougeSkill2:_blockClick()
	UIBlockMgr.instance:endAll()

	UIBlockMgrExtend.CircleMvDelay = 10

	UIBlockMgr.instance:startBlock(UIBlockKey.PlayClothSkill)
	self.addEventCb(self, FightController.instance, FightEvent.RespUseClothSkillFail, self._cancelBlock, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._cancelBlock, self)
end

function FightViewRougeSkill2:_cancelBlock()
	self.removeEventCb(self, FightController.instance, FightEvent.RespUseClothSkillFail, self._cancelBlock, self)
	self.removeEventCb(self, FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._cancelBlock, self)

	UIBlockMgrExtend.CircleMvDelay = nil

	UIBlockMgr.instance:endBlock(UIBlockKey.PlayClothSkill)
end

function FightViewRougeSkill2:switchToSimple()
	AudioMgr.instance:trigger(20320605)

	self.state = State.Simple

	self.animator:Play("fight_heroskill_out", 0, 1)
end

function FightViewRougeSkill2:switchToDetail()
	AudioMgr.instance:trigger(20320604)

	self.state = State.Detail

	self.animator:Play("fight_heroskill_tips", 0, 0)
end

function FightViewRougeSkill2:onOpen()
	self.state = State.Simple

	self:refreshPower()
	self:setClickAreaWidth()
	self:initSkillItem()
	self:refreshSkillItem()
	self:initDescItem()
	self:refreshDescItem()
end

function FightViewRougeSkill2:setClickAreaWidth()
	local skillList = FightModel.instance:getClothSkillList()

	if skillList then
		if not (#skillList * FightViewRougeSkill2.ItemWidth) then
			local width = 0

			width = width + FightViewRougeSkill2.InitWidth

			recthelper.setWidth(self.clickAreaRectTr, width)
			recthelper.setWidth(self.bgRectTr, width)
		end
	end
end

function FightViewRougeSkill2:refreshPower()
	local power = FightModel.instance.power

	power = power + self.preAddPower
	power = math.min(self.maxShowPower, power)
	self.txtSimpleCount.text = power
	self.txtSimpleCountMax.text = power
	self.txtDetailCount.text = power
end

function FightViewRougeSkill2:initSkillItem()
	local skillList = FightModel.instance:getClothSkillList()

	if skillList then
		for _, skillInfo in ipairs(skillList) do
			local skillItem = self:getUserDataTb_()

			table.insert(self.skillItemList, skillItem)

			skillItem.go = gohelper.cloneInPlace(self.goSkillItem)

			gohelper.setActive(skillItem.go, true)

			skillItem.goNotCost = gohelper.findChild(skillItem.go, "notcost")
			skillItem.goCanCost = gohelper.findChild(skillItem.go, "cancost")
			skillItem.simageIcon_Not = gohelper.findChildSingleImage(skillItem.goNotCost, "#simage_icon")
			skillItem.simageIcon = gohelper.findChildSingleImage(skillItem.goCanCost, "#simage_icon")

			local itemId = self:getItemId(skillInfo)

			Rouge2_IconHelper.setGameItemIcon(itemId, skillItem.simageIcon_Not)
			Rouge2_IconHelper.setGameItemIcon(itemId, skillItem.simageIcon)

			skillItem.skillInfo = skillInfo
		end
	end
end

function FightViewRougeSkill2:refreshSkillItem()
	for _, skillItem in ipairs(self.skillItemList) do
		local canUse = self:checkCanUseSkill(skillItem.skillInfo)

		gohelper.setActive(skillItem.goNotCost, not canUse)
		gohelper.setActive(skillItem.goCanCost, canUse)
	end
end

function FightViewRougeSkill2:initDescItem()
	local skillList = FightModel.instance:getClothSkillList()

	if skillList then
		for _, skillInfo in ipairs(skillList) do
			local descItem = self:getUserDataTb_()

			table.insert(self.descItemList, descItem)

			descItem.go = gohelper.cloneInPlace(self.goDescItem)

			gohelper.setActive(descItem.go, true)

			descItem.click = gohelper.getClickWithDefaultAudio(descItem.go)

			descItem.click:AddClickListener(self.onClickDesc, self, skillInfo)

			descItem.txtDesc = gohelper.findChildText(descItem.go, "desc")
			descItem.txtDesc.text = self:getSkillInfoDesc(skillInfo)
			descItem.goNotCost = gohelper.findChild(descItem.go, "skill/notcost")
			descItem.goCanCost = gohelper.findChild(descItem.go, "skill/cancost")
			descItem.simageIcon_Not = gohelper.findChildSingleImage(descItem.goNotCost, "#simage_icon")
			descItem.simageIcon = gohelper.findChildSingleImage(descItem.goCanCost, "#simage_icon")

			local itemId = self:getItemId(skillInfo)

			Rouge2_IconHelper.setGameItemIcon(itemId, descItem.simageIcon_Not)
			Rouge2_IconHelper.setGameItemIcon(itemId, descItem.simageIcon)

			descItem.skillInfo = skillInfo
		end
	end
end

function FightViewRougeSkill2:refreshDescItem()
	for _, descItem in ipairs(self.descItemList) do
		local canUse = self:checkCanUseSkill(descItem.skillInfo)

		gohelper.setActive(descItem.goNotCost, not canUse)
		gohelper.setActive(descItem.goCanCost, canUse)
	end
end

function FightViewRougeSkill2:checkCanUseSkill(skillInfo)
	if skillInfo.cd > 0 then
		return false
	end

	return FightModel.instance.power >= skillInfo.needPower
end

function FightViewRougeSkill2:getSkillInfoDesc(skillInfo)
	local co = self.skillId2Co[skillInfo.skillId]

	if not co then
		logError(string.format("skillId %s not found", skillInfo.skillId))

		co = lua_rouge2_active_skill.configList[1]
	end

	return string.format("%s\nCOST<color=#FFA500>-%s</color>", co.desc, skillInfo.needPower)
end

function FightViewRougeSkill2:getItemId(skillInfo)
	local co = self.skillId2Co[skillInfo.skillId]

	if not co then
		logError(string.format("skillId %s not found", skillInfo.skillId))

		co = lua_rouge2_active_skill.configList[1]
	end

	return co.id
end

function FightViewRougeSkill2:onDestroyView()
	TaskDispatcher.cancelTask(self._sendUseClothSkillRequest, self)

	for _, descItem in ipairs(self.descItemList) do
		descItem.simageIcon_Not:UnLoadImage()
		descItem.simageIcon:UnLoadImage()
		descItem.click:RemoveClickListener()
	end

	for _, skillItem in ipairs(self.skillItemList) do
		skillItem.simageIcon_Not:UnLoadImage()
		skillItem.simageIcon:UnLoadImage()
	end
end

return FightViewRougeSkill2
