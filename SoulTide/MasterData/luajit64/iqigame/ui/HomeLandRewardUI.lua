-- chunkname: @IQIGame\\UI\\HomeLandRewardUI.lua

local HomeLandRewardUI = Base:Extend("HomeLandRewardUI", "IQIGame.Onigao.UI.HomeLandRewardUI", {})

function HomeLandRewardUI:OnInit()
	self.TextTitle:GetComponent("Text").text = HomeLandRewardUIApi:GetString("TextTitle")
	self.TextTitle1:GetComponent("Text").text = HomeLandRewardUIApi:GetString("TextTitle1")
	self.TextTitle2:GetComponent("Text").text = HomeLandRewardUIApi:GetString("TextTitle2")
	self.TextMsg:GetComponent("Text").text = HomeLandRewardUIApi:GetString("TextMsg")
	self.TextBtnLab:GetComponent("Text").text = HomeLandRewardUIApi:GetString("TextBtnLab")
	self.btnGetRewardComponent = self.BtnGetReward:GetComponent("Button")

	function self.delegateBtnGetReward()
		self:OnBtnGetReward()
	end
end

function HomeLandRewardUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandRewardUI:OnOpen(userData)
	self:UpDataView()
end

function HomeLandRewardUI:OnClose(userData)
	return
end

function HomeLandRewardUI:OnAddListeners()
	self.btnGetRewardComponent.onClick:AddListener(self.delegateBtnGetReward)
end

function HomeLandRewardUI:OnRemoveListeners()
	self.btnGetRewardComponent.onClick:RemoveListener(self.delegateBtnGetReward)
end

function HomeLandRewardUI:OnPause()
	return
end

function HomeLandRewardUI:OnResume()
	return
end

function HomeLandRewardUI:OnCover()
	return
end

function HomeLandRewardUI:OnReveal()
	return
end

function HomeLandRewardUI:OnRefocus(userData)
	return
end

function HomeLandRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandRewardUI:OnDestroy()
	return
end

function HomeLandRewardUI:UpDataView()
	local parentTransform = self.Grid.transform

	for i = 0, parentTransform.childCount - 1 do
		local obj = parentTransform:GetChild(0).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	local soulDataList = SoulModule.GetSortedUnlockSoulDataList()

	for i, v in pairs(soulDataList) do
		local obj = UnityEngine.Object.Instantiate(self.Mould)

		obj.transform:SetParent(parentTransform, false)
		obj:SetActive(true)

		local tab = {}

		LuaCodeInterface.BindOutlet(obj, tab)

		tab.Text1:GetComponent("Text").text = CfgSoulTable[v.soulCid].Name
		tab.Text2:GetComponent("Text").text = self:GetBaseComfortDegree() + self:GetRoomAddComfortDegree(v.soulCid) .. ""

		LuaCodeInterface.ClearOutlet(obj, tab)
	end
end

function HomeLandRewardUI:GetBaseComfortDegree()
	local now = HomeLandLuaModule.homeLandBaseInfo.currentComfort
	local tab = {}

	for i, v in pairsCfg(CfgHomeLandComfortTable) do
		table.insert(tab, v)
	end

	table.sort(tab, function(a, b)
		return a.Level > b.Level
	end)

	for i = 1, #tab do
		local cfg = tab[i]

		if now >= cfg.ComfortInterval then
			return cfg.Reward
		end
	end

	return 0
end

function HomeLandRewardUI:GetRoomAddComfortDegree(soulID)
	local per = CfgDiscreteDataTable[6506033].Data[1] / 1000
	local tabData = HomeLandLuaModule.homeLandRoomDic

	for i, v in pairs(tabData) do
		local cfgRoom = CfgHomeLandRoomTable[v.cid]

		if cfgRoom.WhichSoul == soulID then
			return math.floor(v.comfort * per)
		end
	end

	return 0
end

function HomeLandRewardUI:OnBtnGetReward()
	HomeLandLuaModule.ReceiveComfortAwards()
	UIModule.Close(Constant.UIControllerName.HomeLandRewardUI)
end

return HomeLandRewardUI
