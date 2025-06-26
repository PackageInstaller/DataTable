-- chunkname: @IQIGame\\UI\\Activity\\SpaceTreasure\\SpaceTreasureView.lua

local m = {
	isPlayEffect = false,
	spaceCellTab = {}
}
local SpaceTreasureCell = require("IQIGame.UI.Activity.SpaceTreasure.SpaceTreasureCell")

function m.New(view, root, operateEventID)
	local obj = Clone(m)

	obj:Init(view, root, operateEventID)

	return obj
end

function m:Init(view, root, operateEventID)
	self.View = view
	self.root = root
	self.operateEventID = operateEventID

	LuaCodeInterface.BindOutlet(self.View, self)

	local sortComponents = self.View:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder))
	local canvas = self.root.UIController.gameObject:GetComponent("Canvas")

	for i = 0, sortComponents.Length - 1 do
		sortComponents[i].UIRootCanvas = canvas
	end

	UGUIUtil.SetText(self.TextBtnClaim, ActivityUIApi:GetString("SpaceTextBtnClaim"))
	UGUIUtil.SetText(self.TextGetMsg, ActivityUIApi:GetString("SpaceTextGetMsg"))

	function self.delegateUpdateOperations()
		self:UpDateView()
	end

	function self.delegateBtnClaim()
		self:OnBtnClaim()
	end

	function self.delegateOnUpdateItem()
		self:OnUpdateItem()
	end

	self.spaceCellTab = {}

	for i = 1, 4 do
		local cell = SpaceTreasureCell.New(self["Cell" .. i], self.root)

		function cell.clickSelfCallBack(cell)
			self:OnSelectCell(cell)
		end

		self.spaceCellTab[i] = cell
	end
end

function m.GetPreloadAssetPaths()
	return
end

function m:Update(elapseSeconds, realElapseSeconds)
	return
end

function m:AddListener()
	self.BtnClaim:GetComponent("Button").onClick:AddListener(self.delegateBtnClaim)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.delegateOnUpdateItem)
	EventDispatcher.AddEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function m:RemoveListener()
	self.BtnClaim:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClaim)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.delegateOnUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.UpdateOperationsEvent, self.delegateUpdateOperations)
end

function m:UpDateView()
	if ActiveOperationEventModule.CheckIsOpen(self.operateEventID) then
		self.eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.operateEventID)

		if self.eventPOD then
			local spaceListTab = ActiveSpaceTreasureModule.GetSpaceListData(self.operateEventID)

			for i = 1, #self.spaceCellTab do
				local cell = self.spaceCellTab[i]
				local cfgData = spaceListTab[i]

				cell:SetData(cfgData.Id)

				if self.selectCellID == cfgData.Id then
					cell:SetSelect(true)
				else
					cell:SetSelect(false)
				end

				local itemName = cell.costItemCfgData.Name
				local getNum = ActiveSpaceTreasureModule.GetItemNum(self.operateEventID, cell.costItemCfgData.Id)

				if getNum == nil then
					getNum = 0
				end

				UGUIUtil.SetText(self["TextSpendItem" .. i], ActivityUIApi:GetString("SpaceTextSpendItem", itemName, getNum))
			end

			UGUIUtil.SetText(self.TextOpenTime, ActivityUIApi:GetString("SpaceTextOpenTime", getCustomDateTimeText(self.eventPOD.startTime, "MonthToMinuteFormat"), getCustomDateTimeText(self.eventPOD.endTime, "MonthToMinuteFormat")))

			local cfgSpaceGlobal = CfgSpaceTreasureGlobalTable[self.eventPOD.dataCfgId]

			UGUIUtil.SetText(self.TextDes, cfgSpaceGlobal.Desc)

			local power = ActiveSpaceTreasureModule.GetSpendPower(self.operateEventID)

			UGUIUtil.SetText(self.TextSpendPower, ActivityUIApi:GetString("SpaceTextSpendPower", power))
			UGUIUtil.SetText(self.TextTitleMsg, ActivityUIApi:GetString("SpaceTextTitleMsg", cfgSpaceGlobal.NeedPower))
		end
	end
end

function m:OnSelectCell(cell)
	if self.selectCellID == cell.cfgSpaceListID then
		return
	end

	self.selectCellID = cell.cfgSpaceListID

	self:UpDateView()
end

function m:OnUpdateItem()
	if self.operateEventID then
		self:UpDateView()
	end
end

function m:OnBtnClaim()
	if self.isPlayEffect then
		return
	end

	if ActiveOperationEventModule.CheckIsOpen(self.operateEventID) and self.selectCellID then
		local cfgSpaceList = CfgSpaceTreasureListTable[self.selectCellID]
		local costItemCid = cfgSpaceList.Cost[1]
		local needItemNum = cfgSpaceList.Cost[2]
		local haveNum = WarehouseModule.GetItemNumByCfgID(costItemCid)

		if haveNum < needItemNum then
			NoticeModule.ShowNotice(21052002)

			return
		end

		local count = math.floor(haveNum / needItemNum)

		if count > 999 then
			count = 999
		end

		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		self.isPlayEffect = true

		self.ExploreEffect:SetActive(true)

		self.timer = Timer.New(function()
			self.ExploreEffect:SetActive(false)
			ActiveSpaceTreasureModule.Explore(self.operateEventID, self.selectCellID, count)

			self.isPlayEffect = false
		end, 2)

		self.timer:Start()
	end
end

function m:Open()
	self:AddListener()
	self.ExploreEffect:SetActive(false)
	self.View:SetActive(true)

	self.isPlayEffect = false
	self.selectCellID = ActiveSpaceTreasureModule.GetSelectSpace(self.operateEventID)

	self:UpDateView()
end

function m:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function m:OnHide()
	self:RemoveListener()
end

function m:OnDestroy()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	for i, v in pairs(self.spaceCellTab) do
		v:Dispose()
	end

	self.spaceCellTab = {}

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
