-- chunkname: @IQIGame\\UI\\WorldAreaUI.lua

local WorldAreaUI = {}

WorldAreaUI = Base:Extend("WorldAreaUI", "IQIGame.Onigao.UI.WorldAreaUI", WorldAreaUI)

local areaItem = require("IQIGame/UI/Map/Area/WorldArea_AreaItem")
local detailPanelClass = require("IQIGame/UI/Map/Area/WorldAreaUI_DetailPop")
local WorldAreaUI_WanFa = require("IQIGame/UI/Map/Area/WorldAreaUI_WanFa")
local WorldAreaUI_RiChang = require("IQIGame/UI/Map/Area/WorldAreaUI_RiChang")
local dataName_Sex = "sex"
local stateName_man = "man"
local stateName_woMan = "woman"
local ToggleItem = {}

function ToggleItem.New(view, callback)
	local obj = Clone(ToggleItem)

	obj:__Init(view, callback)

	return obj
end

function ToggleItem:__Init(view, callback)
	self.gameObject = view
	self.selectCallBack = callback

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.toggleCom = UIEventUtil.AddToggleListener(self, "ToggleGo", self.__OnToggleValueChangeHandler)

	self.lockedRoot.gameObject:SetActive(false)
	self.gameObject:SetActive(true)
end

function ToggleItem:__OnToggleValueChangeHandler(isOn)
	if self.isLock then
		return
	end

	self.selectedRoot.gameObject:SetActive(isOn)
	self.normalRoot.gameObject:SetActive(not isOn)
	self.lockedRoot.gameObject:SetActive(false)

	if not isOn then
		return
	end

	if self.selectCallBack == nil then
		return
	end

	self.selectCallBack()
end

function ToggleItem:Select()
	if self.isLock then
		return
	end

	self.toggleCom.isOn = true
end

function ToggleItem:IsSelect()
	return self.toggleCom.isOn
end

function ToggleItem:SetLockedState(isLock)
	self.isLock = isLock

	self.lockedRoot.gameObject:SetActive(isLock)

	if isLock then
		self.selectedRoot.gameObject:SetActive(false)
		self.normalRoot.gameObject:SetActive(false)
	end
end

function ToggleItem:Dispose()
	self.toggleCom = nil

	UIEventUtil.RemoveToggleListener(self, "ToggleGo")
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function WorldAreaUI:OnInit()
	self:__InitToggle()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
end

function WorldAreaUI:__InitToggle()
	self.toggleItems = {}
	self.toggleItems[Constant.WorldAreaUIToggleType.Day] = ToggleItem.New(self.DayToggle, function()
		self:__ForceRefreshToggleView(Constant.WorldAreaUIToggleType.Day)
	end)
	self.toggleItems[Constant.WorldAreaUIToggleType.Trunk] = ToggleItem.New(self.TrunkToggle, function()
		self:__ForceRefreshToggleView(Constant.WorldAreaUIToggleType.Trunk)
	end)
	self.toggleItems[Constant.WorldAreaUIToggleType.Activity] = ToggleItem.New(self.ActivityToggle, function()
		self:__ForceRefreshToggleView(Constant.WorldAreaUIToggleType.Activity)
	end)
end

function WorldAreaUI:InitMembers()
	return
end

function WorldAreaUI:InitComponent()
	self.areaItemList = {}

	local contentTrans = self.content.transform
	local len = LuaUtility.GetChildCount(contentTrans)

	for i = 1, len do
		local trans = LuaUtility.GetChild(contentTrans, i - 1)
		local id = tonumber(trans.gameObject.name)

		if id then
			local item = areaItem.New(trans.gameObject, self)

			item:RefreshByAreaId(id)

			self.areaItemList[id] = item
		end
	end

	self.detailPanel = detailPanelClass.New(self.areaDetailPop, self)

	self.detailPanel:Hide()

	self.returnButton = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	self.returnButton:RegisterReturnEvent(function()
		GameChapterModule.ClearCache()
		UIModule.CloseSelf(self)
	end)

	self.playerAnchor = self.playerTag:GetComponent("RectTransform")
	self.wanFaView = WorldAreaUI_WanFa.New(self.WanFaRoot)
	self.riChangView = WorldAreaUI_RiChang.New(self.RiChangRoot)

	if PlayerModule.GetSex() == Constant.PlayerSex.Man then
		LuaUtility.SetStateController(self.playerTag, dataName_Sex, stateName_man)
	elseif PlayerModule.GetSex() == Constant.PlayerSex.WoMen then
		LuaUtility.SetStateController(self.playerTag, dataName_Sex, stateName_woMan)
	end
