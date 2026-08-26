-- chunkname: @modules/logic/dungeon/view/DungeonElementRewardView.lua

module("modules.logic.dungeon.view.DungeonElementRewardView", package.seeall)

local DungeonElementRewardView = class("DungeonElementRewardView", BaseView)

function DungeonElementRewardView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goitem = gohelper.findChild(self.viewGO, "#go_item")
	self._goreward0 = gohelper.findChild(self.viewGO, "reward/#go_reward0")
	self._gocontent0 = gohelper.findChild(self.viewGO, "reward/#go_reward0/#go_content0")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonElementRewardView:addEvents()
	return
end

function DungeonElementRewardView:removeEvents()
	return
end

function DungeonElementRewardView:_editableInitView()
	return
end

function DungeonElementRewardView:onUpdateParam()
	return
end

function DungeonElementRewardView:onOpen()
	self:showReward(self._gocontent0, self.viewParam)
end

function DungeonElementRewardView:showReward(container, rewardList)
	local startPosX = 80
	local width = 205

	recthelper.setWidth(container.transform, #rewardList * width + 20)

	for i, reward in ipairs(rewardList) do
		local item = gohelper.clone(self._goitem, container)

		gohelper.setActive(item, true)
		recthelper.setAnchor(item.transform, startPosX + width * (i - 1), -75)

		local itemIconGO = gohelper.findChild(item, "itemicon")
		local itemIcon = IconMgr.instance:getCommonPropItemIcon(itemIconGO)
		local countbg = gohelper.findChild(item.gameObject, "countbg")

		itemIcon:setMOValue(reward[1], reward[2], reward[3], nil, true)
		itemIcon:isShowCount(true)
		itemIcon:hideEquipLvAndBreak(true)
		itemIcon:setHideLvAndBreakFlag(true)
		itemIcon:setCountFontSize(40)
		itemIcon:SetCountLocalY(43.6)
		itemIcon:SetCountBgHeight(30)
		itemIcon:SetCountBgScale(1, 1.3, 1)
		itemIcon:setHideLvAndBreakFlag(true)
		itemIcon:hideEquipLvAndBreak(true)
		itemIcon._itemIcon:setJumpFinishCallback(self.jumpFinishCallback, self)
		gohelper.setActive(countbg, false)
	end
end

function DungeonElementRewardView:jumpFinishCallback()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

function DungeonElementRewardView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_OK)
end

function DungeonElementRewardView:onDestroyView()
	return
end

return DungeonElementRewardView
