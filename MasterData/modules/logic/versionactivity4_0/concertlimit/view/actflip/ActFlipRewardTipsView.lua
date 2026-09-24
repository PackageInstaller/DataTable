-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/actflip/ActFlipRewardTipsView.lua

module("modules.logic.versionactivity4_0.concertlimit.view.actflip.ActFlipRewardTipsView", package.seeall)

local ActFlipRewardTipsView = class("ActFlipRewardTipsView", BaseView)

function ActFlipRewardTipsView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_rewards")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_rewards/title/txt_title")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "#go_rewards/#scroll_reward")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_rewards/#scroll_reward/Viewport/#go_content")
	self._gorewarditem = gohelper.findChild(self.viewGO, "#go_rewards/#scroll_reward/Viewport/#go_content/#go_rewarditem")
	self._gohaveGet = gohelper.findChild(self.viewGO, "#go_rewards/#scroll_reward/Viewport/#go_content/#go_rewarditem/#go_haveGet")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rewards/#btn_left")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rewards/#btn_right")
	self._gopagetags = gohelper.findChild(self.viewGO, "#go_pagetags")
	self._gopagetagitem = gohelper.findChild(self.viewGO, "#go_pagetags/#go_pagetagitem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActFlipRewardTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
end

function ActFlipRewardTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
end

function ActFlipRewardTipsView:_btnleftOnClick()
	self._curCardIndex = self._curCardIndex - 1

	self:_refresh()
end

function ActFlipRewardTipsView:_btnrightOnClick()
	self._curCardIndex = self._curCardIndex + 1

	self:_refresh()
end

function ActFlipRewardTipsView:_btncloseOnClick()
	self:closeThis()
end

function ActFlipRewardTipsView:_editableInitView()
	self._actId = VersionActivity4_0Enum.ActivityId.ConcertActFlip

	self:_initView()
end

function ActFlipRewardTipsView:_initView()
	self._rewardItems = self:getUserDataTb_()
	self._tagItems = self:getUserDataTb_()

	gohelper.setActive(self._gorewarditem, false)
	gohelper.setActive(self._gopagetagitem, false)

	self._curCardIndex = ActFlipModel.instance:getCurCardIndex()
end

function ActFlipRewardTipsView:onOpen()
	self:_refresh()
end

function ActFlipRewardTipsView:_refresh()
	self:_refreshTips()
	self:_refreshTags()
	self:_refreshRewards()
end

function ActFlipRewardTipsView:_refreshTips()
	gohelper.setActive(self._btnleft.gameObject, self._curCardIndex > 1)

	local totalCount = ActFlipModel.instance:getTotalCardCount()

	gohelper.setActive(self._btnright.gameObject, totalCount > self._curCardIndex)

	local indexNum = GameUtil.getRomanNums(self._curCardIndex)

	self._txttitle.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v4a0_actflip_rewardtip_title"), {
		indexNum
	})
end

function ActFlipRewardTipsView:_refreshTags()
	local totalCount = ActFlipModel.instance:getTotalCardCount()

	for i = 1, totalCount do
		if not self._tagItems[i] then
			self._tagItems[i] = {}

			local go = gohelper.cloneInPlace(self._gopagetagitem)

			self._tagItems[i].go = go
			self._tagItems[i].godark = gohelper.findChild(go, "go_dark")
			self._tagItems[i].golight = gohelper.findChild(go, "go_light")
			self._tagItems[i].btnClick = gohelper.findChildButtonWithAudio(go, "btn_pageclick")

			self._tagItems[i].btnClick:AddClickListener(self._btnClickPageOnClick, self, i)
		end

		gohelper.setActive(self._tagItems[i].go, true)
		gohelper.setActive(self._tagItems[i].godark, i ~= self._curCardIndex)
		gohelper.setActive(self._tagItems[i].golight, i == self._curCardIndex)
	end
end

function ActFlipRewardTipsView:_btnClickPageOnClick(index)
	if self._curCardIndex == index then
		return
	end

	self._curCardIndex = index

	self:_refresh()
end

function ActFlipRewardTipsView:_refreshRewards()
	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			item:showItem(false)
		end
	end

	local notGetRewards, getRewards = ActFlipModel.instance:getCardRewardsDetail(self._curCardIndex)

	for i = 1, #notGetRewards do
		local rewardId = notGetRewards[i]

		if not self._rewardItems[i] then
			self._rewardItems[i] = ActFlipRewardItem.New()

			local go = gohelper.cloneInPlace(self._gorewarditem)

			self._rewardItems[i]:init(go)
		end

		self._rewardItems[i]:refresh(rewardId)
		self._rewardItems[i]:showGet(false)
	end

	for i = #notGetRewards + 1, #notGetRewards + #getRewards do
		local rewardId = getRewards[i - #notGetRewards]

		if not self._rewardItems[i] then
			self._rewardItems[i] = ActFlipRewardItem.New()

			local go = gohelper.cloneInPlace(self._gorewarditem)

			self._rewardItems[i]:init(go)
		end

		self._rewardItems[i]:refresh(rewardId)
		self._rewardItems[i]:showGet(true)
	end
end

function ActFlipRewardTipsView:onClose()
	return
end

function ActFlipRewardTipsView:onDestroyView()
	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			item:destroy()
		end

		self._rewardItems = nil
	end

	if self._tagItems then
		for i, tagItem in pairs(self._tagItems) do
			tagItem.btnClick:RemoveClickListener()
		end

		self._tagItems = nil
	end
end

return ActFlipRewardTipsView
