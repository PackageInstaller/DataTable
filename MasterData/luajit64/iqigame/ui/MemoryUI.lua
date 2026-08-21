-- chunkname: @IQIGame\\UI\\MemoryUI.lua

require("IQIGame.UI.Memory.MemoryFragment")
require("IQIGame.UI.AVPro.AVProView")

local MemoryChooseChapterView = require("IQIGame.UI.Memory.MemoryChooseChapterView")
local MemoryUI = Base:Extend("MemoryUI", "IQIGame.Onigao.UI.MemoryUI", {
	isOpenUIAttribute = false,
	openNum = 0,
	isNextChapter = false,
	isMove = false,
	isGoingToOpenRewardView = false,
	btnGiftEffectId = 9000301,
	isGoingToOpenFashingView = false,
	btnRewardEffectId = 9000001,
	effectTable = {}
})
local MemoryUnlockView = require("IQIGame.UI.Memory.MemoryUnlockView")

function MemoryUI:OnInit()
	self:Init()
end

function MemoryUI:GetPreloadAssetPaths()
	return nil
end

function MemoryUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MemoryUI:GetBGM(userData)
	return MemoryUIApi:GetString("MemoryUIBGM")
end

function MemoryUI:OnOpen(userData)
	self.soulData = userData

	self.Mask:SetActive(false)
	self.BGMask:SetActive(false)
	MemoryModule.SetLastChapter()
	self:RefreshAllMemoryFragments()
	self:RefreshAllButtons()
	self.chooseChapterView:UpdateView()
	self.moneyCell:RefreshView({
		Constant.ItemID.MONEY,
		Constant.ItemID.TREASURE
	})
end

function MemoryUI:OnClose(userData)
	self.Mask:SetActive(false)
	self.BGMask:SetActive(false)

	for k, fragment in pairs(self.arrAllFragmentsList) do
		fragment:CloseUI()
	end

	EventDispatcher.Dispatch(EventID.MemoryUICloseEvent)
end

function MemoryUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.MemoryCurrentChapterChangedEvent, self.delegateOnMemoryChapterChanged)
	EventDispatcher.AddEventListener(EventID.MemoryActiveMemoryFragmentSuccessEvent, self.delegateOnMemoryActiveMemoryFragmentSuccess)
	EventDispatcher.AddEventListener(EventID.MemoryExperienceSuccessEvent, self.delegateOnMemoryExperienceSuccess)
	EventDispatcher.AddEventListener(EventID.MemoryGetRewardEvent, self.delegateOnMemoryGetReward)
	self.btnBack.onClick:AddListener(self.delegateOnClickBtnBack)
	self.btnPlayMovie.onClick:AddListener(self.delegateOnClickBtnPlayMovie)
	self.btn_PlayMovie_2:GetComponent("Button").onClick:AddListener(self.delegateOnClickBtnPlayMovie)
	self.btnGetReward.onClick:AddListener(self.delegateOnClickBtnGetReward)
	self.BtnAttribute:GetComponent("Button").onClick:AddListener(self.delegateBtnAttribute)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnBack)
	self.BtnCloseUnlock:GetComponent("Button").onClick:AddListener(self.delegateBtnCloseUnlockView)
end

function MemoryUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.MemoryCurrentChapterChangedEvent, self.delegateOnMemoryChapterChanged)
	EventDispatcher.RemoveEventListener(EventID.MemoryActiveMemoryFragmentSuccessEvent, self.delegateOnMemoryActiveMemoryFragmentSuccess)
	EventDispatcher.RemoveEventListener(EventID.MemoryExperienceSuccessEvent, self.delegateOnMemoryExperienceSuccess)
	EventDispatcher.RemoveEventListener(EventID.MemoryGetRewardEvent, self.delegateOnMemoryGetReward)
	self.btnBack.onClick:RemoveListener(self.delegateOnClickBtnBack)
	self.btnPlayMovie.onClick:RemoveListener(self.delegateOnClickBtnPlayMovie)
	self.btn_PlayMovie_2:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickBtnPlayMovie)
	self.btnGetReward.onClick:RemoveListener(self.delegateOnClickBtnGetReward)
	self.BtnAttribute:GetComponent("Button").onClick:RemoveListener(self.delegateBtnAttribute)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBack)
	self.BtnCloseUnlock:GetComponent("Button").onClick:RemoveListener(self.delegateBtnCloseUnlockView)
