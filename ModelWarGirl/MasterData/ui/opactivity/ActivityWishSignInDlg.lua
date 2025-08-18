-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityWishSignInDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActivityWishRewardPool = require("ClientData/ResOpActivityWishRewardPool")
local ResOpActivityWishMisc = require("ClientData/ResOpActivityWishMisc")
local ResRandClient = require("ClientData/ResRandClient")
local SelWishAwardItem = Class("SelWishAwardItem", UIControls.Child)
local WEEKDAY = {
	Lang.get(1764),
	Lang.get(1765),
	Lang.get(1766),
	Lang.get(1767),
	Lang.get(1768),
	Lang.get(1769),
	Lang.get(1775)
}

function SelWishAwardItem:ctor()
	self.item = nil
	self.txtNmlAward = UIControls.Panel(self, "FixedAwardText")
	self.descPanel = UIControls.Panel(self, "MissText")
	self.txtDesc = UIControls.Label(self, "MissText/Text")
end

function SelWishAwardItem:setData(index, isSpecWish, wishData, hasWish)
	local awardId

	self.txtNmlAward:setVisible(false)

	if index == 2 and isSpecWish then
		awardId = self.mParent.miscData.fix_reward_id

		self.txtNmlAward:setVisible(true)
	elseif wishData then
		local poolId = self.mParent.miscData.reward_pool

		awardId = ResOpActivityWishRewardPool[poolId][wishData.index].reward_id
	end

	if awardId then
		if not self.item then
			local awardData = ResRandClient[awardId]
			local item = UIControls.getGridAwardContainer(self, "ItemNode")
			local clientItem = BaseObject.GetObject(awardData.show_ids[1], awardData.show_nums[1])

			item.mDisableWays = true

			item:setObj(clientItem)

			self.item = item
		end

		if isSpecWish and index == 2 and hasWish == false then
			self.item:setIconGray(true)
		else
			self.item:setIconGray(false)
		end

		self.item:setVisible(true)
		self.descPanel:setVisible(false)
	else
		if self.item then
			self.item:setVisible(false)
		end

		local curWday = self.mParent.actData.curWday

		if curWday < 6 then
			curWday = curWday + 7
		end

		local wDay = self.mParent.miscData.wish_days and self.mParent.miscData.wish_days[index] or nil

		if wDay then
			if wDay < curWday then
				self.txtDesc:setText(Lang.get(30628))
				self.descPanel:setVisible(true)
			elseif curWday < wDay then
				if RegionUtils.isSEA() then
					WEEKDAY = {
						Lang.get(56527),
						Lang.get(56528),
						Lang.get(56529),
						Lang.get(56530),
						Lang.get(56531),
						Lang.get(56532),
						Lang.get(56533)
					}

					self.txtDesc:setText(string.format(Lang.get(56534), WEEKDAY[wDay]))
				else
					self.txtDesc:setText(string.format(Lang.get(30629), WEEKDAY[wDay]))
				end

				self.descPanel:setVisible(true)
			else
				self.descPanel:setVisible(false)
			end
		else
			self.descPanel:setVisible(false)
		end
	end
end

function SelWishAwardItem:setAward(awardData)
	if not self.item then
		local item = UIControls.getGridAwardContainer(self, "ItemNode")

		self.item = item
	end

	local clientItem = BaseObject.GetObject(awardData.show_ids[1], awardData.show_nums[1])

	self.item:setObj(clientItem)

	self.item.grid.mDisableWays = true

	self.item:setVisible(true)
end

local WishAwardItem = Class("WishAwardItem", UIControls.Panel)

function WishAwardItem:ctor()
	self.btn = UIControls.Button(self, self.mPath)

	self.btn:addEventClick(Slot(self.onBtnClick, self))

	self.imgMask = UIControls.Panel(self, self.mPath .. "/Img")
	self.imgBg = UIControls.Panel(self, self.mPath .. "/Background")
	self.imgLock = UIControls.Panel(self, self.mPath .. "/AwardLock")
	self.imgGet = UIControls.Panel(self, self.mPath .. "/AwardCheck")
	self.imgCheck = UIControls.Panel(self, self.mPath .. "/Background/Checkmark")
	self.aniWish = UIControls.UIAni(self, self.mPath .. "/AwardLock")

	self.aniWish:addEventFinish(self.onAniEnd)

	self.item = nil
end

function WishAwardItem:setData(awardData, index)
	self.awardData = awardData
	self.index = index

	if awardData and not self.item then
		local item = UIControls.getGridAwardContainer(self, self.mPath .. "/ItemNode")
		local clientItem = BaseObject.GetObject(awardData.show_ids[1], awardData.show_nums[1])

		item:setObj(clientItem)

		item.grid.mDisableWays = true

		item:setVisible(true)

		self.item = item
	end
