-- chunkname: @IQIGame\\UI\\MonsterAcademySelectPanelUI.lua

local MonsterAcademySelectPanelUI = {
	dialogTime = 0,
	functionOptionDic = {}
}

MonsterAcademySelectPanelUI = Base:Extend("MonsterAcademySelectPanelUI", "IQIGame.Onigao.UI.MonsterAcademySelectPanelUI", MonsterAcademySelectPanelUI)

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterAcademyPlayerHeadView = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyPlayerHeadView")
local FunctionOptionCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.FunctionOptionCell")

function MonsterAcademySelectPanelUI:OnInit()
	UGUIUtil.SetTextInChildren(self.CloseBtn, MonsterAcademySelectPanelUIApi:GetString("CloseBtnLabel"))

	function self.delegateCloseBtn()
		self:OnCloseBtn()
	end

	function self.DelegateUpdateScheduleEvent()
		self:OnUpdateScheduleEvent()
	end

	function self.DelegateUpdateBaseEvent()
		self:OnUpdateBaseEvent()
	end

	function self.DelegateUpdateAreaEvent()
		self:OnUpdateAreaEvent()
	end

	function self.DelegateUpdateSelectPanelUIEvent(areaID)
		self:OnUpdateSelectPanelUIEvent(areaID)
	end

	self.playerHeadView = MonsterAcademyPlayerHeadView.New(self.PlayerInformation)

	self.FunctionOption:SetActive(false)

	self.functionOptionPool = UIObjectPool.New(5, function()
		local functionOptionCell = FunctionOptionCell.New(UnityEngine.Object.Instantiate(self.FunctionOption))

		return functionOptionCell
	end, function(cell)
		cell:Dispose()
	end)
end

function MonsterAcademySelectPanelUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademySelectPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademySelectPanelUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademySelectPanelUI:GetBGM(userData)
	local areaCid = userData.AreaCid
	local areaData = MonsterAcademyModule.GetMonsterAcademyAreaData(areaCid)

	if areaData and areaData.cfgInfo.BGM > 0 then
		return areaData.cfgInfo.BGM
	end
end

function MonsterAcademySelectPanelUI:OnOpen(userData)
	self.areaCid = userData.AreaCid

	self:UpdateView()
	self.Root:SetActive(false)
	self.Outer:SetActive(false)
	self.Point:SetActive(true)

	self.timer = Timer.New(function()
		self.Root:SetActive(true)
		self.Outer:SetActive(true)
		self.Point:SetActive(false)
	end, 1)

	self.timer:Start()
end

function MonsterAcademySelectPanelUI:OnClose(userData)
	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil
end

function MonsterAcademySelectPanelUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateCloseBtn)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateScheduleEvent, self.DelegateUpdateScheduleEvent)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateBaseEvent, self.DelegateUpdateBaseEvent)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateAreaEvent, self.DelegateUpdateAreaEvent)
	EventDispatcher.AddEventListener(EventID.UpdateSelectPanelUI, self.DelegateUpdateSelectPanelUIEvent)
end

function MonsterAcademySelectPanelUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateScheduleEvent, self.DelegateUpdateScheduleEvent)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateBaseEvent, self.DelegateUpdateBaseEvent)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateAreaEvent, self.DelegateUpdateAreaEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateSelectPanelUI, self.DelegateUpdateSelectPanelUIEvent)
end

function MonsterAcademySelectPanelUI:OnPause()
	return
end

function MonsterAcademySelectPanelUI:OnResume()
	return
end

function MonsterAcademySelectPanelUI:OnCover()
	return
end

function MonsterAcademySelectPanelUI:OnReveal()
	return
end

function MonsterAcademySelectPanelUI:OnRefocus(userData)
	return
end

function MonsterAcademySelectPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if UIModule.HasUI(Constant.UIControllerName.DialogUI) then
		self.dialogTime = PlayerModule.GetServerTime()
	end
end

function MonsterAcademySelectPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademySelectPanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademySelectPanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademySelectPanelUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.playerHeadView:Dispose()

	for i, v in pairs(self.functionOptionDic) do
		self.functionOptionPool:Release(v)
	end

	self.functionOptionDic = {}

	self.functionOptionPool:Dispose()
end

function MonsterAcademySelectPanelUI:OnUpdateScheduleEvent()
	self:UpdateView()
end

function MonsterAcademySelectPanelUI:OnUpdateBaseEvent()
	self:ChangeBG()
end

function MonsterAcademySelectPanelUI:OnUpdateAreaEvent()
	self:UpdateView()
end

function MonsterAcademySelectPanelUI:OnUpdateSelectPanelUIEvent(areaID)
	self.areaCid = tonumber(areaID)

	self:UpdateView()
end

function MonsterAcademySelectPanelUI:UpdateView()
	self.playerHeadView:UpdateView()

	local areaData = MonsterAcademyModule.GetMonsterAcademyAreaData(self.areaCid)

	for i, v in pairs(self.functionOptionDic) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.functionOptionPool:Release(v)
	end

	self.functionOptionDic = {}

	if areaData then
		for k, v in pairs(areaData.areaFunDic) do
			local functionOptionCell = self.functionOptionPool:Obtain()

			functionOptionCell.View.transform:SetParent(self.BtnGrid.transform, false)
			functionOptionCell.View:SetActive(true)

			function functionOptionCell.selectCallBack(funCid)
				self:OnSelectOption(funCid)
			end

			functionOptionCell:SetData(v)
			table.insert(self.functionOptionDic, functionOptionCell)
		end

		self:ChangeBG()
	end
end

function MonsterAcademySelectPanelUI:ChangeBG()
	local areaData = MonsterAcademyModule.GetMonsterAcademyAreaData(self.areaCid)

	if areaData then
		local bgPath = areaData.cfgInfo.ImageBg[MonsterAcademyModule.SaveDataDetailPOD.basePOD.dayOfPhase]

		if bgPath then
			local path = UIGlobalApi.GetImagePath(bgPath)

			AssetUtil.LoadAsset(self, path, self.OnLoadHeadSuccess)
		end
	end
end

function MonsterAcademySelectPanelUI:OnLoadHeadSuccess(assetName, asset, duration, userData)
	local imgIcon = self.ImgBG:GetComponent("Image")

	imgIcon.sprite = LuaCodeInterface.ToSprite(asset)
end

function MonsterAcademySelectPanelUI:OnSelectOption(funCid)
	if PlayerModule.GetServerTime() - self.dialogTime < 1 then
		return
	end

	MonsterAcademyModule.ExecutionAreaFunctionOption(funCid, self.areaCid)
end

function MonsterAcademySelectPanelUI:OnCloseBtn()
	UIModule.Close(Constant.UIControllerName.MonsterAcademySelectPanelUI)
end

return MonsterAcademySelectPanelUI
