-- chunkname: @IQIGame\\UI\\ComExcessiveUI.lua

local ComExcessiveUI = Base:Extend("ComExcessiveUI", "IQIGame.Onigao.UI.ComExcessiveUI", {
	twPool = {}
})

function ComExcessiveUI:OnInit()
	self:Initialize()
end

function ComExcessiveUI:GetPreloadAssetPaths()
	return nil
end

function ComExcessiveUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ComExcessiveUI:OnOpen(userData)
	self:Refresh(userData)
end

function ComExcessiveUI:OnClose(userData)
	self:OnHide()
	ModuleTimerUtil.Stop(Constant.UIControllerName.ComExcessiveUI)
end

function ComExcessiveUI:OnPause()
	return
end

function ComExcessiveUI:OnResume()
	return
end

function ComExcessiveUI:OnCover()
	return
end

function ComExcessiveUI:OnReveal()
	return
end

function ComExcessiveUI:OnRefocus(userData)
	return
end

function ComExcessiveUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ComExcessiveUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ComExcessiveUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ComExcessiveUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ComExcessiveUI:Initialize()
	self.twAlphaBg = self.goBg:GetComponent("TweenAlpha")
	self.twPositionTop = self.goTop:GetComponent("TweenPosition")
	self.twPositionBottom = self.goBottom:GetComponent("TweenPosition")
	self.twPool[1] = self.twAlphaBg
	self.twPool[2] = self.twPositionBottom
	self.twPool[3] = self.twPositionTop

	function self.onTwAlphaFinishedDelegate()
		self:OnTwAlphaFinished()
	end
end

function ComExcessiveUI:Refresh(userData)
	if userData == nil then
		return
	end

	self.onFadeFinishedDelegate = userData[1]

	self:PlayTween()
end

function ComExcessiveUI:OnHide()
	return
end

function ComExcessiveUI:OnDestroy()
	return
end

function ComExcessiveUI:OnAddListeners()
	return
end

function ComExcessiveUI:OnRemoveListeners()
	return
end

function ComExcessiveUI:OnTwAlphaFinished()
	if self.onFadeFinishedDelegate ~= nil then
		self.onFadeFinishedDelegate()

		self.onFadeFinishedDelegate = nil
	end
end

function ComExcessiveUI:PlayTween()
	self:ResetTween()
	self.twPositionBottom:Play(true)
	self.twAlphaBg:Play(true)
	self.twPositionTop:Play(true)

	local timer = ModuleTimerUtil.NewTimer(Constant.UIControllerName.ComExcessiveUI, self.onTwAlphaFinishedDelegate, MiscApi:GetString("FadeDuration"))

	timer:Start()
end

function ComExcessiveUI:ResetTween()
	for i, v in pairs(self.twPool) do
		v.enabled = true

		v:ResetToBeginning()
	end
end

return ComExcessiveUI
