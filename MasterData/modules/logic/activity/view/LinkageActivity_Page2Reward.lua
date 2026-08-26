-- chunkname: @modules/logic/activity/view/LinkageActivity_Page2Reward.lua

module("modules.logic.activity.view.LinkageActivity_Page2Reward", package.seeall)

local LinkageActivity_Page2Reward = class("LinkageActivity_Page2Reward", LinkageActivity_Page2RewardBase)

function LinkageActivity_Page2Reward:onInitView()
	self._txtNum = gohelper.findChildText(self.viewGO, "image_NumBG/#txt_Num")
	self._goCanGet = gohelper.findChild(self.viewGO, "#go_CanGet")
	self._goGet = gohelper.findChild(self.viewGO, "#go_Get")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LinkageActivity_Page2Reward:addEvents()
	return
end

function LinkageActivity_Page2Reward:removeEvents()
	return
end

local split = string.split

function LinkageActivity_Page2Reward:ctor(ctorParam)
	LinkageActivity_Page2Reward.super.ctor(self, ctorParam)
end

function LinkageActivity_Page2Reward:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_itemIcon")
	FrameTimerController.onDestroyViewMember(self, "_frameTimer")
	LinkageActivity_Page2Reward.super.onDestroyView(self)
end

function LinkageActivity_Page2Reward:_editableAddEvents()
	LinkageActivity_Page2Reward.super._editableInitView(self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._OnOpenView, self)
end

function LinkageActivity_Page2Reward:_editableRemoveEvents()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._OnOpenView, self)
end

function LinkageActivity_Page2Reward:_editableInitView()
	self._txtNum.text = ""

	self:setActive_goGet(false)
	self:setActive_goCanGet(false)

	self._imageRewardGo = gohelper.findChild(self.viewGO, "image_Reward")
	self._itemIcon = IconMgr.instance:getCommonPropItemIcon(self._imageRewardGo)
	self._imageRewardBG = gohelper.findChildImage(self.viewGO, "image_RewardBG")
	self._imageTipsBGGo = gohelper.findChild(self.viewGO, "image_TipsBG")
end

function LinkageActivity_Page2Reward:onUpdateMO(mo)
	LinkageActivity_Page2Reward.super.onUpdateMO(self, mo)

	local isClaimed = self:isType101RewardGet()
	local hexColor = isClaimed and "#808080" or "#ffffff"
	local co = self:getNorSignActivityCo()
	local index = self._index
	local rewards = split(co.bonus, "|")
	local rewardCount = #rewards

	assert(rewardCount == 1, string.format("[LinkageActivity_Page2Reward] rewardCount=%s", tostring(rewardCount)))

	local itemCo = string.splitToNumber(rewards[1], "#")
	local itemType = itemCo[1]
	local itemId = itemCo[2]
	local itemCount = itemCo[3]

	mo._itemCo = itemCo

	self._itemIcon:setMOValue(itemType, itemId, itemCount)
	self._itemIcon:isShowQuality(false)
	self._itemIcon:isShowEquipAndItemCount(false)
	self._itemIcon:customOnClickCallback(self._onClick, self)

	if self._itemIcon:isEquipIcon() then
		self._itemIcon:setScale(0.7)
	else
		self._itemIcon:setScale(0.8)
	end

	self._itemIcon:setItemColor(hexColor)
	UIColorHelper.set(self._imageRewardBG, hexColor)

	self._txtNum.text = luaLang("multiple") .. itemCount

	self:setActive_goGet(isClaimed)
	self:setActive_goCanGet(self:isType101RewardCouldGet())

	local totalday = self:getType101LoginCount()

	self:setActive_goTmr(totalday + 1 == index)
end

function LinkageActivity_Page2Reward:setActive_goCanGet(isActive)
	gohelper.setActive(self._goCanGet, isActive)
end

function LinkageActivity_Page2Reward:setActive_goGet(isActive)
	gohelper.setActive(self._goGet, isActive)
end

function LinkageActivity_Page2Reward:setActive_goTmr(isActive)
	gohelper.setActive(self._imageTipsBGGo, isActive)
end

function LinkageActivity_Page2Reward:_onClaimAllCb()
	if not self:isType101RewardCouldGetAnyOne() then
		FrameTimerController.onDestroyViewMember(self, "_frameTimer")

		self._frameTimer = FrameTimerController.instance:register(function()
			if ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.RoomBlockPackageGetView) then
				FrameTimerController.onDestroyViewMember(self, "_frameTimer")

				local c = self:_assetGetViewContainer()

				c:switchPage(1)
			end
		end, nil, 6, 6)

		self._frameTimer:Start()
	end
end

function LinkageActivity_Page2Reward:_onClick()
	if not self:isActOnLine() then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local couldGet = self:isType101RewardCouldGet()

	if couldGet then
		self.sendGet101BonusRequest(self, self._onClaimAllCb, self)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tags_2000013)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_25050217)

	local mo = self._mo
	local itemCo = mo._itemCo

	MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
end

function LinkageActivity_Page2Reward:_OnOpenView(viewName)
	if viewName == ViewName.RoomBlockPackageGetView then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shenghuo_building_collect_20234002)
	end
end

return LinkageActivity_Page2Reward
