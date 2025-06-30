-- chunkname: @IQIGame\\UI\\LibrarySoulInfoUI.lua

local LibrarySoulInfoUI = Base:Extend("LibrarySoulInfoUI", "IQIGame.Onigao.UI.LibrarySoulInfoUI", {
	isChangePage = true,
	stateCount = 2,
	showState = 1
})
local SoulSpineCell = require("IQIGame.UI.Common.SoulSpineCell")
local LibrarySoulL2DView = require("IQIGame.UI.Library.LibrarySoulL2DView")
local LibrarySoulNormalView = require("IQIGame.UI.Library.LibrarySoulNormalView")

require("IQIGame.UI.AVPro.AVProView")

function LibrarySoulInfoUI:OnInit()
	UGUIUtil.SetText(self.TextPanelTitle, LibrarySoulApi:GetString("TextPanelTitle"))
	UGUIUtil.SetText(self.TextLock, LibrarySoulApi:GetString("TextLock"))
	UGUIUtil.SetText(self.TextBtnJump, LibrarySoulApi:GetString("TextBtnJump"))

	self.btnChange = self.BtnChange:GetComponent("Button")
	self.btnJumpComponent = self.BtnJump:GetComponent("Button")

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateBtnRight()
		self:OnBtnRight()
	end

	function self.delegateBtnLeft()
		self:OnBtnLeft()
	end

	function self.delegateBtnChange()
		self:OnBtnChange()
	end

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

	self.live2DView = LibrarySoulL2DView.New(self.Live2D)
	self.soulNormalView = LibrarySoulNormalView.New(self.Normal, self)
	self.spineCell = SoulSpineCell.New(self.goSpineCell)
	self.avProView = AVProView.New()
	self.avProView.playCurtainEnterLoop = self.delegateOnPlayMovieLoad
	self.avProView.playComplete = self.delegateOnPlayMovieComplete
	self.avProView.videoError = self.delegateOnPlayMovieError

	function self.avProView.playCurtainEndComplete()
		self:OnSpineCurtainEnd()
	end
end

function LibrarySoulInfoUI:GetPreloadAssetPaths()
	return nil
end

function LibrarySoulInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LibrarySoulInfoUI:IsManualShowOnOpen(userData)
	return false
end

function LibrarySoulInfoUI:GetBGM(userData)
	return nil
end

function LibrarySoulInfoUI:OnOpen(userData)
	UIModule.BugFixL2dUIList[self.name] = self
	self.townLibrarySoulData = userData[1]
	self.isChangePage = userData[2]
	self.townSoul = TownLibraryModule.SoulTab
	self.showState = 1

	table.sort(self.townSoul, function(a, b)
		return a.cfgID < b.cfgID
	end)

	for i = 1, #self.townSoul do
		local soulData = self.townSoul[i]

		if soulData.cfgID == self.townLibrarySoulData.cfgID then
			self.index = i

			break
		end
	end

	self:UpdateView()
	self.Mask:SetActive(false)
	self.VideoBG:SetActive(false)
end

function LibrarySoulInfoUI:OnClose(userData)
	UIModule.BugFixL2dUIList[self.name] = nil

	self.live2DView:Dispose()
	self.soulNormalView:Close()
	self.Mask:SetActive(false)
	self.VideoBG:SetActive(false)
	self.spineCell:OnHide()
	EventDispatcher.Dispatch(EventID.L2DResume)
end

function LibrarySoulInfoUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateBtnRight)
	self.BtnChange:GetComponent("Button").onClick:AddListener(self.delegateBtnChange)
	self.btnJumpComponent.onClick:AddListener(self.delegateBtnJump)
end

function LibrarySoulInfoUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRight)
	self.BtnChange:GetComponent("Button").onClick:RemoveListener(self.delegateBtnChange)
	self.btnJumpComponent.onClick:RemoveListener(self.delegateBtnJump)
end

function LibrarySoulInfoUI:OnPause()
	return
end

function LibrarySoulInfoUI:OnResume()
	return
end

function LibrarySoulInfoUI:OnCover()
	return
end

function LibrarySoulInfoUI:OnReveal()
	return
end

function LibrarySoulInfoUI:OnRefocus(userData)
	return
end

function LibrarySoulInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.spineCell ~= nil then
		self.spineCell:OnUpdate()
	end
end

function LibrarySoulInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LibrarySoulInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibrarySoulInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibrarySoulInfoUI:OnDestroy()
	self.live2DView:OnDestroy()
	self.soulNormalView:Dispose()
	self.spineCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function LibrarySoulInfoUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.LibrarySoulInfoUI)
end

