-- chunkname: @modules/logic/playercard/view/PlayerCardThemeItem.lua

module("modules.logic.playercard.view.PlayerCardThemeItem", package.seeall)

local PlayerCardThemeItem = class("PlayerCardThemeItem", ListScrollCellExtend)

function PlayerCardThemeItem:init(go)
	self.viewGO = go
	self.simageBg = gohelper.findChildSingleImage(self.viewGO, "themeBg")
	self.txtName = gohelper.findChildTextMesh(self.viewGO, "#txt_name")
	self.goLocked = gohelper.findChild(self.viewGO, "#go_locked")
	self.goSelect = gohelper.findChild(self.viewGO, "#go_select")
	self.goUsing = gohelper.findChild(self.viewGO, "#go_using")
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "click")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")
end

function PlayerCardThemeItem:addEvents()
	self.btnClick:AddClickListener(self._onClick, self)
	PlayerCardController.instance:registerCallback(PlayerCardEvent.SwitchTheme, self.refreshUI, self)
	PlayerCardController.instance:registerCallback(PlayerCardEvent.ChangeSkin, self.refreshUI, self)
end

function PlayerCardThemeItem:removeEvents()
	PlayerCardController.instance:unregisterCallback(PlayerCardEvent.SwitchTheme, self.refreshUI, self)
	PlayerCardController.instance:unregisterCallback(PlayerCardEvent.ChangeSkin, self.refreshUI, self)
	self.btnClick:RemoveClickListener()
end

function PlayerCardThemeItem:_isShowRedDot()
	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayerCardNewBgSkinRed) .. self._mo.id

	return PlayerPrefsHelper.getNumber(key, 0) == 1
end

function PlayerCardThemeItem:_onClick()
	PlayerCardModel.instance:setSelectSkinMO(self._mo)

	if self:_isShowRedDot() then
		PlayerCardController.instance:setBgSkinRed(self._mo.id, false)
		PlayerCardModel.instance:setShowRed()
		gohelper.setActive(self._goreddot, false)
	end

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SwitchTheme, self._mo.id)
end

function PlayerCardThemeItem:refreshUI()
	local isSelect = self._skinId == PlayerCardModel.instance:getSelectSkinMO().id

	gohelper.setActive(self.goSelect, isSelect)

	local isUsing = self._mo:checkIsUse()

	gohelper.setActive(self.goUsing, isUsing)
end

function PlayerCardThemeItem:onUpdateMO(mo)
	self._mo = mo
	self._skinId = self._mo:isEmpty() and 0 or self._mo.id
	self._config = self._mo:getConfig()
	self._bgreddot = self._bgreddot or RedDotController.instance:addNotEventRedDot(self._goreddot, self._isShowRedDot, self)

	if self._mo:isEmpty() then
		self:refreshEmpty()
	else
		self:refreshItem()
	end

	local isSelect = self._skinId == PlayerCardModel.instance:getSelectSkinMO().id

	gohelper.setActive(self.goSelect, isSelect)

	local isUsing = self._mo:checkIsUse()

	gohelper.setActive(self.goUsing, isUsing)
end

function PlayerCardThemeItem:refreshEmpty()
	self.txtName.text = luaLang("talent_style_special_tag_998")

	self.simageBg:LoadImage(ResUrl.getPlayerCardIcon("banner/" .. self._skinId))
	gohelper.setActive(self.goLocked, false)
end

function PlayerCardThemeItem:refreshItem()
	self.txtName.text = self._config.name

	self.simageBg:LoadImage(ResUrl.getPlayerCardIcon("banner/" .. self._skinId))
	gohelper.setActive(self.goLocked, not self._mo:isUnLock())
	self._bgreddot:setShowType(RedDotEnum.Style.Normal)
	self._bgreddot:setCheckShowRedDotFunc(self._isShowRedDot, self)
end

function PlayerCardThemeItem:onDestroy()
	self.simageBg:UnLoadImage()
end

return PlayerCardThemeItem
