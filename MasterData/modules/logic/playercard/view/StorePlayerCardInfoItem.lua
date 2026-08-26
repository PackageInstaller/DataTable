-- chunkname: @modules/logic/playercard/view/StorePlayerCardInfoItem.lua

module("modules.logic.playercard.view.StorePlayerCardInfoItem", package.seeall)

local StorePlayerCardInfoItem = class("StorePlayerCardInfoItem", SocialFriendItem)

function StorePlayerCardInfoItem:_editableInitView()
	StorePlayerCardInfoItem.super._editableInitView(self)

	self.viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	self._playericon:setEnableClick(false)
end

function StorePlayerCardInfoItem:onShowDecorateStoreDefault()
	self:playAnim("open", 1)

	if self._goskinEffect then
		self._skinEffectAnim = self._skinEffectAnim or self._goskinEffect:GetComponent(typeof(UnityEngine.Animator))

		self._skinEffectAnim:Play("open", 0, 1)
	end
end

function StorePlayerCardInfoItem:playAnim(animName, progtress)
	if self.viewAnim then
		self.viewAnim:Play(animName, 0, progtress)
	end
end

return StorePlayerCardInfoItem
