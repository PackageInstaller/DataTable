-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneSwitchItem.lua

module("modules.logic.mainsceneswitch.view.MainSceneSwitchItem", package.seeall)

local MainSceneSwitchItem = class("MainSceneSwitchItem", ListScrollCellExtend)

function MainSceneSwitchItem:onInitView()
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

function MainSceneSwitchItem:addEvents()
	return
end

function MainSceneSwitchItem:removeEvents()
	return
end

function MainSceneSwitchItem:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self.viewGO)
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._animatorPlayer.animator.enabled = false
end

function MainSceneSwitchItem:_editableAddEvents()
	self._click:AddClickListener(self._onClick, self)
end

function MainSceneSwitchItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function MainSceneSwitchItem:_onClick()
	if self._isSelect then
		return
	end

	if self._showReddot then
		MainSceneSwitchController.closeSceneReddot(self._mo.id)
		self:_updateReddot()
	end

	AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_switch_scene)
	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.ClickSwitchItem, self._mo, self._index)
end

function MainSceneSwitchItem:onUpdateMO(mo)
	self._mo = mo

	self._simageicon:LoadImage(ResUrl.getMainSceneSwitchIcon(mo.icon))

	local isCurScene = MainSceneSwitchModel.instance:getCurSceneId() == self._mo.id

	gohelper.setActive(self._goTag, isCurScene)

	local isSelected = MainSceneSwitchListModel.instance:getSelectedCellIndex() == self._index

	self:onSelect(isSelected)

	if isCurScene then
		if isSelected then
			recthelper.setAnchorY(self._goTag.transform, 55)
		else
			recthelper.setAnchorY(self._goTag.transform, 40)
		end
	end

	local sceneStatus = MainSceneSwitchModel.getSceneStatus(self._mo.id)
	local isUnlock = sceneStatus == MainSceneSwitchEnum.SceneStutas.Unlock

	gohelper.setActive(self._goLocked, not isUnlock)
	ZProj.UGUIHelper.SetGrayscale(self._simageicon.gameObject, not isUnlock)
	self:_updateReddot()
end

function MainSceneSwitchItem:_updateReddot()
	self._showReddot = MainSceneSwitchController.sceneHasReddot(self._mo.id)

	gohelper.setActive(self._goreddot, self._showReddot)
end

function MainSceneSwitchItem:onSelect(isSelect)
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

function MainSceneSwitchItem:_onAnimDone()
	self._animPlaying = false

	local scale = self._isSelect and 1 or MainSceneSwitchEnum.ItemUnSelectedScale

	transformhelper.setLocalScale(self._gonormal.transform, scale, scale, 1)
end

function MainSceneSwitchItem:onDestroyView()
	self._simageicon:UnLoadImage()
end

return MainSceneSwitchItem
