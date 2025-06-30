-- chunkname: @IQIGame\\UI\\HomeLandOverviewUI.lua

local HomeLandOverviewUI = Base:Extend("HomeLandOverviewUI", "IQIGame.Onigao.UI.HomeLandOverviewUI", {
	overviewRenderPool = {}
})
local functionTab = {
	Constant.HomelandBuildType.BuildGold,
	Constant.HomelandBuildType.BuildManufacture,
	Constant.HomelandBuildType.BuildPlant,
	Constant.HomelandBuildType.BuildCooking,
	Constant.HomelandBuildType.BuildWork,
	Constant.HomelandBuildType.BuildBackGift
}
local HomeLandOverviewRenderCell = require("IQIGame.UI.HomeLandOverview.HomeLandOverviewRenderCell")

function HomeLandOverviewUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, HomeLandOverviewUIApi:GetString("TextTitle"))

	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.btnHelpComponent = self.BtnHelp:GetComponent("Button")
	self.scrollArea = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollArea.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.scrollArea.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnHelp()
		self:OnBtnHelp()
	end

	function self.delegateUpdateHomeLandOverview()
		self:UpdateView()
	end
end

function HomeLandOverviewUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandOverviewUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandOverviewUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandOverviewUI:GetBGM(userData)
	return nil
end

function HomeLandOverviewUI:OnOpen(userData)
	self:UpdateView()
end

function HomeLandOverviewUI:OnClose(userData)
	return
end

function HomeLandOverviewUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateBtnClose)
	EventDispatcher.AddEventListener(EventID.UpdateHomeLandOverview, self.delegateUpdateHomeLandOverview)
	EventDispatcher.AddEventListener(EventID.HomeLandUpdatePlantEvent, self.delegateUpdateHomeLandOverview)
end

function HomeLandOverviewUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateBtnClose)
	EventDispatcher.RemoveEventListener(EventID.UpdateHomeLandOverview, self.delegateUpdateHomeLandOverview)
	EventDispatcher.RemoveEventListener(EventID.HomeLandUpdatePlantEvent, self.delegateUpdateHomeLandOverview)
end

function HomeLandOverviewUI:OnPause()
	return
end

function HomeLandOverviewUI:OnResume()
	return
end

function HomeLandOverviewUI:OnCover()
	return
end

function HomeLandOverviewUI:OnReveal()
	return
end

function HomeLandOverviewUI:OnRefocus(userData)
	return
end

function HomeLandOverviewUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandOverviewUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandOverviewUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandOverviewUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandOverviewUI:OnDestroy()
	for i, v in pairs(self.overviewRenderPool) do
		v:Dispose()
	end
end

function HomeLandOverviewUI:UpdateView()
	self.scrollArea:Refresh(#functionTab)
end

function HomeLandOverviewUI:OnRenderGridCell(cell)
	local data = functionTab[cell.index + 1]

	if data == nil then
		cell.gameObject:SetActive(false)

		return
	end

	if data == Constant.HomelandBuildType.BuildBackGift then
		local backGiftNum = HomeLandLuaModule.BackGiftNum()

		if backGiftNum <= 0 then
			cell.gameObject:SetActive(false)

			return
		end
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local overviewCell = self.overviewRenderPool[instanceID]

	if overviewCell == nil then
		overviewCell = HomeLandOverviewRenderCell:New(cell.gameObject)
		self.overviewRenderPool[instanceID] = overviewCell
	end

	overviewCell:SetDate(data)
end

function HomeLandOverviewUI:OnSelectedGridCell(cell)
	self:OnBtnClose()

	local buildType = functionTab[cell.index + 1]
	local decorateType

	if buildType == Constant.HomelandBuildType.BuildGold then
		decorateType = Constant.HomelandRoomFunDecorateType.BuildDecorateGold
	elseif buildType == Constant.HomelandBuildType.BuildManufacture then
		decorateType = Constant.HomelandRoomFunDecorateType.BuildDecorateManufacture
	elseif buildType == Constant.HomelandBuildType.BuildPlant then
		decorateType = Constant.HomelandRoomFunDecorateType.BuildDecoratePlant
	elseif buildType == Constant.HomelandBuildType.BuildCooking then
		decorateType = Constant.HomelandRoomFunDecorateType.BuildDecorateCooking
	elseif buildType == Constant.HomelandBuildType.BuildWork then
		decorateType = Constant.HomelandRoomFunDecorateType.BuildDecorateWork
	elseif buildType == Constant.HomelandBuildType.BuildBackGift then
		decorateType = Constant.HomelandRoomFunDecorateType.BuildDecorateGift
	end

	if decorateType then
		GameEntry.LuaEvent:Fire(nil, HomelandClickFunctionDecorationEventArgs():Fill(decorateType, true))
	end
end

function HomeLandOverviewUI:OnBtnHelp()
	return
end

function HomeLandOverviewUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandOverviewUI)
end

return HomeLandOverviewUI
