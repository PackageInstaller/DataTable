-- chunkname: @IQIGame\\UI\\RandomSecretaryUI.lua

local RandomSecretaryUI = {
	randomSecretaryData = {},
	randomSecretaryCellPool = {}
}

RandomSecretaryUI = Base:Extend("RandomSecretaryUI", "IQIGame.Onigao.UI.RandomSecretaryUI", RandomSecretaryUI)

require("IQIGame.UIExternalApi.RandomSecretaryUIApi")

local RandomSecretaryCell = require("IQIGame.UI.Girl.RandomSecretary.RandomSecretaryCell")

function RandomSecretaryUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.DelegateBtnScreen()
		self:OnBtnScreen()
	end

	function self.DelegateUpdateGirlBGEvent(cid)
		self:OnUpdateGirlBG(cid)
	end

	function self.DelegateUpdatePeriodOfTime()
		self:UpdatePeriodOfTime()
	end

	function self.DelegateOnTogSecretaryValueChanged(isOn)
		self:OnTogSecretaryValueChanged(isOn)
	end

	function self.DelegateOnTogLive2D(isOn)
		self:OnTogLive2D(isOn)
	end

	function self.DelegateOnTogSpine(isOn)
		self:OnTogSpine(isOn)
	end

	function self.DelegateOnTogOath(isOn)
		self:OnTogOath(isOn)
	end

	function self.DelegateRefreshSelectSoul()
		self:OnUpdateRefreshSelectSoul()
	end

	function self.DelegateOnBtnTip()
		self:OnBtnTip()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderCell(cell)
	end
	self.ScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectedCell(cell)
	end
end

function RandomSecretaryUI:GetPreloadAssetPaths()
	return nil
end

function RandomSecretaryUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RandomSecretaryUI:IsManualShowOnOpen(userData)
	return false
end

function RandomSecretaryUI:GetBGM(userData)
	return nil
end

function RandomSecretaryUI:OnOpen(userData)
	self:UpdateView()
	self:LoadGirlBG(GirlBackGroundModule.currentUseBG)
end

function RandomSecretaryUI:OnClose(userData)
	RandomSecretaryModule.selectSouls = {}
	RandomSecretaryModule.selectTypes = {}
end

function RandomSecretaryUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
	self.BtnScreen:GetComponent("Button").onClick:AddListener(self.DelegateBtnScreen)
	self.TogSecretary:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnTogSecretaryValueChanged)
	self.TogLive2D:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnTogLive2D)
	self.TogSpine:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnTogSpine)
	self.TogOath:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateOnTogOath)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnTip)
	EventDispatcher.AddEventListener(EventID.UpdatePeriodOfTime, self.DelegateUpdatePeriodOfTime)
	EventDispatcher.AddEventListener(EventID.UpdateGirlBackgroundEvent, self.DelegateUpdateGirlBGEvent)
	EventDispatcher.AddEventListener(EventID.RefreshRandomSecretarySelectSoul, self.DelegateRefreshSelectSoul)
end

function RandomSecretaryUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
	self.BtnScreen:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnScreen)
	self.TogSecretary:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnTogSecretaryValueChanged)
	self.TogLive2D:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnTogLive2D)
	self.TogSpine:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnTogSpine)
	self.TogOath:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnTogOath)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnTip)
	EventDispatcher.RemoveEventListener(EventID.UpdatePeriodOfTime, self.DelegateUpdatePeriodOfTime)
	EventDispatcher.RemoveEventListener(EventID.UpdateGirlBackgroundEvent, self.DelegateUpdateGirlBGEvent)
	EventDispatcher.RemoveEventListener(EventID.RefreshRandomSecretarySelectSoul, self.DelegateRefreshSelectSoul)
end

function RandomSecretaryUI:OnPause()
	return
end

function RandomSecretaryUI:OnResume()
	return
end

function RandomSecretaryUI:OnCover()
	return
end

function RandomSecretaryUI:OnReveal()
	return
end

function RandomSecretaryUI:OnRefocus(userData)
	return
end

function RandomSecretaryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RandomSecretaryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RandomSecretaryUI:OnLoadSucceed(assetName, asset, duration, userData)
	local type = userData.type
	local bgCid = userData.bgCid

	if type == "LoadBG" then
		self.showBGCid = bgCid

		for i = 0, self.BGRoot.transform.childCount - 1 do
			local obj = self.BGRoot.transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		local bgObj = UnityEngine.Object.Instantiate(asset)

		bgObj.transform:SetParent(self.BGRoot.transform, false)

		local sortComponents = bgObj:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder))
		local canvas = self.UIController:GetComponent("Canvas")

		for i = 0, sortComponents.Length - 1 do
			sortComponents[i].UIRootCanvas = canvas
		end
	end
end

function RandomSecretaryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RandomSecretaryUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.randomSecretaryCellPool) do
		v:Dispose()
	end
end

function RandomSecretaryUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function RandomSecretaryUI:OnBtnScreen()
	UIModule.Open(Constant.UIControllerName.RandomSecretaryScreenUI, Constant.UILayer.UI)
end

