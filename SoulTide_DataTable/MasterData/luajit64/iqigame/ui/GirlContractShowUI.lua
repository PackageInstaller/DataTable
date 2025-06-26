-- chunkname: @IQIGame\\UI\\GirlContractShowUI.lua

local GirlContractShowUI = Base:Extend("GirlContractShowUI", "IQIGame.Onigao.UI.GirlContractShowUI", {})

function GirlContractShowUI:OnInit()
	function self.delegateBtnContinue()
		self:OnBtnContinue()
	end
end

function GirlContractShowUI:GetPreloadAssetPaths()
	return nil
end

function GirlContractShowUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GirlContractShowUI:OnOpen(userData)
	self.soulData = userData[1]
	self.openType = userData[2]

	self:UpDateView()
end

function GirlContractShowUI:OnClose(userData)
	return
end

function GirlContractShowUI:OnAddListeners()
	self.BtnContinue:GetComponent("Button").onClick:AddListener(self.delegateBtnContinue)
end

function GirlContractShowUI:OnRemoveListeners()
	self.BtnContinue:GetComponent("Button").onClick:RemoveListener(self.delegateBtnContinue)
end

function GirlContractShowUI:OnPause()
	return
end

function GirlContractShowUI:OnResume()
	return
end

function GirlContractShowUI:OnCover()
	return
end

function GirlContractShowUI:OnReveal()
	return
end

function GirlContractShowUI:OnRefocus(userData)
	return
end

function GirlContractShowUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GirlContractShowUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GirlContractShowUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GirlContractShowUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GirlContractShowUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function GirlContractShowUI:UpDateView()
	local cfgSoulMarry = GirlModule.GetSoulOathData(self.soulData.soulCid)

	for i = 1, #cfgSoulMarry.StartImage do
		local path = UIGlobalApi.GetImagePath(cfgSoulMarry.StartImage[i])

		if self["Img" .. i] ~= nil then
			AssetUtil.LoadImage(self, path, self["Img" .. i]:GetComponent("Image"))
		end
	end

	local time = (GirlModule.soulOathPOD.dateData[5] - GirlModule.soulOathPOD.dateData[1]) / 1000

	if time < 0 then
		time = PlayerModule.GetServerTime() - GirlModule.soulOathPOD.dateData[1] / 1000
	end

	local textStr1 = string.format(cfgSoulMarry.StratWord[1], math.ceil(time / 3600))

	self.Text1:GetComponent("Text").text = textStr1

	local textStr2 = string.format(cfgSoulMarry.StratWord[2], GirlModule.soulOathPOD.countData[3])

	self.Text2:GetComponent("Text").text = textStr2

	local textStr3 = string.format(cfgSoulMarry.StratWord[3], GirlModule.soulOathPOD.countData[2])

	self.Text3:GetComponent("Text").text = textStr3

	local textStr4 = string.format(cfgSoulMarry.StratWord[4], GirlModule.soulOathPOD.countData[1])

	self.Text4:GetComponent("Text").text = textStr4

	local textStr5 = string.format(cfgSoulMarry.StratWord[5], "")

	self.Text5:GetComponent("Text").text = textStr5
end

function GirlContractShowUI:OnBtnContinue()
	local cfgSoulMarry = GirlModule.GetSoulOathData(self.soulData.soulCid)

	if self.openType == 1 then
		GirlModule.Connective(cfgSoulMarry.Id)
	else
		DialogModule.OpenDialog(cfgSoulMarry.DialogId)
	end

	UIModule.Close(Constant.UIControllerName.GirlContractShowUI)
end

return GirlContractShowUI
