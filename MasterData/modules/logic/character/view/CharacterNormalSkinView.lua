-- chunkname: @modules/logic/character/view/CharacterNormalSkinView.lua

module("modules.logic.character.view.CharacterNormalSkinView", package.seeall)

local CharacterNormalSkinView = class("CharacterNormalSkinView", BaseView)

function CharacterNormalSkinView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goskincontainer = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer")
	self._simageskin = gohelper.findChildSingleImage(self.viewGO, "characterSpine/#go_skincontainer/#simage_skin")
	self._simagel2d = gohelper.findChildSingleImage(self.viewGO, "characterSpine/#go_skincontainer/#simage_l2d")
	self._gospinecontainer = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer")
	self._gospine = gohelper.findChild(self.viewGO, "characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	self._simagesignatureicon = gohelper.findChildSingleImage(self.viewGO, "desc/#simage_signatureicon")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "desc/#simage_signature")
	self._txtsp = gohelper.findChildText(self.viewGO, "desc/sp/#txt_sp")
	self._txtcharacterName = gohelper.findChildText(self.viewGO, "desc/#txt_characterName")
	self._txtskinName = gohelper.findChildText(self.viewGO, "desc/#txt_skinName")
	self._txtskinNameEn = gohelper.findChildText(self.viewGO, "desc/#txt_skinName/#txt_skinNameEn")
	self._txtdesc = gohelper.findChildText(self.viewGO, "desc/#txt_desc")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "desc/#btn_switch")
	self._txtswitch = gohelper.findChildText(self.viewGO, "desc/#btn_switch/#txt_switch")
	self._gobtntopleft = gohelper.findChild(self.viewGO, "#go_btntopleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterNormalSkinView:addEvents()
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
end

function CharacterNormalSkinView:removeEvents()
	self._btnswitch:RemoveClickListener()
end

function CharacterNormalSkinView:_btnswitchOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_switch_skin_l2d)

	self._isShowSpine = not self._isShowSpine

	self._animator:Play(UIAnimationName.Switch, 0, 0)
	self:_refreshTxtSwitch()
	TaskDispatcher.cancelTask(self._refreshBigVertical, self)
	TaskDispatcher.runDelay(self._refreshBigVertical, self, 0.16)
end

function CharacterNormalSkinView:_editableInitView()
	self._animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._simageskinGo = self._simageskin.gameObject
	self._gospineTran = self._gospine.transform
	self._sp = CharacterSpName.s_createByView(self, gohelper.findChild(self.viewGO, "desc/sp/")):bindName0(self._txtcharacterName)

	self._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))
end

function CharacterNormalSkinView:_loadSpine()
	local skinCo = self._skinCo

	if self._bigSpine then
		self._bigSpine:onDestroy()
	end

	self._bigSpine = GuiModelAgent.Create(self._gospine, true)

	self._bigSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, self.viewName)
	self._bigSpine:setResPath(skinCo, self._onBigSpineLoaded, self)
end

function CharacterNormalSkinView:onUpdateParam()
	self:_refresh()
	self:_refreshTxtSwitch()
	self:_refreshBigVertical()
end

function CharacterNormalSkinView:onOpen()
	self._isShowSpine = true

	local skinId = self.viewParam.skinId

	self._skinCo = SkinConfig.instance:getSkinCo(skinId)
	self._heroCo = HeroConfig.instance:getHeroCO(self._skinCo.characterId)

	self:_loadSpine()
	self:onUpdateParam()
end

function CharacterNormalSkinView:onOpenFinish()
	local skinCfg = self._skinCo

	if skinCfg then
		local chineseViewNameStr = (StatViewNameEnum.ChineseViewName[self.viewName] or self.viewName) .. "-" .. (skinCfg.name or "")

		StatViewController.instance:trackViewName(chineseViewNameStr)
	end
end

function CharacterNormalSkinView:onClose()
	return
end

function CharacterNormalSkinView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshBigVertical, self)
	self._simageskin:UnLoadImage()
	self._simagesignature:UnLoadImage()
	self._simagesignatureicon:UnLoadImage()
	self._simagebg:UnLoadImage()

	if self._bigSpine then
		self._bigSpine:onDestroy()

		self._bigSpine = nil
	end
end

function CharacterNormalSkinView:_onBigSpineLoaded()
	local skinCo = self._skinCo
	local offsetStr = skinCo.skinSwitchLive2dOffset

	if string.nilorempty(offsetStr) then
		offsetStr = skinCo.characterViewOffset
	end

	local offsets = SkinConfig.instance:getSkinOffset(offsetStr)
	local scale = tonumber(offsets[3]) * 1

	self._bigSpine:setAllLayer(UnityLayer.SceneEffect)
	CharacterVoiceEnum.setSpineOffset(self._bigSpine, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gospineTran, scale, scale, scale)
end

function CharacterNormalSkinView:_refresh()
	local skinCo = self._skinCo
	local heroId = self._heroCo.id

	self._simagesignature:LoadImage(ResUrl.getSignature(self._heroCo.signature, "characterget"))
	self._simagesignatureicon:LoadImage(ResUrl.getSignature("3011_2", "characterget"))
	self._sp:onUpdateMO({
		heroId = heroId
	}):setAsML_SpAndName0()

	self._txtskinName.text = "— " .. skinCo.characterSkin
	self._txtskinNameEn.text = skinCo.characterSkinNameEng
	self._txtdesc.text = skinCo.skinDescription
end

function CharacterNormalSkinView:_refreshTxtSwitch()
	self._txtswitch.text = self._isShowSpine and luaLang("storeskinpreviewview_btnswitch") or "L2D"
end

function CharacterNormalSkinView:_refreshBigVertical()
	gohelper.setActive(self._gospinecontainer, self._isShowSpine)
	gohelper.setActive(self._simageskinGo, not self._isShowSpine)
	self._bigSpine:setModelVisible(self._isShowSpine)
end

return CharacterNormalSkinView
