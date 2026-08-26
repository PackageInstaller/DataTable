-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyTrialCharacterSkillTalentView.lua

module("modules.logic.sp01.odyssey.view.OdysseyTrialCharacterSkillTalentView", package.seeall)

local OdysseyTrialCharacterSkillTalentView = class("OdysseyTrialCharacterSkillTalentView", CharacterSkillTalentView)

function OdysseyTrialCharacterSkillTalentView:onInitView()
	OdysseyTrialCharacterSkillTalentView.super.onInitView(self)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyTrialCharacterSkillTalentView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeChange, self._refreshView, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeReset, self._refreshView, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onClickTalentTreeNode, self._refreshView, self)
end

function OdysseyTrialCharacterSkillTalentView:removeEvents()
	self._btnreset:RemoveClickListener()
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeChange, self._refreshView, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeReset, self._refreshView, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onClickTalentTreeNode, self._refreshView, self)
end

function OdysseyTrialCharacterSkillTalentView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.ResetTalentSkillTree, MsgBoxEnum.BoxType.Yes_No, self.sendResetTalentTree, nil, nil, self)
end

function OdysseyTrialCharacterSkillTalentView:sendResetTalentTree()
	OdysseyRpc.instance:sendOdysseyTalentCassandraTreeResetRequest()
end

function OdysseyTrialCharacterSkillTalentView:onOpen()
	self.heroMo = self.viewParam

	local extraMo = self.heroMo.extraMo
	local trialHeroConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TrialHeroId)
	local trialHeroId = tonumber(trialHeroConstCo.value)

	self.isActTrialHero = self.heroMo.trialCo and self.heroMo.trialCo.id == trialHeroId
	self.skillTalentMo = extraMo and self.heroMo.trialCo and self.isActTrialHero and OdysseyTalentModel.instance:getTrialCassandraTreeInfo() or extraMo:getSkillTalentMo()
	self._isOpen = true

	self:_refreshView()
end

return OdysseyTrialCharacterSkillTalentView
