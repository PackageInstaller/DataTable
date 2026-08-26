-- chunkname: @modules/logic/teaching/view/TeachingRewardItem.lua

module("modules.logic.teaching.view.TeachingRewardItem", package.seeall)

local TeachingRewardItem = class("TeachingRewardItem", ListScrollCellExtend)

function TeachingRewardItem:init(go)
	self._goReward = gohelper.findChild(go, "icon")
	self._goCanGet = gohelper.findChild(go, "go_canget")
	self._goRecive = gohelper.findChild(go, "go_receive")
	self._rewardClick = gohelper.getClick(self._goCanGet)
	self._processItems = self:getUserDataTb_()
end

function TeachingRewardItem:addEventListeners()
	if self._rewardClick then
		self._rewardClick:AddClickListener(self._onRewardClick, self)
	end
end

function TeachingRewardItem:removeEventListeners()
	if self._rewardClick then
		self._rewardClick:RemoveClickListener()
	end
end

function TeachingRewardItem:_onRewardClick()
	if self._isClick then
		return
	end

	self._isClick = true

	if self._status == TeachingEnum.TeachingStatus.FinishNotReward then
		TeachingRpc.instance:sendTeachingGetBonusRequest(self._config.id, function()
			self._isClick = false
		end, self)
	end
end

function TeachingRewardItem:refreshItem(status, config)
	self._status = status
	self._config = config
	self._isClick = false

	local bonus = string.splitToNumber(self._config.bonus, "#")

	self._itemIcon = self._itemIcon or IconMgr.instance:getCommonPropItemIcon(self._goReward)

	self._itemIcon:setMOValue(bonus[1], bonus[2], bonus[3])
	self._itemIcon:setScale(0.6)
	self._itemIcon:setCountTxtSize(46)
	gohelper.setActive(self._goRecive, status == TeachingEnum.TeachingStatus.Rewarded)
	gohelper.setActive(self._goCanGet, status == TeachingEnum.TeachingStatus.FinishNotReward)
end

function TeachingRewardItem:onDestroyView()
	if self._itemIcon then
		self._itemIcon:onDestroy()
	end
end

return TeachingRewardItem
