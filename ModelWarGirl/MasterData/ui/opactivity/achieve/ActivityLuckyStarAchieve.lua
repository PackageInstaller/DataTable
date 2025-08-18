-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Achieve\\ActivityLuckyStarAchieve.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local classNameStr = "ActivityLuckyStarAchieve"
local ActivityLuckyStarAchieve = Class(classNameStr, UIControls.Child)

MixinClass(ActivityLuckyStarAchieve, ActivityPanelMixin)

function ActivityLuckyStarAchieve:_setData()
	self.textTime = UIControls.Label(self, "BgTime/TextTime")
	self.textRule = UIControls.Label(self, "BgDes/TextDes")
	self.panelFinish = UIControls.Panel(self, "FinishPanel")
	self.panelReward = UIControls.Panel(self, "RewardPanel")
	self.btnWish = UIControls.Button(self, "RewardPanel/BtnWish")

	self.btnWish:addEventClick(self.onBtnWishClick)

	self.efxWishing = UIControls.Panel(self, "RewardPanel/Efx")
	self.rdWish = UIControls.Panel(self, "RewardPanel/BtnWish/IconNew")
	self.imgWishItem = UIControls.Image(self, "RewardPanel/BtnWish/ImgIcon")
	self.numWishItem = UIControls.Label(self, "RewardPanel/BtnWish/TextCostNum")
	self.panelFreeWish1 = UIControls.Panel(self, "RewardPanel/BtnWish/IconFree")
	self.panelFreeWish2 = UIControls.Panel(self, "RewardPanel/BtnWish/TextFree")
	self.panelFreeWish4 = UIControls.Panel(self, "RewardPanel/BtnWish/TextCostNum/ImgLine")
	self.textNowWish = UIControls.Label(self, "RewardPanel/TextStarAward")
	self.efxNowWish = UIControls.Panel(self, "RewardPanel/TextStarAward/Efx")
	self.textNowWishItem = UIControls.Label(self, "RewardPanel/AwardNumPanel/TextNum")
	self.btnNowWishItem = UIControls.Button(self, "RewardPanel/AwardNumPanel/IconAward")

	self.btnNowWishItem:addEventClick(self.onBtnWishItemClick)

	self.miscData = self.actObj.actData.miscData

	if self.miscData and self.miscData.item_id then
		Const.ACTIVITY_NO_BAG_ITEM_IDS[self.miscData.item_id] = true
		self.costItem = BaseObject.GetObject(self.miscData.item_id, 1)

		local itemPath = self.costItem:getIconPath()

		if itemPath then
			self.imgWishItem:setImage(itemPath[1], itemPath[2])
			self.btnNowWishItem:setImage(itemPath[1], itemPath[2])
		end
	end
end

function ActivityLuckyStarAchieve:onBtnWishClick()
	if self.wishing then
		return
	end

	if self.wishAchieveState == Const.ACT_ACHIEVE_STATE_ENOUGH then
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.actObj.opId, self.wishNowAchieveData.index, self.wishNowAchieveData.type), self.actObj.opId)
		CurAvatar:setCacheActivityBonus(self.actObj.opId, Functor(self.onCachedBonus, self, self.wishNowAchieveData))

		self.wishing = true
	else
		MsgManager.clientNotice(678)
	end
end

function ActivityLuckyStarAchieve:onCachedBonus(wishNowAchieveData, bonus)
	if self.id == nil then
		return
	end

	local hasCrit = false
	local critBonusNum = wishNowAchieveData.control_arg1 or 0
	local tData = self.actObj.actData.typeMiscData[wishNowAchieveData.type]

	if tData and tData.arg then
		local needItemId = tData.arg
		local items = bonus[3] or {}

		for _, info in ipairs(items) do
			if info.id == needItemId then
				hasCrit = critBonusNum <= info.num

				break
			end
		end
	end

	self.bonus = bonus

	if hasCrit then
		self:playAni("LuckycatsCirt", Slot(self.onPlayAniOver, self), true)
	else
		self:playAni("LuckycatsCommon", Slot(self.onPlayAniOver, self), true)
	end
end

function ActivityLuckyStarAchieve:onPlayAniOver()
	if self.bonus then
		CurAvatar:onGetBonusNotice("commonBonusDlg", "onShow", self.bonus)
	end

	self.wishing = false

	self:refreshData()
end

function ActivityLuckyStarAchieve:onBtnWishItemClick()
	if self.costItem then
		UIManager.getUI("itemTips"):showObj(self, self.costItem)
	end
end

function ActivityLuckyStarAchieve:_onShow()
	self.wishAchieveData = nil

	for achieveType, typeData in pairs(self.actObj.actData.clientData) do
		self.wishAchieveData = typeData

		break
	end

	self:refreshData()
end

function ActivityLuckyStarAchieve:refreshData()
	local actData = self.actObj.actData

	if actData:isOver() then
		self.panelReward:setVisible(false)
		self.panelFinish:setVisible(true)

		return
	end

	self.panelReward:setVisible(true)
	self.panelFinish:setVisible(false)

	local nextWishData, addProgress, _, _, preProgress = actData:getNextAchieveInfo()

	self.wishAchieveState = actData:getAchieveState(nextWishData.type, nextWishData.index)
	self.wishNowAchieveData = nextWishData

	self.textNowWish:setText(nextWishData.action_desc or "")

	if self.wishNowAchieveData.param > 0 then
		self.numWishItem:setText(self.wishNowAchieveData.param - preProgress)
		self.rdWish:setVisible(self.wishAchieveState == Const.ACT_ACHIEVE_STATE_ENOUGH)
		self.panelFreeWish1:setVisible(false)
		self.panelFreeWish2:setVisible(false)
		self.panelFreeWish4:setVisible(false)
	else
		self.numWishItem:setText(nextWishData.desc_name or "")
		self.rdWish:setVisible(false)
		self.panelFreeWish1:setVisible(true)
		self.panelFreeWish2:setVisible(true)
		self.panelFreeWish4:setVisible(true)
	end

	self.textNowWishItem:setText(addProgress - preProgress)

	if self.wishAchieveState == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.numWishItem:setFontColor(ResColor.COLORBGRANK06)
	else
		self.numWishItem:setFontColor(ResColor.RED)
	end

	if self.costItem then
		self.costItem.num = addProgress - preProgress
	end
end

function ActivityLuckyStarAchieve:onActivityDataRefresh()
	if not self.wishing then
		self:refreshData()
	end
end

function ActivityLuckyStarAchieve:updateRelatedActivityData()
	if not self.wishing then
		self:refreshData()
	end
end

return ActivityLuckyStarAchieve
