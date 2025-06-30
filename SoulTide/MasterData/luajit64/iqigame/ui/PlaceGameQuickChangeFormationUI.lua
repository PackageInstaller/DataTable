-- chunkname: @IQIGame\\UI\\PlaceGameQuickChangeFormationUI.lua

local PlaceGameQuickChangeFormationUI = {
	FormationItems = {}
}

PlaceGameQuickChangeFormationUI = Base:Extend("PlaceGameQuickChangeFormationUI", "IQIGame.Onigao.UI.PlaceGameQuickChangeFormationUI", PlaceGameQuickChangeFormationUI)

local PlaceGameQuickFormationItemCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormation.PlaceGameQuickFormationItemCell")

function PlaceGameQuickChangeFormationUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.FormationGrid:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectedFormationCell(cell)
	end
	self.FormationGrid:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderFormationCell(cell)
	end
end

function PlaceGameQuickChangeFormationUI:GetPreloadAssetPaths()
	return nil
end

function PlaceGameQuickChangeFormationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlaceGameQuickChangeFormationUI:IsManualShowOnOpen(userData)
	return false
end

function PlaceGameQuickChangeFormationUI:GetBGM(userData)
	return nil
end

function PlaceGameQuickChangeFormationUI:OnOpen(userData)
	self.FormationIndex = userData.FormationIndex
	self.OnConfirmCallback = userData.OnConfirm

	self:UpdateView()
end

function PlaceGameQuickChangeFormationUI:OnClose(userData)
	PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.PlaceGameFormationTeamIndex, self.FormationIndex)

	if self.OnConfirmCallback ~= nil then
		self.OnConfirmCallback(self.FormationIndex)
	end
end

function PlaceGameQuickChangeFormationUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function PlaceGameQuickChangeFormationUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function PlaceGameQuickChangeFormationUI:OnPause()
	return
end

function PlaceGameQuickChangeFormationUI:OnResume()
	return
end

function PlaceGameQuickChangeFormationUI:OnCover()
	return
end

function PlaceGameQuickChangeFormationUI:OnReveal()
	return
end

function PlaceGameQuickChangeFormationUI:OnRefocus(userData)
	return
end

function PlaceGameQuickChangeFormationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlaceGameQuickChangeFormationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlaceGameQuickChangeFormationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlaceGameQuickChangeFormationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlaceGameQuickChangeFormationUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.FormationItems) do
		v:Dispose()
	end
end

function PlaceGameQuickChangeFormationUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function PlaceGameQuickChangeFormationUI:UpdateView()
	local scrollAreaList = self.FormationGrid:GetComponent("ScrollAreaList")

	scrollAreaList.defaultSelectedToggle = self.FormationIndex - 1

	scrollAreaList:Refresh(#PlaceGameModule.DailyDupPOD.placeGamePOD.placeGameFormationPODs)
end

function PlaceGameQuickChangeFormationUI:OnSelectedFormationCell(cell)
	self.FormationIndex = cell.index + 1
end

function PlaceGameQuickChangeFormationUI:OnRenderFormationCell(cell)
	local index = cell.index + 1
	local item = self.FormationItems[cell.gameObject:GetInstanceID()]

	if item == nil then
		item = PlaceGameQuickFormationItemCell.New(cell.gameObject, function(pIndex)
			self.FormationIndex = pIndex

			UIModule.CloseSelf(self)
		end)
		self.FormationItems[cell.gameObject:GetInstanceID()] = item
	end

	local formationPOD = PlaceGameModule.GetPlaceGameFormationByIndex(index)

	item:SetData(formationPOD, index, self.FormationIndex)
end

return PlaceGameQuickChangeFormationUI
