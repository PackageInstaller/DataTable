-- chunkname: @IQIGame\\UI\\MonsterAcademySLDataUI.lua

local MonsterAcademySLDataUI = {
	openType = 1,
	archivePosCellPool = {}
}

MonsterAcademySLDataUI = Base:Extend("MonsterAcademySLDataUI", "IQIGame.Onigao.UI.MonsterAcademySLDataUI", MonsterAcademySLDataUI)

require("IQIGame.UIExternalApi.MonsterAcademySLDataUIApi")

local MonsterAcademyArchivePosCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyArchivePosCell")

function MonsterAcademySLDataUI:OnInit()
	self.scrollArea = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollArea.onRenderCell(cell)
		self:OnRenderPosCell(cell)
	end

	function self.scrollArea.onSelectedCell(cell)
		self:OnSelectedPosCell(cell)
	end

	function self.DelegateOnClickBtnHelp()
		self:OnClickBtnHelp()
	end

	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateUpdateSaveDataEvent()
		self:UpdateSaveDataEvent()
	end
end

function MonsterAcademySLDataUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademySLDataUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademySLDataUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademySLDataUI:GetBGM(userData)
	return nil
end

function MonsterAcademySLDataUI:OnOpen(userData)
	self.openType = userData.OpenType

	self:UpdateView()
end

function MonsterAcademySLDataUI:OnClose(userData)
	return
end

function MonsterAcademySLDataUI:OnAddListeners()
	self.BtnHelp:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnHelp)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateSaveDataEvent, self.DelegateUpdateSaveDataEvent)
end

function MonsterAcademySLDataUI:OnRemoveListeners()
	self.BtnHelp:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnHelp)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateSaveDataEvent, self.DelegateUpdateSaveDataEvent)
end

function MonsterAcademySLDataUI:OnPause()
	return
end

function MonsterAcademySLDataUI:OnResume()
	return
end

function MonsterAcademySLDataUI:OnCover()
	return
end

function MonsterAcademySLDataUI:OnReveal()
	return
end

function MonsterAcademySLDataUI:OnRefocus(userData)
	return
end

function MonsterAcademySLDataUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademySLDataUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademySLDataUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademySLDataUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademySLDataUI:OnDestroy()
	return
end

function MonsterAcademySLDataUI:OnClickBtnHelp()
	return
end

function MonsterAcademySLDataUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.MonsterAcademySLDataUI)
end

function MonsterAcademySLDataUI:OnSelect()
	if self.openType == 1 then
		if self.selectArchiveData.saveDataPod.gameOver then
			NoticeModule.ShowNotice(21045049)

			return
		end

		MonsterAcademyModule.LoadGame(self.selectArchiveData.index)
	elseif self.openType == 2 then
		MonsterAcademyModule.SaveGame(self.selectArchiveData.index)
	end
end

function MonsterAcademySLDataUI:UpdateSaveDataEvent()
	self:UpdateView()
end

function MonsterAcademySLDataUI:UpdateView()
	self.archiveDataList = MonsterAcademyModule.archives

	UGUIUtil.SetText(self.TextTitle, MonsterAcademySLDataUIApi:GetString("TextTitle", self.openType))
	UGUIUtil.SetText(self.PanelTitle, MonsterAcademySLDataUIApi:GetString("PanelTitle", self.openType))
	self.scrollArea:Refresh(#self.archiveDataList)
end

function MonsterAcademySLDataUI:OnRenderPosCell(cell)
	local data = self.archiveDataList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.archivePosCellPool[instanceID]

	if renderCell == nil then
		renderCell = MonsterAcademyArchivePosCell.New(cell.gameObject)
		self.archivePosCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data)
	renderCell:SetSelect(false)
end

function MonsterAcademySLDataUI:OnSelectedPosCell(cell)
	self.selectArchiveData = self.archiveDataList[cell.index + 1]

	local noticeID

	if self.openType == 1 then
		if self.selectArchiveData.saveDataPod == nil then
			return
		end

		noticeID = 21045047
	else
		if self.selectArchiveData.index == 8 then
			NoticeModule.ShowNotice(21045059)

			return
		end

		noticeID = 21045046
	end

	NoticeModule.ShowNotice(noticeID, function()
		self:OnSelect()
	end, nil, self)
end

return MonsterAcademySLDataUI
