-- chunkname: @modules/logic/mainuiswitch/view/MainUISwitchItem.lua

module("modules.logic.mainuiswitch.view.MainUISwitchItem", package.seeall)

local MainUISwitchItem = class("MainUISwitchItem", ListScrollCellExtend)

function MainUISwitchItem:onInitView()
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

function MainUISwitchItem:addEvents()
	return
end

function MainUISwitchItem:removeEvents()
	return
end

function MainUISwitchItem:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self.viewGO)
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._animatorPlayer.animator.enabled = false
end

function MainUISwitchItem:_editableAddEvents()
	self._click:AddClickListener(self._onClick, self)
end

function MainUISwitchItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function MainUISwitchItem:_onClick()
	if self._isSelect then
		return
	end

	local id = self._mo.co.id

	if self._showReddot then
		MainUISwitchController.closeReddot(id)
		self:_updateReddot()
	end

	AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_switch_scene)
	MainUISwitchListModel.instance:selectCellIndex(self._index)
	MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.SwitchMainUI, id)
end

function MainUISwitchItem:onUpdateMO(mo)
	if not mo then
		return
	end

	self._mo = mo

	local iconName = self._mo.co.icon
	local iconPath = ResUrl.getMainSceneSwitchLangIcon(iconName)

	self._simageicon:LoadImage(iconPath)

	local curId = MainUISwitchModel.instance:getCurUseUI()
	local isCur = curId == self._mo.co.id

	gohelper.setActive(self._goTag, isCur)

	local isSelected = MainUISwitchListModel.instance:getSelectedCellIndex() == self._index

	self:onSelect(isSelected)

	if isCur then
		if isSelected then
			recthelper.setAnchorY(self._goTag.transform, 55)
		else
			recthelper.setAnchorY(self._goTag.transform, 40)
		end
	end

	local status = MainUISwitchModel.getUIStatus(self._mo.co.id)
	local isUnlock = status == MainSceneSwitchEnum.SceneStutas.Unlock

	gohelper.setActive(self._goLocked, not isUnlock)
	ZProj.UGUIHelper.SetGrayscale(self._simageicon.gameObject, not isUnlock)
	self:_updateReddot()
end

function MainUISwitchItem:_updateReddot()
	self._showReddot = MainUISwitchController.hasReddot(self._mo.co.id)

	gohelper.setActive(self._goreddot, self._showReddot)
end

function MainUISwitchItem:onSelect(isSelect)
	local oldSelected = self._isSelect

	self._isSelect = isSelect

	self._goselected:SetActive(isSelect)

	if oldSelected ~= nil and oldSelected ~= isSelect then
		self._animPlaying = true

		if isSelect then
			self._animatorPlayer:Play("select", self._onAnimDone, self)
		else
			self._animatorPlayer:Play("unselect", self._onAnimDone, self)
		end
	end

	if self._animPlaying then
		return
	end

	self:_onAnimDone()
end

function MainUISwitchItem:_onAnimDone()
	self._animPlaying = false

	local scale = self._isSelect and 1 or MainUISwitchEnum.ItemUnSelectedScale

	transformhelper.setLocalScale(self._gonormal.transform, scale, scale, 1)
end

function MainUISwitchItem:onDestroyView()
	self._simageicon:UnLoadImage()
end

return MainUISwitchItem
