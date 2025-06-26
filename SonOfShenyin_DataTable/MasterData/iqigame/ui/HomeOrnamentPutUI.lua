-- chunkname: @IQIGame\\UI\\HomeOrnamentPutUI.lua

local OrnamentItem = {}

function OrnamentItem.New(view)
	local obj = Clone(OrnamentItem)

	obj:__Init(view)

	return obj
end

function OrnamentItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.dragButton = self.gameObject:GetComponent("IQIGame.Onigao.Game.UIScrollAreaDragButton")
end

function OrnamentItem:Show()
	self.gameObject:SetActive(true)
end

function OrnamentItem:Hide()
	self.gameObject:SetActive(false)
end

function OrnamentItem:Dispose()
	self:__ReleaseDragButton()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function OrnamentItem:__ReleaseDragButton()
	self.dragButton = self.gameObject:GetComponent("IQIGame.Onigao.Game.UIScrollAreaDragButton")
	self.dragButton.onBeginDrag = nil
	self.dragButton.onDrag = nil
	self.dragButton.onEndDrag = nil

	self.dragButton.onClick:RemoveAllListeners()

	self.dragButton = nil
end

local HomeOrnamentPutUI = {
	ornamentDataList = {},
	ornamentCellTable = {},
	cacheOrnamentObj = {}
}

HomeOrnamentPutUI = Base:Extend("HomeOrnamentPutUI", "IQIGame.Onigao.UI.HomeOrnamentPutUI", HomeOrnamentPutUI)

function HomeOrnamentPutUI:OnInit()
	self:__InitEventDelegate()
	GameEntry.Input:InitTapGesture()
	GameEntry.Input:InitPanGesture()
	self:__InitOrnamentScrollAreaList()
end

function HomeOrnamentPutUI:GetPreloadAssetPaths()
	return nil
end

function HomeOrnamentPutUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeOrnamentPutUI:IsManualShowOnOpen(userData)
	return false
end

function HomeOrnamentPutUI:GetBGM(userData)
	return nil
end

function HomeOrnamentPutUI:OnOpen(userData)
	return
end

function HomeOrnamentPutUI:OnClose(userData)
	return
end

function HomeOrnamentPutUI:__InitEventDelegate()
	function self.__delegateOnCloseBtnClick()
		HomeModule.ExitOrnamentEditorMode()
	end

	function self.__delegateOnPanGesture(_gesture)
		self:__OnPanGesture(_gesture)
	end
end

function HomeOrnamentPutUI:OnAddListeners()
	self.exitBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCloseBtnClick)

	GameEntry.Input.PanGesture.StateUpdated = GameEntry.Input.PanGesture.StateUpdated + self.__delegateOnPanGesture
end

function HomeOrnamentPutUI:OnRemoveListeners()
	self.exitBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCloseBtnClick)

	GameEntry.Input.PanGesture.StateUpdated = GameEntry.Input.PanGesture.StateUpdated - self.__delegateOnPanGesture
end

function HomeOrnamentPutUI:OnPause()
	return
end

function HomeOrnamentPutUI:OnResume()
	return
end

function HomeOrnamentPutUI:OnCover()
	return
end

function HomeOrnamentPutUI:OnReveal()
	return
end

function HomeOrnamentPutUI:OnRefocus(userData)
	return
end

function HomeOrnamentPutUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeOrnamentPutUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeOrnamentPutUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeOrnamentPutUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeOrnamentPutUI:OnDestroy()
	self:__ReleaseOrnamentScrollAreaList()
end

