-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyTrialCharacterTalentTreeView.lua

module("modules.logic.sp01.odyssey.view.OdysseyTrialCharacterTalentTreeView", package.seeall)

local OdysseyTrialCharacterTalentTreeView = class("OdysseyTrialCharacterTalentTreeView", CharacterSkillTalentTreeView)

function OdysseyTrialCharacterTalentTreeView:onInitView()
	OdysseyTrialCharacterTalentTreeView.super.onInitView(self)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyTrialCharacterTalentTreeView:addEvents()
	OdysseyTrialCharacterTalentTreeView.super.addEvents(self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeChange, self._onTrialTalentTreeChangeReply, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeReset, self._onTrialTalentTreeResetReply, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onClickTalentTreeNode, self._onClickTalentTreeNode, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onCloseSkillTalentTipView, self._onCloseSkillTalentTipView, self)
end

function OdysseyTrialCharacterTalentTreeView:removeEvents()
	OdysseyTrialCharacterTalentTreeView.super.removeEvents(self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeChange, self._onTrialTalentTreeChangeReply, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeReset, self._onTrialTalentTreeResetReply, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onClickTalentTreeNode, self._onClickTalentTreeNode, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onCloseSkillTalentTipView, self._onCloseSkillTalentTipView, self)
end

function OdysseyTrialCharacterTalentTreeView:_onTrialTalentTreeChangeReply()
	self:_refreshView()
end

function OdysseyTrialCharacterTalentTreeView:_onTrialTalentTreeResetReply()
	self:_refreshView()
end

function OdysseyTrialCharacterTalentTreeView:onOpen()
	self.heroMo = self.viewParam

	local extraMo = self.heroMo.extraMo
	local trialHeroConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TrialHeroId)
	local trialHeroId = tonumber(trialHeroConstCo.value)

	self.isActTrialHero = self.heroMo.trialCo and self.heroMo.trialCo.id == trialHeroId
	self.skillTalentMo = extraMo and self.heroMo.trialCo and self.isActTrialHero and OdysseyTalentModel.instance:getTrialCassandraTreeInfo() or extraMo:getSkillTalentMo()

	self:_refreshSubTree()
	self:_refreshView()
end

return OdysseyTrialCharacterTalentTreeView
