-- chunkname: @IQIGame\\UI\\HomeLandChangeThemeRoomUI.lua

local HomeLandChangeThemeRoomUI = Base:Extend("HomeLandChangeThemeRoomUI", "IQIGame.Onigao.UI.HomeLandChangeThemeRoomUI", {
	suitTab = {}
})
local HomeLandSuitMould = require("IQIGame.UI.HomeLand.HomeLandSuitMould")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

function HomeLandChangeThemeRoomUI:OnInit()
	UGUIUtil.SetText(self.TextName, HomeLandChangeThemeRoomUIApi:GetString("TextName", false))
	UGUIUtil.SetText(self.TextNameEng, HomeLandChangeThemeRoomUIApi:GetString("TextName", true))
	UGUIUtil.SetText(self.TextDes, HomeLandChangeThemeRoomUIApi:GetString("TextDes", true))

	self.btnBackComponent = self.BtnClose:GetComponent("Button")

	function self.delegateOnBtnBack()
		self:OnClickBackBtn()
	end

	function self.delegateChangeThemeEvent(roomCid)
		self:OnChangeTheme(roomCid)
	end

	function self.delegateUnlockThemeEvent()
		self:OnUnlockTheme()
	end

	self.suitCellPool = UIObjectPool.New(4, function()
		return HomeLandSuitMould.__New(UnityEngine.Object.Instantiate(self.SuitMould), self.UIController:GetPreloadedAsset(UIGlobalApi.GetItemCellAssetPath()))
	end, function(cell)
		cell:Dispose()
	end)
end

function HomeLandChangeThemeRoomUI:GetPreloadAssetPaths()
	return {
		UIGlobalApi.GetItemCellAssetPath()
	}
end

function HomeLandChangeThemeRoomUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandChangeThemeRoomUI:OnOpen(userData)
	self.roomPOD = userData

	if self.roomPOD then
		self:UpDateView()
	end
end

function HomeLandChangeThemeRoomUI:OnClose(userData)
	return
end

function HomeLandChangeThemeRoomUI:OnAddListeners()
	self.btnBackComponent.onClick:AddListener(self.delegateOnBtnBack)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.delegateOnBtnBack)
	EventDispatcher.AddEventListener(EventID.HomelandChangeThemeEvent, self.delegateChangeThemeEvent)
	EventDispatcher.AddEventListener(EventID.HomelandUnlockThemeEvent, self.delegateUnlockThemeEvent)
end

function HomeLandChangeThemeRoomUI:OnRemoveListeners()
	self.btnBackComponent.onClick:RemoveListener(self.delegateOnBtnBack)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateOnBtnBack)
	EventDispatcher.RemoveEventListener(EventID.HomelandChangeThemeEvent, self.delegateChangeThemeEvent)
	EventDispatcher.RemoveEventListener(EventID.HomelandUnlockThemeEvent, self.delegateUnlockThemeEvent)
end

function HomeLandChangeThemeRoomUI:OnPause()
	return
end

function HomeLandChangeThemeRoomUI:OnResume()
	return
end

function HomeLandChangeThemeRoomUI:OnCover()
	return
end

function HomeLandChangeThemeRoomUI:OnReveal()
	return
end

function HomeLandChangeThemeRoomUI:OnRefocus(userData)
	return
end

function HomeLandChangeThemeRoomUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandChangeThemeRoomUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandChangeThemeRoomUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandChangeThemeRoomUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandChangeThemeRoomUI:OnDestroy()
	for i, v in pairs(self.suitTab) do
		self.suitCellPool:Release(v)
	end

	self.suitTab = {}

	self.suitCellPool:Dispose()
end

function HomeLandChangeThemeRoomUI:OnClickBackBtn()
	UIModule.Close(Constant.UIControllerName.HomeLandChangeThemeRoomUI)
end

function HomeLandChangeThemeRoomUI:OnChangeTheme(roomCid)
	if self.roomPOD.cid == roomCid then
		self.roomPOD = HomeLandLuaModule.GetRoomDataByID(roomCid)

		self:UpdateState()
	end
end

function HomeLandChangeThemeRoomUI:OnUnlockTheme()
	if self.roomPOD then
		self.roomPOD = HomeLandLuaModule.GetRoomDataByID(self.roomPOD.cid)

		self:UpdateState()
	end
end

function HomeLandChangeThemeRoomUI:UpdateState()
	local cfgRoom = CfgHomeLandRoomTable[self.roomPOD.cid]

	for i, cell in pairs(self.suitTab) do
		local isCurrent = self.roomPOD.suitCid == cell.cfgSuitID
		local isLock = cfgRoom.DefaultSuit == cell.cfgSuitID or table.indexOf(HomeLandLuaModule.unlockSuit, cell.cfgSuitID) ~= -1

		cell:UpdateState(cell.cfgSuitID, isCurrent, isLock)
	end
end

function HomeLandChangeThemeRoomUI:UpDateView()
	for i, v in pairs(self.suitTab) do
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
		self.suitCellPool:Release(v)
	end

	self.suitTab = {}

	local cfgRoom = CfgHomeLandRoomTable[self.roomPOD.cid]

	for i, v in pairs(cfgRoom.OtherSuit) do
		local isCurrent = self.roomPOD.suitCid == v
		local isLock = cfgRoom.DefaultSuit == v or table.indexOf(HomeLandLuaModule.unlockSuit, v) ~= -1
		local homeSuitCell = self.suitCellPool:Obtain()

		homeSuitCell.View:SetActive(true)
		homeSuitCell.View.transform:SetParent(self.SuitContent.transform, false)
		homeSuitCell:SetData(self.roomPOD.cid, v, isCurrent, isLock)
		table.insert(self.suitTab, homeSuitCell)
	end
end

return HomeLandChangeThemeRoomUI