end

function MemoryUI:OnPause()
	return
end

function MemoryUI:OnResume()
	return
end

function MemoryUI:OnCover()
	return
end

function MemoryUI:OnReveal()
	return
end

function MemoryUI:OnRefocus(userData)
	return
end

function MemoryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if UIModule.HasUI(Constant.UIControllerName.MemoryAttributeUI) then
		self.isOpenUIAttribute = true

		self.MemoryPlayButtonLoop:SetActive(false)
	else
		self.isOpenUIAttribute = false

		self.MemoryPlayButtonLoop:SetActive(self.openNum == 4)
	end
end

function MemoryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MemoryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MemoryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MemoryUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for k, fragment in pairs(self.arrAllFragmentsList) do
		fragment:Dispose()
	end

	self.chooseChapterView:OnDestroy()
	self.memoryUnlockView:Dispose()
	self.moneyCell:Dispose()

	self.moneyCell = nil
end

function MemoryUI:Init()
	self.TextPanelTitle:GetComponent("Text").text = MemoryUIApi:GetString("TextTitle")

	UGUIUtil.SetText(self.TextBtnAttribute, MemoryUIApi:GetString("TextBtnAttribute"))
	UGUIUtil.SetText(self.TextBtnClose, MemoryUIApi:GetString("TextBtnClose"))

	self.SpineAction = {
		"End",
		"Play_Loop",
		"Start_FallDown",
		"Start_FallDown_Loop",
		"Start_Rise"
	}
	self.btnBack = self.btn_Back:GetComponent("Button")
	self.btnPlayMovie = self.btn_PlayMovie:GetComponent("Button")
	self.btnGetReward = self.btn_GetReward:GetComponent("Button")

	function self.delegateBtnBack()
		self:OnCloseMedia()
	end

	function self.delegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.delegateOnClickBtnPlayMovie()
		self:OnClickBtnPlayMovie()
	end

	function self.delegateOnClickBtnFashion()
		self:OnClickBtnFashion()
	end

	function self.delegateOnClickBtnGetReward()
		self:OnClickBtnGetReward()
	end

	function self.delegateBtnAttribute()
		self:OnClickBtnAttribute()
	end

	function self.delegateBtnCloseUnlockView()
		self:OnBtnCloseUnlockView()
	end

	function self.delegateOnMemoryChapterChanged()
		self:OnMemoryChapterChanged()
	end

	function self.delegateOnMemoryActiveMemoryFragmentSuccess()
		self:OnMemoryActiveMemoryFragmentSuccess()
	end

	function self.delegateOnMemoryExperienceSuccess()
		self:OnMemoryExperienceSuccess()
	end

	function self.delegateOnMemoryGetReward(fashionID)
		self:OnMemoryGetReward(fashionID)
	end

	self.BtnClose:SetActive(false)

	self.avProView = AVProView.New()

	function self.avProView.playComplete()
		self:OnPlayMovieComplete()
	end

	function self.avProView.loadComplete(x, y)
		self:OnPlayMovieLoad(x, y)
	end

	function self.avProView.playCurtainEnterLoop()
		self:OnSpineCurtainEnterLoop()
	end

	function self.avProView.playCurtainEndDownOver()
		self:OnSpineCurtainEndDownOver()
	end

	function self.avProView.playCurtainEndComplete()
		self:OnSpineCurtainEnd()
	end

	function self.avProView.videoError()
		self:OnPlayMovieError()
	end

	self.arrAllFragmentsList = {}

	table.insert(self.arrAllFragmentsList, MemoryFragment.New(self.ui_Fragment01, self))
	table.insert(self.arrAllFragmentsList, MemoryFragment.New(self.ui_Fragment02, self))
	table.insert(self.arrAllFragmentsList, MemoryFragment.New(self.ui_Fragment03, self))
	table.insert(self.arrAllFragmentsList, MemoryFragment.New(self.ui_Fragment04, self))

	self.chooseChapterView = MemoryChooseChapterView.__New(self.ChooseChapter, self)
	self.moneyCell = MoneyCellsBuilder.New(self.CurrencyContainer)
	self.memoryUnlockView = MemoryUnlockView.New(self.MemoryUnlock)

	self.memoryUnlockView:Close()
