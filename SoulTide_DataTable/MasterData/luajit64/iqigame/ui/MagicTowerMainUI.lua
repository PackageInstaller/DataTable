-- chunkname: @IQIGame\\UI\\MagicTowerMainUI.lua

require("IQIGame.UIExternalApi.MagicTowerMainUIApi")

local MagicTowerDollInfoController = require("IQIGame.UI.MagicTower.MagicTowerDollInfoController")
local MagicTowerMonsterInfoCell = require("IQIGame.UI.MagicTower.MagicTowerMonsterInfoCell")
local MagicTowerMainUI = {
	MonsterCellMap = {}
}

MagicTowerMainUI = Base:Extend("MagicTowerMainUI", "IQIGame.Onigao.UI.MagicTowerMainUI", MagicTowerMainUI)

function MagicTowerMainUI:OnInit()
	function self.DelegateOnClickExitBtn()
		self:OnClickExitBtn()
	end

	function self.DelegateOnRemoveElement()
		self:OnRemoveElement()
	end

	function self.DelegateOnClickShowMonsterInfoViewBtn()
		self:OnClickShowMonsterInfoViewBtn()
	end

	function self.DelegateOnClickHideMonsterInfoViewBtn()
		self:OnClickHideMonsterInfoViewBtn()
	end

	self.DollInfoController = MagicTowerDollInfoController.New(self.DollInfoView, self.UIController:GetComponent(typeof(UnityEngine.Canvas)))

	local scrollAreaList = self.MonsterInfoScrollView:GetComponent(typeof(Components.UI.Scroll.ScrollAreaList))

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderMonsterCell(cell)
	end
end

function MagicTowerMainUI:GetPreloadAssetPaths()
	return nil
end

function MagicTowerMainUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MagicTowerMainUI:IsManualShowOnOpen(userData)
	return false
end

function MagicTowerMainUI:GetBGM(userData)
	return nil
end

function MagicTowerMainUI:OnOpen(userData)
	self:UpdateView(userData)
end

function MagicTowerMainUI:OnClose(userData)
	return
end

function MagicTowerMainUI:OnAddListeners()
	self.ExitBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickExitBtn)
	self.ShowMonsterInfoViewBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShowMonsterInfoViewBtn)
	self.HideMonsterInfoViewBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickHideMonsterInfoViewBtn)
	EventDispatcher.AddEventListener(EventID.MagicTowerRemoveElement, self.DelegateOnRemoveElement)
end

function MagicTowerMainUI:OnRemoveListeners()
	self.ExitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickExitBtn)
	self.ShowMonsterInfoViewBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShowMonsterInfoViewBtn)
	self.HideMonsterInfoViewBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickHideMonsterInfoViewBtn)
	EventDispatcher.RemoveEventListener(EventID.MagicTowerRemoveElement, self.DelegateOnRemoveElement)
end

function MagicTowerMainUI:OnPause()
	return
end

function MagicTowerMainUI:OnResume()
	return
end

function MagicTowerMainUI:OnCover()
	return
end

function MagicTowerMainUI:OnReveal()
	return
end

function MagicTowerMainUI:OnRefocus(userData)
	return
end

function MagicTowerMainUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MagicTowerMainUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MagicTowerMainUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MagicTowerMainUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MagicTowerMainUI:OnDestroy()
	self.DollInfoController:Dispose()

	for gameObject, cell in pairs(self.MonsterCellMap) do
		cell:Dispose()
	end
end

function MagicTowerMainUI:UpdateView(userData)
	self.DollInfoController:OnOpen(userData)
	self:RefreshMonsters()
	self:ShowMonsterInfoView(false)
end

function MagicTowerMainUI:RefreshMonsters()
	local heroCellPOD = MagicTowerModule.GetCellPODByID(MagicTowerModule.MapData.mapPOD.role.cellId)
	local cells = MagicTowerModule.MapData.mapPOD.cells
	local monsterMap = {}

	for i = 1, #cells do
		local cellPOD = cells[i]

		if cellPOD.floor == MagicTowerModule.MapData.currentFloor and cellPOD.x > heroCellPOD.x then
			local cfgMagicTowerCellDataData = CfgMagicTowerCellDataTable[cellPOD.dataId]

			if cfgMagicTowerCellDataData.MonsterID ~= 0 then
				local cfgMagicTowerMonsterData = CfgMagicTowerMonsterTable[cfgMagicTowerCellDataData.MonsterID]

				monsterMap[cfgMagicTowerMonsterData.Id] = cfgMagicTowerMonsterData
			end
		end
	end

	self.MonsterDataList = {}

	for id, cfgData in pairs(monsterMap) do
		table.insert(self.MonsterDataList, cfgData)
	end

	table.sort(self.MonsterDataList, function(cfgData1, cfgData2)
		return cfgData1.Id < cfgData2.Id
	end)

	local scrollAreaList = self.MonsterInfoScrollView:GetComponent(typeof(Components.UI.Scroll.ScrollAreaList))

	scrollAreaList:Refresh(#self.MonsterDataList)
end

function MagicTowerMainUI:OnRenderMonsterCell(cell)
	local monsterCell = self.MonsterCellMap[cell.gameObject]

	if monsterCell == nil then
		monsterCell = MagicTowerMonsterInfoCell.New(cell.gameObject, self.UIController:GetComponent(typeof(UnityEngine.Canvas)))
		self.MonsterCellMap[cell.gameObject] = monsterCell
	end

	monsterCell:SetData(self.MonsterDataList[cell.index + 1])
end

function MagicTowerMainUI:OnClickExitBtn()
	UIModule.Open(Constant.UIControllerName.MagicTowerExitUI, Constant.UILayer.UI, {
		onGiveUp = MagicTowerModule.GiveUp,
		onAFK = MagicTowerModule.ExitScene
	})
end

function MagicTowerMainUI:OnRemoveElement()
	self:RefreshMonsters()
end

function MagicTowerMainUI:OnClickShowMonsterInfoViewBtn()
	self:ShowMonsterInfoView(true)
end

function MagicTowerMainUI:OnClickHideMonsterInfoViewBtn()
	self:ShowMonsterInfoView(false)
end

function MagicTowerMainUI:ShowMonsterInfoView(isShow)
	self.MonsterInfoView:SetActive(isShow)
	self.ShowMonsterInfoViewBtn:SetActive(not isShow)
	self.HideMonsterInfoViewBtn:SetActive(isShow)
end

return MagicTowerMainUI
