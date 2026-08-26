-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryItemRewardView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryItemRewardView", package.seeall)

local RoleStoryItemRewardView = class("RoleStoryItemRewardView", BaseView)

function RoleStoryItemRewardView:onInitView()
	self.goRewardPanel = gohelper.findChild(self.viewGO, "goRewardPanel")
	self.btnclose = gohelper.findChildButtonWithAudio(self.goRewardPanel, "btnclose")
	self.goNode = gohelper.findChild(self.goRewardPanel, "#go_node")
	self.rewardContent = gohelper.findChild(self.goRewardPanel, "#go_node/Content")
	self.rewardItems = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryItemRewardView:addEvents()
	self.btnclose:AddClickListener(self.onClickClose, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.OnClickRoleStoryReward, self.showReward, self)
end

function RoleStoryItemRewardView:removeEvents()
	self.btnclose:RemoveClickListener()
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.OnClickRoleStoryReward, self.showReward, self)
end

function RoleStoryItemRewardView:_editableInitView()
	return
end

function RoleStoryItemRewardView:onOpen()
	return
end

function RoleStoryItemRewardView:onClickClose()
	gohelper.setActive(self.goRewardPanel, false)
end

function RoleStoryItemRewardView:showReward(mo, x, y, z)
	if not mo then
		self:onClickClose()

		return
	end

	transformhelper.setPos(self.goNode.transform, x, y, z)
	gohelper.setActive(self.goRewardPanel, true)

	local rewards = mo.rewards

	for i = 1, math.max(#rewards, #self.rewardItems) do
		local item = self.rewardItems[i]
		local data = rewards[i]

		if not item then
			item = IconMgr.instance:getCommonItemIcon(self.rewardContent)
			self.rewardItems[i] = item

			transformhelper.setLocalScale(item.tr, 0.5, 0.5, 1)
		end

		if data then
			gohelper.setActive(item.go, true)
			item:setMOValue(data[1], data[2], data[3])
			item:setCountFontSize(42)
		else
			gohelper.setActive(item.go, false)
		end
	end
end

function RoleStoryItemRewardView:onClose()
	return
end

function RoleStoryItemRewardView:onDestroyView()
	if self.rewardItems then
		for k, v in pairs(self.rewardItems) do
			v:onDestroy()
		end

		self.rewardItems = nil
	end
end

return RoleStoryItemRewardView
