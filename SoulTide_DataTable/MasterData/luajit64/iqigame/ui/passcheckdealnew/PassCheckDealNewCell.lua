-- chunkname: @IQIGame\\UI\\PassCheckDealNew\\PassCheckDealNewCell.lua

local m = {
	Type = 1,
	BaseItemCellPool = {},
	SuperItemCellPool = {},
	BaseRewards = {},
	PayRewards = {}
}
local ImageNumber = require("IQIGame.UI.Common.ImageNumber")

function m.New(view, type)
	local obj = Clone(m)

	obj:Init(view, type)

	return obj
end

function m:Init(view, type)
	self.View = view
	self.Type = type

	LuaCodeInterface.BindOutlet(self.View, self)

	if self.goTitle then
		UGUIUtil.SetText(self.goTitle, PassCheckDealNewUIApi:GetString("Title", self.Type))
	end

	if self.goDesc then
		UGUIUtil.SetText(self.goDesc, PassCheckDealNewUIApi:GetString("Desc"))
	end

	if self.goScrollRewardBase then
		self.goScrollRewardBase:GetComponent("ScrollAreaList").onRenderCell = function(cell)
			self:OnRenderRewardBaseCell(cell)
		end
	end

	if self.goScrollRewardSuper then
		self.goScrollRewardSuper:GetComponent("ScrollAreaList").onRenderCell = function(cell)
			self:OnRenderRewardSuperCell(cell)
		end
	end

	if self.goCurrentNumBox then
		self.CurrentImgNumber = ImageNumber.New(self.goCurrentNumBox, 3, function(num)
			return PassCheckDealNewUIApi:GetString("ReplacementImgNum", num)
		end)
	end

	if self.goEndNumBox then
		self.EndImgNumber = ImageNumber.New(self.goEndNumBox, 3, function(num)
			return PassCheckDealNewUIApi:GetString("ReplacementImgNum", num)
		end)
	end

	function self.DelegateBtnBuy()
		self:OnBtnBuy()
	end

	self:AddListener()
end

function m:AddListener()
	if self.goBtnBuy then
		self.goBtnBuy:GetComponent("Button").onClick:AddListener(self.DelegateBtnBuy)
	end
end

function m:RemoveListener()
	if self.goBtnBuy then
		self.goBtnBuy:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnBuy)
	end
end

function m:SetData(data)
	if self.Type == 1 then
		self.CfgMallData = CfgMallTable[data.PayMoney]
	elseif self.Type == 2 then
		self.CfgMallData = CfgMallTable[data.LvBundlePayMoney]
	end

	self.CfgPayData = CfgPayTable[self.CfgMallData.PayMoney]

	self:UpDateView()
end

function m:UpDateView()
	if self.goBtnBuy then
		UGUIUtil.SetTextInChildren(self.goBtnBuy, string.format(MiscApi:GetString("moneySign") .. "%s", self.CfgPayData.Amount))
	end

	local currentLv = PassCheckModule.lv or 1
	local endLv = currentLv + 20

	if endLv > PassCheckModule.maxLv then
		endLv = PassCheckModule.maxLv
	end

	if self.CurrentImgNumber then
		self.CurrentImgNumber:SetNum(currentLv)
	end

	if self.EndImgNumber then
		self.EndImgNumber:SetNum(endLv)
	end

	self.BaseRewards = {}

	if self.goScrollRewardBase then
		self.BaseRewards = self:GetShowAddReward(0, currentLv)

		self.goScrollRewardBase:GetComponent("ScrollAreaList"):Refresh(#self.BaseRewards)
	end

	if self.goScrollRewardSuper then
		if self.Type == 1 then
			self.PayRewards = self:GetShowAddReward(currentLv + 1, PassCheckModule.maxLv)
		elseif self.Type == 2 then
			self.PayRewards = self:GetShowAddReward(currentLv + 1, endLv)
		end

		self.goScrollRewardSuper:GetComponent("ScrollAreaList"):Refresh(#self.PayRewards)
	end
end

function m:GetShowAddReward(currentLv, endLv)
	local showRewards = {}
	local passRewards = PassCheckModule.GetSortCfgRewardDatum()
	local rewards = {}

	for i, v in pairs(passRewards) do
		if currentLv <= v.SeasonLv and endLv >= v.SeasonLv then
			for index = 1, #v.PayReward, 2 do
				local id = v.PayReward[index]
				local value = v.PayReward[index + 1]

				rewards[id] = rewards[id] or 0
				rewards[id] = rewards[id] + value
			end
		end
	end

	for i, v in pairs(rewards) do
		local itemShowPOD = {}

		itemShowPOD.cid = i
		itemShowPOD.num = v

		table.insert(showRewards, itemShowPOD)
	end

	return showRewards
end

function m:OnRenderRewardBaseCell(cell)
	local itemShowPOD = self.BaseRewards[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.BaseItemCellPool[instanceID]

	if itemCell == nil then
		itemCell = ItemCell.New(cell.transform:GetChild(0).gameObject, true, true, true)
		self.BaseItemCellPool[instanceID] = itemCell
	end

	itemCell:SetItemByCID(itemShowPOD.cid, itemShowPOD.num)
end

function m:OnRenderRewardSuperCell(cell)
	local itemShowPOD = self.PayRewards[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.SuperItemCellPool[instanceID]

	if itemCell == nil then
		itemCell = ItemCell.New(cell.transform:GetChild(0).gameObject, true, true, true)
		self.SuperItemCellPool[instanceID] = itemCell
	end

	itemCell:SetItemByCID(itemShowPOD.cid, itemShowPOD.num)
end

function m:OnBtnBuy()
	MallModule.ReqPay(self.CfgMallData.PayMoney)
	UIModule.Close(Constant.UIControllerName.PassCheckDealNewUI)
end

function m:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.BaseItemCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.SuperItemCellPool) do
		v:Dispose()
	end

	if self.CurrentImgNumber then
		self.CurrentImgNumber:Dispose()
	end

	if self.EndImgNumber then
		self.EndImgNumber:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
