-- chunkname: @IQIGame\\UI\\MonsterAcademyMallUI.lua

local MonsterAcademyMallUI = {
	functionIDs = {},
	productList = {},
	mallCellPool = {}
}

MonsterAcademyMallUI = Base:Extend("MonsterAcademyMallUI", "IQIGame.Onigao.UI.MonsterAcademyMallUI", MonsterAcademyMallUI)

require("IQIGame.UIExternalApi.MonsterAcademyMallUIApi")

local MonsterAcademyPlayerHeadView = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyPlayerHeadView")
local MonsterAcademyMallCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyMallCell")

function MonsterAcademyMallUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateUpdateShopEvent()
		self:OnUpdateShopEvent()
	end

	self.playerHeadView = MonsterAcademyPlayerHeadView.New(self.PlayerInformation)
	self.shortList = self.goShortList:GetComponent("ScrollAreaList")

	function self.shortList.onRenderCell(cell)
		self:OnRenderItemCell(cell)
	end

	function self.shortList.onSelectedCell(cell)
		self:OnSelectItemCell(cell)
	end
end

function MonsterAcademyMallUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyMallUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyMallUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyMallUI:GetBGM(userData)
	return nil
end

function MonsterAcademyMallUI:OnOpen(userData)
	self.functionIDs = userData.FunctionIDs

	self:UpdateView()
end

function MonsterAcademyMallUI:OnClose(userData)
	return
end

function MonsterAcademyMallUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateShopEvent, self.DelegateUpdateShopEvent)
end

function MonsterAcademyMallUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateShopEvent, self.DelegateUpdateShopEvent)
end

function MonsterAcademyMallUI:OnPause()
	return
end

function MonsterAcademyMallUI:OnResume()
	return
end

function MonsterAcademyMallUI:OnCover()
	return
end

function MonsterAcademyMallUI:OnReveal()
	return
end

function MonsterAcademyMallUI:OnRefocus(userData)
	return
end

function MonsterAcademyMallUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyMallUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyMallUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyMallUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyMallUI:OnDestroy()
	self.playerHeadView:Dispose()

	for i, v in pairs(self.mallCellPool) do
		v:Dispose()
	end
end

function MonsterAcademyMallUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function MonsterAcademyMallUI:OnUpdateShopEvent()
	self:UpdateView()
end

function MonsterAcademyMallUI:UpdateView()
	self.playerHeadView:UpdateView()

	self.productList = {}

	for k, functionID in pairs(self.functionIDs) do
		local cfgFunction = CfgGalgameMonsterSchoolFunctionTable[functionID]

		for i, v in pairsCfg(CfgGalgameMonsterShopTable) do
			if table.indexOf(cfgFunction.Parameter, v.MallType) ~= -1 then
				if v.ShowCondition ~= nil and v.ShowCondition > 0 then
					if ConditionModule.Check(v.ShowCondition) then
						table.insert(self.productList, v)
					end
				else
					table.insert(self.productList, v)
				end
			end
		end
	end

	table.sort(self.productList, function(a, b)
		return a.Sort < b.Sort
	end)

	if self.shortList.dataCount ~= #self.productList then
		self.shortList:RenderCellsDynamic(#self.productList)
	else
		self.shortList:RenderCells()
	end
end

function MonsterAcademyMallUI:OnRenderItemCell(grid)
	local luaIndex = grid.index + 1
	local cfgMallData = self.productList[luaIndex]
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.mallCellPool[insID]

	if cell == nil then
		cell = MonsterAcademyMallCell.New(grid.gameObject)
		self.mallCellPool[insID] = cell
	end

	cell:SetData(cfgMallData)
end

function MonsterAcademyMallUI:OnSelectItemCell(grid)
	local luaIndex = grid.index + 1
	local cfgMallData = self.productList[luaIndex]
	local insID = grid.gameObject:GetInstanceID()
	local cell = self.mallCellPool[insID]

	if cell.isSellOut then
		NoticeModule.ShowNoticeNoCallback(21040055)

		return
	end

	UIModule.Open(Constant.UIControllerName.MonsterAcademyBuyPanelUI, Constant.UILayer.UI, {
		mallCid = cfgMallData.Id
	})
end

return MonsterAcademyMallUI
