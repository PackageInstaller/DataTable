-- chunkname: @IQIGame\\UI\\SoulMarryAvPlayUI.lua

local SoulMarryAvPlayUI = {
	ChangePageEffectPlayId = 0
}

SoulMarryAvPlayUI = Base:Extend("SoulMarryAvPlayUI", "IQIGame.Onigao.UI.SoulMarryAvPlayUI", SoulMarryAvPlayUI)

require("IQIGame.UI.AVPro.AVProVideoView")

function SoulMarryAvPlayUI:OnInit()
	function self.delegateOnPlayMovieLoad(data)
		self:OnPlayMovieLoad(data)
	end

	function self.delegateOnPlayMovieComplete(data)
		self:OnPlayMovieComplete(data)
	end
end

function SoulMarryAvPlayUI:GetPreloadAssetPaths()
	return nil
end

function SoulMarryAvPlayUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SoulMarryAvPlayUI:IsManualShowOnOpen(userData)
	return false
end

function SoulMarryAvPlayUI:GetBGM(userData)
	return nil
end

function SoulMarryAvPlayUI:OnOpen(userData)
	self.cfgSoulMarry = userData

	self:PlayMovie()

	self.closeEffectTimer = Timer.New(function()
		self.ChangePageEffectPlayId = GameEntry.Effect:PlayUIMountPointEffect(9008004, 50000, 0, self.SpineEffectPoint, self.UIController:GetComponent("Canvas").sortingOrder + 1)
	end, 24)

	self.closeEffectTimer:Start()
	EventDispatcher.Dispatch(EventID.StopBGM)
	EventDispatcher.Dispatch(EventID.L2DPause)
end

function SoulMarryAvPlayUI:OnClose(userData)
	if self.ChangePageEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.ChangePageEffectPlayId)

		self.ChangePageEffectPlayId = 0
	end

	if self.closeEffectTimer then
		self.closeEffectTimer:Stop()
	end

	self.closeEffectTimer = nil

	EventDispatcher.Dispatch(EventID.L2DResume)
	EventDispatcher.Dispatch(EventID.RestoreBGM)
end

function SoulMarryAvPlayUI:OnAddListeners()
	return
end

function SoulMarryAvPlayUI:OnRemoveListeners()
	return
end

function SoulMarryAvPlayUI:OnPause()
	return
end

function SoulMarryAvPlayUI:OnResume()
	return
end

function SoulMarryAvPlayUI:OnCover()
	return
end

function SoulMarryAvPlayUI:OnReveal()
	return
end

function SoulMarryAvPlayUI:OnRefocus(userData)
	return
end

function SoulMarryAvPlayUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SoulMarryAvPlayUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulMarryAvPlayUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulMarryAvPlayUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulMarryAvPlayUI:OnDestroy()
	self.avProVideoView:DisPose()
end

function SoulMarryAvPlayUI:PlayMovie()
	local path = self.cfgSoulMarry.MarryMovie

	if string.sub(path, 1, 1) == "/" then
		path = string.sub(path, 2)
	end

	self.videoPath = {
		path
	}
	self.avProVideoView = AVProVideoView.New()

	self.avProVideoView:LoadAVPro(self.VideoNode, 1, self.videoPath[1])

	self.avProVideoView.loadComplete = self.delegateOnPlayMovieLoad
	self.avProVideoView.playComplete = self.delegateOnPlayMovieComplete
end

function SoulMarryAvPlayUI:OnPlayMovieLoad(data)
	self.avProVideoView:PlayVideo(false)
end

function SoulMarryAvPlayUI:OnPlayMovieComplete(data)
	self.avProVideoView:Pause()
	UIModule.Close(Constant.UIControllerName.SoulMarryAvPlayUI)
	UIModule.Open(Constant.UIControllerName.SoulMarryCgShowUI, Constant.UILayer.UI, self.cfgSoulMarry)
end

return SoulMarryAvPlayUI