end

function MemoryUI:OnClickBtnBack()
	UIModule.Close(Constant.UIControllerName.MemoryUI)
end

function MemoryUI:OnClickBtnPrevChapter()
	local result, l, index = MemoryModule.IsToPrevChapter()

	if result == false then
		if l ~= nil then
			NoticeModule.ShowNoticeByType(1, MemoryUIApi:GetString("GetReachLifeLevelTxt", l.cfgChapter.UnlockFavorDegreeLevel))
		end

		return
	end

	if self.isMove then
		return
	end

	self.isMove = true
	self.isNextChapter = false
end

function MemoryUI:OnClickBtnNextChapter()
	local result, l, index = MemoryModule.IsToNextChapter()

	if result == false then
		if l ~= nil then
			NoticeModule.ShowNoticeByType(1, MemoryUIApi:GetString("TextMsg", l.UnlockFavorDegreeLevel))
		end

		return
	end

	if l == nil then
		NoticeModule.ShowNoticeByType(1, MemoryUIApi:GetString("GetNoGetGiftNextChapter"))

		return
	end

	self.isNextChapter = true

	if self.isNextChapter then
		MemoryModule.SetToNextChapter()
	end
end

function MemoryUI:OnClickBtnPlayMovie()
	if MemoryModule.currentSoulChapterInfo.cfgChapter.MemoryType == 2 then
		MemoryStoryModule.EnterStory(MemoryModule.currentSoulChapterInfo.cfgChapter.Scene, MemoryStoryModule.EntryType.Memory, MemoryModule.currentSoulChapterInfo.cfgChapter.SoulId)

		return
	end

	if UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork then
		NoticeModule.ShowNotice(21043004, function()
			self:PlayMovie()
		end, nil, self, MemoryModule.currentSoulChapterInfo.cfgChapter.ResourceSize)
	else
		self:PlayMovie()
	end
end

function MemoryUI:PlayMovie()
	self.Mask:SetActive(true)
	self.BGMask:SetActive(true)
	self.curtainNode:SetActive(true)
	self.VideoNode:SetActive(true)

	local curtainPath = MemoryModule.currentSoulChapterInfo.cfgChapter.PlayPrefab
	local url = MemoryModule.currentSoulChapterInfo.cfgChapter.Movie

	self.avProView:Show(self.View, self.curtainNode, self.VideoNode, curtainPath, url)
end

function MemoryUI:OnClickBtnFashion()
	local dressActive = MemoryModule.IsDressActive()

	if dressActive then
		local fashionID = MemoryModule.GetCurrentDressCId()

		MemoryModule.RequestComposeMemoryDress(fashionID)
	else
		local cfgSoulMemoryDressData = MemoryModule.GetCurrentCfgMemoryFashionData(MemoryModule.currentSoulID)

		MemoryModule.RequestGetSoulMemoryDressProgress(cfgSoulMemoryDressData.Id)

		self.isGoingToOpenFashingView = true
	end
end

function MemoryUI:OnClickLockPlay()
	local s = MemoryUIApi:GetString("GetLockPlayText")

	NoticeModule.ShowNoticeByType(1, s)
end

function MemoryUI:OnClickBtnGetReward()
	if MemoryModule.currentSoulChapterInfo == nil then
		return
	end

	self:OpenRewardPanel()
end

function MemoryUI:OpenRewardPanel()
	local cfgMemoryChapterInfo = CfgSoulMemoryChapterTable[MemoryModule.currentSoulChapterInfo.cid]
	local rewards = {}

	for i = 1, #cfgMemoryChapterInfo.MemoryReward - 1, 2 do
		table.insert(rewards, {
			id = cfgMemoryChapterInfo.MemoryReward[i],
			cid = cfgMemoryChapterInfo.MemoryReward[i],
			num = cfgMemoryChapterInfo.MemoryReward[i + 1]
		})
	end

	local canGetReward = false
	local unlockCount = #MemoryModule.currentSoulChapterInfo.arrUnlockPiecesCidsList
	local cfgMemoryChapterInfo = CfgSoulMemoryChapterTable[MemoryModule.currentSoulChapterInfo.cid]
	local fragmentCount = #cfgMemoryChapterInfo.PieceIdList

	if unlockCount == fragmentCount then
		canGetReward = not MemoryModule.currentSoulChapterInfo.isGetReward
	end

	local isSeeMovie = MemoryModule.currentSoulChapterInfo.isExperience

	if canGetReward == false or isSeeMovie == false then
		if isSeeMovie == false then
			NoticeModule.ShowNoticeByType(1, MemoryUIApi:GetString("GetLabRewardCheckTxt"))
		end

		UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
			Rewards = rewards,
			State = self.state
		})
	else
		MemoryModule.RequestGetRewards(MemoryModule.currentSoulChapterInfo.cid)
	end
