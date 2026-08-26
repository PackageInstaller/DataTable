-- chunkname: @modules/logic/versionactivity1_3/armpipe/view/ArmRewardViewTaskItem.lua

module("modules.logic.versionactivity1_3.armpipe.view.ArmRewardViewTaskItem", package.seeall)

local ArmRewardViewTaskItem = class("ArmRewardViewTaskItem", ListScrollCellExtend)

function ArmRewardViewTaskItem:onInitView()
	self._txtNum = gohelper.findChildText(self.viewGO, "Root/#txt_Num")
	self._txtTaskDesc = gohelper.findChildText(self.viewGO, "Root/#txt_TaskDesc")
	self._gorewards = gohelper.findChild(self.viewGO, "Root/#scroll_Rewards/Viewport/#gorewards")
	self._goclaimedBG = gohelper.findChild(self.viewGO, "Root/image_ClaimedBG")
	self._gocollecticon = gohelper.findChild(self.viewGO, "Root/#go_collecticon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArmRewardViewTaskItem:addEvents()
	return
end

function ArmRewardViewTaskItem:removeEvents()
	return
end

function ArmRewardViewTaskItem:_editableInitView()
	gohelper.setActive(self._gocollecticon, false)

	self._animator = self.viewGO:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
end

function ArmRewardViewTaskItem:_editableAddEvents()
	return
end

function ArmRewardViewTaskItem:_editableRemoveEvents()
	return
end

function ArmRewardViewTaskItem:getAnimator()
	return self._animator
end

function ArmRewardViewTaskItem:onUpdateMO(mo)
	self._rewardMO = mo

	self:_refreshUI()
end

function ArmRewardViewTaskItem:onSelect(isSelect)
	return
end

function ArmRewardViewTaskItem:onDestroyView()
	return
end

function ArmRewardViewTaskItem:_refreshUI()
	local atMO = self._rewardMO

	if atMO and atMO.config then
		local cfg = atMO.config

		self._txtNum.text = self:_getNumStr(cfg.episodeId)
		self._txtTaskDesc.text = cfg.name

		local itemList = ItemModel.instance:getItemDataListByConfigStr(atMO.config.firstBonus)

		self.itemList = itemList
		self._isReceived = Activity124Model.instance:isReceived(cfg.activityId, cfg.episodeId)

		IconMgr.instance:getCommonPropItemIconList(self, self._onItemShow, itemList, self._gorewards)
		gohelper.setActive(self._goclaimedBG, self._isReceived)
	end
end

function ArmRewardViewTaskItem:_getNumStr(num)
	if num < 10 then
		return "0" .. num
	end

	return tostring(num)
end

function ArmRewardViewTaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)

	if not cell_component._gocollecticon then
		cell_component._gocollecticon = gohelper.clone(self._gocollecticon, cell_component.viewGO)

		local trs = cell_component._gocollecticon.transform

		transformhelper.setLocalPos(trs, 0, 0, 0)
	end

	gohelper.setActive(cell_component._gocollecticon, self._isReceived)
end

ArmRewardViewTaskItem.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_arm/v1a3_armreward_taskitem.prefab"

return ArmRewardViewTaskItem
