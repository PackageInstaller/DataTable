-- chunkname: @IQIGame\\UI\\SoulMarryCgShowUI.lua

local SoulMarryCgShowUI = {
	cvEnd = false,
	isWearThe = false,
	isSend = false,
	ChangePageEffectPlayId = 0
}

SoulMarryCgShowUI = Base:Extend("SoulMarryCgShowUI", "IQIGame.Onigao.UI.SoulMarryCgShowUI", SoulMarryCgShowUI)

local Live2DHarmoniousMask = require("IQIGame.UI.Common.Live2DHarmoniousMask")

function SoulMarryCgShowUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, SoulMarryCgShowUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextBtnContinue, SoulMarryCgShowUIApi:GetString("TextBtnContinue"))

	self.l2dBuilder = self.Live2D:GetComponent("L2DBuilderMainCity")
	self.cvFrame = CvUIFrame.New(self.CvFrame.transform:GetChild(0).gameObject, Constant.UIControllerName.SoulMarryCgShowUI)
	self.live2DHarmoniousMask = Live2DHarmoniousMask.New(self.Live2D)
	self.tweenAlpha = self.ImgIcon:GetComponent("TweenAlpha")

	function self.delegateTweenEnd()
		self:OnTweenEnd()
	end

	function self.delegateBtnPutOn()
		self:OnBtnPutOn()
	end

	function self.delegateSoulOathSuccess()
		self:OnOathSuccess()
	end

	function self.delegateBtnContinue()
		self:OnBtnContinue()
	end

	function self.delegateBtnFinish()
		self:OnBtnFinish()
	end
end

function SoulMarryCgShowUI:GetPreloadAssetPaths()
	return nil
end

function SoulMarryCgShowUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SoulMarryCgShowUI:IsManualShowOnOpen(userData)
	return false
end

function SoulMarryCgShowUI:GetBGM(userData)
	return 9
end

function SoulMarryCgShowUI:OnOpen(userData)
	UIModule.BugFixL2dUIList[self.name] = self
	self.cvEnd = false
	self.isSend = false
	self.isWearThe = false
	self.cfgSoulMarry = userData

	if GirlModule.soulOathPOD.activation then
		self.type = 2
	else
		self.type = 1
	end

	self:RefreshL2D()
	self.HandNode:SetActive(false)
	self.CgNode:SetActive(false)
	self.Finish:SetActive(false)
	self.BtnContinue:SetActive(false)

	self.Finish:GetComponent("TweenAlpha").enabled = false

	local tweenP1 = self.HandAnimation:GetComponent("TweenPosition")
	local tweenP2 = self.BoxNode:GetComponent("TweenPosition")

	tweenP1.enabled = false

	tweenP1:ResetToBeginning()

	tweenP2.enabled = false

	tweenP2:ResetToBeginning()

	self.Live2DNode.transform.localScale = Vector3.New(0, 0, 0)

	local time = Timer.New(function()
		self:UpdateView()
	end, 7)

	time:Start()
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.cfgSoulMarry.CGShow1), self.ImgCG1:GetComponent("Image"))
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.cfgSoulMarry.CGShow2), self.ImgCG2:GetComponent("Image"))
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.cfgSoulMarry.CGShow3), self.ImgCG3:GetComponent("Image"))

	self.ChangePageEffectPlayId = GameEntry.Effect:PlayUIMountPointEffect(9008005, 50000, 0, self.SpineEffectPoint, self.UIController:GetComponent("Canvas").sortingOrder + 1)

	local timeCg = Timer.New(function()
		self.CgNode:SetActive(true)

		local animation = self.CgNode:GetComponent(typeof(UnityEngine.Animation))

		if animation ~= nil then
			animation:Play()
		end
	end, 1)

	timeCg:Start()
	EventDispatcher.Dispatch(EventID.L2DPause)
end

