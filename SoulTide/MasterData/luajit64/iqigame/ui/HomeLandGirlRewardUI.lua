-- chunkname: @IQIGame\\UI\\HomeLandGirlRewardUI.lua

local HomeLandGirlRewardUI = Base:Extend("HomeLandGirlRewardUI", "IQIGame.Onigao.UI.HomeLandGirlRewardUI", {})

function HomeLandGirlRewardUI:OnInit()
	UGUIUtil.SetText(self.TextBtnGetReward, HomeLandGirlRewardUIApi:GetString("TextBtnGetReward"))

	self.btnGetReward = self.BtnGetReward:GetComponent("Button")
	self.btnClose = self.BtnClose:GetComponent("Button")

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnGetReward()
		self:OnBtnGetReward()
	end

	function self.delegateRebateGiftSuccess(roleCid, letterCid)
		self:OnRebateGiftSuccess(roleCid, letterCid)
	end
end

function HomeLandGirlRewardUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandGirlRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandGirlRewardUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandGirlRewardUI:GetBGM(userData)
	return nil
end

function HomeLandGirlRewardUI:OnOpen(userData)
	self:UpdateView()
end

function HomeLandGirlRewardUI:OnClose(userData)
	self.currentLetterID = 0
end

function HomeLandGirlRewardUI:OnAddListeners()
	self.btnGetReward.onClick:AddListener(self.delegateBtnGetReward)
	self.btnClose.onClick:AddListener(self.delegateBtnClose)
	EventDispatcher.AddEventListener(EventID.GetRebateGiftSuccess, self.delegateRebateGiftSuccess)
end

function HomeLandGirlRewardUI:OnRemoveListeners()
	self.btnGetReward.onClick:RemoveListener(self.delegateBtnGetReward)
	self.btnClose.onClick:RemoveListener(self.delegateBtnClose)
	EventDispatcher.RemoveEventListener(EventID.GetRebateGiftSuccess, self.delegateRebateGiftSuccess)
end

function HomeLandGirlRewardUI:OnPause()
	return
end

function HomeLandGirlRewardUI:OnResume()
	return
end

function HomeLandGirlRewardUI:OnCover()
	return
end

function HomeLandGirlRewardUI:OnReveal()
	return
end

function HomeLandGirlRewardUI:OnRefocus(userData)
	return
end

function HomeLandGirlRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if UIModule.HasUI(Constant.UIControllerName.GetPanelUI) then
		self.UIController.gameObject:SetActive(false)
	else
		self.UIController.gameObject:SetActive(true)
	end
end

function HomeLandGirlRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandGirlRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandGirlRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandGirlRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function HomeLandGirlRewardUI:CreateDate()
	return
end

function HomeLandGirlRewardUI:UpdateView()
	self.letters = {}

	if HomeLandLuaModule.homeLandRoles ~= nil then
		for k, v in pairs(HomeLandLuaModule.homeLandRoles) do
			if v.letters then
				for i = 1, #v.letters do
					local id = v.letters[i]

					table.insert(self.letters, id)
				end
			end
		end
	end

	if #self.letters > 0 then
		self.currentLetterID = self.letters[1]

		self:ShowLetterMsg()
	else
		self:OnBtnClose()
	end
end

function HomeLandGirlRewardUI:ShowLetterMsg()
	local cfgLetter = CfgLetterTable[self.currentLetterID]
	local cfgHomeLandRole = CfgHomeLandRoleTable[cfgLetter.SoulId]
	local path

	if cfgHomeLandRole.SoulId > 0 then
		local soulData = SoulModule.GetSoulData(cfgHomeLandRole.SoulId)

		path = UIGlobalApi.GetImagePath(soulData:GetCfgSoulRes2D().HomelandHeadIcon)
	else
		path = UIGlobalApi.GetImagePath(cfgHomeLandRole.HeadIcon)
	end

	AssetUtil.LoadImage(self, path, self.SoulHeadIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.SoulName, cfgLetter.Signature)

	local titleStr = string.gsub(cfgLetter.CallTitle, "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName)
	local contentStr = string.gsub(cfgLetter.Content, "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName)

	UGUIUtil.SetText(self.TextDes, HomeLandGirlRewardUIApi:GetString("TextDes", titleStr, contentStr))
end

function HomeLandGirlRewardUI:OnRebateGiftSuccess(roleCid, letterCid)
	self:UpdateView()
end

function HomeLandGirlRewardUI:OnBtnGetReward()
	if self.currentLetterID > 0 then
		local cfgLetter = CfgLetterTable[self.currentLetterID]

		HomeLandLuaModule.ReceiveLetter(cfgLetter.SoulId, self.currentLetterID)
	end
end

function HomeLandGirlRewardUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandGirlRewardUI)
end

return HomeLandGirlRewardUI
