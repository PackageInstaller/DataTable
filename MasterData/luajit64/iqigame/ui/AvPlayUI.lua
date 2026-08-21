-- chunkname: @IQIGame\\UI\\AvPlayUI.lua

local AvPlayUI = Base:Extend("AvPlayUI", "IQIGame.Onigao.UI.AvPlayUI", {})

require("IQIGame.UI.AVPro.AVProView")

function AvPlayUI:OnInit()
	UGUIUtil.SetText(self.TextBtnJump, AvPlayUIApi:GetString("TextBtnJump"))

	function self.delegateBtnJump()
		self:OnCloseMedia()
	end

	function self.delegateOnPlayMovieComplete()
		self:OnPlayMovieComplete()
	end

	function self.delegateOnPlayMovieLoad(x, y)
		self:OnPlayMovieLoad(x, y)
	end

	function self.delegateOnPlayMovieError()
		self:OnPlayMovieError()
	end

	self.avProView = AVProView.New()
	self.avProView.playCurtainEnterLoop = self.delegateOnPlayMovieLoad
	self.avProView.playComplete = self.delegateOnPlayMovieComplete
	self.avProView.videoError = self.delegateOnPlayMovieError

	function self.avProView.playCurtainEndComplete()
		self:OnSpineCurtainEnd()
	end
end

function AvPlayUI:GetPreloadAssetPaths()
	return nil
end

function AvPlayUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AvPlayUI:IsManualShowOnOpen(userData)
	return false
end

function AvPlayUI:GetBGM(userData)
	return nil
end

function AvPlayUI:OnOpen(userData)
	local cgID = userData

	self:PlayMovie(cgID)
	EventDispatcher.Dispatch(EventID.StopBGM)
	EventDispatcher.Dispatch(EventID.L2DPause)
end

function AvPlayUI:OnClose(userData)
	EventDispatcher.Dispatch(EventID.L2DResume)
	EventDispatcher.Dispatch(EventID.RestoreBGM)
end

function AvPlayUI:OnAddListeners()
	self.BtnJump:GetComponent("Button").onClick:AddListener(self.delegateBtnJump)
end

function AvPlayUI:OnRemoveListeners()
	self.BtnJump:GetComponent("Button").onClick:RemoveListener(self.delegateBtnJump)
end

function AvPlayUI:OnPause()
	return
end

function AvPlayUI:OnResume()
	return
end

function AvPlayUI:OnCover()
	return
end

function AvPlayUI:OnReveal()
	return
end

function AvPlayUI:OnRefocus(userData)
	return
end

function AvPlayUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AvPlayUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AvPlayUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AvPlayUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AvPlayUI:OnDestroy()
	return
end

function AvPlayUI:PlayMovie(id)
	self.cfgCGInfo = CfgCGTable[id]

	if UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork then
		NoticeModule.ShowNotice(21043004, function()
			self.playCfgCG = self.cfgCGInfo

			self.Mask:SetActive(true)
			self.avProView:Show(self.UIController.gameObject, self.curtainNode, self.VideoNode, self.cfgCGInfo.PlayPrefab, self.cfgCGInfo.CgLink)
		end, function()
			self:CloseUI()
		end, self, self.cfgCGInfo.ResourceSize)

		return
	end

	self.Mask:SetActive(true)
	self.avProView:Show(self.UIController.gameObject, self.curtainNode, self.VideoNode, self.cfgCGInfo.PlayPrefab, self.cfgCGInfo.CgLink)
end

function AvPlayUI:OnPlayMovieLoad(gameObj, mediaPlayer)
	self.BtnJump:SetActive(true)

	if self.cfgCGInfo and self.cfgCGInfo.CGType == 3 then
		self:HideCurtainNode(true)
	end
end

function AvPlayUI:HideCurtainNode(hide)
	if hide then
		self.curtainNode.transform.localScale = Vector3.New(0, 0, 0)
	else
		self.curtainNode.transform.localScale = Vector3.New(1, 1, 1)
	end
end

function AvPlayUI:OnPlayMovieComplete()
	self:HideCurtainNode(false)
	self.BtnJump:SetActive(false)
end

function AvPlayUI:OnPlayMovieError()
	self:HideCurtainNode(false)
	self.BtnJump:SetActive(false)
	self:OnSpineCurtainEnd()
end

function AvPlayUI:OnSpineCurtainEnd()
	self:HideCurtainNode(false)
	self.Mask:SetActive(false)
	self:CloseUI()
end

function AvPlayUI:OnCloseMedia()
	self:HideCurtainNode(false)
	self.avProView:CloseVideo()
	self.BtnJump:SetActive(false)
end

function AvPlayUI:CloseUI()
	UIModule.Close(Constant.UIControllerName.AvPlayUI)
end

return AvPlayUI
