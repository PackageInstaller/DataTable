-- chunkname: @IQIGame\\UI\\LibraryMonsterListUI.lua

local LibraryMonsterListUI = Base:Extend("LibraryMonsterListUI", "IQIGame.Onigao.UI.LibraryMonsterListUI", {})
local LibraryMonsterCell = require("IQIGame.UI.Library.LibraryMonsterCell")
local LibraryMonsterResCell = require("IQIGame.UI.Library.LibraryMonsterResCell")
local TownLibraryMonsterResData = require("IQIGame.Module.TownLibrary.TownLibraryMonsterResData")

function LibraryMonsterListUI:OnInit()
	UGUIUtil.SetText(self.MonsterPanelTitle, LibraryMazeUIApi:GetString("MonsterPanelTitle"))

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	self.scrollList = self.PlaceScroll:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(gridCell)
		self:OnRenderGridCell(gridCell)
	end

	function self.scrollList.onSelectedCell(gridCell)
		self:OnSelectedGridCell(gridCell)
	end

	self.scrollMonsterList = self.MonsterScroll:GetComponent("ScrollAreaList")

	function self.scrollMonsterList.onRenderCell(gridCell)
		self:OnRenderMonsterGridCell(gridCell)
	end

	function self.scrollMonsterList.onSelectedCell(gridCell)
		self:OnSelectedMonsterGridCell(gridCell)
	end
end

function LibraryMonsterListUI:GetPreloadAssetPaths()
	return nil
end

function LibraryMonsterListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LibraryMonsterListUI:IsManualShowOnOpen(userData)
	return false
end

function LibraryMonsterListUI:GetBGM(userData)
	return nil
end

function LibraryMonsterListUI:OnOpen(userData)
	self:ShowList()
end

function LibraryMonsterListUI:OnClose(userData)
	return
end

function LibraryMonsterListUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
end

function LibraryMonsterListUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
end

function LibraryMonsterListUI:OnPause()
	return
end

function LibraryMonsterListUI:OnResume()
	return
end

function LibraryMonsterListUI:OnCover()
	return
end

function LibraryMonsterListUI:OnReveal()
	return
end

function LibraryMonsterListUI:OnRefocus(userData)
	return
end

function LibraryMonsterListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LibraryMonsterListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LibraryMonsterListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibraryMonsterListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibraryMonsterListUI:OnDestroy()
	LibraryMonsterCell.DisposeIn(self)
	LibraryMonsterResCell.DisposeIn(self)
end

function LibraryMonsterListUI:ShowList()
	self.libraryMonsters = TownLibraryModule.monsterTab

	table.sort(self.libraryMonsters, function(a, b)
		return a.cfgID < b.cfgID
	end)
	self.scrollList:Refresh(#self.libraryMonsters)
	self:ShowPlace()
end

function LibraryMonsterListUI:ShowPlace()
	if self.selectMonsterData then
		self.monsterRes = {}

		for i, cfgRes in pairsCfg(CfgTownMonsterBookResTable) do
			if cfgRes.TownMonsterID == self.selectMonsterData.cfgID then
				local data = self.selectMonsterData:GetLockMonsterResData(cfgRes.Id)

				if data == nil then
					data = TownLibraryMonsterResData.New(cfgRes.Id, false, nil)
				end

				table.insert(self.monsterRes, data)
			end
		end

		table.sort(self.monsterRes, function(a, b)
			return a.cfgID < b.cfgID
		end)
		self.scrollMonsterList:Refresh(#self.monsterRes)
	end
end

function LibraryMonsterListUI:OnSelectedGridCell(cell)
	local monsterData = self.libraryMonsters[cell.index + 1]

	if self.selectObj then
		self.selectObj:Select(false)
	end

	self.selectObj = LibraryMonsterCell.PackageOrReuseView(self, cell.gameObject)

	self.selectObj:SetData(monsterData)
	self.selectObj:Select(true)

	self.selectMonsterData = monsterData

	self:ShowPlace()
end

function LibraryMonsterListUI:OnRenderGridCell(cell)
	local item = cell.gameObject
	local itemCell = LibraryMonsterCell.PackageOrReuseView(self, item)
	local monsterData = self.libraryMonsters[cell.index + 1]

	itemCell:SetData(monsterData)

	if self.selectMonsterData == nil then
		self.selectMonsterData = monsterData
		self.selectObj = itemCell

		itemCell:Select(true)
	elseif self.selectMonsterData.cfgID == monsterData.cfgID then
		self.selectMonsterData = monsterData
		self.selectObj = itemCell

		itemCell:Select(true)
	else
		itemCell:Select(false)
	end
end

function LibraryMonsterListUI:OnRenderMonsterGridCell(cell)
	local monsterResData = self.monsterRes[cell.index + 1]

	if monsterResData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	local obj = cell.gameObject
	local cell = LibraryMonsterResCell.PackageOrReuseView(self, obj)

	cell:SetData(monsterResData)
end

function LibraryMonsterListUI:OnSelectedMonsterGridCell(cell)
	UIModule.Open(Constant.UIControllerName.LibraryMonsterInfoUI, Constant.UILayer.UI, {
		cell.index + 1,
		self.monsterRes
	})
end

function LibraryMonsterListUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.LibraryMonsterListUI)
end

return LibraryMonsterListUI
