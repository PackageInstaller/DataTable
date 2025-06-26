-- chunkname: @IQIGame\\UI\\IllusionMazeElementCollectionUI.lua

local IllusionMazeElementCollectionUI = Base:Extend("IllusionMazeElementCollectionUI", "IQIGame.Onigao.UI.IllusionMazeElementCollectionUI", {
	EntityId = 0,
	ElementCells = {}
})
local LibraryEventElementCell = require("IQIGame.UI.Library.LibraryEventElementCell")

function IllusionMazeElementCollectionUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateOnShowElementEntityFailure(sender, args)
		self:OnShowElementEntityFailure(sender, args)
	end

	local scrollAreaList = self.ElementGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectedCell(cell)
	end

	UGUIUtil.SetText(self.TitleText, IllusionMazeElementCollectionUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.LockNameText, IllusionMazeElementCollectionUIApi:GetString("LockNameText"))
	UGUIUtil.SetText(self.LockInfoPanelTitle, IllusionMazeElementCollectionUIApi:GetString("InfoPanelTitle"))
	UGUIUtil.SetText(self.InfoPanelTitle, IllusionMazeElementCollectionUIApi:GetString("InfoPanelTitle"))
	UGUIUtil.SetText(self.LockDescText, IllusionMazeElementCollectionUIApi:GetString("LockDescText"))
	self.BlockView:SetActive(false)
end

function IllusionMazeElementCollectionUI:GetPreloadAssetPaths()
	return nil
end

function IllusionMazeElementCollectionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function IllusionMazeElementCollectionUI:IsManualShowOnOpen(userData)
	return false
end

function IllusionMazeElementCollectionUI:GetBGM(userData)
	return nil
end

function IllusionMazeElementCollectionUI:OnOpen(userData)
	self:UpdateView()
end

function IllusionMazeElementCollectionUI:OnClose(userData)
	self:HideEntity()
	self:BlockInput(false)
end

function IllusionMazeElementCollectionUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
end

function IllusionMazeElementCollectionUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntityFailureEventArgs.EventId, self.DelegateOnShowElementEntityFailure)
end

function IllusionMazeElementCollectionUI:OnPause()
	return
end

function IllusionMazeElementCollectionUI:OnResume()
	return
end

function IllusionMazeElementCollectionUI:OnCover()
	return
end

function IllusionMazeElementCollectionUI:OnReveal()
	return
end

function IllusionMazeElementCollectionUI:OnRefocus(userData)
	return
end

function IllusionMazeElementCollectionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function IllusionMazeElementCollectionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function IllusionMazeElementCollectionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function IllusionMazeElementCollectionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function IllusionMazeElementCollectionUI:OnDestroy()
	for i = 1, #self.ElementCells do
		local cell = self.ElementCells[i]

		cell:Dispose()
	end
end

function IllusionMazeElementCollectionUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function IllusionMazeElementCollectionUI:UpdateView()
	self.ElementDataList = {}

	for id, cfgTownAlienEventBookResData in pairsCfg(CfgTownAlienEventBookResTable) do
		if cfgTownAlienEventBookResData.AlienType == Constant.LibraryBookType.AlienEventTypeIllusionMaze then
			local isUnlock = TownLibraryModule.LibraryPOD.alienEvent[id] ~= nil

			table.insert(self.ElementDataList, {
				cfg = cfgTownAlienEventBookResData,
				isUnlock = isUnlock
			})
		end
	end

	local scrollAreaList = self.ElementGrid:GetComponent("ScrollAreaList")

	scrollAreaList:Refresh(#self.ElementDataList)
	self:RefreshElementInfo()
end

function IllusionMazeElementCollectionUI:OnRenderCell(cell)
	local elementCell = self.ElementCells[cell.gameObject]

	if elementCell == nil then
		elementCell = LibraryEventElementCell.New(cell.gameObject)
		self.ElementCells[cell.gameObject] = elementCell
	end

	local data = self.ElementDataList[cell.index + 1]

	elementCell:SetData(data.cfg, data.isUnlock)
end

function IllusionMazeElementCollectionUI:OnSelectedCell(cell)
	local data = self.ElementDataList[cell.index + 1]

	self:RefreshElementInfo(data.cfg, data.isUnlock)
end

function IllusionMazeElementCollectionUI:RefreshElementInfo(cfgTownAlienEventBookResData, isUnlock)
	self:HideEntity()
	self.Lock:SetActive(not isUnlock)
	self.Normal:SetActive(isUnlock)

	if cfgTownAlienEventBookResData ~= nil then
		UGUIUtil.SetText(self.NameText, cfgTownAlienEventBookResData.TabName)
		UGUIUtil.SetText(self.DescText, cfgTownAlienEventBookResData.Describe)

		if isUnlock then
			self:ShowElement(cfgTownAlienEventBookResData.EntityID)
		end
	end
end

function IllusionMazeElementCollectionUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function IllusionMazeElementCollectionUI:ShowElement(elementEntityCid)
	self:BlockInput(true)

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.NormalPoint.transform, Vector3.zero)
end

function IllusionMazeElementCollectionUI:OnShowElementEntitySuccess(sender, args)
	if args.Entity.Id == self.EntityId then
		setGameObjectLayers(args.Entity.transform, "UI")

		args.Entity.transform.localScale = LibraryMazeUIApi:GetString("EventEntityScale")

		local animation = args.Entity:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end

		local canvas = self.UIController:GetComponent("Canvas")

		args.Entity:GetComponentInChildren(typeof(UnityEngine.Renderer)).sortingOrder = canvas.sortingOrder + 1

		self:BlockInput(false)
	end
end

function IllusionMazeElementCollectionUI:OnShowElementEntityFailure(sender, args)
	if args.EntityId == self.EntityId then
		self:BlockInput(false)
	end
end

function IllusionMazeElementCollectionUI:BlockInput(value)
	self.BlockView:SetActive(value)
end

return IllusionMazeElementCollectionUI
