-- chunkname: @IQIGame\\UI\\Lottery\\LotteryProgressPanel.lua

local LotteryProgressPanel = class(nil, BaseChildrenPanel)
local LotteryMessageItemViewClass = require("IQIGame.UI.Lottery.LotteryMessageItemView")

function LotteryProgressPanel.New(go, mainView)
	local o = Clone(LotteryProgressPanel)

	o:Initialize(go, mainView)

	return o
end

function LotteryProgressPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function LotteryProgressPanel:InitComponent()
	self.SkipBtn = self.SkipBtn:GetComponent("Button")
	self.messageScrollList = self.messageScrollList:GetComponent("ScrollRect")
	self.messageViewList = {}

	for i = 1, LuaUtility.GetChildCount(self.messageContent.transform) do
		local objectItem = LuaUtility.GetChild(self.messageContent.transform, i - 1)
		local item = LotteryMessageItemViewClass.New(objectItem.gameObject, self)

		item:Hide()
		table.insert(self.messageViewList, item)
	end
end

function LotteryProgressPanel:InitDelegate()
	function self.SkipBtnDelegate()
		self:OnSkipBtnClick()
	end

	function self.buttonProgressSkipDelegate()
		self:OnButtonProgressSkipClick()
	end
end

function LotteryProgressPanel:AddListener()
	self.SkipBtn.onClick:AddListener(self.SkipBtnDelegate)
	self.buttonProgressSkip:GetComponent("Button").onClick:AddListener(self.buttonProgressSkipDelegate)
end

function LotteryProgressPanel:RemoveListener()
	self.SkipBtn.onClick:RemoveListener(self.SkipBtnDelegate)
	self.buttonProgressSkip:GetComponent("Button").onClick:RemoveListener(self.buttonProgressSkipDelegate)
end

function LotteryProgressPanel:OnSkipBtnClick()
	return
end

function LotteryProgressPanel:OnButtonProgressSkipClick()
	for i = #self.Data.drawResults, 1, -1 do
		local cid = self.Data.drawResults[i].itemShowPODs[1].cid

		if self.Data.drawResults[i].isCheck or CfgItemTable[cid].ItemTypes == Constant.ItemType.HeroDebris then
			table.remove(self.Data.drawResults, i)
		end
	end

	self.mainView.HeroShowView:SetData(self.Data, function()
		self.mainView.RewardShowView:SetData(self.originalData.drawResults)
		self.mainView.RewardShowView:Show()
	end)
	self:Close()
end

function LotteryProgressPanel:OnClose()
	for i = 1, #self.messageViewList do
		self.messageViewList[i]:Hide()
	end

	LuaUtility.SetGameObjectShow(self.MobileParent, false)
end

function LotteryProgressPanel:OnOpen()
	LuaUtility.SetGameObjectShow(self.notTouchMask, true)
end

function LotteryProgressPanel:Refresh(Data)
	self.index = 1
	self.originalData = Data
	self.Data = Clone(Data)

	LuaUtility.SetGameObjectShow(self.effectPhoneLight, false)
	LuaUtility.SetGameObjectShow(self.buttonProgressSkip, false)
	LuaUtility.SetGameObjectShow(self.MobileParent, true)

	if #Data.drawResults < 10 then
		LuaUtility.PlayAnimation(self.MobileParent, "Lottery_1")
	else
		LuaUtility.PlayAnimation(self.MobileParent, "Lottery_10")
	end

	coroutine.start(function()
		coroutine.wait(LuaUtility.GetDoTweenMaxTime(self.MobileParent))
		self:ShowReward(Data.drawResults)
	end)
end

function LotteryProgressPanel:ShowReward(Data)
	local isTenStraight = #Data >= 10 and true or false

	self.index = 10

	for i = 1, #Data do
		self.messageViewList[self.index]:Show()
		self.messageViewList[self.index]:Refresh(Data[i], isTenStraight, self.index, i)

		self.index = self.index - 1
		self.messageScrollList.verticalNormalizedPosition = 1
	end

	coroutine.start(function()
		coroutine.wait(CfgUtil.publicParametersData.lotteryRGBDelayTime)

		if self:HasSSR(Data) then
			self:PlayPhoneLightEffect()
		end
	end)
	coroutine.start(function()
		coroutine.wait(LuaUtility.GetAnimationLengthWithName(self.MobileParent, isTenStraight and "Lottery_10" or "Lottery_1"))

		if isTenStraight then
			LuaUtility.SetGameObjectShow(self.notTouchMask, false)
		end

		LuaUtility.SetGameObjectShow(self.buttonProgressSkip, true)
	end)
end

function LotteryProgressPanel:HasSSR(Data)
	for i = 1, #Data do
		local cfgItem = CfgUtil.GetItemCfgDataWithID(Data[i].itemShowPODs[1].cid)

		if cfgItem.Quality >= 5 then
			return true
		end
	end

	return false
end

function LotteryProgressPanel:PlayPhoneLightEffect()
	LuaUtility.SetGameObjectShow(self.effectPhoneLight, true)
end

function LotteryProgressPanel:ShowOneReward(data, index, dataIndex)
	local drawPod = {}

	drawPod.drawResults = {
		data
	}

	self.messageViewList[index]:Hide()

	local isShowView = 10

	for i = 1, #self.messageViewList do
		if not self.messageViewList[i]:IsShow() then
			isShowView = isShowView - 1
		end
	end

	if isShowView <= 0 then
		self:OnButtonProgressSkipClick()
	else
		self.mainView.HeroShowView:SetData(drawPod, function()
			self.mainView.HeroShowView:Hide()
		end)
	end

	self.Data.drawResults[dataIndex].isCheck = true
end

return LotteryProgressPanel