end

function WishAwardItem:setState(state, hasWish)
	self.imgCheck:setVisible(false)

	if state == 1 then
		self.btn:setEnable(false)
		self.imgMask:setVisible(false)
		self.imgLock:setVisible(true)
		self.imgGet:setVisible(false)
		self.item:setIconGray(true)
		self.imgBg:setObjGray(true)
	elseif state == 2 then
		self.btn:setEnable(false)
		self.imgMask:setVisible(false)
		self.imgLock:setVisible(false)
		self.imgGet:setVisible(true)
		self.item:setIconGray(true)
		self.imgBg:setObjGray(true)
	else
		self.btn:setEnable(not hasWish)
		self.imgMask:setVisible(not hasWish)
		self.imgLock:setVisible(false)
		self.imgGet:setVisible(false)
		self.item:setIconGray(false)
		self.imgBg:setObjGray(false)
	end
end

function WishAwardItem:setSel(isSelected)
	self.imgCheck:setVisible(isSelected)
	self.btn:setEnable(not isSelected)
	self.imgMask:setVisible(not isSelected)
end

function WishAwardItem:onBtnClick()
	if self.mEventClick then
		self:mEventClick(self)
	end
end

function WishAwardItem:playWishAni()
	self.imgLock:setVisible(true)
	self.aniWish:startAni("SigInWishHearCell")
end

function WishAwardItem:onAniEnd()
	self:setSel(false)
	self.mParent:onPanelRefresh()
end

local ActivityWishSignInDlg = Class("ActivityWishSigninDlg", UIControls.Window)

MixinClass(ActivityWishSignInDlg, ActivityPanelMixin)

function ActivityWishSignInDlg:ctor()
	return
end

function ActivityWishSignInDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickClose)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm", "Text")

	self.btnConfirm:addEventClick(self.onConfirmClick)

	self.imgIconNew = UIControls.Image(self, "BgPanel/BtnConfirm/IconNew")
	self.awardPanel = UIControls.Panel(self, "BgPanel/AwardGroup")
	self.awardTimePanel = UIControls.Panel(self, "BgPanel/AwardTimeBack")
	self.txtAwardLimit = UIControls.Label(self, "BgPanel/AwardTimeBack/TimeText")
	self.actTimePanel = UIControls.Panel(self, "BgPanel/ActivitTimBack")
	self.txtActLimit = UIControls.Label(self, "BgPanel/ActivitTimBack/ActivitTimeText")
	self.awardNothingPanel = UIControls.Panel(self, "BgPanel/AwardNoting")
	self.awardItems = {}
	self.gridParent = {}
	self.selAwarditems = {}

	for i = 1, 7 do
		self.gridParent[i] = UIControls.Panel(self, "BgPanel/AwardGroup/CardList0" .. i)
	end
end

function ActivityWishSignInDlg:_onShow(isOnPageShow)
	if not isOnPageShow then
		self.gotAll = self.actData.gotAll
	end

	self:refreshUI()
end

function ActivityWishSignInDlg:_setData()
	self.actData = self.actObj.actData

	if not self.miscData then
		self.miscData = ResOpActivityWishMisc[self.actObj.actId]
		self.isSpecWish = false

		if self.miscData.wish_days then
			self.dayCount = #self.miscData.wish_days
		end

		if self.miscData.next_day_award and self.miscData.next_day_award == 1 then
			self.isSpecWish = true
		end
	end
end

function ActivityWishSignInDlg:refreshUI()
	if self.actData.isWishDay or self.actData.isRewardDay then
		self:setItems()
	end

	self:setState()
end