end

function MemoryUI:RefreshAllButtons()
	local showPan2 = MemoryModule.currentSoulChapterInfo.cfgChapter.MemoryType == 2

	self.Panel1:SetActive(not showPan2)
	self.Panel2:SetActive(showPan2)

	local isChapterActived = MemoryModule.IsCurrentChapterActived()

	self:UpdateDesk(isChapterActived)

	if isChapterActived then
		self.btnPlayMovie.gameObject:SetActive(true)
		self.btn_PlayMovie_2:SetActive(true)
	else
		self.btnPlayMovie.gameObject:SetActive(false)
		self.btn_PlayMovie_2:SetActive(false)
	end

	if MemoryModule.currentSoulChapterInfo ~= nil then
		self:SetGetRewardBtnState()

		local tab = {}

		for i, v in pairsCfg(CfgSoulMemoryChapterTable) do
			if MemoryModule.currentSoulChapterInfo.cfgChapter.SoulId == v.SoulId then
				table.insert(tab, v)
			end
		end

		table.sort(tab, function(a, b)
			return a.Id < b.Id
		end)

		local next = MemoryModule.currentSouldChapterIndex + 1

		self.Tip:SetActive(true)

		if next > #tab then
			next = #tab

			self.Tip:SetActive(false)
		end

		local nextChapter = tab[next]

		UGUIUtil.SetText(self.MemoryCondition, MemoryUIApi:GetString("TextMsg", nextChapter.UnlockFavorDegreeLevel))
	end
end

function MemoryUI:OnMemoryChapterChanged()
	self:RefreshAllMemoryFragments()
	self:RefreshAllButtons()
end

function MemoryUI:OnMemoryActiveMemoryFragmentSuccess()
	self:RefreshAllMemoryFragments()
	self:OpenFragmentDetailView(self.curCfgFragmentData)

	local isChapterActived = MemoryModule.IsCurrentChapterActived()

	if isChapterActived then
		self.btnPlayMovie.gameObject:SetActive(true)
		self.btn_PlayMovie_2:SetActive(true)
	else
		self.btnPlayMovie.gameObject:SetActive(false)
		self.btn_PlayMovie_2:SetActive(false)
	end

	self:UpdateDesk(isChapterActived)
end

function MemoryUI:OnMemoryExperienceSuccess()
	self:RefreshAllButtons()
end

function MemoryUI:OnMemoryGetReward()
	self:RefreshAllButtons()

	if self.chooseChapterView then
		self.chooseChapterView:UpdateView()
	end
end

function MemoryUI:OnPlayMovieComplete()
	self.BtnClose:SetActive(false)
end

function MemoryUI:OnPlayMovieLoad(gameObj, mediaPlayer)
	self.Panel:SetActive(false)
end

function MemoryUI:OnPlayMovieError()
	self.BtnClose:SetActive(false)
	self:OnSpineCurtainEndDownOver()
	self:OnSpineCurtainEnd()
end

function MemoryUI:OpenFragmentRequirementView(cfgFragmentData)
	self.curCfgFragmentData = cfgFragmentData

	self.memoryUnlockView:Open(cfgFragmentData, false)
end

function MemoryUI:OpenFragmentDetailView(cfgFragmentData)
	self.memoryUnlockView:Open(cfgFragmentData, true)
end

