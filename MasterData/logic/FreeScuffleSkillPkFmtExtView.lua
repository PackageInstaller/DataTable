-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleSkillPkFmtExtView.lua

module("logic.extensions.freescuffle.view.FreeScuffleSkillPkFmtExtView", package.seeall)

local FreeScuffleSkillPkFmtExtView = class("FreeScuffleSkillPkFmtExtView", ViewComponent)

function FreeScuffleSkillPkFmtExtView:buildUI()
	FreeScuffleSkillPkFmtExtView.super.buildUI(self)

	self._btnSkill = self:getGo("btnSkill")
end

function FreeScuffleSkillPkFmtExtView:bindEvents()
	FreeScuffleSkillPkFmtExtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
end

function FreeScuffleSkillPkFmtExtView:unbindEvents()
	FreeScuffleSkillPkFmtExtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSkill)
end

function FreeScuffleSkillPkFmtExtView:onEnter()
	FreeScuffleSkillPkFmtExtView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._activityId = self._customFmtMo:getActivityId()
	self._subMo = FreeScuffleController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.FreeScuffleUpdateSkillBag, self._freeScuffleUpdateSkillBag, self)
	self:_onUpdate()
end

function FreeScuffleSkillPkFmtExtView:onExit()
	FreeScuffleSkillPkFmtExtView.super.onExit(self)
end

function FreeScuffleSkillPkFmtExtView:_freeScuffleUpdateSkillBag()
	self._customFmtMo:onDispatchFormationChanged()
end

function FreeScuffleSkillPkFmtExtView:_onUpdate()
	return
end

function FreeScuffleSkillPkFmtExtView:_onClickBtnSkill()
	local infos = self._subMo:getBattlePetIdDic()

	if TableUtil.isTableEmpty(infos) then
		FloatWordMgr.instance:show("还未拥有战斗精灵，无法调整技能")

		return
	end

	UIStateManager.instance:push(ViewName.FreeScuffleSkillBagView, self._activityId, FreeScuffleEnum.FmtType_Pk, self._customFmtMo._rightPetList)
end

return FreeScuffleSkillPkFmtExtView