function SoulMarryCgShowUI:OnClose(userData)
	UIModule.BugFixL2dUIList[self.name] = nil

	if self.animationTimer then
		self.animationTimer:Stop()
	end

	self.animationTimer = nil

	if self.cvTimer then
		self.cvTimer:Stop()
	end

	self.cvTimer = nil

	if self.ChangePageEffectPlayId ~= 0 then
		GameEntry.Effect:StopEffect(self.ChangePageEffectPlayId)

		self.ChangePageEffectPlayId = 0
	end

	self.cvFrame:Dispose()
	EventDispatcher.Dispatch(EventID.L2DResume)
end

function SoulMarryCgShowUI:OnAddListeners()
	self.BtnPutOn:GetComponent("Button").onClick:AddListener(self.delegateBtnPutOn)
	self.BtnContinue:GetComponent("Button").onClick:AddListener(self.delegateBtnContinue)
	self.Finish:GetComponent("Button").onClick:AddListener(self.delegateBtnFinish)
	EventDispatcher.AddEventListener(EventID.SoulCompleteOathSuccess, self.delegateSoulOathSuccess)
end

function SoulMarryCgShowUI:OnRemoveListeners()
	self.BtnPutOn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnPutOn)
	self.BtnContinue:GetComponent("Button").onClick:RemoveListener(self.delegateBtnContinue)
	self.Finish:GetComponent("Button").onClick:RemoveListener(self.delegateBtnFinish)
	EventDispatcher.RemoveEventListener(EventID.SoulCompleteOathSuccess, self.delegateSoulOathSuccess)
end

function SoulMarryCgShowUI:OnPause()
	return
end

function SoulMarryCgShowUI:OnResume()
	return
end

function SoulMarryCgShowUI:OnCover()
	return
end

function SoulMarryCgShowUI:OnReveal()
	return
end

function SoulMarryCgShowUI:OnRefocus(userData)
	return
end

function SoulMarryCgShowUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SoulMarryCgShowUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulMarryCgShowUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulMarryCgShowUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulMarryCgShowUI:OnDestroy()
	self.live2DHarmoniousMask:Dispose()
	AssetUtil.UnloadAsset(self)
end

function SoulMarryCgShowUI:UpdateView()
	self.CgNode:SetActive(false)

	self.tweenAlpha.enabled = false

	self.tweenAlpha:ResetToBeginning()
	self.HandNode:SetActive(true)
	self.ImgIcon:SetActive(true)
	self.ImgRing1:SetActive(false)
	self.ImgRing2:SetActive(false)
	UGUIUtil.SetText(self.TextMsg, SoulMarryCgShowUIApi:GetString("TextMsg"))

	local path = UIGlobalApi.GetImagePath(self.cfgSoulMarry.RingIconComplete)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	AssetUtil.LoadImage(self, path, self.ImgRing1:GetComponent("Image"))
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.cfgSoulMarry.RingIconHalf), self.ImgRing2:GetComponent("Image"))

	if self.type == 2 then
		local timer = Timer.New(function()
			self:WearTheRing()
		end, 2)

		timer:Start()
	end
end

function SoulMarryCgShowUI:WearTheRing()
	self.isWearThe = true

	self.CgNode:SetActive(false)

	local animation = self.HandAnimation:GetComponent(typeof(UnityEngine.Animation))

	if animation ~= nil then
		animation:Stop()
	end

	self.tweenAlpha.enabled = true

	self.tweenAlpha:ResetToBeginning()
	self.tweenAlpha:PlayForward()
	self.tweenAlpha:SetOnFinished(self.delegateTweenEnd)
end

function SoulMarryCgShowUI:OnTweenEnd()
	self.tweenAlpha:RemoveOnFinished(self.delegateTweenEnd)

	self.tweenAlpha.enabled = false

	self.ImgIcon:SetActive(false)
	self.ImgRing1:SetActive(true)
	self.ImgRing2:SetActive(true)

	local animation = self.HandAnimation:GetComponent(typeof(UnityEngine.Animation))

	if animation ~= nil then
		animation:Play()
	end

	self.animationTimer = Timer.New(function()
		self:PlayCV()
	end, 2.5)

	self.animationTimer:Start()
end

function SoulMarryCgShowUI:OnBtnPutOn()
	if self.isWearThe then
		return
	end

	self:WearTheRing()