function MemoryUI:RefreshAllMemoryFragments()
	local memoryChapterInfo = MemoryModule.currentSoulChapterInfo
	local cfgMemoryChapterInfo = CfgSoulMemoryChapterTable[memoryChapterInfo.cid]

	for k, fragment in pairs(self.arrAllFragmentsList) do
		fragment:CloseUI()
	end

	local num = 0

	if cfgMemoryChapterInfo ~= nil then
		for i = 1, #cfgMemoryChapterInfo.PieceIdList do
			local fragmentCid = cfgMemoryChapterInfo.PieceIdList[i]
			local isUnlock = MemoryModule.IsMemoryFragmentUnlock(fragmentCid)

			self.arrAllFragmentsList[i]:OpenUI(fragmentCid, isUnlock)
			self["MemoryLineLoop" .. i]:SetActive(isUnlock)

			if isUnlock then
				num = num + 1
			end
		end
	end

	self.openNum = num

	if num == 4 then
		self.MemoryPlayButtonLoop:SetActive(not self.isOpenUIAttribute)
		self.MemoryStarrySkyLoop:SetActive(true)
	else
		self.MemoryPlayButtonLoop:SetActive(false)
		self.MemoryStarrySkyLoop:SetActive(false)
	end
end

function MemoryUI:OnCloseMedia()
	self.avProView:CloseVideo()
	self.BtnClose:SetActive(false)
end

function MemoryUI:OnSpineCurtainEndDownOver()
	if MemoryModule.currentSoulChapterInfo ~= nil then
		self:SetGetRewardBtnState()
	end

	self.Panel:SetActive(true)

	if MemoryModule.currentSoulChapterInfo.isGetReward == false then
		MemoryModule.RequestExperienceMemory(MemoryModule.currentSoulChapterInfo.cid)
	end

	if MemoryModule.currentSoulChapterInfo.isNew then
		MemoryModule.RequestViewMemory(MemoryModule.currentSoulChapterInfo.cid)

		MemoryModule.currentSoulChapterInfo.isNew = false

		MemoryModule.UpdateMemoryIsNew(MemoryModule.currentSoulID, MemoryModule.currentSoulChapterInfo.cid, MemoryModule.currentSoulChapterInfo.isNew)
	end
end

function MemoryUI:OnSpineCurtainEnd()
	self.Mask:SetActive(false)
	self.BGMask:SetActive(false)
end

function MemoryUI:OnSpineCurtainEnterLoop()
	if GameEntry.Base.DevMode then
		self.BtnClose:SetActive(true)
	elseif not MemoryModule.currentSoulChapterInfo.isNew then
		self.BtnClose:SetActive(true)
	end
end

function MemoryUI:SetGetRewardBtnState()
	local currentChapter = MemoryModule.GetMemoryChapterInfoByCid(MemoryModule.currentSoulChapterInfo.cid)
	local unlockCount = #currentChapter.arrUnlockPiecesCidsList
	local cfgMemoryChapterInfo = CfgSoulMemoryChapterTable[currentChapter.cid]
	local fragmentCount = #cfgMemoryChapterInfo.PieceIdList
	local isSeeMovie = currentChapter.isExperience

	self.btn_GetReward.transform:Find("Image_02").gameObject:SetActive(false)
	self.btn_GetReward.transform:Find("Image_03").gameObject:SetActive(false)
	self.btn_GetReward.transform:Find("Image_04").gameObject:SetActive(false)

	if unlockCount == fragmentCount then
		if isSeeMovie == true then
			if currentChapter.isGetReward == true then
				self.btn_GetReward.transform:Find("Image_03").gameObject:SetActive(true)

				self.state = 1
			else
				self.btn_GetReward.transform:Find("Image_04").gameObject:SetActive(true)

				self.state = 2
			end
		else
			self.btn_GetReward.transform:Find("Image_02").gameObject:SetActive(true)

			self.state = 3
		end
	else
		self.btn_GetReward.transform:Find("Image_02").gameObject:SetActive(true)

		self.state = 3
	end
end

function MemoryUI:UpdateDesk(isUnlock)
	self.Back1:SetActive(not isUnlock)
	self.Back1_2:SetActive(not isUnlock)
	self.Back2:SetActive(isUnlock)
	self.Back2_2:SetActive(isUnlock)
	self.PanelText1:SetActive(not isUnlock)
	self.PanelText1_2:SetActive(not isUnlock)
	self.PanelText2:SetActive(isUnlock)
	self.PanelText2_2:SetActive(isUnlock)
	self.TextLockNode:SetActive(not isUnlock)
	self.TextLockNode_2:SetActive(not isUnlock)
	self.Play:SetActive(isUnlock)
	self.Play_2:SetActive(isUnlock)
