-- chunkname: @modules/logic/summonuiswitch/view/SummonUISwitchItem.lua

module("modules.logic.summonuiswitch.view.SummonUISwitchItem", package.seeall)

local SummonUISwitchItem = class("SummonUISwitchItem", ListScrollCellExtend)

function SummonUISwitchItem:onInitView()
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

function SummonUISwitchItem:addEvents()
	return
end

function SummonUISwitchItem:removeEvents()
	return
end

function SummonUISwitchItem:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self.viewGO)
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._animatorPlayer.animator.enabled = false
end

function SummonUISwitchItem:_editableAddEvents()
	self._click:AddClickListener(self._onClick, self)
end

function SummonUISwitchItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function SummonUISwitchItem:_onClick()
	if self._isSelect then
		return
	end

	local id = self._mo.co.id

	if self._showReddot then
		SummonUISwitchController.closeReddot(id)
		self:_updateReddot()
	end

	AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_switch_scene)
	SummonUISwitchListModel.instance:selectCellIndex(self._index)
	SummonUISwitchController.instance:dispatchEvent(SummonUISwitchEvent.SwitchSceneUI, id)
end

function SummonUISwitchItem:onUpdateMO(mo)
	if not mo then
		return
	end

	self._mo = mo

	local iconName = self._mo.co.icon
	local iconPath = ResUrl.getMainSceneSwitchIcon(iconName)

	self._simageicon:LoadImage(iconPath)

	local curId = SummonUISwitchModel.instance:getCurUseUI()
	local isCur = curId == self._mo.co.id

	gohelper.setActive(self._goTag, isCur)

	local isSelected = SummonUISwitchListModel.instance:getSelectedCellIndex() == self._index

	self:onSelect(isSelected)

	if isCur then
		if isSelected then
			recthelper.setAnchorY(self._goTag.transform, 55)
		else
			recthelper.setAnchorY(self._goTag.transform, 40)
		end
	end

	local status = SummonUISwitchModel.getUIStatus(self._mo.co.id)
	local isUnlock = status == MainSceneSwitchEnum.SceneStutas.Unlock

	gohelper.setActive(self._goLocked, not isUnlock)
	ZProj.UGUIHelper.SetGrayscale(self._simageicon.gameObject, not isUnlock)
	self:_updateReddot()
end

function SummonUISwitchItem:_updateReddot()
	self._showReddot = SummonUISwitchController.hasReddot(self._mo.co.id)

	gohelper.setActive(self._goreddot, self._showReddot)
end

function SummonUISwitchItem:onSelect(isSelect)
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

function SummonUISwitchItem:_onAnimDone()
	self._animPlaying = false

	local scale = self._isSelect and 1 or SummonUISwitchEnum.ItemUnSelectedScale

	transformhelper.setLocalScale(self._gonormal.transform, scale, scale, 1)
end

function SummonUISwitchItem:onDestroyView()
	self._simageicon:UnLoadImage()
end

return SummonUISwitchItem
