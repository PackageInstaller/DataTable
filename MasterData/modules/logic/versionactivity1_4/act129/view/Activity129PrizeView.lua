-- chunkname: @modules/logic/versionactivity1_4/act129/view/Activity129PrizeView.lua

module("modules.logic.versionactivity1_4.act129.view.Activity129PrizeView", package.seeall)

local Activity129PrizeView = class("Activity129PrizeView", BaseView)

function Activity129PrizeView:onInitView()
	self.goPrize = gohelper.findChild(self.viewGO, "#go_Prize")
	self.click = gohelper.findChildClick(self.goPrize, "click")
	self.simageIcon = gohelper.findChildSingleImage(self.goPrize, "#simage_ItemIcon")
	self.imageIcon = gohelper.findChildImage(self.goPrize, "#simage_ItemIcon")
	self.gonormal = gohelper.findChild(self.viewGO, "normal")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity129PrizeView:addEvents()
	self.addEventCb(self, Activity129Controller.instance, Activity129Event.OnShowSpecialReward, self.showReward, self)
end

function Activity129PrizeView:removeEvents()
	self.click:RemoveClickListener()
	self.removeEventCb(self, Activity129Controller.instance, Activity129Event.OnShowSpecialReward, self.showReward, self)
end

function Activity129PrizeView:_editableInitView()
	return
end

function Activity129PrizeView:onOpen()
	self.actId = self.viewParam.actId
end

function Activity129PrizeView:showReward(specialList, list)
	self:clear()

	self.specialList = specialList
	self.list = list

	self:startShow()
end

function Activity129PrizeView:startShow()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_award_all)
	gohelper.setActive(self.gonormal, false)
	gohelper.setActive(self.gonormal, true)
	TaskDispatcher.cancelTask(self.continueShow, self)
	TaskDispatcher.runDelay(self.continueShow, self, 1.34)
end

function Activity129PrizeView:continueShow()
	gohelper.setActive(self.gonormal, false)

	if not self.specialList then
		self:onShowEnd()

		return
	end

	self:showItem()
end

function Activity129PrizeView:showItem()
	local item = table.remove(self.specialList, 1)

	if not item then
		self:onShowEnd()

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_award_core)

	local config, icon = ItemModel.instance:getItemConfigAndIcon(item[1], item[2], true)

	self.simageIcon:LoadImage(icon)
	gohelper.setActive(self.goPrize, false)
	gohelper.setActive(self.goPrize, true)
	TaskDispatcher.cancelTask(self.showItem, self)
	TaskDispatcher.runDelay(self.showItem, self, 1.84)
end

function Activity129PrizeView:onShowEnd()
	self:clear()
	gohelper.setActive(self.goPrize, false)
	gohelper.setActive(self.gonormal, false)

	local list = self.list

	self.list = nil
	self.specialList = nil

	Activity129Controller.instance:dispatchEvent(Activity129Event.OnShowReward, list)
end

function Activity129PrizeView:clear()
	TaskDispatcher.cancelTask(self.showItem, self)
	TaskDispatcher.cancelTask(self.continueShow, self)
end

function Activity129PrizeView:onClose()
	TaskDispatcher.cancelTask(self.showItem, self)
	TaskDispatcher.cancelTask(self.continueShow, self)
end

function Activity129PrizeView:onDestroyView()
	return
end

return Activity129PrizeView
