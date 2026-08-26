-- chunkname: @modules/logic/fightuiswitch/view/FightUISwitchItem.lua

module("modules.logic.fightuiswitch.view.FightUISwitchItem", package.seeall)

local FightUISwitchItem = class("FightUISwitchItem", MainSceneSwitchItem)

function FightUISwitchItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_icon")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_normal/#go_Locked")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_normal/#go_reddot")
	self._goTag = gohelper.findChild(self.viewGO, "#go_Tag")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightUISwitchItem:addEvents()
	return
end

function FightUISwitchItem:removeEvents()
	return
end

function FightUISwitchItem:_onClick()
	if self._isSelect then
		return
	end

	FightUISwitchModel.instance:onSelect(self._mo)
	AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_switch_scene)
end

function FightUISwitchItem:onUpdateMO(mo)
	self._mo = mo

	if mo then
		gohelper.setActive(self._goLocked, not mo:isUnlock())
		gohelper.setActive(self._goTag, mo:isUse())

		local co = mo:getConfig()

		self._simageicon:LoadImage(ResUrl.getMainSceneSwitchIcon(co.image))

		local isSelected = FightUISwitchListModel.instance:getSelectMo() == mo

		self:onSelect(isSelected)
		ZProj.UGUIHelper.SetGrayscale(self._simageicon.gameObject, not mo:isUnlock())
	end
end

function FightUISwitchItem:onSelect(isSelect)
	if self._mo then
		FightUISwitchItem.super.onSelect(self, isSelect)
	end
end

return FightUISwitchItem