end

function WorldAreaUI:InitDelegate()
	return
end

function WorldAreaUI:OnAddListeners()
	return
end

function WorldAreaUI:OnRemoveListeners()
	return
end

function WorldAreaUI:OnOpen(userData)
	self:__CheckToggleOpen()

	local toggleType = Constant.WorldAreaUIToggleType.Trunk

	if userData ~= nil and userData.ToggleType ~= nil then
		toggleType = userData.ToggleType
	end

	local toggleItem = self.toggleItems[toggleType]

	if toggleItem == nil then
		logError("WorldAreaUI 页签选项错误,userdata错误的ToggleType参数:{0}", toggleType)

		return
	end

	if toggleItem:IsSelect() then
		self:__ForceRefreshToggleView(toggleType)
	else
		toggleItem:Select()
	end

	WorldMapModule.DebugFinishedAction()
end

function WorldAreaUI:OnClose(userData)
	return
end

function WorldAreaUI:GetPreloadAssetPaths()
	return nil
end

function WorldAreaUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function WorldAreaUI:IsManualShowOnOpen(userData)
	return false
end

function WorldAreaUI:GetBGM(userData)
	return nil
end

function WorldAreaUI:OnPause()
	return
end

function WorldAreaUI:OnResume()
	return
end

function WorldAreaUI:OnCover()
	return
end

function WorldAreaUI:OnReveal()
	return
end

function WorldAreaUI:OnRefocus(userData)
	return
end

function WorldAreaUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function WorldAreaUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function WorldAreaUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function WorldAreaUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function WorldAreaUI:Refresh()
	for _, v in pairs(self.areaItemList) do
		v:Refresh()
		v:LogInfo()
	end

	self:ResetPlayerPos()
end

function WorldAreaUI:ResetPlayerPos()
	local currentRoom = WorldMapModule.GetCurrentHomeData()

	if not currentRoom then
		return
	end

	local playerRoomId = currentRoom.cid

	for _, v in pairs(self.areaItemList) do
		local areaData = WorldMapModule.GetAreaDataWithID(v.areaId)

		if areaData:GetRoomDataWithID(playerRoomId) then
			LuaUtility.SetAnchoredPositionWithRectTransform(self.playerAnchor, v.anchorPos.x, v.anchorPos.y + 60)
		end
	end
end

function WorldAreaUI:ShowDetailPop(anchorPosX, anchorPosY, areaId)
	self.detailPanel:Show()
	self.detailPanel:Refresh(anchorPosX, anchorPosY, areaId)
end

function WorldAreaUI:OnDestroy()
	for i, v in pairs(self.areaItemList) do
		v:OnDestroy()

		self.areaItemList[i] = nil
	end

	self.areaItemList = {}

	self.detailPanel:OnDestroy()
	self.returnButton:Dispose()
	ForPairs(self.toggleItems, function(_, _item)
		_item:Dispose()
	end)
	self.wanFaView:Dispose()
	self.riChangView:Dispose()
	AssetUtil.UnloadAsset(self)
end

function WorldAreaUI:__ForceRefreshToggleView(toggleType)
	GameChapterModule.ToggleType = toggleType

	if toggleType == Constant.WorldAreaUIToggleType.Day then
		self:__OnShowDayView()
	elseif toggleType == Constant.WorldAreaUIToggleType.Trunk then
		self:__OnShowTrunkView()
	elseif toggleType == Constant.WorldAreaUIToggleType.Activity then
		self:__OnShowActivityView()
	else
		self:__OnShowTrunkView()
	end
end

function WorldAreaUI:__OnShowDayView()
	self.riChangView:Show()
	self.wanFaView:Hide()
end

function WorldAreaUI:__OnShowTrunkView()
	self.detailPanel:Hide()
	self.wanFaView:Hide()
	self.riChangView:Hide()
	self:Refresh()
end

function WorldAreaUI:__OnShowActivityView()
	self.wanFaView:Show()
	self.riChangView:Hide()
end

function WorldAreaUI:__CheckToggleOpen()
	ForPairs(self.toggleItems, function(_toggleType, _toggleItem)
		local isLocked = false

		if _toggleType == Constant.WorldAreaUIToggleType.Activity then
			local conditionList = OtherExtendApi:GetWorldAreaUIWanFaToggleOpenConditionList()
			local isUnLock = ConditionModule.CheckMultipleCondition(conditionList)

			isLocked = not isUnLock
		end

		_toggleItem:SetLockedState(isLocked)
	end)
end

return WorldAreaUI
