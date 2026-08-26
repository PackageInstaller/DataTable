-- chunkname: @modules/logic/playercard/view/PlayerCardCharacterSwitchCharacterView.lua

module("modules.logic.playercard.view.PlayerCardCharacterSwitchCharacterView", package.seeall)

local PlayerCardCharacterSwitchCharacterView = class("PlayerCardCharacterSwitchCharacterView", BaseView)

function PlayerCardCharacterSwitchCharacterView:onInitView()
	self.goLeft = gohelper.findChild(self.viewGO, "#go_characterswitchview/characterswitchview/rightLeft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardCharacterSwitchCharacterView:addEvents()
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.RefreshSwitchView, self._onRefreshSwitchView, self)
end

function PlayerCardCharacterSwitchCharacterView:removeEvents()
	return
end

function PlayerCardCharacterSwitchCharacterView:onSwitchAnimDone()
	return
end

function PlayerCardCharacterSwitchCharacterView:_editableInitView()
	gohelper.setActive(self._simageskin.gameObject, true)
end

function PlayerCardCharacterSwitchCharacterView:_onRefreshSwitchView(param)
	self:_updateHero(param.heroId, param.skinId, param.isL2d)
end

function PlayerCardCharacterSwitchCharacterView:setHeroId(heroId)
	if heroId then
		self._heroIdSet = self._heroIdSet or {}
		self._heroIdSet[heroId] = true

		if tabletool.len(self._heroIdSet) >= 5 then
			self._heroIdSet = {}

			GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0.5, self)
		end
	end
end

function PlayerCardCharacterSwitchCharacterView:_updateHero(heroId, skinId, isL2d)
	local hero = HeroModel.instance:getByHeroId(heroId)
	local skinCo = SkinConfig.instance:getSkinCo(skinId or hero and hero.skin)

	if not skinCo then
		gohelper.setActive(self.goLeft, false)

		return
	end

	gohelper.setActive(self.goLeft, true)

	self.skinCo = skinCo
	self.heroCo = HeroConfig.instance:getHeroCO(self.skinCo.characterId)

	self:refreshSkin(isL2d)
end

function PlayerCardCharacterSwitchCharacterView:refreshSkin(isL2d)
	self:resetRes()
	self:refreshBigVertical(isL2d)
end

function PlayerCardCharacterSwitchCharacterView:resetRes()
	self._simageskin:UnLoadImage()
end

function PlayerCardCharacterSwitchCharacterView:refreshBigVertical(isL2d)
	self._simageskin:LoadImage(ResUrl.getHeadIconImg(self.skinCo.id), self._loadedImage, self)
end

function PlayerCardCharacterSwitchCharacterView:_loadedImage()
	ZProj.UGUIHelper.SetImageSize(self._simageskin.gameObject)

	local offsetStr = self.skinCo.playercardViewImgOffset

	if string.nilorempty(offsetStr) then
		offsetStr = self.skinCo.characterViewImgOffset
	end

	if not string.nilorempty(offsetStr) then
		local offsets = string.splitToNumber(offsetStr, "#")

		recthelper.setAnchor(self._simageskin.transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._simageskin.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	end
end

function PlayerCardCharacterSwitchCharacterView:onClose()
	self._simageskin:UnLoadImage()
end

function PlayerCardCharacterSwitchCharacterView:setShaderKeyWord(enable)
	if enable then
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	else
		UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
	end
end

function PlayerCardCharacterSwitchCharacterView:onDestroyView()
	self._simageskin:UnLoadImage()
end

return PlayerCardCharacterSwitchCharacterView
