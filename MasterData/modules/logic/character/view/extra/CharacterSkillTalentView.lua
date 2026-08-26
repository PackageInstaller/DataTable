-- chunkname: @modules/logic/character/view/extra/CharacterSkillTalentView.lua

module("modules.logic.character.view.extra.CharacterSkillTalentView", package.seeall)

local CharacterSkillTalentView = class("CharacterSkillTalentView", BaseView)

function CharacterSkillTalentView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._txtremainTalentPoint = gohelper.findChildText(self.viewGO, "talentpoint/#txt_remainTalentPoint")
	self._txtremainTalentPointEffect = gohelper.findChildText(self.viewGO, "talentpoint/#txt_effect")
	self._txttitle = gohelper.findChildText(self.viewGO, "bottom/#txt_title")
	self._imageTagIcon = gohelper.findChildImage(self.viewGO, "bottom/#txt_title/#image_TagIcon")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "bottom/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "bottom/#scroll_desc/Viewport/#txt_desc")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkillTalentView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, self._refreshView, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onResetHero3124TalentTreeReply, self._refreshView, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, self._refreshView, self)
end

function CharacterSkillTalentView:removeEvents()
	self._btnreset:RemoveClickListener()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, self._refreshView, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onResetHero3124TalentTreeReply, self._refreshView, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, self._refreshView, self)
end

function CharacterSkillTalentView:_btnresetOnClick()
	if not self.heroMo:isOwnHero() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.ResetTalentSkillTree, MsgBoxEnum.BoxType.Yes_No, self.sendResetTalentTree, nil, nil, self)
end

function CharacterSkillTalentView:sendResetTalentTree()
	HeroRpc.instance:setResetHero3124TalentTreeRequest(self.heroMo.heroId)
end

function CharacterSkillTalentView:_editableInitView()
	self._gobottom = gohelper.findChild(self.viewGO, "bottom")

	local gotalentpoint = gohelper.findChild(self.viewGO, "talentpoint")

	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO.gameObject)
	self._talentPointAnim = gotalentpoint:GetComponent(typeof(UnityEngine.Animator))
end

function CharacterSkillTalentView:onUpdateParam()
	return
end

function CharacterSkillTalentView:onOpen()
	self.heroMo = self.viewParam

	local extraMo = self.heroMo.extraMo

	self.skillTalentMo = extraMo:getSkillTalentMo()
	self._isOpen = true

	self:_refreshView()
end

function CharacterSkillTalentView:_refreshView()
	local mainFieldMo = self.skillTalentMo:getMainFieldMo()

	self:_refreshDetail(mainFieldMo)
	self:_refreshNode()
end

function CharacterSkillTalentView:_refreshNode()
	if self._talentpoint and self._talentpoint ~= self.skillTalentMo:getTalentpoint() then
		self._talentPointAnim:Play(CharacterExtraEnum.SkillTreeAnimName.Click, 0, 0)
	end

	self._talentpoint = self.skillTalentMo:getTalentpoint()
	self._txtremainTalentPoint.text = self._talentpoint
	self._txtremainTalentPointEffect.text = self._talentpoint

	gohelper.setActive(self._btnreset.gameObject, not self.skillTalentMo:isNotLight())
end

function CharacterSkillTalentView:_refreshDetail(mo)
	local animName

	if mo then
		local exSkillLevel = self.heroMo.exSkillLevel
		local co = mo.co
		local sub = co.sub
		local fieldDesc = mo:getFieldDesc(exSkillLevel)

		self._txttitle.text = co.fieldName
		self._fieldDesc = self._fieldDesc or MonoHelper.addNoUpdateLuaComOnceToGo(self._txtdesc.gameObject, SkillDescComp)

		local desc = fieldDesc .. self.skillTalentMo:getLightNodeAdditionalDesc(exSkillLevel)

		self._fieldDesc:updateInfo(self._txtdesc, desc, self.heroMo.heroId)
		self._fieldDesc:setTipParam(nil, Vector2(250, -365))
		self._fieldDesc:setBuffTipPivot(CommonBuffTipEnum.Pivot.Down)
		UISpriteSetMgr.instance:setUiCharacterSprite(self._imageTagIcon, self.skillTalentMo:getSmallSubIconPath(sub))

		if self._isOpen then
			animName = CharacterExtraEnum.SkillTreeAnimName.OpenBottom
		elseif not self.isShowBottom then
			animName = CharacterExtraEnum.SkillTreeAnimName.Bottom
		end

		self.isShowBottom = true
	else
		if self._isOpen then
			animName = CharacterExtraEnum.SkillTreeAnimName.OpenNomal
		elseif self.isShowBottom then
			animName = CharacterExtraEnum.SkillTreeAnimName.Normal
		end

		self.isShowBottom = false
	end

	if not string.nilorempty(animName) then
		gohelper.setActive(self._gobottom, true)
		self._animPlayer:Play(animName, self._playAnimCallback, self)
	end

	self._isOpen = false
end

function CharacterSkillTalentView:_playAnimCallback()
	if not self.isShowBottom then
		gohelper.setActive(self._gobottom, false)
	end
end

function CharacterSkillTalentView:onClose()
	return
end

function CharacterSkillTalentView:onDestroyView()
	return
end

return CharacterSkillTalentView
