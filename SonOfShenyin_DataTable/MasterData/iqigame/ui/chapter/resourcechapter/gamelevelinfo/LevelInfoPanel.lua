-- chunkname: @IQIGame\\UI\\Chapter\\ResourceChapter\\GameLevelInfo\\LevelInfoPanel.lua

local m = {
	NeedPower = 0,
	ItemCellList = {},
	NeedItemList = {}
}
local StageDetailPanel = require("IQIGame.UI.Chapter.StageDetailPanel")

function m.New(view, onClose, uiController)
	local obj = Clone(m)

	obj:Init(view, onClose, uiController)

	return obj
end

function m:Init(view, onClose, uiController)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.OnClose = onClose
	self.SubTween = self.View:GetComponent("TweenPosition")
	self.CloseBtnComponent = self.CloseBtn:GetComponent("Button")
	self.ReadyFightBtnComponent = self.ReadyFightBtn:GetComponent("Button")
	self.LevelNameComponent = self.LevelName:GetComponent("Text")

	function self.DelegateCloseBtn()
		self:Hide()
	end

	self.DropItemContent = self.DropItemGrid:GetComponent("ScrollAreaList")

	function self.DropItemContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	function self.DelegateReadyFight()
		self:ReadyFightClick()
	end

	function self.DelegateAutoFight()
		self:AutoFightClick()
	end

	self.StageDetail = StageDetailPanel.New(self.StageDetailPanel)

	function self.delegateOpenStageDetailBtn()
		local monsterTeamID = self.LevelInfoData:GetCfg().MonsterTeam

		self.StageDetail:OnOpen(monsterTeamID)
	end

	self:AddListeners()
end

function m:AddListeners()
	self.CloseBtnComponent.onClick:AddListener(self.DelegateCloseBtn)
	self.ReadyFightBtnComponent.onClick:AddListener(self.DelegateReadyFight)
	self.AutoFightBtn:GetComponent("Button").onClick:AddListener(self.DelegateAutoFight)
	self.StageDetailParent:GetComponent("Button").onClick:AddListener(self.delegateOpenStageDetailBtn)
end

function m:RemoveListeners()
	self.CloseBtnComponent.onClick:RemoveListener(self.DelegateCloseBtn)
	self.ReadyFightBtnComponent.onClick:RemoveListener(self.DelegateReadyFight)
	self.AutoFightBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateAutoFight)
	self.StageDetailParent:GetComponent("Button").onClick:RemoveListener(self.delegateOpenStageDetailBtn)
end

function m:SetData(data)
	self.LevelInfoData = data

	self:SetOtherInfo()
end

function m:RefreshEnterConsumItem(cfgData)
	local needItemCid = 0
	local consumNum, enterConsum, passConsum = 0, 0, 0

	if cfgData.EnterCost ~= nil and #cfgData.EnterCost ~= 0 then
		enterConsum = cfgData.EnterCost[2]
		needItemCid = cfgData.EnterCost[1]
	end

	if cfgData.PassCost ~= nil and #cfgData.PassCost ~= 0 then
		passConsum = cfgData.PassCost[2]
		needItemCid = cfgData.PassCost[1]
	end

	consumNum = enterConsum + passConsum

	UGUIUtil.SetText(self.StrengthText, consumNum)

	local path = UIGlobalApi.GetIconPath(CfgItemTable[needItemCid].SmallIcon)

	AssetUtil.LoadImage(self, path, self.ConsumSlotImg:GetComponent("Image"))
end

function m:SetOtherInfo()
	self.DropData = {}
	self.LevelNameComponent.text = self.LevelInfoData:GetCfg().Name

	self:RefreshEnterConsumItem(self.LevelInfoData:GetCfg())

	for k = 1, #self.LevelInfoData:GetCfg().PassReward do
		for i, j in pairs(CfgDropLibTable[self.LevelInfoData:GetCfg().PassReward[k]].DropShowItem) do
			table.insert(self.DropData, ItemData.CreateByCIDAndNumber(j, 0))
		end
	end

	self.DropItemContent:Refresh(#self.DropData)
end

function m:OnRenderItem(cell)
	local dropItemData = self.DropData[cell.index + 1]
	local itemList = {}

	LuaCodeInterface.BindOutlet(cell.gameObject, itemList)

	self.ItemCell = ItemCell.PackageOrReuseView(self, itemList.CommonSlot, true, true)

	self.ItemCell:SetItem(dropItemData)
end

function m:Show()
	self:SetTweenState(true)
end

function m:Hide()
	self.StageDetail:OnClose()
	self:SetTweenState(false)

	if self.OnClose ~= nil then
		self.OnClose()
	end
end

function m:SetTweenState(state)
	self.CloseBtn:SetActive(state)
	self:PanelTween(self.SubTween, state)
end

function m:PanelTween(panel, v)
	if v == false then
		panel:PlayReverse()
	else
		panel:PlayForward()
	end
end

function m:ReadyFightClick()
	if WarehouseModule.GetPlayerStrengthNum() < self.NeedPower then
		NoticeModule.ShowNotice(20006)

		return
	end

	if not ActivityModule.IsOpenByTime(CfgDailyDupChapterTable[self.LevelInfoData:GetCfg().ChapterId].ActivityId) then
		NoticeModule.ShowNotice(51012)

		return
	end

	local userData = {}

	userData.OpenType = 2
	userData.ChapterType = Constant.ChapterPassType.TYPE_RESOURCES
	userData.StageId = self.LevelInfoData.cid

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

function m:AutoFightClick()
	if WarehouseModule.GetPlayerStrengthNum() < self.NeedPower then
		NoticeModule.ShowNotice(20006)

		return
	end

	local userData = {}

	userData.OpenType = 2
	userData.ChapterType = Constant.ChapterPassType.TYPE_RESOURCES
	userData.StageId = self.LevelInfoData.cid

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

function m:Dispose()
	self.StageDetail:OnDestroy()
	ItemCell.DisposeIn(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
