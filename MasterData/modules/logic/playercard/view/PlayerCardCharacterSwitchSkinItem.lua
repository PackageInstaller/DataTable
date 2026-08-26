-- chunkname: @modules/logic/playercard/view/PlayerCardCharacterSwitchSkinItem.lua

module("modules.logic.playercard.view.PlayerCardCharacterSwitchSkinItem", package.seeall)

local PlayerCardCharacterSwitchSkinItem = class("PlayerCardCharacterSwitchSkinItem", LuaCompBase)

function PlayerCardCharacterSwitchSkinItem:showSkin(heroId, skinId)
	self._heroId = heroId
	self._skinId = skinId

	gohelper.setActive(self.viewGO, true)

	self._image = self._singleImg:GetComponent(gohelper.Type_Image)
	self._image.enabled = false

	self._singleImg:LoadImage(ResUrl.getHeadIconMiddle(skinId), self._loadCallback, self)
end

function PlayerCardCharacterSwitchSkinItem:_loadCallback()
	self._image.enabled = true
end

function PlayerCardCharacterSwitchSkinItem:setSelected(value)
	self._selected = value

	gohelper.setActive(self._selectGo, value)
	gohelper.setActive(self._unselectGo, not value)

	self._canvas.alpha = value and 1 or 0.75
end

function PlayerCardCharacterSwitchSkinItem:init(go)
	self.viewGO = go
	self._singleImg = gohelper.findChildSingleImage(self.viewGO, "heroskin")
	self._selectGo = gohelper.findChild(self.viewGO, "heroskin/select")
	self._unselectGo = gohelper.findChild(self.viewGO, "heroskin/unselect")
	self._canvas = gohelper.findChildComponent(self.viewGO, "heroskin", typeof(UnityEngine.CanvasGroup))
end

function PlayerCardCharacterSwitchSkinItem:addEventListeners()
	self._click = gohelper.getClickWithAudio(self.viewGO, AudioEnum.UI.play_ui_character_switch)

	if self._click then
		self._click:AddClickListener(self._onClick, self)
	end

	PlayerCardController.instance:registerCallback(PlayerCardEvent.SwitchHeroSkin, self._switchHeroSkin, self)
end

function PlayerCardCharacterSwitchSkinItem:removeEventListeners()
	PlayerCardController.instance:unregisterCallback(PlayerCardEvent.SwitchHeroSkin, self._switchHeroSkin, self)

	if self._click then
		self._click:RemoveClickListener()
	end
end

function PlayerCardCharacterSwitchSkinItem:_switchHeroSkin(heroId, skinId)
	local value = heroId == self._heroId and self._skinId == skinId

	self:setSelected(value)
end

function PlayerCardCharacterSwitchSkinItem:_onClick()
	if self._selected then
		return
	end

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SwitchHeroSkin, self._heroId, self._skinId)
end

function PlayerCardCharacterSwitchSkinItem:onStart()
	return
end

function PlayerCardCharacterSwitchSkinItem:onDestroy()
	self._singleImg:UnLoadImage()
end

return PlayerCardCharacterSwitchSkinItem