end

function MemoryUI:SetMemoryChapterMsg(cfgMemoryChapter)
	UGUIUtil.SetText(self.PanelText1.transform:Find("Text_01/Text_Title").gameObject, MemoryUIApi:GetString("TextOrder", cfgMemoryChapter.Order))
	UGUIUtil.SetText(self.PanelText2.transform:Find("Text_01/Text_Title").gameObject, MemoryUIApi:GetString("TextOrder", cfgMemoryChapter.Order))
	UGUIUtil.SetText(self.PanelText1.transform:Find("Text_02/Text_01").gameObject, cfgMemoryChapter.Name)
	UGUIUtil.SetText(self.PanelText1.transform:Find("Text_02/Text_02").gameObject, cfgMemoryChapter.Name)
	UGUIUtil.SetText(self.PanelText2.transform:Find("Text_02/Text_01").gameObject, cfgMemoryChapter.Name)
	UGUIUtil.SetText(self.PanelText2.transform:Find("Text_02/Text_02").gameObject, cfgMemoryChapter.Name)
	UGUIUtil.SetText(self.PanelText1.transform:Find("Text_03").gameObject, "Story")
	UGUIUtil.SetText(self.PanelText2.transform:Find("Text_03").gameObject, "Story")
	UGUIUtil.SetText(self.PanelText1_2.transform:Find("Text_01/Text_Title").gameObject, MemoryUIApi:GetString("TextOrder", cfgMemoryChapter.Order))
	UGUIUtil.SetText(self.PanelText2_2.transform:Find("Text_01/Text_Title").gameObject, MemoryUIApi:GetString("TextOrder", cfgMemoryChapter.Order))
	UGUIUtil.SetText(self.PanelText1_2.transform:Find("Text_02/Text_01").gameObject, cfgMemoryChapter.Name)
	UGUIUtil.SetText(self.PanelText1_2.transform:Find("Text_02/Text_02").gameObject, cfgMemoryChapter.Name)
	UGUIUtil.SetText(self.PanelText2_2.transform:Find("Text_02/Text_01").gameObject, cfgMemoryChapter.Name)
	UGUIUtil.SetText(self.PanelText2_2.transform:Find("Text_02/Text_02").gameObject, cfgMemoryChapter.Name)
	UGUIUtil.SetText(self.PanelText1_2.transform:Find("Text_03").gameObject, "Story")
	UGUIUtil.SetText(self.PanelText2_2.transform:Find("Text_03").gameObject, "Story")
	UGUIUtil.SetText(self.TextLock, MemoryUIApi:GetString("TextLock"))
	UGUIUtil.SetText(self.TextLock_2, MemoryUIApi:GetString("TextLock"))
	UGUIUtil.SetText(self.TextLockDes, MemoryUIApi:GetString("TextLockDes"))
	UGUIUtil.SetText(self.TextLockDes_2, MemoryUIApi:GetString("TextLockDes"))
	UGUIUtil.SetText(self.TextUnLock, MemoryUIApi:GetString("TextUnLock"))
	UGUIUtil.SetText(self.TextUnLock_2, MemoryUIApi:GetString("TextUnLock_2", self.state))
	UGUIUtil.SetText(self.TextUnLockDes, MemoryUIApi:GetString("TextUnLockDes"))
	UGUIUtil.SetText(self.TextUnLockDes_2, MemoryUIApi:GetString("TextUnLockDes"))

	local path = UIGlobalApi.GetImagePath(cfgMemoryChapter.ImageCover)

	AssetUtil.LoadImage(self, path, self.ImgBg:GetComponent("Image"))
end

function MemoryUI:OnClickBtnAttribute()
	UIModule.Open(Constant.UIControllerName.MemoryAttributeUI, Constant.UILayer.UI, {
		self.soulData.soulCid
	})
end

function MemoryUI:OnBtnCloseUnlockView()
	self.memoryUnlockView:OnClickBtnClose()
end

return MemoryUI
