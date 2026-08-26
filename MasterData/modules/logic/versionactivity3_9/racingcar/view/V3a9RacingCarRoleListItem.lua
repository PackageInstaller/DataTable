-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarRoleListItem.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarRoleListItem", package.seeall)

local V3a9RacingCarRoleListItem = class("V3a9RacingCarRoleListItem", V3a9RacingCarRoleItemBase)

function V3a9RacingCarRoleListItem:onInitView()
	self._goTop = gohelper.findChild(self.viewGO, "Top")
	self._imagebg = gohelper.findChildImage(self.viewGO, "BG/#image_bg")
	self._txtTeamName = gohelper.findChildText(self.viewGO, "Top/#txt_TeamName")
	self._txtTeamIndex = gohelper.findChildText(self.viewGO, "Top/#txt_TeamName/#txt_index")
	self._txtRoleName = gohelper.findChildText(self.viewGO, "Top/#txt_RoleName")
	self._goRole = gohelper.findChild(self.viewGO, "Top/RoleIconMask")
	self._imageRoleIcon = gohelper.findChildImage(self.viewGO, "Top/RoleIconMask/#image_RoleIcon")
	self._goItem = gohelper.findChild(self.viewGO, "Attribute/#go_Item")
	self._txtDesc = gohelper.findChildText(self.viewGO, "Scroll_Desc/Viewport/Content/#txt_Desc")
	self._txtDesc2 = gohelper.findChildText(self.viewGO, "Scroll_Desc/Viewport/Content/#txt_Desc_2")
	self._goLock = gohelper.findChild(self.viewGO, "#go_Lock")
	self._btnUnlockBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Lock/#btn_UnlockBtn")
	self._goLockBG = gohelper.findChild(self.viewGO, "#go_Lock/#btn_UnlockBtn/#go_LockBG")
	self._goNormalBG = gohelper.findChild(self.viewGO, "#go_Lock/#btn_UnlockBtn/#go_NormalBG")
	self._imageRoleIcon2 = gohelper.findChildImage(self.viewGO, "#go_Lock/mask/#image_RoleIcon2")
	self._txtCurrencyNum = gohelper.findChildText(self.viewGO, "#go_Lock/#btn_UnlockBtn/#txt_CurrencyNum")
	self._goReddot = gohelper.findChild(self.viewGO, "#go_Lock/#btn_UnlockBtn/#go_Reddot")
	self._goSelect = gohelper.findChild(self.viewGO, "#go_Select")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9RacingCarRoleListItem:_onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if not self:_getIsUnlock() then
		GameFacade.showToast(ToastEnum.V3a9_Racing_Car_Tip2)

		return
	end

	if not self._isSelected then
		V3a9RacingCarRoleListModel.instance:setSelectedCell(self._index, true)
	end
end

function V3a9RacingCarRoleListItem:onUpdateMO(mo)
	self._config = mo:getConfig()
	self._mo = mo

	if self._txtRoleName then
		self._txtRoleName.text = self._config.name
	end

	self._txtTeamName.text = self._config.name
	self._txtTeamIndex.text = self._config.id
	self._txtDesc.text = self._config.desc
	self._txtDesc2.text = self._config.desc1

	UISpriteSetMgr.instance:setV3a9RacingSprite(self._imagebg, "v3a9_racing_playerbg_2_" .. self._config.uiPic)

	local icon = "v3a9_racing_game_character_choose_" .. self._config.pic

	UISpriteSetMgr.instance:setV3a9RacingSprite(self._imageRoleIcon, icon)
	UISpriteSetMgr.instance:setV3a9RacingSprite(self._imageRoleIcon2, icon)
	self:_refreshAttr()
	self:_refreshUnlock()
end

return V3a9RacingCarRoleListItem