function HomeOrnamentPutUI:__InitOrnamentScrollAreaList()
	self.ornamentScrollAreaList = self.scrollAreaList:GetComponent("ScrollAreaList")

	function self.ornamentScrollAreaList.onRenderCell(_cell)
		self:__OnRenderOrnamentItemCell(_cell)
	end

	table.insert(self.ornamentDataList, 1)
	table.insert(self.ornamentDataList, 2)
	table.insert(self.ornamentDataList, 3)
	table.insert(self.ornamentDataList, 4)
	table.insert(self.ornamentDataList, 5)
	self.ornamentScrollAreaList:Refresh(#self.ornamentDataList)
end

function HomeOrnamentPutUI:__OnRenderOrnamentItemCell(cell)
	local insID = cell.gameObject:GetInstanceID()
	local itemCell = self.ornamentCellTable[insID]

	if itemCell == nil then
		itemCell = self:__CreateOrnamentItem(cell.gameObject)
		self.ornamentCellTable[insID] = itemCell
	end

	local ornamentData = self.ornamentDataList[cell.index + 1]

	itemCell:Show()
end

function HomeOrnamentPutUI:__CreateOrnamentItem(gameObject)
	local instanceID = gameObject:GetInstanceID()
	local item = OrnamentItem.New(gameObject)

	function item.dragButton.onBeginDrag(eventData)
		self:__OnBeginDrag(instanceID, eventData)
	end

	function item.dragButton.onDrag(eventData)
		self:__OnDrag(instanceID, eventData)
	end

	function item.dragButton.onEndDrag(eventData)
		self:__OnEndDrag(instanceID, eventData)
	end

	function self.__delegateOnClick()
		self:__OnClick(instanceID)
	end

	item.dragButton.onClick:AddListener(self.__delegateOnClick)

	return item
end

function HomeOrnamentPutUI:__ReleaseOrnamentScrollAreaList()
	self.ornamentScrollAreaList.onRenderCell = nil
	self.ornamentScrollAreaList = nil
end

function HomeOrnamentPutUI:__OnBeginDrag(insID, eventData)
	logError("OnBeginDrag------>>{0}", insID)

	self.ornamentCid = 1

	local ornamentObj = self.cacheOrnamentObj[self.ornamentCid]

	if ornamentObj ~= nil then
		ornamentObj.gameObject:SetActive(true)
	else
		self:__LoadOrnament(self.ornamentCid, 1, "Assets/03_Prefabs/Home/Ornament/Ornament_Sofa.prefab")
	end

	self:__RayCastOrnamentGrid()
end

function HomeOrnamentPutUI:__OnDrag(insID, eventData)
	self:__RayCastOrnamentGrid()
end

function HomeOrnamentPutUI:__OnEndDrag(insID, eventData)
	local ornamentObj = self.cacheOrnamentObj[self.ornamentCid]

	if ornamentObj ~= nil then
		ornamentObj.gameObject:SetActive(false)
	end
end

function HomeOrnamentPutUI:__OnClick(insID)
	logError("OnClick------>>{0}", insID)
end

function HomeOrnamentPutUI:__LoadOrnament(ornamentCid, ornamentId, assetPath)
	AssetUtil.LoadAsset(self, assetPath, function(_, _assetUrl, _asset, _duration, _userData)
		self:__OnOrnamentLoadSuccess(ornamentCid, ornamentId, _asset)
	end, function(_assetName, _status, _errorMessage, _userData)
		logError("加载家具失败 {0}", assetPath)
	end)
end

function HomeOrnamentPutUI:__OnOrnamentLoadSuccess(ornamentCid, ornamentId, asset)
	local ornamentObj = GameObject.Instantiate(asset)

	ornamentObj.transform:SetParent(self.dragRoot.transform, true)

	ornamentObj.transform.localPosition = Vector3.zero
	self.cacheOrnamentObj[ornamentCid] = ornamentObj

	local active = ornamentCid == self.ornamentCid

	ornamentObj.gameObject:SetActive(active)
end

function HomeOrnamentPutUI:__RayCastOrnamentGrid()
	local transformList = LuaCodeInterface.RaycastAllTransforms(UnityEngine.Camera.main)

	if transformList == nil then
		return
	end

	local gridPutItem

	ForArrayByCount(0, transformList.Count - 1, 1, function(index)
		local trans = transformList[index]

		gridPutItem = trans.gameObject:GetComponent(typeof(IQIGame.Onigao.Game.Home.OrnamentPutGridItem))

		if gridPutItem ~= nil then
			return true
		end
	end)

	if gridPutItem == nil then
		return
	end

	self.dragRoot.transform.position = gridPutItem.transform.position

	local room = HomeModule:GetCurrentHomeRoom()

	room:UpdateOrnamentPoint(self.ornamentCid, gridPutItem.ColIndex, gridPutItem.RowIndex)
end

function HomeOrnamentPutUI:__OnPanGesture(gesture)
	if gesture.State == DigitalRubyShared.GestureRecognizerState.Began then
		-- block empty
	elseif gesture.State == DigitalRubyShared.GestureRecognizerState.Executing then
		-- block empty
	elseif gesture.State == DigitalRubyShared.GestureRecognizerState.Ended then
		-- block empty
	end
end

function HomeOrnamentPutUI:__RayCastOrnament()
	local transformList = LuaCodeInterface.RaycastAllTransforms(UnityEngine.Camera.main)

	if transformList == nil then
		return
	end
end

return HomeOrnamentPutUI
