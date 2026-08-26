-- chunkname: @modules/logic/tips/view/PackageRewardDetailView.lua

module("modules.logic.tips.view.PackageRewardDetailView", package.seeall)

local PackageRewardDetailView = class("PackageRewardDetailView", BaseView)

function PackageRewardDetailView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goreward = gohelper.findChild(self.viewGO, "#go_reward")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "#go_reward/#scroll_reward")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_reward/#scroll_reward/Viewport/#go_content")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_reward/#scroll_reward/Viewport/#go_content/#go_rewarditem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PackageRewardDetailView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function PackageRewardDetailView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function PackageRewardDetailView:_btncloseOnClick()
	self:closeThis()
end

function PackageRewardDetailView:_editableInitView()
	self._rewardItemList = {}

	gohelper.setActive(self._gorewarditem, false)
end

function PackageRewardDetailView:onUpdateParam()
	self:_refresh()
end

function PackageRewardDetailView:onOpen()
	self:_refresh()
end

function PackageRewardDetailView:_refresh()
	local bonusList = self.viewParam.rewardList

	for i, itemCo in ipairs(bonusList) do
		if not self._rewardItemList[i] then
			self._rewardItemList[i] = {}
			self._rewardItemList[i].go = gohelper.cloneInPlace(self._gorewarditem)

			gohelper.setActive(self._rewardItemList[i].go, true)

			self._rewardItemList[i].item = IconMgr.instance:getCommonItemIcon(self._rewardItemList[i].go)

			self._rewardItemList[i].item:setInPack(false)
			self._rewardItemList[i].item:isShowName(false)
			self._rewardItemList[i].item:isShowCount(true)
			self._rewardItemList[i].item:isShowEffect(true)
		end

		self._rewardItemList[i].item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	end

	for i = #bonusList + 1, #self._rewardItemList do
		gohelper.setActive(self._rewardItemList[i].go, false)
	end
end

function PackageRewardDetailView:onClose()
	return
end

function PackageRewardDetailView:onDestroyView()
	if not self._rewardItemList then
		-- block empty
	end
end

return PackageRewardDetailView
