-- chunkname: @modules/logic/playercard/view/StorePlayerCardView.lua

module("modules.logic.playercard.view.StorePlayerCardView", package.seeall)

local StorePlayerCardView = class("StorePlayerCardView", NewPlayerCardView)

function StorePlayerCardView:onOpen(tempSkinId, tempItemSkinId)
	self._achievementCls = self._achievementCls or MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, PlayerCardAchievement)
	self._achievementCls.viewParam = self.viewParam
	self._achievementCls.viewContainer = self.viewContainer

	self._achievementCls:onOpen()

	self._infoCls = self._infoCls or MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, PlayerCardPlayerInfo)
	self._infoCls.viewParam = self.viewParam

	self._infoCls:onOpen()

	self._loader = self._loader or MultiAbLoader.New()
	self._socialitemPath = "ui/viewres/social/socialfrienditem.prefab"
	self._skinId = tempItemSkinId

	if not self._socialitem then
		self._loader:addPath(self._socialitemPath)
		self._loader:startLoad(self._onLoadFinish, self)
	else
		self:_showSocialItem()
	end

	self.viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self:_onOpen(tempSkinId, tempItemSkinId)
end

function StorePlayerCardView:_onOpen(tempSkinId, tempItemSkinId)
	self._animator.enabled = true

	if self.viewParam and self.viewParam.userId then
		self.userId = self.viewParam.userId
	end

	self.playercardinfo = PlayerCardModel.instance:getCardInfo(self.userId)

	if not tempItemSkinId then
		::label_2_0::

		local themeId = self.playercardinfo:getThemeId()

		if themeId == 0 or string.nilorempty(themeId) then
			themeId = nil
		end

		self.themeId = themeId

		local _, skinId, _, _ = self.playercardinfo:getMainHero()

		if tempSkinId and tempSkinId > 0 then
			skinId = tempSkinId
		end

		self:_creatBgEffect()

		local heroId = SkinConfig.instance:getSkinCo(skinId).characterId

		self:_updateHero(heroId, skinId)
		self:_refreshProgress()
		self:_refreshBaseInfo()
		self:_initCritter()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)

		self.progressopen = false
		self.baseinfoopen = false
	end
end

function StorePlayerCardView:_editableInitView()
	StorePlayerCardView.super._editableInitView(self)
	transformhelper.setLocalScale(self._root.transform, 0.7, 0.7, 1)
	transformhelper.setLocalPosXY(self._root.transform, 0, 40)
end

function StorePlayerCardView:_onLoadFinish()
	local assetItem = self._loader:getAssetItem(self._socialitemPath)
	local viewPrefab = assetItem:GetResource(self._socialitemPath)

	self._socialitem = gohelper.clone(viewPrefab, self.viewGO)
	self._socialfrienditemcls = MonoHelper.addNoUpdateLuaComOnceToGo(self._socialitem, StorePlayerCardInfoItem)

	self:_showSocialItem()
end

function StorePlayerCardView:_showSocialItem()
	if not self._socialitem or not self._socialfrienditemcls then
		return
	end

	local selfInfo = PlayerModel.instance:getPlayinfo()
	local mo = {
		time = 0,
		userId = selfInfo.userId,
		name = selfInfo.name,
		level = selfInfo.level,
		portrait = selfInfo.portrait
	}

	self._socialfrienditemcls:onUpdateMO(mo)
	self._socialfrienditemcls:selectSkin(self._skinId)
	transformhelper.setLocalScale(self._socialitem.transform, 0.75, 0.75, 1)
	transformhelper.setLocalPosXY(self._socialitem.transform, 730, 150)
end

function StorePlayerCardView:_disposeLoader()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function StorePlayerCardView:onShowDecorateStoreDefault()
	self:playAnim("open", 1)

	if self._socialfrienditemcls then
		self._socialfrienditemcls:onShowDecorateStoreDefault()
	end
end

function StorePlayerCardView:playAnim(animName, progtress)
	if self.viewAnim then
		self.viewAnim:Play(animName, 0, progtress)
	end
end

function StorePlayerCardView:onDestroy()
	StorePlayerCardView.super.onDestroy(self)
	self:_disposeLoader()
end

function StorePlayerCardView:onClose()
	self:resetSpine()
	self:removeEvents()

	self._has_onInitView = false

	if self._scrollView then
		self._scrollView:onDestroyViewInternal()
		self._scrollView:__onDispose()
	end

	gohelper.destroy(self.goskinpreview)

	self._scrollView = nil
end

return StorePlayerCardView
