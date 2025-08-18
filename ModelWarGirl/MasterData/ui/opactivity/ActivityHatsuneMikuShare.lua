-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityHatsuneMikuShare.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ShareAchievePanel = require("UI/Achieve/ShareAchievePanel")
local ResShopExchg = require("ClientData/ResShopExchg")
local ResOpActivityConditionLimit = require("ClientData/ResOpActivityConditionLimit")
local ResOpActivityShopMisc = require("ClientData/ResOpActivityShopMisc")
local classNameStr = "ActivityHatsuneMikuSharePage"
local ActivityHatsuneMikuShare = Class(classNameStr, UIControls.Child)

MixinClass(ActivityHatsuneMikuShare, ActivityPanelMixin)

local shareBgs = {
	shareBg1 = 1,
	shareBg2 = 2
}

function ActivityHatsuneMikuShare:initUI()
	self.bg1 = UIControls.Panel(self, "Bg1")
	self.bg2 = UIControls.Panel(self, "Bg2")
	self.btnAct1 = UIControls.Button(self, "BtnAct1")

	self.btnAct1:addEventClick(Functor(self._switchPanel, self, shareBgs.shareBg1))

	self.btnAct2 = UIControls.Button(self, "BtnAct2")

	self.btnAct2:addEventClick(Functor(self._switchPanel, self, shareBgs.shareBg2))

	self.btnAct2Dis = UIControls.Button(self, "BtnAct2Dis")
	self.btn1RedDot = UIControls.Panel(self, "BtnAct1/IconNew")
	self.btn2RedDot = UIControls.Panel(self, "BtnAct2/IconNew")
	self.txtTime = UIControls.Label(self, "BgTime/TextTime")
	self.sharePanel = ShareAchievePanel(self, "SharePanel")

	self.sharePanel:setShopInfo(self.actObj.actId, "Miku")
	self.sharePanel:setShareVisible(true)
end

function ActivityHatsuneMikuShare:_switchPanel(shareBg)
	self.curBg = shareBg

	local isShowingBg1 = shareBg == shareBgs.shareBg1

	self.bg1:setVisible(isShowingBg1)
	self.bg2:setVisible(not isShowingBg1)
	self.btnAct1:setEnable(not isShowingBg1)
	self.btnAct2:setEnable(isShowingBg1)
	self:_refreshAwardPanel(isShowingBg1)
end

function ActivityHatsuneMikuShare:_refreshAwardPanel(isShowingBg1)
	local frame1, frame2

	if self.miscData then
		frame1, frame2 = unpack(self.miscData.shareFrameID)
	end

	local frameIdx = isShowingBg1 and frame1 or frame2
	local newRewardBtn1, newRewardBtn2, exchgid1, exchgid2

	for _, v in pairs(self.acts) do
		if v.index == 1 then
			exchgid1 = v.exchgid
			newRewardBtn1 = self:_checkPageReward(v.exchgid)
		elseif v.index == 2 then
			exchgid2 = v.exchgid
			newRewardBtn2 = self:_checkPageReward(v.exchgid)
		end
	end

	if isShowingBg1 then
		self.btn1RedDot:setVisible(false)
		self.btn2RedDot:setVisible(newRewardBtn2 or false)
		self.sharePanel:setShareFrame(frameIdx, exchgid1, newRewardBtn1)
	else
		self.btn1RedDot:setVisible(newRewardBtn1 or false)
		self.btn2RedDot:setVisible(false)
		self.sharePanel:setShareFrame(frameIdx, exchgid2, newRewardBtn2)
	end
end

function ActivityHatsuneMikuShare:_checkPageReward(exchgid)
	local pageData = self.acts[exchgid]
	local exchgmax = ResShopExchg[pageData.exchgid].exchgmax
	local hasBought = self.serverData[exchgid] and self.serverData[exchgid].count or 0

	if exchgmax and exchgmax - hasBought > 0 then
		return true
	else
		return false
	end
end

function ActivityHatsuneMikuShare:_onShow(isOnPageShow)
	if isOnPageShow then
		self:_switchPanel(shareBgs.shareBg1)

		for _, v in pairs(self.acts) do
			if v.index == 2 and v.act_condition then
				local btn2Dix = self.actObj.actData:isShopItemUnlock(v.exchgid)

				if btn2Dix then
					self.btnAct2Dis:setVisible(false)
					self.btn2RedDot:setVisible(self:_checkPageReward(v.exchgid))
				else
					self.btnAct2Dis:setVisible(true)
					self.btnAct2Dis:clearEventClick()
					self.btnAct2:setVisible(false)

					local function noticeLock()
						MsgManager.notice(ResOpActivityConditionLimit[v.act_condition].unlock_desc)
					end

					self.btnAct2Dis:addEventClick(noticeLock)
				end
			end
		end

		local leftTime = self.actObj:getRemainOpenTime()

		if leftTime > 0 then
			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, false, Lang.get(48674), Slot(self._onTimeDownEnd, self))
		end
	end
end

function ActivityHatsuneMikuShare:_onTimeDownEnd()
	self.txtTime:setText(Lang.get(30121))
end

function ActivityHatsuneMikuShare:_setData()
	local clientData = self.actObj.actData.clientData
	local serverData = self.actObj.actData.serverData

	self.acts = {}
	self.serverData = {}

	if clientData then
		for i, v in pairs(clientData) do
			self.acts[i] = v
		end
	end

	if serverData then
		for i, v in pairs(serverData) do
			if self.acts[i] then
				self.serverData[i] = v
			end
		end
	end

	self.miscData = ResOpActivityShopMisc[self.actObj.actId]

	for _, v in pairs(self.acts) do
		local newReward = self:_checkPageReward(v.exchgid)
		local btn2Dix = self.actObj.actData:isShopItemUnlock(v.exchgid)

		if self.actObj.actData and self.actObj.actData.checkNew then
			function self.actObj.actData.checkNew()
				return newReward and btn2Dix
			end

			if newReward and btn2Dix then
				break
			end
		end
	end

	if self.actObj and self.actObj.checkNew then
		self.actObj:checkNew()
	end
end

function ActivityHatsuneMikuShare:onActivityDataRefresh(actObj)
	self:_setData()

	if self.curBg then
		self:_switchPanel(self.curBg)
	end
end

return ActivityHatsuneMikuShare
