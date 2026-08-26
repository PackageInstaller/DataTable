-- chunkname: @modules/logic/versionactivity1_4/act129/view/Activity129ResultView.lua

module("modules.logic.versionactivity1_4.act129.view.Activity129ResultView", package.seeall)

local Activity129ResultView = class("Activity129ResultView", BaseView)

function Activity129ResultView:onInitView()
	self.goRewards = gohelper.findChild(self.viewGO, "#go_Result")
	self.bigList = self:createList(gohelper.findChild(self.goRewards, "#go_BigList"))
	self.smallList = self:createList(gohelper.findChild(self.goRewards, "#go_SmallList"))
	self.rewardItems = {}
	self.click = gohelper.findChildClick(self.goRewards, "click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity129ResultView:addEvents()
	self.click:AddClickListener(self.onClick, self)
	self.addEventCb(self, Activity129Controller.instance, Activity129Event.OnShowReward, self.showReward, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onOnCloseViewFinish, self)
end

function Activity129ResultView:removeEvents()
	self.click:RemoveClickListener()
	self.removeEventCb(self, Activity129Controller.instance, Activity129Event.OnShowReward, self.showReward, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onOnCloseViewFinish, self)
end

function Activity129ResultView:_editableInitView()
	return
end

function Activity129ResultView:_onOnCloseViewFinish(viewName)
	if viewName == ViewName.RoomBlockPackageGetView then
		RoomController.instance:checkThemeCollerctFullReward()
	end
end

function Activity129ResultView:onClick()
	gohelper.setActive(self.goRewards, false)
	Activity129Controller.instance:dispatchEvent(Activity129Event.OnLotteryEnd)
end

function Activity129ResultView:onOpen()
	self.actId = self.viewParam.actId
end

function Activity129ResultView:showReward(list)
	if not list then
		gohelper.setActive(self.goRewards, false)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_award_all)
	gohelper.setActive(self.goRewards, true)
	gohelper.setActive(self.bigList.go, false)
	gohelper.setActive(self.smallList.go, false)

	local count = #list

	if count > 8 then
		if not self.bigList then
			local contentList = self.smallList

			gohelper.setActive(contentList.go, true)

			for i = 1, math.max(count, #self.rewardItems) do
				local item = self.rewardItems[i]

				if not item then
					item = IconMgr.instance:getCommonPropItemIcon(contentList.goContent)
					self.rewardItems[i] = item
				end

				local data = list[i]

				if data then
					gohelper.addChild(contentList.goContent, item.go)
					gohelper.setAsLastSibling(item.go)
					gohelper.setActive(item.go, true)
					item:setMOValue(data[1], data[2], data[3], nil, true)
					item:isShowEffect(true)
				else
					gohelper.setActive(item.go, false)
				end
			end

			local roomList = {}

			for i, v in ipairs(list) do
				if v[1] == MaterialEnum.MaterialType.Building or v[1] == MaterialEnum.MaterialType.BlockPackage then
					local o = MaterialDataMO.New()

					o:initValue(v[1], v[2], 1, 0)
					table.insert(roomList, o)
				end
			end

			if #roomList > 0 then
				RoomController.instance:popUpRoomBlockPackageView(roomList)
			end
		end
	end
end

function Activity129ResultView:createList(go)
	local item = self:getUserDataTb_()

	item.go = go
	item.title1 = gohelper.findChild(go, "image_SmallTitle1")
	item.title2 = gohelper.findChild(go, "image_SmallTitle2")
	item.goContent = gohelper.findChild(go, "#scroll_GetRewardList/Viewport/Content")

	return item
end

function Activity129ResultView:onClose()
	return
end

function Activity129ResultView:onDestroyView()
	return
end

return Activity129ResultView
