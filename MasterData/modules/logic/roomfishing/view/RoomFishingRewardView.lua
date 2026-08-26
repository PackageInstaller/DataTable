-- chunkname: @modules/logic/roomfishing/view/RoomFishingRewardView.lua

module("modules.logic.roomfishing.view.RoomFishingRewardView", package.seeall)

local RoomFishingRewardView = class("RoomFishingRewardView", BaseView)

function RoomFishingRewardView:onInitView()
	self._goState1 = gohelper.findChild(self.viewGO, "#go_State1")
	self._btnView = gohelper.findChildButtonWithAudio(self.viewGO, "#go_State1/#btn_View")
	self._btnskip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_State1/#btn_skip")
	self._goState2 = gohelper.findChild(self.viewGO, "#go_State2")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_State2/#btn_Close")
	self._gomyfishing = gohelper.findChild(self.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_myfishing")
	self._txtmyfishing = gohelper.findChildText(self.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_myfishing/Tips/image_TipsBG/#txt_Statistics")
	self._gomyfishingcontent = gohelper.findChild(self.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_myfishing/Grid")
	self._gomyfishingitem = gohelper.findChild(self.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_myfishing/Grid/#go_Item")
	self._gootherfishing = gohelper.findChild(self.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_otherfishing")
	self._txtotherfishing = gohelper.findChildText(self.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_otherfishing/Tips/image_TipsBG/#txt_Statistics")
	self._gootherfishingcontent = gohelper.findChild(self.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_otherfishing/Grid")
	self._gootherfishingitem = gohelper.findChild(self.viewGO, "#go_State2/ScrollView/Viewport/Content/#go_otherfishing/Grid/#go_Item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomFishingRewardView:addEvents()
	self._btnView:AddClickListener(self._btnViewOnClick, self)
	self._btnskip:AddClickListener(self._btnskipOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._stateAnimEventWrap:AddEventListener("openReward", self._onOpenReward, self)
end

function RoomFishingRewardView:removeEvents()
	self._btnView:RemoveClickListener()
	self._btnskip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._stateAnimEventWrap:RemoveAllEventListener()
end

function RoomFishingRewardView:_btnViewOnClick()
	if self._stateAnimator then
		self._stateAnimator:Play("click", 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_1.RoomFishing.ui_home_mingdi_huoqu1)
	else
		self:_btnskipOnClick()
	end
end

function RoomFishingRewardView:_btnskipOnClick()
	gohelper.setActive(self._goState1, false)
	gohelper.setActive(self._goState2, true)
	AudioMgr.instance:trigger(AudioEnum3_1.RoomFishing.ui_home_mingdi_huoqu2)
end

function RoomFishingRewardView:_btnCloseOnClick()
	self:closeThis()
end

function RoomFishingRewardView:_onOpenReward()
	self:_btnskipOnClick()
end

function RoomFishingRewardView:_editableInitView()
	self._stateAnimator = self._goState1:GetComponent(typeof(UnityEngine.Animator))
	self._stateAnimEventWrap = self._goState1:GetComponent(typeof(ZProj.AnimationEventWrap))

	gohelper.setActive(self._goState1, true)
	gohelper.setActive(self._goState2, false)
end

function RoomFishingRewardView:onUpdateParam()
	if self.viewParam then
		local myFishingInfo = self.viewParam.myFishingInfo

		if self.viewParam then
			local otherFishingInfo = self.viewParam.otherFishingInfo

			if myFishingInfo then
				local hour, minute, second = TimeUtil.secondToHMS(myFishingInfo.time)
				local totalFishingTimes = 0

				for _, fishingTimes in pairs(myFishingInfo.fishingTimesDict) do
					totalFishingTimes = totalFishingTimes + fishingTimes
				end

				self._txtmyfishing.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("RoomFishing_reward_tips"), hour, minute, totalFishingTimes)
			end

			if otherFishingInfo then
				local hour, minute, second = TimeUtil.secondToHMS(otherFishingInfo.time)
				local totalFishingTimes = 0

				for _, fishingTimes in pairs(otherFishingInfo.fishingTimesDict) do
					totalFishingTimes = totalFishingTimes + fishingTimes
				end

				self._txtotherfishing.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("RoomFishing_other_reward_tips"), hour, minute, totalFishingTimes)
			end

			self:setRewardItems(myFishingInfo, self._gomyfishing, self._gomyfishingcontent, self._gomyfishingitem)
			self:setRewardItems(otherFishingInfo, self._gootherfishing, self._gootherfishingcontent, self._gootherfishingitem, true)
		end
	end
end

function RoomFishingRewardView:onOpen()
	self:onUpdateParam()
	AudioMgr.instance:trigger(AudioEnum3_1.RoomFishing.play_ui_home_mingdi_harvest)
end

function RoomFishingRewardView:setRewardItems(fishingInfo, goGroup, goItemContent, goItem, isShare)
	local rewardList = {}

	if fishingInfo then
		rewardList = FishingModel.instance:getFishingItemList(fishingInfo.poolIdList, fishingInfo.fishingTimesDict, isShare)
	end

	gohelper.CreateObjList(self, self.onRewardItemShow, rewardList, goItemContent, goItem, RoomFishingResourceItem)
	gohelper.setActive(goGroup, rewardList and #rewardList > 0)
end

function RoomFishingRewardView:onRewardItemShow(obj, data, index)
	obj:onUpdateMO(data)
	obj:setCanClick(true)
end

function RoomFishingRewardView:onClose()
	return
end

function RoomFishingRewardView:onDestroyView()
	return
end

return RoomFishingRewardView
