-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/map/EliminateSelectRoleItem.lua

module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectRoleItem", package.seeall)

local EliminateSelectRoleItem = class("EliminateSelectRoleItem", ListScrollCellExtend)

function EliminateSelectRoleItem:onInitView()
	self._goRole = gohelper.findChild(self.viewGO, "#go_Role")
	self._goRoleSelected = gohelper.findChild(self.viewGO, "#go_Role/#go_RoleSelected")
	self._imageRoleBG = gohelper.findChildImage(self.viewGO, "#go_Role/#image_RoleBG")
	self._imageRoleHPBG = gohelper.findChildImage(self.viewGO, "#go_Role/#image_RoleHPBG")
	self._imageRoleHPFG = gohelper.findChildImage(self.viewGO, "#go_Role/#image_RoleHPFG")
	self._simageRole = gohelper.findChildSingleImage(self.viewGO, "#go_Role/image/#simage_Role")
	self._imageRoleHPNumBG = gohelper.findChildImage(self.viewGO, "#go_Role/#image_RoleHPNumBG")
	self._txtRoleHP = gohelper.findChildText(self.viewGO, "#go_Role/#image_RoleHPNumBG/#txt_RoleHP")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Role/#go_Locked")
	self._goRoleName1 = gohelper.findChild(self.viewGO, "RoleName/#go_RoleName1")
	self._txtRoleName = gohelper.findChildText(self.viewGO, "RoleName/#go_RoleName1/#txt_RoleName")
	self._goRoleName2 = gohelper.findChild(self.viewGO, "RoleName/#go_RoleName2")
	self._txtRoleName2 = gohelper.findChildText(self.viewGO, "RoleName/#go_RoleName2/#txt_RoleName2")
	self._goAssist = gohelper.findChild(self.viewGO, "#go_Assist")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateSelectRoleItem:addEvents()
	return
end

function EliminateSelectRoleItem:removeEvents()
	return
end

function EliminateSelectRoleItem:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self.viewGO)
	self._rawWidth = recthelper.getWidth(self.viewGO.transform)
	self._scaleWidth = 330
	self._animator = self.viewGO:GetComponent("Animator")
end

function EliminateSelectRoleItem:_onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if not self._isUnlock then
		return
	end

	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.ClickCharacter, self._index)
end

function EliminateSelectRoleItem:_editableAddEvents()
	self._click:AddClickListener(self._onClick, self)
end

function EliminateSelectRoleItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function EliminateSelectRoleItem:onUpdateMO(mo, index)
	self._config = mo
	self._index = index
	self._isPreset = EliminateTeamSelectionModel.instance:isPreset()
	self._isUnlock = EliminateTeamSelectionModel.instance:hasCharacterOrPreset(self._config.id)

	gohelper.setActive(self._goLocked, not self._isUnlock)

	if self._isUnlock and not EliminateMapController.hasOnceActionKey(EliminateMapEnum.PrefsKey.RoleUnlock, self._config.id) then
		EliminateMapController.setOnceActionKey(EliminateMapEnum.PrefsKey.RoleUnlock, self._config.id)
		gohelper.setActive(self._goLocked, true)

		local animator = self._goLocked:GetComponent("Animator")

		animator:Play("unlock")
	end

	self._txtRoleName.text = self._config.name
	self._txtRoleName2.text = self._config.name
	self._txtRoleHP.text = self._config.hp

	self._simageRole:LoadImage(ResUrl.getHeadIconSmall(self._config.resPic))
	ZProj.UGUIHelper.SetGrayscale(self._imageRoleBG.gameObject, not self._isUnlock)
	ZProj.UGUIHelper.SetGrayscale(self._simageRole.gameObject, not self._isUnlock)
	ZProj.UGUIHelper.SetGrayscale(self._imageRoleHPBG.gameObject, not self._isUnlock)
	gohelper.setActive(self._imageRoleHPFG, self._isUnlock)
	gohelper.setActive(self._imageRoleHPNumBG, self._isUnlock)
end

function EliminateSelectRoleItem:isUnlocked()
	return self._isUnlock
end

function EliminateSelectRoleItem:getConfig()
	return self._config
end

function EliminateSelectRoleItem:onSelect(isSelect)
	local oldStatus = self._isSelected

	self._isSelected = isSelect

	gohelper.setActive(self._goRoleSelected, isSelect)
	gohelper.setActive(self._goRoleName1, isSelect and self._isUnlock)
	gohelper.setActive(self._goRoleName2, not isSelect and self._isUnlock)
	recthelper.setWidth(self.viewGO.transform, (isSelect or nil) and (self._scaleWidth or self._rawWidth))

	local scaleValue = isSelect and 1.3 or 1

	transformhelper.setLocalScale(self._goRole.transform, scaleValue, scaleValue, 1)

	if self._isSelected then
		self._animator:Play("select")
	elseif oldStatus then
		self._animator:Play("unselect")
	end

	self._animator:Play("idle")
	gohelper.setActive(self._goAssist, self._isSelected and self._isPreset)
end

function EliminateSelectRoleItem:onDestroyView()
	self._simageRole:UnLoadImage()
end

return EliminateSelectRoleItem
