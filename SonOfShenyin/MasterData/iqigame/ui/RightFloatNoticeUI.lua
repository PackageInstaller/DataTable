-- chunkname: @IQIGame\\UI\\RightFloatNoticeUI.lua

local RightFloatNoticeUI = {
	Timer = 0,
	isPlayAnim = false,
	DURATION = 2
}

RightFloatNoticeUI = Base:Extend("RightFloatNoticeUI", "IQIGame.Onigao.UI.RightFloatNoticeUI", RightFloatNoticeUI)

function RightFloatNoticeUI:OnInit()
	self.frameAnimation = self.Frame:GetComponent("Animation")
	self.DURATION = self.frameAnimation.clip.length
end

function RightFloatNoticeUI:GetPreloadAssetPaths()
	return nil
end

function RightFloatNoticeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RightFloatNoticeUI:IsManualShowOnOpen(userData)
	return false
end

function RightFloatNoticeUI:GetBGM(userData)
	return nil
end

function RightFloatNoticeUI:OnOpen(userData)
	self:UpdateView(userData)
	self:Reset()
end

function RightFloatNoticeUI:OnClose(userData)
	return
end

function RightFloatNoticeUI:OnAddListeners()
	return
end

function RightFloatNoticeUI:OnRemoveListeners()
	return
end

function RightFloatNoticeUI:OnPause()
	return
end

function RightFloatNoticeUI:OnResume()
	return
end

function RightFloatNoticeUI:OnCover()
	return
end

function RightFloatNoticeUI:OnReveal()
	return
end

function RightFloatNoticeUI:OnRefocus(userData)
	return
end

function RightFloatNoticeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.Timer < self.DURATION then
		self.Timer = self.Timer + realElapseSeconds
	else
		UIModule.Close(Constant.UIControllerName.RightFloatNoticeUI)
	end
end

function RightFloatNoticeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RightFloatNoticeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RightFloatNoticeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RightFloatNoticeUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function RightFloatNoticeUI:UpdateView(userData)
	local cfgNoticeData = CfgNoticeTable[userData.cid]

	if cfgNoticeData == nil then
		logColorInfo("没有找到 CfgNoticeTable 对应的Key=>" .. userData.cid, colorCode.Red)

		return
	end

	local content = string.format(cfgNoticeData.Describe, unpack(userData.args))

	AssetUtil.LoadImage(self, NoticeUIApi:GetStateImgPath(cfgNoticeData.SubType), self.StateImg:GetComponent("Image"))
	UGUIUtil.SetText(self.FloatItem, content)
	self.frameAnimation:Play()
end

function RightFloatNoticeUI:Reset()
	self.Timer = 0
end

return RightFloatNoticeUI
