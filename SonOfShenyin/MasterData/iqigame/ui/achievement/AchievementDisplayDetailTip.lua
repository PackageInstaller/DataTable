-- chunkname: @IQIGame\\UI\\Achievement\\AchievementDisplayDetailTip.lua

local AchievementDisplayDetailTip = {}
local AcDisplayDetailTipApproachItemClass = require("IQIGame.UI.Achievement.AcDisplayDetailTipApproachItem")

function AchievementDisplayDetailTip.New(go, mainView)
	local o = Clone(AchievementDisplayDetailTip)

	o:Initialize(go, mainView)

	return o
end

function AchievementDisplayDetailTip:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function AchievementDisplayDetailTip:InitMembers()
	self.approachItemViews = {}
end

function AchievementDisplayDetailTip:InitComponent()
	self.closeBtn = self.closeBtn:GetComponent("Button")
	self.approachContentTrans = self.approachContent.transform

	for i = 1, LuaUtility.GetChildCount(self.approachContentTrans) do
		local trans = LuaUtility.GetChild(self.approachContentTrans, i - 1)
		local item = AcDisplayDetailTipApproachItemClass.New(trans.gameObject, self)

		table.insert(self.approachItemViews, item)
	end
end

function AchievementDisplayDetailTip:InitDelegate()
	function self.closeBtnDelegate()
		self:OnCloseBtnClick()
	end
end

function AchievementDisplayDetailTip:AddListener()
	self.closeBtn.onClick:AddListener(self.closeBtnDelegate)
end

function AchievementDisplayDetailTip:RemoveListener()
	self.closeBtn.onClick:RemoveListener(self.closeBtnDelegate)
end

function AchievementDisplayDetailTip:OnCloseBtnClick()
	self:Close()
end

function AchievementDisplayDetailTip:Show(itemID)
	local cfgData = CfgUtil.GetItemCfgDataWithID(itemID)

	self:Refresh(cfgData)
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function AchievementDisplayDetailTip:Close()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function AchievementDisplayDetailTip:Refresh(Data)
	self.Data = Data

	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(self.Data.Icon), self.itemImg:GetComponent("Image"))
	LuaUtility.SetText(self.nameText, self.Data.Name)
	LuaUtility.SetText(self.content, self.Data.ItemTips)

	local getWays = self.Data.Source
	local index = 1

	for i = 1, #getWays do
		local item = self:GetOrCreateAcApproachItem(i)

		item:Refresh(getWays[i])
		item:Show()

		index = i
	end

	for i = index + 1, #self.approachItemViews do
		self.approachItemViews[i]:Hide()
	end
end

function AchievementDisplayDetailTip:GetOrCreateAcApproachItem(index)
	if index <= #self.approachItemViews then
		return self.approachItemViews[index]
	end

	local obj = GameObject.Instantiate(self.itemPrefab, self.approachContentTrans)
	local item = AcDisplayDetailTipApproachItemClass.New(obj, self)

	table.insert(self.approachItemViews, item)
end

return AchievementDisplayDetailTip
