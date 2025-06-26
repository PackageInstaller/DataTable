-- chunkname: @IQIGame\\UI\\HomeLand\\HLWorkList\\WorkRecordView.lua

local WorkRecordView = {
	cellPool = {}
}
local EventRecordView = require("IQIGame.UI.HomeLand.HLWorkList.EventRecordView")
local WorkRecordCell = require("IQIGame.UI.HomeLand.HLWorkList.WorkRecordCell")

function WorkRecordView.New(view)
	local obj = Clone(WorkRecordView)

	obj:Init(view)

	return obj
end

function WorkRecordView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfCurRecordNum = self.goCurRecordNum:GetComponent("Text")
	self.eventRecordView = EventRecordView.New(self.goEventRecordView)
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnDeleteAll = self.goBtnDeleteAll:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnDeleteAllDelegate()
		self:OnClickBtnDeleteAll()
	end

	function self.onDeleteRecordSuccessDelegate()
		self:OnDeleteRecordSuccess()
	end

	self.scrollList = self.goScrollList:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectCell(cell)
	end

	self.goTitle:GetComponent("Text").text = HomeLandWorkListUIApi:GetString("workViewTitle")
	self.goTitle2:GetComponent("Text").text = HomeLandWorkListUIApi:GetString("workViewTitle2")
	self.goRecordDesc:GetComponent("Text").text = HomeLandWorkListUIApi:GetString("workViewRecordDDesc")
	self.goBtnDeleteAll.transform:Find("Text"):GetComponent("Text").text = HomeLandWorkListUIApi:GetString("btnDeleteAllTxt")
	self.goTotalRecordNum:GetComponent("Text").text = HomeLandWorkListUIApi:GetString("workViewTotalRecordNum", HLWorkModule.RECORD_LIMIT_NUM)
end

function WorkRecordView:Open(recordDataList)
	self.recordDataList = recordDataList

	self.View:SetActive(true)
	self.goWorkRecordBlock:SetActive(true)
	self.eventRecordView:Close()
	self:RefreshCells()
end

function WorkRecordView:Close()
	self:OnHide()
	self.View:SetActive(false)
end

function WorkRecordView:OnHide()
	for i, v in pairs(self.cellPool) do
		v:OnHide()
	end

	self.eventRecordView:OnHide()
end

function WorkRecordView:OnDestroy()
	for i, v in pairs(self.cellPool) do
		v:OnDestroy()
	end

	self.eventRecordView:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function WorkRecordView:OnAddListeners()
	self:OnRemoveListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnDeleteAll.onClick:AddListener(self.onClickBtnDeleteAllDelegate)
	EventDispatcher.AddEventListener(EventID.HLDeleteRecordSuccess, self.onDeleteRecordSuccessDelegate)
end

function WorkRecordView:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnDeleteAll.onClick:RemoveListener(self.onClickBtnDeleteAllDelegate)
	EventDispatcher.RemoveEventListener(EventID.HLDeleteRecordSuccess, self.onDeleteRecordSuccessDelegate)
end

function WorkRecordView:OnClickBtnClose()
	self:Close()
end

function WorkRecordView:OnClickBtnDeleteAll()
	HLWorkModule.DeleteAllRecord()
	self:Open(HLWorkModule.GetRecordDataList())
end

function WorkRecordView:OnDeleteRecordSuccess()
	self:Open(HLWorkModule.GetRecordDataList())
end

function WorkRecordView:OnRenderCell(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local recordData = self.recordDataList[luaIndex]
	local cfgWorkData = CfgTransactionListTable[recordData[1]]
	local workCell = self.cellPool[insID]

	if workCell == nil then
		workCell = WorkRecordCell.New(cell.gameObject)
		self.cellPool[insID] = workCell
	end

	workCell:Refresh(cfgWorkData, luaIndex, recordData[4])
end

function WorkRecordView:OnSelectCell(cell)
	local luaIndex = cell.index + 1
	local recordData = self.recordDataList[luaIndex]
	local cfgWorkData = CfgTransactionListTable[recordData[1]]

	self.eventRecordView:Open(cfgWorkData, recordData[2], recordData[3], recordData[4], recordData[5])
end

function WorkRecordView:RefreshCells()
	local num = #self.recordDataList

	self.tfCurRecordNum.text = HomeLandWorkListUIApi:GetString("workViewTotalRecordNum", num)

	self.scrollList:Refresh(num)
end

return WorkRecordView
