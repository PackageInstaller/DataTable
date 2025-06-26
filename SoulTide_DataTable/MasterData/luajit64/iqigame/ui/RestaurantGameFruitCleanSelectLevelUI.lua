-- chunkname: @IQIGame\\UI\\RestaurantGameFruitCleanSelectLevelUI.lua

local RestaurantGameFruitCleanSelectLevelUI = {
	cfgControls = {},
	selectLevelPool = {}
}

RestaurantGameFruitCleanSelectLevelUI = Base:Extend("RestaurantGameFruitCleanSelectLevelUI", "IQIGame.Onigao.UI.RestaurantGameFruitCleanSelectLevelUI", RestaurantGameFruitCleanSelectLevelUI)

local FruitGameSelectLevelCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.FruitCleanGame.FruitGameSelectLevelCell")

function RestaurantGameFruitCleanSelectLevelUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderItemCell(cell)
	end
	self.ScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectItemCell(cell)
	end
end

function RestaurantGameFruitCleanSelectLevelUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantGameFruitCleanSelectLevelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantGameFruitCleanSelectLevelUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantGameFruitCleanSelectLevelUI:GetBGM(userData)
	return nil
end

function RestaurantGameFruitCleanSelectLevelUI:OnOpen(userData)
	self:UpdateView()
end

function RestaurantGameFruitCleanSelectLevelUI:OnClose(userData)
	return
end

function RestaurantGameFruitCleanSelectLevelUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function RestaurantGameFruitCleanSelectLevelUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function RestaurantGameFruitCleanSelectLevelUI:OnPause()
	return
end

function RestaurantGameFruitCleanSelectLevelUI:OnResume()
	return
end

function RestaurantGameFruitCleanSelectLevelUI:OnCover()
	return
end

function RestaurantGameFruitCleanSelectLevelUI:OnReveal()
	return
end

function RestaurantGameFruitCleanSelectLevelUI:OnRefocus(userData)
	return
end

function RestaurantGameFruitCleanSelectLevelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantGameFruitCleanSelectLevelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantGameFruitCleanSelectLevelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantGameFruitCleanSelectLevelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantGameFruitCleanSelectLevelUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.selectLevelPool) do
		v:Dispose()
	end
end

function RestaurantGameFruitCleanSelectLevelUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function RestaurantGameFruitCleanSelectLevelUI:UpdateView()
	self.cfgControls = ROFruitCleanGameModule.cfgFruitCleanGameControls

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.cfgControls)
end

function RestaurantGameFruitCleanSelectLevelUI:OnRenderItemCell(grid)
	local luaIndex = grid.index + 1
	local cfgData = self.cfgControls[luaIndex]
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.selectLevelPool[insID]

	if cell == nil then
		cell = FruitGameSelectLevelCell.New(grid.gameObject)
		self.selectLevelPool[insID] = cell
	end

	local passData = ROFruitCleanGameModule.GetPassLevelData(cfgData.Id)
	local cfgMaxLv = ROFruitCleanGameModule.maxLv
	local passMaxLv = ROFruitCleanGameModule.GetMaxPassLevel()
	local isMaxUnlock = false

	if passMaxLv < cfgMaxLv then
		isMaxUnlock = cfgData.Level == passMaxLv + 1
	end

	cell:SetData(cfgData, passData, isMaxUnlock)
end

function RestaurantGameFruitCleanSelectLevelUI:OnSelectItemCell(grid)
	local luaIndex = grid.index + 1
	local cfgData = self.cfgControls[luaIndex]
	local passMaxLv = ROFruitCleanGameModule.GetMaxPassLevel()

	if cfgData.Level > passMaxLv + 1 then
		return
	end

	ROFruitCleanGameModule.CreateNewLevel(cfgData.Level)
	EventDispatcher.Dispatch(EventID.ROUpdateFruitCleanGameEvent)
	self:OnClickBtnClose()
end

return RestaurantGameFruitCleanSelectLevelUI
