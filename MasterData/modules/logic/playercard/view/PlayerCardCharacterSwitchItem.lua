-- chunkname: @modules/logic/playercard/view/PlayerCardCharacterSwitchItem.lua

module("modules.logic.playercard.view.PlayerCardCharacterSwitchItem", package.seeall)

local PlayerCardCharacterSwitchItem = class("PlayerCardCharacterSwitchItem", ListScrollCellExtend)

function PlayerCardCharacterSwitchItem:onInitView()
	self._gorandom = gohelper.findChild(self.viewGO, "#go_random")
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_normal/#txt_name")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardCharacterSwitchItem:addEvents()
	return
end

function PlayerCardCharacterSwitchItem:removeEvents()
	return
end

function PlayerCardCharacterSwitchItem:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self.viewGO)
end

function PlayerCardCharacterSwitchItem:_editableAddEvents()
	self._click:AddClickListener(self._onClick, self)
end

function PlayerCardCharacterSwitchItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function PlayerCardCharacterSwitchItem:_onClick()
	if self._isSelect then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)
	self._view:selectCell(self._index, true)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SwitchHero, {
		self._heroId,
		self._skinId,
		self._mo.isRandom
	})
end

function PlayerCardCharacterSwitchItem:onUpdateMO(mo)
	self._mo = mo
	self._skinId = self._mo.skinId
	self._heroId = nil

	gohelper.setActive(self._gorandom, self._mo.isRandom)
	gohelper.setActive(self._gonormal, not self._mo.isRandom)

	if self._mo.isRandom then
		return
	end

	self._config = self._mo.heroMO.config
	self._heroId = self._mo.heroMO.heroId
	self._txtname.text = self._config.name

	self._simageicon:LoadImage(ResUrl.getHeadIconSmall(self._skinId))
end

function PlayerCardCharacterSwitchItem:onSelect(isSelect)
	self._isSelect = isSelect

	self._goselected:SetActive(isSelect)
end

function PlayerCardCharacterSwitchItem:onDestroyView()
	self._simageicon:UnLoadImage()
end

return PlayerCardCharacterSwitchItem
