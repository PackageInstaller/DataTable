-- chunkname: @modules/logic/versionactivity1_2/trade/view/ActivityTradeBargainRewardItem.lua

module("modules.logic.versionactivity1_2.trade.view.ActivityTradeBargainRewardItem", package.seeall)

local ActivityTradeBargainRewardItem = class("ActivityTradeBargainRewardItem", UserDataDispose)

function ActivityTradeBargainRewardItem:ctor(go, parentGo)
	self:__onInit()

	self.go = go
	self.anim = go:GetComponent(typeof(UnityEngine.Animator))
	self.btnNotEnough = gohelper.findChildButtonWithAudio(self.go, "btn_unable")
	self.btnGet = gohelper.findChildButtonWithAudio(self.go, "btn_get")
	self.goHasReceive = gohelper.findChild(self.go, "go_hasreceive")
	self.goScroll = gohelper.findChild(self.go, "scroll_reward")
	self.scroll = self.goScroll:GetComponent(typeof(ZProj.LimitedScrollRect))
	self.scroll.parentGameObject = parentGo
	self.goIconContainer = gohelper.findChild(self.go, "scroll_reward/Viewport/Content")
	self.txtDesc = gohelper.findChildText(self.go, "txt_desc")
	self.goMask = gohelper.findChild(self.go, "go_blackmask")
	self._simagebg = gohelper.findChildSingleImage(self.go, "bg")
	self.rewardIcons = {}

	self.addClickCb(self, self.btnGet, self.onClickGetReward, self)
	self._simagebg:LoadImage(ResUrl.getVersionTradeBargainBg("img_changguidi"))

	self._simageclickbg = gohelper.findChildSingleImage(self.go, "click/bg")

	self._simageclickbg:LoadImage(ResUrl.getVersionActivity1_2TaskImage("renwu_diehei"))
end

function ActivityTradeBargainRewardItem:setData(data)
	self.data = data

	if not data then
		gohelper.setActive(self.go, false)

		return
	end

	gohelper.setActive(self.go, true)
	self.anim:Play(UIAnimationName.Idle)

	local status = data:getStatus()

	gohelper.setActive(self.btnNotEnough.gameObject, status == Activity117Enum.Status.NotEnough)
	gohelper.setActive(self.btnGet.gameObject, status == Activity117Enum.Status.CanGet)
	gohelper.setActive(self.goHasReceive, status == Activity117Enum.Status.AlreadyGot)
	gohelper.setActive(self.goMask, status == Activity117Enum.Status.AlreadyGot)

	self.txtDesc.text = formatLuaLang("versionactivity_1_2_117desc_1", data.needScore)

	self:refreshRewardIcons(data)
end

function ActivityTradeBargainRewardItem:refreshRewardIcons(data)
	local dataList = data.rewardItems

	for i = 1, math.max(#dataList, #self.rewardIcons) do
		local iconItem = self:getOrCreateRewardIcon(i)

		self:refreshRewardIcon(iconItem, dataList[i])
	end
end

function ActivityTradeBargainRewardItem:refreshRewardIcon(iconItem, data)
	if not data then
		gohelper.setActive(iconItem.go, false)

		return
	end

	gohelper.setActive(iconItem.go, true)
	iconItem.comp:setMOValue(data[1], data[2], data[3], nil, true)
	iconItem.comp:setScale(0.59)
	iconItem.comp:setCountFontSize(45)
end

function ActivityTradeBargainRewardItem:getOrCreateRewardIcon(index)
	local iconItem = self.rewardIcons[index]

	if not iconItem then
		iconItem = self:getUserDataTb_()
		iconItem.comp = IconMgr.instance:getCommonItemIcon(self.goIconContainer)
		iconItem.go = iconItem.comp.gameObject
		self.rewardIcons[index] = iconItem
	end

	return iconItem
end

function ActivityTradeBargainRewardItem:onClickGetReward()
	if not self.data then
		return
	end

	UIBlockMgr.instance:startBlock("BargainReward")
	self:onFinish()
	TaskDispatcher.runDelay(self._sendGetBonus, self, 0.6)
end

function ActivityTradeBargainRewardItem:onFinish()
	self.anim:Play(UIAnimationName.Finish)
end

function ActivityTradeBargainRewardItem:_sendGetBonus()
	UIBlockMgr.instance:endBlock("BargainReward")
	Activity117Rpc.instance:sendAct117GetBonusRequest(self.data.actId, {
		self.data.id
	})
end

function ActivityTradeBargainRewardItem:destory()
	UIBlockMgr.instance:endBlock("BargainReward")
	TaskDispatcher.cancelTask(self._sendGetBonus, self)
	self._simagebg:UnLoadImage()
	self._simageclickbg:UnLoadImage()
	self:__onDispose()
end

return ActivityTradeBargainRewardItem