function ActivityWishSignInDlg:setItems()
	local wishAwards = {}

	for i, wData in ipairs(self.actData.wishPool) do
		wishAwards[wData.index] = true
	end

	local hasWish = self.actData.hasWish

	if self.isSpecWish and #self.actData.wishPool > 0 then
		hasWish = true
	end

	local awardPool = ResOpActivityWishRewardPool[self.miscData.reward_pool]

	for i = 1, 7 do
		if awardPool[i] then
			local awardData = ResRandClient[awardPool[i].reward_id]

			if not self.awardItems[i] then
				local awardItem = WishAwardItem(self, "BgPanel/AwardGroup/CardList0" .. i)

				awardItem.mEventClick = Slot(self.onAwardSel, self)
				self.awardItems[i] = awardItem
			end

			self.awardItems[i]:setData(awardData, awardPool[i].index)

			local state = 0

			if self.actData.got[i + 1] then
				state = 2
			elseif wishAwards[i] then
				state = 1
			end

			self.awardItems[i]:setState(state, hasWish)
			self.gridParent[i]:setVisible(true)
		else
			self.gridParent[i]:setVisible(false)
		end
	end

	local count = self.isSpecWish == true and 2 or self.dayCount

	for j = 1, count do
		if not self.selAwarditems[j] then
			local path = "System/Activity/WishAwardBtn"

			self.selAwarditems[j] = SelWishAwardItem(self, "BgPanel/AwardGroup/WishAwardNode", path)
		end

		local wDay = self.miscData.wish_days and self.miscData.wish_days[j] or nil
		local wishData

		if wDay and self.actData.wishPoolByWday[wDay] then
			wishData = self.actData.wishPoolByWday[wDay]
		elseif self.isSpecWish then
			wishData = self.actData.wishPool[j]
		end

		self.selAwarditems[j]:setData(j, self.isSpecWish, wishData, hasWish)
		self.selAwarditems[j]:setVisible(true)

		if self.isSpecWish then
			if j == 1 then
				self.todaySelAward = self.selAwarditems[j]
			end
		else
			local wishDay = self.miscData.wish_days[j]

			if wishDay and wishDay == self.actData.curWday then
				self.todaySelAward = self.selAwarditems[j]
			end
		end
	end
end

function ActivityWishSignInDlg:setState()
	self.wishState = self.actData:getState()

	self.awardNothingPanel:setVisible(false)
	self.awardTimePanel:setVisible(false)
	self.awardPanel:setVisible(true)

	if self.wishState == 1 then
		self.btnConfirm:setVisible(true)
		self.btnConfirm:setText(Lang.get(308))
	elseif self.wishState == 2 then
		self.btnConfirm:setVisible(false)
		self.awardTimePanel:setVisible(true)

		if self.actData.rewardTime > 0 then
			local timeLeft = self.actData.rewardTime - ClientUtils.getServerTime()

			ClientTimerManager.AddSecondFormatTickUI(self.txtAwardLimit, timeLeft, false, Lang.get(48679))
		end
	elseif self.wishState == 3 then
		self.btnConfirm:setVisible(true)
		self.btnConfirm:setText(Lang.get(38))
	else
		self.awardPanel:setVisible(false)
		self.btnConfirm:setVisible(false)
		self.awardNothingPanel:setVisible(true)
	end

	if self.isSpecWish then
		self.actTimePanel:setVisible(self.wishState ~= 0)

		local timeLeft = self.actObj:getRemainOpenTime()

		ClientTimerManager.AddSecondFormatTickUI(self.txtActLimit, timeLeft, false, Lang.get(48655))
	elseif self.wishState == 0 then
		self.actTimePanel:setVisible(true)

		local timeLeft = self.actData.nextWishTime - ClientUtils.getServerTime()

		ClientTimerManager.AddSecondFormatTickUI(self.txtActLimit, timeLeft, false, Lang.get(45383))
	else
		self.actTimePanel:setVisible(false)
	end
end

function ActivityWishSignInDlg:setChooseAward()
	if self.todaySelAward and self.curSelAward then
		self.todaySelAward:setAward(self.curSelAward.awardData)
		self.btnConfirm:setVisible(true)
	end
end

function ActivityWishSignInDlg:onConfirmClick()
	if self.wishState == 1 then
		if not self.curSelAward then
			MsgManager.notice(Lang.get(30632))
		else
			CurAvatar:activityRPC(Functor(RPC.opactWishChoose, self.actObj.opId, self.curSelAward.index), self.actObj.opId)
			self.btnConfirm:setVisible(false)
		end
	elseif self.wishState == 3 then
		for i, data in ipairs(self.actData.wishPool) do
			CurAvatar:activityRPC(Functor(RPC.opactWishGetAward, self.actObj.opId, data.index), self.actObj.opId)
		end
	end
end

function ActivityWishSignInDlg:onAwardSel(sender)
	if self.wishState == 1 then
		if self.curSelAward then
			self.curSelAward:setSel(false)
		end

		sender:setSel(true)

		self.curSelAward = sender

		self:setChooseAward()
	end
end

function ActivityWishSignInDlg:onClickClose()
	self:setVisible(false)
end

function ActivityWishSignInDlg:onClose()
	ActivityWishSignInDlg.super.onClose(self)

	self.curSelAward = nil
end

function ActivityWishSignInDlg:updateActivityData(actObj)
	if self.curSelAward then
		self.curSelAward:playWishAni()

		self.curSelAward = nil
	else
		self:onPanelRefresh()
	end
end

function ActivityWishSignInDlg:onPanelRefresh()
	self:refreshUI()
	CurAvatar:_refreshActivityUI()
end

return ActivityWishSignInDlg
