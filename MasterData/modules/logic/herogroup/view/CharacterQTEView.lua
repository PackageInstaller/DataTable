-- chunkname: @modules/logic/herogroup/view/CharacterQTEView.lua

module("modules.logic.herogroup.view.CharacterQTEView", package.seeall)

local CharacterQTEView = class("CharacterQTEView", CharacterSkillCardBase)

function CharacterQTEView:addEventListeners()
	CharacterQTEView.super.addEventListeners(self)
end

function CharacterQTEView:removeEventListeners()
	CharacterQTEView.super.removeEventListeners(self)
	self._qtebtn:RemoveClickListener()
end

function CharacterQTEView:_editableInitView()
	CharacterQTEView.super._editableInitView(self)

	self._gobreakthough = gohelper.findChild(self.viewGO, "playcards/#go_breakthough")
	self._qteicon = gohelper.findChildSingleImage(self._gobreakthough, "card/imgIcon")
	self._qtetag = gohelper.findChildSingleImage(self._gobreakthough, "card/tag/tagIcon")
	self._qtebtn = gohelper.findChildButtonWithAudio(self._gobreakthough, "btn", AudioEnum.UI.Play_ui_role_description)

	self._qtebtn:AddClickListener(self._onQteCardClick, self)

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function CharacterQTEView:_refreshUI()
	self._qteMo = SkillConfig.instance:getHeroQteMO(self._heroId, self._heroMo)

	if not self._qteMo then
		return
	end

	CharacterQTEView.super._refreshUI(self)
	self:_refreshQte()
end

function CharacterQTEView:_refreshQte()
	local skillId = self._qteMo:getActiveId()
	local skillCO = lua_skill.configDict[skillId]

	self._qteicon:LoadImage(ResUrl.getSkillIcon(skillCO.icon))
	self._qtetag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. skillCO.showTag))
end

function CharacterQTEView:playOpenAni(viewType, forcePlayAnim)
	if self.viewGO and self.viewGO.activeInHierarchy then
		local deviceViewParam = CharacterEnum.DeviceViewParam[viewType]
		local aniName = deviceViewParam and deviceViewParam.OpenAniName

		if self._playingAni == aniName then
			self._isPlayedOpenAnim = false
		end

		if not self._isPlayedOpenAnim or forcePlayAnim then
			if aniName then
				self:playAnim(aniName)
			end

			self._isPlayedOpenAnim = true
		end
	end
end

function CharacterQTEView:_onQteCardClick()
	ViewMgr.instance:openView(ViewName.QteSkillTipView, self._qteMo:getQteGroupId())
end

function CharacterQTEView:playAnim(animName)
	if not self._animatorPlayer then
		return
	end

	self._playingAni = animName

	self._animatorPlayer:Play(animName, self._playFinishAnim, self)
end

function CharacterQTEView:_playFinishAnim()
	self._playingAni = nil
end

function CharacterQTEView:onDestroy()
	CharacterQTEView.super.onDestroy(self)
	self._qteicon:UnLoadImage()
	self._qtetag:UnLoadImage()
end

return CharacterQTEView
