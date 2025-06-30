-- chunkname: @IQIGame\\UI\\PersonalityTipsUI.lua

local PersonalityTipsUI = {}

PersonalityTipsUI = Base:Extend("PersonalityTipsUI", "IQIGame.Onigao.UI.PersonalityTipsUI", PersonalityTipsUI)

function PersonalityTipsUI:OnInit()
	self:InitDelegate()
end

function PersonalityTipsUI:InitDelegate()
	function self.delegateOnClickButtonClose()
		UIModule.CloseSelf(self)
	end
end

function PersonalityTipsUI:OnAddListeners()
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClose)
end

function PersonalityTipsUI:OnRemoveListeners()
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClose)
end

function PersonalityTipsUI:OnOpen(userData)
	self:__SetCloseBtnState()

	self.personalityId = userData.personalityId

	self:Refresh()
end

function PersonalityTipsUI:OnClose(userData)
	return
end

function PersonalityTipsUI:GetPreloadAssetPaths()
	return nil
end

function PersonalityTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PersonalityTipsUI:IsManualShowOnOpen(userData)
	return false
end

function PersonalityTipsUI:GetBGM(userData)
	return nil
end

function PersonalityTipsUI:OnPause()
	return
end

function PersonalityTipsUI:OnResume()
	return
end

function PersonalityTipsUI:OnCover()
	return
end

function PersonalityTipsUI:OnReveal()
	return
end

function PersonalityTipsUI:OnRefocus(userData)
	return
end

function PersonalityTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PersonalityTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PersonalityTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PersonalityTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PersonalityTipsUI:Refresh()
	local cfgPersonality = CfgUtil.GetCfgPersonalityDataWithID(self.personalityId)

	LuaUtility.SetText(self.textName, cfgPersonality.Name)
	LuaUtility.SetText(self.textDesc, cfgPersonality.PersonalityTips)
	LuaUtility.SetText(self.textNum, BattleUIApi:GetBattleActionOrderText(self:_GetIndex(cfgPersonality, 1)))
end

function PersonalityTipsUI:_GetIndex(cfgPersonality, index)
	if not cfgPersonality.PreviousID or cfgPersonality.PreviousID == 0 then
		return index
	end

	local preCfg = CfgUtil.GetCfgPersonalityDataWithID(cfgPersonality.PreviousID)

	return self:_GetIndex(preCfg, index + 1)
end

function PersonalityTipsUI:__SetCloseBtnState()
	LuaUtility.SetGameObjectShow(self.buttonClose, false)

	self.timer = ModuleTimerUtil.NewTimer(self, function()
		LuaUtility.SetGameObjectShow(self.buttonClose, true)
	end, 1.5, 1)

	self.timer:Start()
end

function PersonalityTipsUI:OnDestroy()
	if self.timer then
		self.timer.Stop(self)

		self.timer = nil
	end

	AssetUtil.UnloadAsset(self)
end

return PersonalityTipsUI
