-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewShowRewardView.lua

module("modules.logic.turnback.view.new.view.TurnbackNewShowRewardView", package.seeall)

local TurnbackNewShowRewardView = class("TurnbackNewShowRewardView", BaseView)

function TurnbackNewShowRewardView:onInitView()
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "reward/#scroll_reward")
	self._gocontent = gohelper.findChild(self.viewGO, "reward/#scroll_reward/Viewport/#go_content")
	self._gorewarditem = gohelper.findChild(self.viewGO, "reward/#scroll_reward/Viewport/#go_content/#go_rewarditem")
	self._btnclose = gohelper.findChildButton(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackNewShowRewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function TurnbackNewShowRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function TurnbackNewShowRewardView:_btncloseOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)
	self:closeThis()
end

function TurnbackNewShowRewardView:_editableInitView()
	self._rewardItemList = {}
end

function TurnbackNewShowRewardView:onUpdateParam()
	return
end

function TurnbackNewShowRewardView:onOpen()
	self.bonus = self.viewParam.bonus

	self:_refreshReward()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
end

function TurnbackNewShowRewardView:_refreshReward()
	local bounscoList = GameUtil.splitString2(self.bonus, true)

	for index, co in ipairs(bounscoList) do
		local item = self:getUserDataTb_()

		item.go = gohelper.cloneInPlace(self._gorewarditem, "item" .. index)

		gohelper.setActive(item.go, true)

		local type, id, num = co[1], co[2], co[3]

		item.itemIcon = item.itemIcon or IconMgr.instance:getCommonPropItemIcon(item.go)

		item.itemIcon:setMOValue(type, id, num, nil, true)
		item.itemIcon:isShowQuality(true)
		item.itemIcon:isShowCount(true)
	end
end

function TurnbackNewShowRewardView:onClose()
	return
end

function TurnbackNewShowRewardView:onDestroyView()
	return
end

return TurnbackNewShowRewardView
