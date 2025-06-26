-- chunkname: @IQIGame\\UI\\ActivityNewDollBingoHistoryUI.lua

local ActivityNewDollBingoHistoryUI = {
	cellPool = {}
}

ActivityNewDollBingoHistoryUI = Base:Extend("ActivityNewDollBingoHistoryUI", "IQIGame.Onigao.UI.ActivityNewDollBingoHistoryUI", ActivityNewDollBingoHistoryUI)

local BingoRecordCell = require("IQIGame.UI.Activity.DollBingo.BingoRecordCell")

function ActivityNewDollBingoHistoryUI:OnInit()
	self:Initialize()
end

function ActivityNewDollBingoHistoryUI:GetPreloadAssetPaths()
	return nil
end

function ActivityNewDollBingoHistoryUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActivityNewDollBingoHistoryUI:IsManualShowOnOpen(userData)
	return false
end

function ActivityNewDollBingoHistoryUI:GetBGM(userData)
	return nil
end

function ActivityNewDollBingoHistoryUI:OnOpen(userData)
	self:Refresh(userData)
end

function ActivityNewDollBingoHistoryUI:OnClose(userData)
	self:OnHide()
end

function ActivityNewDollBingoHistoryUI:OnPause()
	return
end

function ActivityNewDollBingoHistoryUI:OnResume()
	return
end

function ActivityNewDollBingoHistoryUI:OnCover()
	return
end

function ActivityNewDollBingoHistoryUI:OnReveal()
	return
end

function ActivityNewDollBingoHistoryUI:OnRefocus(userData)
	return
end

function ActivityNewDollBingoHistoryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ActivityNewDollBingoHistoryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ActivityNewDollBingoHistoryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActivityNewDollBingoHistoryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActivityNewDollBingoHistoryUI:Initialize()
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnClose2 = self.goBtnClose2:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onUpdateRecordSuccessDelegate()
		self:OnUpdateRecordSuccess()
	end

	self.list = self.goList:GetComponent("ScrollAreaList")

	function self.list.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	self.goTitle:GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("recordTitle")
	self.goEmptyDesc:GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("recordEmptyDesc")
	self.goDesc:GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("recordDesc")

	for i = 1, 3 do
		self.goTagRoot.transform:Find("Text_0" .. i):GetComponent("Text").text = ActivityNewDollBingoUIApi:GetString("recordTag", i)
	end
end

function ActivityNewDollBingoHistoryUI:Refresh(userData)
	self.eventID = userData
	self.hasInit = false
	DollBingoModule.recordDatum = {}
	DollBingoModule.id2RecordDic = {}

	self:RefreshList()
	DollBingoModule.ReqRecord(self.eventID, 1)
end

function ActivityNewDollBingoHistoryUI:OnHide()
	for i, v in pairs(self.cellPool) do
		v:OnHide()
	end
end

function ActivityNewDollBingoHistoryUI:OnDestroy()
	for i, v in pairs(self.cellPool) do
		v:OnDestroy()
	end
end

function ActivityNewDollBingoHistoryUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:AddListener(self.onClickBtnCloseDelegate)
	EventDispatcher.AddEventListener(EventID.BingoUpdateRecordSuccess, self.onUpdateRecordSuccessDelegate)
end

function ActivityNewDollBingoHistoryUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	EventDispatcher.RemoveEventListener(EventID.BingoUpdateRecordSuccess, self.onUpdateRecordSuccessDelegate)
end

function ActivityNewDollBingoHistoryUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function ActivityNewDollBingoHistoryUI:OnRenderCell(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local recordCell = self.cellPool[insID]

	if recordCell == nil then
		recordCell = BingoRecordCell.New(cell.gameObject)
		self.cellPool[insID] = recordCell
	end

	recordCell:Refresh(self.listDatum[luaIndex])

	if #self.listDatum >= DollBingoModule.PER_REQ_RECORD_NUM and luaIndex >= #self.listDatum - 5 then
		DollBingoModule.ReqRecord(self.eventID, luaIndex)
	end
end

function ActivityNewDollBingoHistoryUI:OnUpdateRecordSuccess()
	self:RefreshList()
end

function ActivityNewDollBingoHistoryUI:RefreshList()
	self.listDatum = DollBingoModule.recordDatum

	if self.hasInit then
		if self.list.dataCount ~= #self.listDatum then
			self.list:RenderCellsDynamic(#self.listDatum)
		end
	else
		self.list:Refresh(#self.listDatum)

		self.hasInit = true
	end

	self.goSignEmpty:SetActive(#self.listDatum == 0)
end

return ActivityNewDollBingoHistoryUI
