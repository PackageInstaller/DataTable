-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\BPBuyBox.lua

local ResRandClient = require("ClientData/ResRandClient")
local RechargeManager = require("System/Recharge/RechargeManager")
local strClassName = "BPBuyBox"
local BPBuyBox = Class(strClassName, UIControls.Window)

function BPBuyBox:ctor()
	self.txtTimeTip = UIControls.Label(self, "Bg/TextTips")
	self.btn = UIControls.Button(self, "Bg/BtnFunc", "TextPrice")
	self.items = {}

	self.btn:addEventClick(self.onBtnClick)

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "Bg/BtnFunc/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "Bg/BtnFunc/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function BPBuyBox:onShow(awardIds, rechargeId, price, time, showTime)
	self.btn:setText(price)

	self.lastTime = time

	ClientTimerManager.RemoveSecondTickUI(self.txtTimeTip)

	if showTime == true then
		if self.lastTime / 86400 >= 1 then
			self.txtTimeTip:setText(string.format(Lang.get(30531), math.floor(self.lastTime / 86400)))
		else
			ClientTimerManager.AddSecondFormatTickUI(self.txtTimeTip, self.lastTime, nil, Lang.get(48673), Slot(self.timeDownCB, self))
		end

		self.txtTimeTip:setVisible(true)
	else
		self.txtTimeTip:setVisible(false)
	end

	for _, item in ipairs(self.items) do
		item:setVisible(false)
	end

	local index = 0

	for idx, super_award in pairs(awardIds) do
		local supAwardData = ResRandClient[super_award]

		for k, id in ipairs(supAwardData.show_ids) do
			index = index + 1

			local item = BaseObject.GetObject(id, supAwardData.show_nums[k])

			if not self.items[index] then
				self.items[index] = UIControls.getGridChild(item, self, "Bg/AwardList/Content")

				self.items[index]:setVisible(true)
			end

			self.items[index].mDisableWays = true

			self.items[index]:setObj(item)
		end
	end

	self.rechargeId = rechargeId
end

function BPBuyBox:onBtnClick()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_RECHARGE, self.rechargeId)
	RechargeManager.startRecharge(self.rechargeId, nil, nil)
	self:setVisible(false)
	ClientTimerManager.RemoveSecondTickUI(self.txtTimeTip)
end

function BPBuyBox:timeDownCB()
	self:setVisible(false)
	ClientTimerManager.RemoveSecondTickUI(self.txtTimeTip)
end

return BPBuyBox