function RandomSecretaryUI:OnTogSecretaryValueChanged(isOn)
	local value = isOn and 1 or 0

	if PlayerModule.PlayerInfo.dressUpRotateSwitch ~= value then
		RandomSecretaryModule.DressUpRotateSwitch(value)
	end
end

function RandomSecretaryUI:OnTogLive2D(isOn)
	if isOn then
		RandomSecretaryModule.AddSelectType(Constant.GirlOnDutyShowType.ShowType_LIVE2D)
	else
		RandomSecretaryModule.RemoveSelectType(Constant.GirlOnDutyShowType.ShowType_LIVE2D)
	end
end

function RandomSecretaryUI:OnTogSpine(isOn)
	if isOn then
		RandomSecretaryModule.AddSelectType(Constant.GirlOnDutyShowType.ShowType_Spine)
	else
		RandomSecretaryModule.RemoveSelectType(Constant.GirlOnDutyShowType.ShowType_Spine)
	end
end

function RandomSecretaryUI:OnTogOath(isOn)
	if isOn then
		RandomSecretaryModule.AddSelectType(Constant.GirlOnDutyShowType.ShowType_Oath)
	else
		RandomSecretaryModule.RemoveSelectType(Constant.GirlOnDutyShowType.ShowType_Oath)
	end
end

function RandomSecretaryUI:OnUpdateRefreshSelectSoul()
	self:UpdateView()
end

function RandomSecretaryUI:UpdateView()
	local isOpen = false

	if PlayerModule.PlayerInfo.dressUpRotateSwitch then
		isOpen = PlayerModule.PlayerInfo.dressUpRotateSwitch > 0
	end

	self.TogSecretary:GetComponent("Toggle").isOn = isOpen
	self.TogLive2D:GetComponent("Toggle").isOn = RandomSecretaryModule.CheckToggleIsSelect(Constant.GirlOnDutyShowType.ShowType_LIVE2D)
	self.TogSpine:GetComponent("Toggle").isOn = RandomSecretaryModule.CheckToggleIsSelect(Constant.GirlOnDutyShowType.ShowType_Spine)
	self.TogOath:GetComponent("Toggle").isOn = RandomSecretaryModule.CheckToggleIsSelect(Constant.GirlOnDutyShowType.ShowType_Oath)

	local len = 0

	if PlayerModule.PlayerInfo.dressUpRotateList then
		len = #PlayerModule.PlayerInfo.dressUpRotateList
	end

	UGUIUtil.SetText(self.TextSelect, RandomSecretaryUIApi:GetString("TextSelect", len))
	self:RefreshList()
	self.StateAll:SetActive(#RandomSecretaryModule.selectSouls == 0)
	self.StateScreen:SetActive(#RandomSecretaryModule.selectSouls > 0)
end

function RandomSecretaryUI:RefreshList()
	self.randomSecretaryData = RandomSecretaryModule.GetRandomSecretaryData(RandomSecretaryModule.selectSouls, RandomSecretaryModule.selectTypes)

	table.sort(self.randomSecretaryData, function(a, b)
		local aSelect = a.isSelect and 1 or 0
		local bSelect = b.isSelect and 1 or 0

		if aSelect == bSelect then
			return a:GetCfgData().Sort < b:GetCfgData().Sort
		end

		return bSelect < aSelect
	end)
	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.randomSecretaryData)
	self.Null:SetActive(#self.randomSecretaryData == 0)
end

function RandomSecretaryUI:OnRenderCell(cell)
	local data = self.randomSecretaryData[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.randomSecretaryCellPool[instanceID]

	if renderCell == nil then
		renderCell = RandomSecretaryCell.New(cell.gameObject)
		self.randomSecretaryCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data)
end

function RandomSecretaryUI:OnSelectedCell(cell)
	local data = self.randomSecretaryData[cell.index + 1]

	data.isSelect = not data.isSelect
	RandomSecretaryModule.allRandomSecretaryData[data.cid] = data

	self.randomSecretaryCellPool[cell.gameObject:GetInstanceID()]:SetSelect(data.isSelect)
	RandomSecretaryModule.RefreshRandomList()

	local len = 0

	if PlayerModule.PlayerInfo.dressUpRotateList then
		len = #PlayerModule.PlayerInfo.dressUpRotateList
	end

	UGUIUtil.SetText(self.TextSelect, RandomSecretaryUIApi:GetString("TextSelect", len))
end

function RandomSecretaryUI:UpdatePeriodOfTime()
	self:LoadGirlBG(GirlBackGroundModule.currentUseBG)
end

function RandomSecretaryUI:OnUpdateGirlBG(cid)
	self:LoadGirlBG(cid)
end

function RandomSecretaryUI:LoadGirlBG(cid)
	if self.showBGCid == cid then
		return
	end

	local path, bgm, environmentalSound = GirlBackGroundModule.GetBackGroundPath(cid)

	AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, self.OnLoadFailed, {
		type = "LoadBG",
		bgCid = cid
	})
end

function RandomSecretaryUI:OnBtnTip()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 3100)
end

return RandomSecretaryUI
