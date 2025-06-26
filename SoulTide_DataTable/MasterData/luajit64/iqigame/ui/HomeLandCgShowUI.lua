-- chunkname: @IQIGame\\UI\\HomeLandCgShowUI.lua

local HomeLandCgShowUI = Base:Extend("HomeLandCgShowUI", "IQIGame.Onigao.UI.HomeLandCgShowUI", {})

function HomeLandCgShowUI:OnInit()
	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.TextBtnTitle:GetComponent("Text").text = HomeLandCgShowUIApi:GetString("TextBtnTitle")

	UGUIUtil.SetText(self.TextMsg, HomeLandCgShowUIApi:GetString("TextMsg"))

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end
end

function HomeLandCgShowUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandCgShowUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandCgShowUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandCgShowUI:GetBGM(userData)
	return nil
end

function HomeLandCgShowUI:OnOpen(userData)
	self.picUrl = userData[1]
	self.cgPicturePosition = userData[2]

	self:LoadPic()
end

function HomeLandCgShowUI:OnClose(userData)
	return
end

function HomeLandCgShowUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateClickBtnClose)
end

function HomeLandCgShowUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateClickBtnClose)
end

function HomeLandCgShowUI:OnPause()
	return
end

function HomeLandCgShowUI:OnResume()
	return
end

function HomeLandCgShowUI:OnCover()
	return
end

function HomeLandCgShowUI:OnReveal()
	return
end

function HomeLandCgShowUI:OnRefocus(userData)
	return
end

function HomeLandCgShowUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandCgShowUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandCgShowUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandCgShowUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandCgShowUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function HomeLandCgShowUI:LoadPic()
	self.ImgCG.transform.anchoredPosition = Vector2(self.cgPicturePosition[1], self.cgPicturePosition[2])

	if self.picUrl ~= nil then
		AssetUtil.LoadImage(self, self.picUrl, self.ImgCG:GetComponent("Image"))
	end
end

function HomeLandCgShowUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandCgShowUI)
end

return HomeLandCgShowUI
