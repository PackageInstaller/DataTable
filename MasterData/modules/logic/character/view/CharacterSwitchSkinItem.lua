-- chunkname: @modules/logic/character/view/CharacterSwitchSkinItem.lua

module("modules.logic.character.view.CharacterSwitchSkinItem", package.seeall)

local CharacterSwitchSkinItem = class("CharacterSwitchSkinItem", LuaCompBase)

function CharacterSwitchSkinItem:showSkin(heroId, skinId)
	self._heroId = heroId
	self._skinId = skinId

	gohelper.setActive(self.viewGO, true)

	self._image = self._singleImg:GetComponent(gohelper.Type_Image)
	self._image.enabled = false

	self._singleImg:LoadImage(ResUrl.getHeadIconMiddle(skinId), self._loadCallback, self)
end

function CharacterSwitchSkinItem:_loadCallback()
	self._image.enabled = true
end

function CharacterSwitchSkinItem:setSelected(value)
	self._selected = value

	gohelper.setActive(self._selectGo, value)
	gohelper.setActive(self._unselectGo, not value)

	self._canvas.alpha = value and 1 or 0.75
end

function CharacterSwitchSkinItem:init(go)
	self.viewGO = go
	self._singleImg = gohelper.findChildSingleImage(self.viewGO, "heroskin")
	self._selectGo = gohelper.findChild(self.viewGO, "heroskin/select")
	self._unselectGo = gohelper.findChild(self.viewGO, "heroskin/unselect")
	self._canvas = gohelper.findChildComponent(self.viewGO, "heroskin", typeof(UnityEngine.CanvasGroup))
end

function CharacterSwitchSkinItem:addEventListeners()
	self._click = gohelper.getClickWithAudio(self.viewGO, AudioEnum.UI.play_ui_character_switch)

	if self._click then
		self._click:AddClickListener(self._onClick, self)
	end

	CharacterController.instance:registerCallback(CharacterEvent.SwitchHeroSkin, self._switchHeroSkin, self)
end

function CharacterSwitchSkinItem:removeEventListeners()
	CharacterController.instance:unregisterCallback(CharacterEvent.SwitchHeroSkin, self._switchHeroSkin, self)

	if self._click then
		self._click:RemoveClickListener()
	end
end

function CharacterSwitchSkinItem:_switchHeroSkin(heroId, skinId)
	local value = heroId == self._heroId and self._skinId == skinId

	self:setSelected(value)
end

function CharacterSwitchSkinItem:_onClick()
	if self._selected then
		return
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.SwitchHeroSkin, self._heroId, self._skinId)
end

function CharacterSwitchSkinItem:onStart()
	return
end

function CharacterSwitchSkinItem:onDestroy()
	self._singleImg:UnLoadImage()
end

return CharacterSwitchSkinItem
