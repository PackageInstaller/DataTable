-- chunkname: @IQIGame\\UI\\LibraryEventUI.lua

local LibraryEventUI = Base:Extend("LibraryEventUI", "IQIGame.Onigao.UI.LibraryEventUI", {
	sortingOrder = 0,
	EntityId = 0,
	entityIds = {}
})
local LibraryEventElementCell = require("IQIGame.UI.Library.LibraryEventElementCell")

function LibraryEventUI:OnInit()
	UGUIUtil.SetText(self.PanelTitle, LibraryMazeUIApi:GetString("TextBtnEvent"))
	UGUIUtil.SetText(self.LockTitle1, LibraryMazeUIApi:GetString("LockTitle1"))
	UGUIUtil.SetText(self.LockTitle2, LibraryMazeUIApi:GetString("LockTitle2"))
	UGUIUtil.SetText(self.NormalTitle2, LibraryMazeUIApi:GetString("LockTitle2"))
	UGUIUtil.SetText(self.LockDes, LibraryMazeUIApi:GetString("LockDes"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	self.scrollEvent = self.EventScrollArea:GetComponent("ScrollAreaList")

	function self.scrollEvent.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.scrollEvent.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end
end

function LibraryEventUI:GetPreloadAssetPaths()
	return nil
end

function LibraryEventUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LibraryEventUI:IsManualShowOnOpen(userData)
	return false
end

function LibraryEventUI:GetBGM(userData)
	return nil
end

function LibraryEventUI:OnOpen(userData)
	self.selectResData = nil
	self.selectObj = nil

	self:UpDateView()
end

function LibraryEventUI:OnClose(userData)
	self:HideEntity()
end

function LibraryEventUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function LibraryEventUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function LibraryEventUI:OnPause()
	return
end

function LibraryEventUI:OnResume()
	return
end

function LibraryEventUI:OnCover()
	return
end

function LibraryEventUI:OnReveal()
	return
end

function LibraryEventUI:OnRefocus(userData)
	return
end

function LibraryEventUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LibraryEventUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	local canvas = self.UIController:GetComponent("Canvas")

	self.sortingOrder = canvas.sortingOrder + 1
end

function LibraryEventUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibraryEventUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibraryEventUI:OnDestroy()
	LibraryEventElementCell.DisposeIn(self)
end

function LibraryEventUI:UpDateView()
	self.libraryRes = {}

	local alienEventTab = TownLibraryModule.alienEventTab

	for j, eventData in pairs(alienEventTab) do
		for i, cfgRes in pairsCfg(CfgTownAlienEventBookResTable) do
			if cfgRes.TownAlienEventID == eventData.cfgID and cfgRes.AlienType == Constant.LibraryBookType.AlienEventTypeNormal then
				local unLock = eventData:IsUnlockRes(cfgRes.Id)
				local resData = {}

				resData.unLock = unLock
				resData.cfgRes = cfgRes

				table.insert(self.libraryRes, resData)
			end
		end
	end

	table.sort(self.libraryRes, LibraryEventUI.SortAreaEvent)
	self.scrollEvent:Refresh(#self.libraryRes)
	self:ShowRes()
end

function LibraryEventUI:ShowRes()
	if self.selectResData then
		self.Lock:SetActive(not self.selectResData.unLock)
		self.Normal:SetActive(self.selectResData.unLock)
		UGUIUtil.SetText(self.NormalTitle1, self.selectResData.cfgRes.TabName)
		UGUIUtil.SetText(self.NormalDes, self.selectResData.cfgRes.Describe)

		if self.selectResData.unLock then
			self:ShowElement(self.selectResData.cfgRes.EntityID)
		end
	end
end

function LibraryEventUI:ShowElement(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	table.insert(self.entityIds, self.EntityId)
	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.NormalPoint.transform, Vector3.zero)
end

function LibraryEventUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function LibraryEventUI:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = LibraryMazeUIApi:GetString("EventEntityScale")
		self.SpineRenderers = args.Entity.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end

		self:UpdateSpineSortingOrder()
		setGameObjectLayers(args.Entity.gameObject.transform, "UI")
	else
		local pos = table.indexOf(self.entityIds, args.Entity.Id)

		if pos ~= -1 and args.Entity.Id ~= 0 then
			GameEntry.Entity:HideEntity(args.Entity.Id)
			table.remove(self.entityIds, pos)
		end
	end
end

function LibraryEventUI:UpdateSpineSortingOrder()
	if self.SpineRenderers ~= nil then
		for i = 0, self.SpineRenderers.Length - 1 do
			self.SpineRenderers[i].sortingOrder = self.sortingOrder
		end
	end
end

function LibraryEventUI.SortAreaEvent(tb1, tb2)
	local res = false
	local aIsRead = tb1.unLock == true and 1 or 0
	local bIsRead = tb2.unLock == true and 1 or 0
	local id1 = tb1.cfgRes.Id
	local id2 = tb2.cfgRes.Id

	if aIsRead == bIsRead then
		res = id1 < id2
	else
		res = bIsRead < aIsRead
	end

	return res
end

function LibraryEventUI:OnSelectedGridCell(cell)
	local eventData = self.libraryRes[cell.index + 1]

	if self.selectObj then
		self.selectObj:Select(false)
	end

	self.selectObj = LibraryEventElementCell.PackageOrReuseView(self, cell.gameObject)

	self.selectObj:SetData(eventData.cfgRes, eventData.unLock)
	self.selectObj:Select(true)

	self.selectResData = eventData

	self:ShowRes()
end

function LibraryEventUI:OnRenderGridCell(cell)
	local item = cell.gameObject
	local itemCell = LibraryEventElementCell.PackageOrReuseView(self, item)
	local eventData = self.libraryRes[cell.index + 1]

	itemCell:SetData(eventData.cfgRes, eventData.unLock)

	if self.selectResData == nil then
		self.selectResData = eventData
		self.selectObj = itemCell

		itemCell:Select(true)
	elseif self.selectResData.cfgRes.Id == eventData.cfgRes.Id then
		self.selectResData = eventData
		self.selectObj = itemCell

		itemCell:Select(true)
	else
		itemCell:Select(false)
	end
end

function LibraryEventUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.LibraryEventUI)
end

return LibraryEventUI
