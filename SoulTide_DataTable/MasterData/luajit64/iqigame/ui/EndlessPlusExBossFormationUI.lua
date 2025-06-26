-- chunkname: @IQIGame\\UI\\EndlessPlusExBossFormationUI.lua

local EndlessPlusExBossFormationUI = {
	RuneSuitItemPool = {}
}

EndlessPlusExBossFormationUI = Base:Extend("EndlessPlusExBossFormationUI", "IQIGame.Onigao.UI.EndlessPlusExBossFormationUI", EndlessPlusExBossFormationUI)

require("IQIGame.UIExternalApi.EndlessPlusExBossFormationUIApi")

local json = require("Util.json")
local MultiFunctionFormationPanel = require("IQIGame.UI.FormationUI.MultiFunctionFormationPanel")
local EndlessPlusExBossRuneSuitItem = require("IQIGame.UI.ExploreHall.EndlessPlus.EndlessPlusExBossRuneSuitItem")

function EndlessPlusExBossFormationUI:OnInit()
	UGUIUtil.SetText(self.TextFormation, EndlessPlusExBossFormationUIApi:GetString("TextFormation"))
	UGUIUtil.SetText(self.TextNoRune, EndlessPlusExBossFormationUIApi:GetString("TextNoRune"))

	self.rankFormationView = MultiFunctionFormationPanel.New(self.Formation)
	self.playerHead = PlayerHeadUI.New(self.PlayerHead)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.RunesModule:SetActive(false)
end

function EndlessPlusExBossFormationUI:GetPreloadAssetPaths()
	return nil
end

function EndlessPlusExBossFormationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessPlusExBossFormationUI:IsManualShowOnOpen(userData)
	return false
end

function EndlessPlusExBossFormationUI:GetBGM(userData)
	return nil
end

function EndlessPlusExBossFormationUI:OnOpen(userData)
	self.userData = userData.userData
	self.rankingPOD = userData.rankingPOD

	self:UpdateView()
end

function EndlessPlusExBossFormationUI:OnClose(userData)
	return
end

function EndlessPlusExBossFormationUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function EndlessPlusExBossFormationUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function EndlessPlusExBossFormationUI:OnPause()
	return
end

function EndlessPlusExBossFormationUI:OnResume()
	return
end

function EndlessPlusExBossFormationUI:OnCover()
	return
end

function EndlessPlusExBossFormationUI:OnReveal()
	return
end

function EndlessPlusExBossFormationUI:OnRefocus(userData)
	return
end

function EndlessPlusExBossFormationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessPlusExBossFormationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessPlusExBossFormationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessPlusExBossFormationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessPlusExBossFormationUI:OnDestroy()
	self.rankFormationView:Dispose()

	if self.playerHead then
		self.playerHead:Dispose()
	end

	for i, v in pairs(self.RuneSuitItemPool) do
		v:Dispose()
	end

	self.RuneSuitItemPool = {}
end

function EndlessPlusExBossFormationUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function EndlessPlusExBossFormationUI:UpdateView()
	local str = IQIGame.Onigao.Game.GZipUtil.DecompressString(self.userData)
	local userDataTab = json.decode(str)
	local prefabList = {}

	for k, formationSoulPrefabPOD in pairs(userDataTab.soulPrefabs) do
		prefabList[tonumber(k)] = formationSoulPrefabPOD
	end

	self.rankFormationView:SetData(prefabList)
	UGUIUtil.SetText(self.TextPower, tostring(self.rankFormationView:GetPower()))

	if self.rankingPOD then
		UGUIUtil.SetText(self.TextPlayerName, self.rankingPOD.name)

		if self.playerHead then
			self.playerHead:SetData(self.rankingPOD.headIcon, self.rankingPOD.pLv, self.rankingPOD.avatarFrame)
		end
	end

	local runeTabStr = string.split(userDataTab.userData, ",")
	local runeTab = {}

	for i, v in pairs(runeTabStr) do
		if v ~= "" and v ~= nil then
			local value = tonumber(v)

			if value > 0 then
				table.insert(runeTab, value)
			end
		end
	end

	self:RefreshRune(runeTab)
end

function EndlessPlusExBossFormationUI:RefreshRune(runeTable)
	for i, v in pairs(self.RuneSuitItemPool) do
		v:Dispose()
	end

	if runeTable == nil then
		self.RuneNullNode:SetActive(true)

		return
	end

	self.RuneNullNode:SetActive(#runeTable == 0)

	self.RuneSuitItemPool = {}

	local runes = {}

	for i = 1, #runeTable do
		local cid = runeTable[i]

		table.insert(runes, CfgRuneTable[cid])
	end

	table.sort(runes, function(a, b)
		return a.Quality > b.Quality
	end)

	for i = 1, #runes do
		local cfgRuneData = runes[i]
		local obj = UnityEngine.Object.Instantiate(self.RunesModule)

		obj.transform:SetParent(self.RunesNode.transform, false)

		local runeSuitItem = EndlessPlusExBossRuneSuitItem.New(obj)

		runeSuitItem:SetData(cfgRuneData)
		table.insert(self.RuneSuitItemPool, runeSuitItem)
	end
end

return EndlessPlusExBossFormationUI
