-- chunkname: @IQIGame\\UI\\AssistInFightingUI.lua

local AIFWearItemCell = require("IQIGame.UI.AssisInFighting.AIFWearItemCell")
local AssistInFightingUI = Base:Extend("AssistInFightingUI", "IQIGame.Onigao.UI.AssistInFightingUI", {
	GridCount = 4,
	cellList = {}
})

function AssistInFightingUI:OnInit()
	self:InitDelegates()
	self:Initialize()
end

function AssistInFightingUI:InitDelegates()
	function self.OnAssisInFightingChangeDelegate(pos, data)
		self:OnAssisInFightingChange(pos, data)
	end
end

function AssistInFightingUI:Initialize()
	LuaCodeInterface.BindOutlet(self.View, self)

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function AssistInFightingUI:RefreshData()
	for i = 1, self.GridCount do
		if self.cellList[i] == nil then
			self.cellList[i] = {}

			local FightItem = UnityEngine.Object.Instantiate(self.GridItem.gameObject)

			FightItem:SetActive(true)

			FightItem.name = i

			FightItem.transform:SetParent(self.ContentGrid.transform, false)

			local cell = AIFWearItemCell.New(FightItem, self)

			self.cellList[i] = cell
		end

		self.cellList[i]:RefreshData(AssistInFightingModule.WarlockList[i], i)
	end
end

function AssistInFightingUI:OnAssisInFightingChange(pos, data)
	self.cellList[pos]:RefreshData(AssistInFightingModule.WarlockList[pos], pos)
end

function AssistInFightingUI:GetPreloadAssetPaths()
	return nil
end

function AssistInFightingUI:GetOpenPreloadAssetPaths(userData)
	AssistInFightingModule.PreloadAssetPath = {}

	local _t = {}

	for i, v in pairs(AssistInFightingModule.WarlockList) do
		local path = v:GetCurStaticSkinImagePath(Constant.SkinImageType.AssistInFightingImg)

		table.insert(_t, path)
		AssistInFightingModule.SetPreloadAssetPath(v.cid, path)
	end

	return _t
end

function AssistInFightingUI:IsManualShowOnOpen(userData)
	return false
end

function AssistInFightingUI:GetBGM(userData)
	return nil
end

function AssistInFightingUI:OnOpen(userData)
	self:RefreshData()
end

function AssistInFightingUI:OnClose(userData)
	return
end

function AssistInFightingUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.AssisInFightingChange, self.OnAssisInFightingChangeDelegate)
end

function AssistInFightingUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.AssisInFightingChange, self.OnAssisInFightingChangeDelegate)
end

function AssistInFightingUI:OnPause()
	return
end

function AssistInFightingUI:OnResume()
	return
end

function AssistInFightingUI:OnCover()
	return
end

function AssistInFightingUI:OnReveal()
	return
end

function AssistInFightingUI:OnRefocus(userData)
	return
end

function AssistInFightingUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AssistInFightingUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AssistInFightingUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AssistInFightingUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AssistInFightingUI:OnDestroy()
	for i, v in pairs(self.cellList) do
		v:OnDestroy()
	end

	self.commonReturnBtn:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
end

return AssistInFightingUI
