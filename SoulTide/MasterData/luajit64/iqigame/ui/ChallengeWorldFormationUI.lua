-- chunkname: @IQIGame\\UI\\ChallengeWorldFormationUI.lua

local ChallengeWorldFormationUI = Base:Extend("ChallengeWorldFormationUI", "IQIGame.Onigao.UI.ChallengeWorldFormationUI", {})
local json = require("Util.json")
local MultiFunctionFormationPanel = require("IQIGame.UI.FormationUI.MultiFunctionFormationPanel")

function ChallengeWorldFormationUI:OnInit()
	UGUIUtil.SetText(self.TextFormation, ChallengeWorldFormationUIApi:GetString("TextFormation"))

	self.rankFormationView = MultiFunctionFormationPanel.New(self.Formation)
	self.playerHead = PlayerHeadUI.New(self.PlayerHead)

	function self.delegateBtnClose()
		self:OnBtnClose()
	end
end

function ChallengeWorldFormationUI:GetPreloadAssetPaths()
	return nil
end

function ChallengeWorldFormationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChallengeWorldFormationUI:IsManualShowOnOpen(userData)
	return false
end

function ChallengeWorldFormationUI:GetBGM(userData)
	return nil
end

function ChallengeWorldFormationUI:OnOpen(userData)
	self.userData = userData[1]
	self.rankingPOD = userData[2]

	self:UpdateView()
end

function ChallengeWorldFormationUI:OnClose(userData)
	return
end

function ChallengeWorldFormationUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function ChallengeWorldFormationUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function ChallengeWorldFormationUI:OnPause()
	return
end

function ChallengeWorldFormationUI:OnResume()
	return
end

function ChallengeWorldFormationUI:OnCover()
	return
end

function ChallengeWorldFormationUI:OnReveal()
	return
end

function ChallengeWorldFormationUI:OnRefocus(userData)
	return
end

function ChallengeWorldFormationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChallengeWorldFormationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChallengeWorldFormationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChallengeWorldFormationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChallengeWorldFormationUI:OnDestroy()
	self.rankFormationView:Dispose()

	if self.playerHead then
		self.playerHead:Dispose()
	end
end

function ChallengeWorldFormationUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.ChallengeWorldFormationUI)
end

function ChallengeWorldFormationUI:UpdateView()
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
end

return ChallengeWorldFormationUI
