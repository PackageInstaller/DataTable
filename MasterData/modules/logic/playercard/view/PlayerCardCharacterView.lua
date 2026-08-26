-- chunkname: @modules/logic/playercard/view/PlayerCardCharacterView.lua

module("modules.logic.playercard.view.PlayerCardCharacterView", package.seeall)

local PlayerCardCharacterView = class("PlayerCardCharacterView", BaseView)

function PlayerCardCharacterView:onInitView()
	self.goLeft = gohelper.findChild(self.viewGO, "Left")
	self._simageskin = gohelper.findChildSingleImage(self.viewGO, "Left/characterSpine/#go_skincontainer/#simage_skin")
	self._simagel2d = gohelper.findChildSingleImage(self.viewGO, "Left/characterSpine/#go_skincontainer/#simage_l2d")
	self._spineContainer = gohelper.findChild(self.viewGO, "Left/characterSpine/#go_skincontainer/#go_spinecontainer")
	self._gobigspine = gohelper.findChild(self.viewGO, "Left/characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_switch")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "#btn_switch/#simage_signature")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardCharacterView:addEvents()
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.UpdateCardInfo, self.refreshSkin, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function PlayerCardCharacterView:removeEvents()
	self._btnswitch:RemoveClickListener()
end

function PlayerCardCharacterView:_onOpenView(viewName)
	if viewName == ViewName.PlayerCardCharacterSwitchView and self.bigSpine then
		self.bigSpine:setModelVisible(false)
	end
end

function PlayerCardCharacterView:_onCloseView(viewName)
	if viewName == ViewName.PlayerCardCharacterSwitchView and self.bigSpine then
		self.bigSpine:setModelVisible(true)
	end
end

function PlayerCardCharacterView:_btnswitchOnClick()
	ViewMgr.instance:openView(ViewName.PlayerCardCharacterSwitchView, {
		userId = self.userId
	})
end

function PlayerCardCharacterView:_editableInitView()
	return
end

function PlayerCardCharacterView:onOpen()
	self:_updateParam()
	self:refreshSkin()
end

function PlayerCardCharacterView:onUpdateParam()
	self:_updateParam()
	self:refreshSkin()
end

function PlayerCardCharacterView:_updateParam()
	local param = self.viewParam

	self.userId = param.userId
end

function PlayerCardCharacterView:refreshSignature()
	self._simagesignature:LoadImage(ResUrl.getSignature(self.heroCo.signature))
end

function PlayerCardCharacterView:refreshSkin()
	local info = PlayerCardModel.instance:getCardInfo(self.userId)

	if not info then
		gohelper.setActive(self.goLeft, false)
		gohelper.setActive(self._btnswitch, false)

		return
	end

	local heroId, skinId, _, isL2d = info:getMainHero()

	self:_updateHero(heroId, skinId, isL2d)
end

function PlayerCardCharacterView:_updateHero(heroId, skinId, isL2d)
	local hero = HeroModel.instance:getByHeroId(heroId)
	local skinCo = SkinConfig.instance:getSkinCo(skinId or hero and hero.skin)

	if not skinCo then
		gohelper.setActive(self.goLeft, false)

		return
	end

	gohelper.setActive(self.goLeft, true)

	self.skinCo = skinCo
	self.heroCo = HeroConfig.instance:getHeroCO(self.skinCo.characterId)

	self:resetRes()
	self:refreshSignature()
	self:refreshBigVertical(isL2d)
	self:_refreshSkinInfo()
end

function PlayerCardCharacterView:resetRes()
	self._simageskin:UnLoadImage()
	self._simagel2d:UnLoadImage()
end

function PlayerCardCharacterView:refreshBigVertical(isL2d)
	gohelper.setActive(self._spineContainer, isL2d)
	gohelper.setActive(self._simageskin.gameObject, not isL2d)

	if isL2d then
		if self.bigSpine == nil then
			self.bigSpine = GuiModelAgent.Create(self._gobigspine, true)
		end

		self.bigSpine:setResPath(self.skinCo, self.onBigSpineLoaded, self)
	else
		self._simageskin:LoadImage(ResUrl.getHeadIconImg(self.skinCo.id), self._loadedImage, self)
	end

	local live2dbg = self.skinCo.live2dbg

	if not string.nilorempty(live2dbg) then
		gohelper.setActive(self._simagel2d.gameObject, isL2d)
		self._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(live2dbg))
	else
		gohelper.setActive(self._simagel2d.gameObject, false)
	end
end

function PlayerCardCharacterView:_refreshSkinInfo()
	gohelper.setActive(self._btnswitch, PlayerModel.instance:isPlayerSelf(self.userId))
end

function PlayerCardCharacterView:onBigSpineLoaded()
	self.bigSpine:setAllLayer(UnityLayer.SceneEffect)

	local offsetStr = self.skinCo.playercardViewLive2dOffset

	if string.nilorempty(offsetStr) then
		offsetStr = self.skinCo.characterViewOffset
	end

	local offsets = SkinConfig.instance:getSkinOffset(offsetStr)

	recthelper.setAnchor(self._gobigspine.transform, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gobigspine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	self.bigSpine:setModelVisible(not ViewMgr.instance:isOpen(ViewName.PlayerCardCharacterSwitchView))
end

function PlayerCardCharacterView:_loadedImage()
	ZProj.UGUIHelper.SetImageSize(self._simageskin.gameObject)

	local offsetStr = self.skinCo.playercardViewImgOffset

	if string.nilorempty(offsetStr) then
		offsetStr = self.skinCo.characterViewImgOffset
	end

	if not string.nilorempty(offsetStr) then
		local offsets = string.splitToNumber(offsetStr, "#")

		recthelper.setAnchor(self._simageskin.transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._simageskin.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	else
		recthelper.setAnchor(self._simageskin.transform, -150, -150)
		transformhelper.setLocalScale(self._simageskin.transform, 0.6, 0.6, 0.6)
	end
end

function PlayerCardCharacterView:onClose()
	self._simageskin:UnLoadImage()
	self._simagesignature:UnLoadImage()
	self._simagel2d:UnLoadImage()

	if self.bigSpine then
		self.bigSpine:setModelVisible(false)
	end
end

function PlayerCardCharacterView:setShaderKeyWord(enable)
	if enable then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function PlayerCardCharacterView:onDestroyView()
	if self.bigSpine then
		self.bigSpine:onDestroy()

		self.bigSpine = nil
	end

	self._simagesignature:UnLoadImage()
	self._simagel2d:UnLoadImage()
	self._simageskin:UnLoadImage()
end

return PlayerCardCharacterView