function LibrarySoulInfoUI:UpdateView()
	self.soulData = SoulModule.GetSoulData(self.townLibrarySoulData.cfgID)

	if self.soulData:GetCfgSoulRes2D().UISpineId > 0 then
		self.stateCount = 3
	else
		self.stateCount = 2
	end

	if self.showState > self.stateCount then
		self.showState = 2
	end

	if not self.townLibrarySoulData.isLock then
		self.showState = 2
	end

	UGUIUtil.SetText(self.TextBtnChange, LibrarySoulApi:GetString("TextBtnChange", self.showState))

	self.btnChange.interactable = self.townLibrarySoulData.isLock

	self.BtnLeft:SetActive(self.index ~= 1 and self.isChangePage)
	self.BtnRight:SetActive(self.index ~= #self.townSoul and self.isChangePage)
	self.Normal:SetActive(self.townLibrarySoulData.isLock)

	if self.townLibrarySoulData.isLock then
		self.soulNormalView:Open()
		self.soulNormalView:Update(self.townLibrarySoulData)
		self.Lock:SetActive(false)
		self.LockImg:SetActive(false)
	else
		self.soulNormalView:Close()
		self.Lock:SetActive(true)
		self.LockImg:SetActive(true)
	end

	self.Live2D:SetActive(self.showState == 1)
	self.Spine:SetActive(self.showState == 2)
	self.DressSpine:SetActive(self.showState == 3)

	if self.showState == 1 then
		self.live2DView:Refresh(self.soulData)
		self.soulNormalView:SetCVToggleVisible(1)
		self.spineCell:Close()
	elseif self.showState == 2 then
		self.soulNormalView:SetCVToggleVisible(2)
		self.spineCell:Close()
	else
		self.soulNormalView:SetCVToggleVisible(3)
		self.spineCell:Show(self.soulData.soulCid)
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.soulData:GetCfgSoulRes2D().SoulbookBg), self.ImgBG:GetComponent("Image"))
	end

	for i = 0, self.Spine.transform.childCount - 1 do
		local obj = self.Spine.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	AssetUtil.LoadAsset(self, UIGlobalApi.GetSoulPortraitPath(self.soulData.soulCid, self.soulData:GetCfgSoulRes2D().Id), self.OnLoadHeadSuccess)
end

function LibrarySoulInfoUI:OnLoadHeadSuccess(assetName, asset, duration, userData)
	local obj = UnityEngine.Object.Instantiate(asset)

	obj.transform:SetParent(self.Spine.transform, false)
	self.Spine:GetComponent("GrayComponent"):SetGray(not self.townLibrarySoulData.isLock)
end

function LibrarySoulInfoUI:OnBtnRight()
	self.index = self.index + 1

	if self.index > #self.townSoul then
		self.index = #self.townSoul
	end

	self.townLibrarySoulData = self.townSoul[self.index]

	self:UpdateView()
	EventDispatcher.Dispatch(EventID.UpdateLibraryPageEvent, {
		"LibrarySoulListUI",
		self.townLibrarySoulData
	})
end

function LibrarySoulInfoUI:OnBtnLeft()
	self.index = self.index - 1

	if self.index < 1 then
		self.index = 1
	end

	self.townLibrarySoulData = self.townSoul[self.index]

	self:UpdateView()
	EventDispatcher.Dispatch(EventID.UpdateLibraryPageEvent, {
		"LibrarySoulListUI",
		self.townLibrarySoulData
	})
end

function LibrarySoulInfoUI:OnBtnChange()
	self.showState = self.showState + 1

	if self.showState > self.stateCount then
		self.showState = 1
	end

	self.Live2D:SetActive(self.showState == 1)
	self.Spine:SetActive(self.showState == 2)
	self.DressSpine:SetActive(self.showState == 3)

	if self.showState == 1 then
		self.live2DView:Refresh(self.soulData)
		self.soulNormalView:SetCVToggleVisible(1)
		self.spineCell:Close()
	elseif self.showState == 2 then
		self.soulNormalView:SetCVToggleVisible(2)
		self.spineCell:Close()
	else
		self.soulNormalView:SetCVToggleVisible(3)
		self.spineCell:Show(self.soulData.soulCid)
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.soulData:GetCfgSoulRes2D().SoulbookBg), self.ImgBG:GetComponent("Image"))
	end

	UGUIUtil.SetText(self.TextBtnChange, LibrarySoulApi:GetString("TextBtnChange", self.showState))
end

function LibrarySoulInfoUI:PlayMovie(cfgCGInfo)
	if cfgCGInfo.MemoryType == 2 then
		MemoryStoryModule.EnterStory(cfgCGInfo.Scene, MemoryStoryModule.EntryType.LibrarySoulInfo, self.soulData.soulCid)

		return
	end

	if UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork then
		NoticeModule.ShowNotice(21043004, function()
			self.playCfgCG = cfgCGInfo

			self.Mask:SetActive(true)
			self.VideoBG:SetActive(true)
			self.avProView:Show(self.UIController.gameObject, self.curtainNode, self.VideoNode, cfgCGInfo.PlayPrefab, cfgCGInfo.CgLink)
		end, nil, self, cfgCGInfo.ResourceSize)

		return
	end

	self.playCfgCG = cfgCGInfo

	self.Mask:SetActive(true)
	self.VideoBG:SetActive(true)
	self.avProView:Show(self.UIController.gameObject, self.curtainNode, self.VideoNode, cfgCGInfo.PlayPrefab, cfgCGInfo.CgLink)
end

function LibrarySoulInfoUI:OnPlayMovieLoad(gameObj, mediaPlayer)
	self.live2DView:Pause()
	self.BtnJump:SetActive(true)

	if self.playCfgCG and self.playCfgCG.CGType == 3 then
		self:HideCurtainNode(true)
	end
end

function LibrarySoulInfoUI:OnPlayMovieComplete()
	self:HideCurtainNode(false)
	self.BtnJump:SetActive(false)
end

function LibrarySoulInfoUI:OnPlayMovieError()
	self:HideCurtainNode(false)
	self.BtnJump:SetActive(false)
	self:OnSpineCurtainEnd()
end

function LibrarySoulInfoUI:OnSpineCurtainEnd()
	self.Mask:SetActive(false)
	self.VideoBG:SetActive(false)
	self.live2DView:OnResumeL2D()
end

function LibrarySoulInfoUI:OnCloseMedia()
	self:HideCurtainNode(false)
	self.avProView:CloseVideo()
	self.BtnJump:SetActive(false)
end

function LibrarySoulInfoUI:HideCurtainNode(hide)
	if hide then
		self.curtainNode.transform.localScale = Vector3.New(0, 0, 0)
	else
		self.curtainNode.transform.localScale = Vector3.New(1, 1, 1)
	end
end

return LibrarySoulInfoUI
