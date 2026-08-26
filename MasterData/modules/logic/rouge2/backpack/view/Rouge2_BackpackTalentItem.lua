-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackTalentItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackTalentItem", package.seeall)

local Rouge2_BackpackTalentItem = class("Rouge2_BackpackTalentItem", Rouge2_BackpackTalentItemBase)

function Rouge2_BackpackTalentItem:init(go)
	Rouge2_BackpackTalentItem.super.init(self, go)

	self._goLock = gohelper.findChild(self.go, "go_Lock")
	self._imageLockIcon = gohelper.findChildImage(self.go, "go_Lock/image_Icon")
	self._txtLockName = gohelper.findChildText(self.go, "go_Lock/txt_Name")
	self._goUnlockNotActive = gohelper.findChild(self.go, "go_Unlock_NotActive")
	self._imageUnlockNotActiveIcon = gohelper.findChildImage(self.go, "go_Unlock_NotActive/image_Icon")
	self._txtUnlockNotActiveName = gohelper.findChildText(self.go, "go_Unlock_NotActive/txt_Name")
	self._goUnlockCanActive = gohelper.findChild(self.go, "go_Unlock_CanActive")
	self._imageUnlockCanActiveIcon = gohelper.findChildImage(self.go, "go_Unlock_CanActive/image_Icon")
	self._txtUnlockCanActiveName = gohelper.findChildText(self.go, "go_Unlock_CanActive/txt_Name")
	self._goActive = gohelper.findChild(self.go, "go_Active")
	self._imageActiveIcon = gohelper.findChildImage(self.go, "go_Active/image_Icon")
	self._txtActiveName = gohelper.findChildText(self.go, "go_Active/txt_Name")
	self._goSelect = gohelper.findChild(self.go, "go_Select")
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
end

function Rouge2_BackpackTalentItem:refreshUI()
	gohelper.setActive(self._goLock, self._status == Rouge2_Enum.BagTalentStatus.Lock)
	gohelper.setActive(self._goUnlockNotActive, self._status == Rouge2_Enum.BagTalentStatus.UnlockNotActive)
	gohelper.setActive(self._goUnlockCanActive, self._status == Rouge2_Enum.BagTalentStatus.UnlockCanActive)
	gohelper.setActive(self._goActive, self._status == Rouge2_Enum.BagTalentStatus.Active)
	Rouge2_IconHelper.setSummonerTalentIcon(self._talentId, Rouge2_Enum.BagTalentStatus.Lock, self._imageLockIcon)
	Rouge2_IconHelper.setSummonerTalentIcon(self._talentId, Rouge2_Enum.BagTalentStatus.UnlockNotActive, self._imageUnlockNotActiveIcon)
	Rouge2_IconHelper.setSummonerTalentIcon(self._talentId, Rouge2_Enum.BagTalentStatus.UnlockCanActive, self._imageUnlockCanActiveIcon)
	Rouge2_IconHelper.setSummonerTalentIcon(self._talentId, Rouge2_Enum.BagTalentStatus.Active, self._imageActiveIcon)

	self._txtLockName.text = self._talentName
	self._txtUnlockNotActiveName.text = self._talentName
	self._txtUnlockCanActiveName.text = self._talentName
	self._txtActiveName.text = self._talentName
end

function Rouge2_BackpackTalentItem:playLockAnim()
	self._animator:Play("lock", 0, 0)
end

function Rouge2_BackpackTalentItem:playUnlockNotActiveAnim()
	self._animator:Play("unlock", 0, 0)
end

function Rouge2_BackpackTalentItem:playUnlockCanActiveAnim()
	self._animator:Play("unlock", 0, 0)
end

function Rouge2_BackpackTalentItem:playActiveAnim()
	self._animator:Play("active", 0, 0)
end

function Rouge2_BackpackTalentItem:_btnClickOnClick()
	self:tryOpenDetailView()
end

return Rouge2_BackpackTalentItem
