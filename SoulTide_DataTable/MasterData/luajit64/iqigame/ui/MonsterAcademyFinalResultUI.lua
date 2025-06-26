-- chunkname: @IQIGame\\UI\\MonsterAcademyFinalResultUI.lua

local MonsterAcademyFinalResultUI = {
	monsterAcademyFinaAttrCells = {},
	monsterAcademyAtt = {},
	monsterAcademyFinaGirlCells = {},
	girlList = {}
}

MonsterAcademyFinalResultUI = Base:Extend("MonsterAcademyFinalResultUI", "IQIGame.Onigao.UI.MonsterAcademyFinalResultUI", MonsterAcademyFinalResultUI)

require("IQIGame.UIExternalApi.MonsterAcademyFinalResultUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterAcademyFinalAttributeCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyFinalResult.MonsterAcademyFinalAttributeCell")
local MonsterAcademyFinaGirlCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyFinalResult.MonsterAcademyFinaGirlCell")

function MonsterAcademyFinalResultUI:OnInit()
	UGUIUtil.SetText(self.CloseBtnLabel, MonsterAcademyFinalResultUIApi:GetString("CloseBtnLabel"))
	UGUIUtil.SetText(self.TextAttributeTitle, MonsterAcademyFinalResultUIApi:GetString("TextAttributeTitle"))
	UGUIUtil.SetText(self.TextFavorTitle, MonsterAcademyFinalResultUIApi:GetString("TextFavorTitle"))

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.AttributeMould:SetActive(false)

	self.monsterAcademyFinaAttrCellPool = UIObjectPool.New(4, function()
		return MonsterAcademyFinalAttributeCell.New(UnityEngine.Object.Instantiate(self.AttributeMould))
	end, function(cell)
		cell:Dispose()
	end)

	self.GirlHeadMould:SetActive(false)

	self.monsterAcademyFinaGirlCellPool = UIObjectPool.New(6, function()
		return MonsterAcademyFinaGirlCell.New(UnityEngine.Object.Instantiate(self.GirlHeadMould))
	end, function(cell)
		cell:Dispose()
	end)
end

function MonsterAcademyFinalResultUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyFinalResultUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyFinalResultUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyFinalResultUI:GetBGM(userData)
	return nil
end

function MonsterAcademyFinalResultUI:OnOpen(userData)
	self.functionId = userData
	self.monsterAcademyAtt = MonsterAcademyModule.GetMonsterAcademyAtt()

	self:UpdateView()
end

function MonsterAcademyFinalResultUI:OnClose(userData)
	return
end

function MonsterAcademyFinalResultUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function MonsterAcademyFinalResultUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function MonsterAcademyFinalResultUI:OnPause()
	return
end

function MonsterAcademyFinalResultUI:OnResume()
	return
end

function MonsterAcademyFinalResultUI:OnCover()
	return
end

function MonsterAcademyFinalResultUI:OnReveal()
	return
end

function MonsterAcademyFinalResultUI:OnRefocus(userData)
	return
end

function MonsterAcademyFinalResultUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyFinalResultUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyFinalResultUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyFinalResultUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyFinalResultUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.monsterAcademyFinaAttrCells) do
		self.monsterAcademyFinaAttrCellPool:Release(v)
	end

	self.monsterAcademyFinaAttrCells = {}

	self.monsterAcademyFinaAttrCellPool:Dispose()

	for i, v in pairs(self.monsterAcademyFinaGirlCells) do
		self.monsterAcademyFinaGirlCellPool:Release(v)
	end

	self.monsterAcademyFinaGirlCells = {}

	self.monsterAcademyFinaGirlCellPool:Dispose()
end

function MonsterAcademyFinalResultUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function MonsterAcademyFinalResultUI:UpdateView()
	local cfgFunctionData = CfgGalgameMonsterSchoolFunctionTable[self.functionId]

	UGUIUtil.SetText(self.TextEnding, MonsterAcademyFinalResultUIApi:GetString("TextEnding", cfgFunctionData.ButtonWord))
	UGUIUtil.SetText(self.TextPlayerName, PlayerModule.PlayerInfo.baseInfo.pName)

	for i, v in pairs(self.monsterAcademyFinaAttrCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.monsterAcademyFinaAttrCellPool:Release(v)
	end

	self.monsterAcademyFinaAttrCells = {}

	for i = 1, #self.monsterAcademyAtt do
		local attributeID = self.monsterAcademyAtt[i]
		local itemCell = self.monsterAcademyFinaAttrCellPool:Obtain()

		itemCell.View:SetActive(true)
		itemCell.View.transform:SetParent(self.AttributeNode.transform, false)
		itemCell:SetData(attributeID)
		table.insert(self.monsterAcademyFinaAttrCells, itemCell)
	end

	self:ShowGirls()
end

function MonsterAcademyFinalResultUI:ShowGirls()
	self.girlList = {}

	for i, v in pairs(MonsterAcademyModule.girlDic) do
		if v.favor > 0 then
			table.insert(self.girlList, v)
		end
	end

	table.sort(self.girlList, function(a, b)
		return a.favor > b.favor
	end)

	for i, v in pairs(self.monsterAcademyFinaGirlCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.monsterAcademyFinaGirlCellPool:Release(v)
	end

	self.monsterAcademyFinaGirlCells = {}

	for i = 1, #self.girlList do
		local monsterAcademyGirlData = self.girlList[i]
		local itemCell = self.monsterAcademyFinaGirlCellPool:Obtain()

		itemCell.View:SetActive(true)
		itemCell.View.transform:SetParent(self.GirlHeadNode.transform, false)
		itemCell:SetData(monsterAcademyGirlData)
		table.insert(self.monsterAcademyFinaGirlCells, itemCell)
	end
end

return MonsterAcademyFinalResultUI
