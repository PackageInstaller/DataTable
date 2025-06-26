-- chunkname: @IQIGame\\UI\\RestaurantGameSelectLevelUI.lua

local RestaurantGameSelectLevelUI = {
	cfgControls = {},
	selectLevelPool = {}
}

RestaurantGameSelectLevelUI = Base:Extend("RestaurantGameSelectLevelUI", "IQIGame.Onigao.UI.RestaurantGameSelectLevelUI", RestaurantGameSelectLevelUI)

require("IQIGame.UIExternalApi.RestaurantGameSelectLevelUIApi")

local CardGameSelectLevelCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.CardGame.CardGameSelectLevelCell")

function RestaurantGameSelectLevelUI:OnInit()
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

function RestaurantGameSelectLevelUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantGameSelectLevelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantGameSelectLevelUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantGameSelectLevelUI:GetBGM(userData)
	return nil
end

function RestaurantGameSelectLevelUI:OnOpen(userData)
	self:UpdateView()
end

function RestaurantGameSelectLevelUI:OnClose(userData)
	return
end

function RestaurantGameSelectLevelUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function RestaurantGameSelectLevelUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function RestaurantGameSelectLevelUI:OnPause()
	return
end

function RestaurantGameSelectLevelUI:OnResume()
	return
end

function RestaurantGameSelectLevelUI:OnCover()
	return
end

function RestaurantGameSelectLevelUI:OnReveal()
	return
end

function RestaurantGameSelectLevelUI:OnRefocus(userData)
	return
end

function RestaurantGameSelectLevelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantGameSelectLevelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantGameSelectLevelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantGameSelectLevelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantGameSelectLevelUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.selectLevelPool) do
		v:Dispose()
	end
end

function RestaurantGameSelectLevelUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function RestaurantGameSelectLevelUI:UpdateView()
	self.cfgControls = ROCardGameModule.cfgCardGameControls

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.cfgControls)
end

function RestaurantGameSelectLevelUI:OnRenderItemCell(grid)
	local luaIndex = grid.index + 1
	local cfgData = self.cfgControls[luaIndex]
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.selectLevelPool[insID]

	if cell == nil then
		cell = CardGameSelectLevelCell.New(grid.gameObject)
		self.selectLevelPool[insID] = cell
	end

	local passData = ROCardGameModule.GetPassLevelData(cfgData.Id)
	local cfgMaxLv = ROCardGameModule.maxLv
	local passMaxLv = ROCardGameModule.GetMaxPassLevel()
	local isMaxUnlock = false

	if passMaxLv < cfgMaxLv then
		isMaxUnlock = cfgData.Level == passMaxLv + 1
	end

	cell:SetData(cfgData, passData, isMaxUnlock)
end

function RestaurantGameSelectLevelUI:OnSelectItemCell(grid)
	local luaIndex = grid.index + 1
	local cfgData = self.cfgControls[luaIndex]
	local passMaxLv = ROCardGameModule.GetMaxPassLevel()

	if cfgData.Level > passMaxLv + 1 then
		log("选通关前面关卡")

		return
	end

	ROCardGameModule.CreateNewLevel(cfgData.Id)
	EventDispatcher.Dispatch(EventID.ROUpdateCardGameEvent)
	self:OnClickBtnClose()
end

return RestaurantGameSelectLevelUI