end

function SoulMarryCgShowUI:OnOathSuccess()
	local timer = Timer.New(function()
		self:MarrySuccess()
	end, 1)

	timer:Start()
end

function SoulMarryCgShowUI:OnBtnContinue()
	if self.cvEnd then
		local costID = self.cfgSoulMarry.CostItem[1]
		local have = WarehouseModule.GetItemNumByCfgID(costID)

		if have < self.cfgSoulMarry.CostItem[2] then
			NoticeModule.ShowNotice(21040078)

			return
		end

		if GirlModule.soulOathPOD.activation or self.isSend then
			return
		end

		GirlModule.Connective(self.cfgSoulMarry.Id)

		self.isSend = true
	end
end

function SoulMarryCgShowUI:PlayCV()
	local tweenP1 = self.HandAnimation:GetComponent("TweenPosition")
	local tweenP2 = self.BoxNode:GetComponent("TweenPosition")

	tweenP1.enabled = true

	tweenP1:PlayForward()

	tweenP2.enabled = true

	tweenP2:PlayForward()

	local tem = Timer.New(function()
		self.HandNode:SetActive(false)

		self.Live2DNode.transform.localScale = Vector3.New(1, 1, 1)

		local tweenAlpha = self.Live2DNode:GetComponent("TweenAlpha")

		tweenAlpha:ResetToBeginning()
		tweenAlpha:PlayForward()

		local t = Timer.New(function()
			local cfgCV = CfgCVTable[self.cfgSoulMarry.CVId]

			if self.cvTimer then
				self.cvTimer:Stop()
			end

			self.cvTimer = nil
			self.cvTimer = Timer.New(function()
				self.cvEnd = true

				self.BtnContinue:SetActive(true)

				if self.type == 2 then
					self:MarrySuccess()
				end
			end, cfgCV.TextTime)

			self.cvTimer:Start()

			if self.cfgSoulMarry.SoulMarryAction > 0 then
				GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.Dating, self.cfgSoulMarry.SoulMarryAction))
			end
		end, tweenAlpha.duration)

		t:Start()
	end, tweenP1.duration)

	tem:Start()
end

function SoulMarryCgShowUI:MarrySuccess()
	UGUIUtil.SetText(self.TextSuccess, SoulMarryCgShowUIApi:GetString("TextSuccess"))
	self.Finish:SetActive(true)

	local finishTween = self.Finish:GetComponent("TweenAlpha")

	finishTween.enabled = true

	finishTween:ResetToBeginning()
	finishTween:PlayForward()
end

function SoulMarryCgShowUI:RefreshL2D()
	local soulData = SoulModule.GetSoulData(self.cfgSoulMarry.SoulId)

	if soulData ~= nil then
		local cfgSoulResRow = soulData:GetCfgSoulRes2D()

		SoulModule.BuildL2D(self.l2dBuilder, soulData, soulData:GetCfgDress2D())
		self:SetL2DModelProperty(cfgSoulResRow)

		self.l2dBuilder.onShowCvUI = self.cvFrame.dgtOnShowCVUI
		self.l2dBuilder.onHideCvUI = self.cvFrame.dgtOnHideCVUI

		self.cvFrame:RefreshView(Vector3.New(cfgSoulResRow.DatingDialoguePosition[1], cfgSoulResRow.DatingDialoguePosition[2], cfgSoulResRow.DatingDialoguePosition[3]))
	end

	self.Live2D.transform.anchoredPosition3D = Vector3.zero
end

function SoulMarryCgShowUI:SetL2DModelProperty(cfgSoulResRow)
	self.l2dBuilder:SetModelPositionInImage(cfgSoulResRow.Live2DDatingUIModelPosition[1], cfgSoulResRow.Live2DDatingUIModelPosition[2], cfgSoulResRow.Live2DDatingUIModelPosition[3])
end

function SoulMarryCgShowUI:OnBtnFinish()
	UIModule.Close(Constant.UIControllerName.SoulMarryCgShowUI)
end

return SoulMarryCgShowUI
