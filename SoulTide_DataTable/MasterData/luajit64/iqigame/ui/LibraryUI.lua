-- chunkname: @IQIGame\\UI\\LibraryUI.lua

local LibraryUI = Base:Extend("LibraryUI", "IQIGame.Onigao.UI.LibraryUI", {
	isShowReward = false,
	isPlayOpenEffect = false
})
local LibraryBgmView = require("IQIGame.UI.Library.LibraryBgm.LibraryBgmView")

function LibraryUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, LibraryUIApi:GetString("Title"))
	UGUIUtil.SetText(self.TextGetAllReward, LibraryUIApi:GetString("TextBtnReceiveLibrary"))

	self.btnNpc = self.Mould1:GetComponent("Button")
	self.btnSoul = self.Mould2:GetComponent("Button")
	self.btnEquipment = self.Mould3:GetComponent("Button")
	self.btnMazes = self.Mould4:GetComponent("Button")
	self.btnStory = self.Mould5:GetComponent("Button")
	self.btnNewsPaper = self.Mould6:GetComponent("Button")

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateClickBtnNpc()
		self:OnClickBtnNpc()
	end

	function self.delegateClickBtnSoul()
		self:OnClickBtnSoul()
	end

	function self.delegateClickBtnEquipment()
		self:OnClickBtnEquipment()
	end

	function self.delegateClickBtnMaze()
		self:OnClickBtnMaze()
	end

	function self.delegateClickBtnStory()
		self:OnClickBtnStory()
	end

	function self.delegateClickBtnNewsPaper()
		self:OnClickBtnNewsPaper()
	end

	function self.delegateClickBtnGetAllReward()
		self:OnBtnGetAllReward()
	end

	function self.delegateBtnBgm()
		self:OnBtnBgm()
	end

	function self.delegateUpdateGetReward(data)
		self:OnGetReward(data)
	end

	function self.delegateTaskCommitResponse(cid, awards)
		self:OnTaskCommitResponse(cid, awards)
	end

	self.libraryBgmView = LibraryBgmView.New(self.BgmView, self)
end

function LibraryUI:GetPreloadAssetPaths()
	return nil
end

function LibraryUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LibraryUI:IsManualShowOnOpen(userData)
	return false
end

function LibraryUI:GetBGM(userData)
	local bgmID = self.libraryBgmView.bgmID

	return CfgLibraryBgmListTable[bgmID].SoundID
end

function LibraryUI:OnOpen(userData)
	self.isPlayOpenEffect = false

	self:UpdateView()
	self.libraryBgmView:Close()
	self:RefreshBgm()
end

function LibraryUI:OnClose(userData)
	self.libraryBgmView:Close()

	if self.openTimer then
		self.openTimer:Stop()
	end

	self.openTimer = nil
end

function LibraryUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
	self.btnNpc.onClick:AddListener(self.delegateClickBtnNpc)
	self.btnSoul.onClick:AddListener(self.delegateClickBtnSoul)
	self.btnEquipment.onClick:AddListener(self.delegateClickBtnEquipment)
	self.btnMazes.onClick:AddListener(self.delegateClickBtnMaze)
	self.btnStory.onClick:AddListener(self.delegateClickBtnStory)
	self.btnNewsPaper.onClick:AddListener(self.delegateClickBtnNewsPaper)
	self.BtnGetAllReward:GetComponent("Button").onClick:AddListener(self.delegateClickBtnGetAllReward)
	self.BtnBgm:GetComponent("Button").onClick:AddListener(self.delegateBtnBgm)
	EventDispatcher.AddEventListener(EventID.UpdateLibraryNewsEvent, self.delegateUpdateGetReward)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.delegateTaskCommitResponse)
end

function LibraryUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
	self.btnNpc.onClick:RemoveListener(self.delegateClickBtnNpc)
	self.btnSoul.onClick:RemoveListener(self.delegateClickBtnSoul)
	self.btnEquipment.onClick:RemoveListener(self.delegateClickBtnEquipment)
	self.btnMazes.onClick:RemoveListener(self.delegateClickBtnMaze)
	self.btnStory.onClick:RemoveListener(self.delegateClickBtnStory)
	self.btnNewsPaper.onClick:RemoveListener(self.delegateClickBtnNewsPaper)
	self.BtnGetAllReward:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnGetAllReward)
	self.BtnBgm:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBgm)
	EventDispatcher.RemoveEventListener(EventID.UpdateLibraryNewsEvent, self.delegateUpdateGetReward)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.delegateTaskCommitResponse)
end

function LibraryUI:OnPause()
	return
end

function LibraryUI:OnResume()
	return
end

function LibraryUI:OnCover()
	return
end

function LibraryUI:OnReveal()
	return
end

function LibraryUI:OnRefocus(userData)
	return
end

function LibraryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LibraryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LibraryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibraryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibraryUI:OnDestroy()
	self.libraryBgmView:Dispose()
end

function LibraryUI:UpdateView()
	for i = 1, 6 do
		self["Effect" .. i]:SetActive(false)
	end

	local num1, totalNum1 = TownLibraryModule.GetUnLockNPCRes()

	self:SetText(self.Mould1, num1, totalNum1, LibraryUIApi:GetString("TextToggle1"))

	local num2, totalNum2 = TownLibraryModule.GetUnLockSoulRes()

	self:SetText(self.Mould2, num2, totalNum2, LibraryUIApi:GetString("TextToggle2"))

	local num3, totalNum3 = TownLibraryModule.GetUnLockEquipmentRes()

	self:SetText(self.Mould3, num3, totalNum3, LibraryUIApi:GetString("TextToggle3"))

	local num4, totalNum4 = TownLibraryModule.GetUnLockMazesRes()

	self:SetText(self.Mould4, num4, totalNum4, LibraryUIApi:GetString("TextToggle4"))

	local num5, totalNum5 = TownLibraryModule.GetUnLockStoryRes()

	self:SetText(self.Mould5, num5, totalNum5, LibraryUIApi:GetString("TextToggle5"))

	local num6, totalNum6 = TownLibraryModule.GetUnLockNewsRes()

	self:SetText(self.Mould6, num6, totalNum6, LibraryUIApi:GetString("TextToggle6"))
	self:UpdateRedPoint()
end

function LibraryUI:SetText(goObj, num1, num2, str)
	if num1 > 0 then
		UGUIUtil.SetText(goObj.transform:Find("Panel/Text_01").gameObject, str)
	else
		UGUIUtil.SetText(goObj.transform:Find("Panel/Text_01").gameObject, LibraryUIApi:GetString("TextUnLock"))
	end
end

function LibraryUI:OnGetReward()
	self:UpdateView()
end

function LibraryUI:OnClickBtnSoul()
	self:PlayEffect(self.Effect2, function()
		local num, totalNum = TownLibraryModule.GetUnLockSoulRes()

		if num == 0 then
			NoticeModule.ShowNoticeByType(1, LibraryUIApi:GetString("Error", 2))

			return
		end

		UIModule.Open(Constant.UIControllerName.LibrarySoulListUI, Constant.UILayer.UI)
	end)
end

function LibraryUI:OnClickBtnNpc()
	self:PlayEffect(self.Effect1, function()
		local num, totalNum = TownLibraryModule.GetUnLockNPCRes()

		if num == 0 then
			NoticeModule.ShowNoticeByType(1, LibraryUIApi:GetString("Error", 1))

			return
		end

		UIModule.Open(Constant.UIControllerName.LibraryNpcListUI, Constant.UILayer.UI)
	end)
end

function LibraryUI:OnClickBtnEquipment()
	self:PlayEffect(self.Effect3, function()
		local num, totalNum = TownLibraryModule.GetUnLockEquipmentRes()

		if num == 0 then
			NoticeModule.ShowNoticeByType(1, LibraryUIApi:GetString("Error", 3))

			return
		end

		UIModule.Open(Constant.UIControllerName.LibraryEquipListUI, Constant.UILayer.UI)
	end)
end

function LibraryUI:OnClickBtnMaze()
	self:PlayEffect(self.Effect4, function()
		local num, totalNum = TownLibraryModule.GetUnLockMazesRes()

		if num == 0 then
			NoticeModule.ShowNoticeByType(1, LibraryUIApi:GetString("Error", 4))

			return
		end

		UIModule.Open(Constant.UIControllerName.LibraryMonsterEventUI, Constant.UILayer.UI)
	end)
end

function LibraryUI:OnClickBtnStory()
	self:PlayEffect(self.Effect5, function()
		local num, totalNum = TownLibraryModule.GetUnLockStoryRes()

		if num == 0 then
			NoticeModule.ShowNoticeByType(1, LibraryUIApi:GetString("Error", 5))

			return
		end

		UIModule.Open(Constant.UIControllerName.LibraryDialogListUI, Constant.UILayer.UI)
	end)
end

function LibraryUI:OnClickBtnNewsPaper()
	self:PlayEffect(self.Effect6, function()
		local num, totalNum = TownLibraryModule.GetUnLockNewsRes()

		if num == 0 then
			NoticeModule.ShowNoticeByType(1, LibraryUIApi:GetString("Error", 6))

			return
		end

		UIModule.Open(Constant.UIControllerName.LibraryNewsPaperUI, Constant.UILayer.UI)
	end)
end

function LibraryUI:PlayEffect(goObj, callBack)
	if self.isPlayOpenEffect then
		return
	end

	self.isPlayOpenEffect = true
	self.callBackFun = callBack

	goObj:SetActive(false)
	goObj:SetActive(true)

	self.openTimer = Timer.New(function()
		goObj:SetActive(false)

		self.isPlayOpenEffect = false

		if self.callBackFun ~= nil then
			self.callBackFun()
		end

		self.callBackFun = nil
	end, 2)

	self.openTimer:Start()
end

function LibraryUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.LibraryUI)
end

function LibraryUI:OnBtnGetAllReward()
	if #self.tasks > 0 then
		self.isShowReward = true

		TaskModule.SendCommitTaskMsgBatch(self.tasks)
	end
end

function LibraryUI:OnTaskCommitResponse(cid, awards)
	if self.isShowReward then
		local addItems = {}

		for i, v in pairs(awards) do
			if addItems[v.cid] == nil then
				addItems[v.cid] = {
					cid = v.cid,
					num = v.num
				}
			else
				addItems[v.cid].num = addItems[v.cid].num + v.num
			end
		end

		if #awards > 0 then
			NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, addItems)
		end
	end

	self.isShowReward = false

	self:UpdateRedPoint()
end

function LibraryUI:UpdateGetAllReward()
	self.tasks = {}

	for i, v in pairs(Constant.LibraryTaskType) do
		local tab = TownLibraryModule.GetLibraryTask(v)

		for i, v in pairs(tab) do
			if v.CurrentNum >= v.TargetNum and v.TaskStatus ~= TaskModule.TaskStatus.FINISH_TASK then
				table.insert(self.tasks, v.cid)
			end
		end
	end

	self.BtnGetAllReward:SetActive(false)
end

function LibraryUI:UpdateRedPoint()
	self:UpdateGetAllReward()

	local red = TownLibraryModule.GetRedPoint(Constant.LibraryTaskType.TaskTypeStory)

	if self.Red5 then
		self.Red5:SetActive(red)
	end

	red = TownLibraryModule.GetRedPoint(Constant.LibraryTaskType.TaskTypeMaze)

	if self.Red4 then
		self.Red4:SetActive(red)
	end

	red = TownLibraryModule.GetRedPoint(Constant.LibraryTaskType.TaskTypeEquipment)

	if self.Red3 then
		self.Red3:SetActive(red)
	end

	red = TownLibraryModule.GetRedPoint(Constant.LibraryTaskType.TaskTypeNews)

	if self.Red6 then
		self.Red6:SetActive(red)
	end
end

function LibraryUI:OnBtnBgm()
	self.libraryBgmView:Open()
end

function LibraryUI:RefreshBgm()
	local bgmID = self.libraryBgmView.bgmID
	local cfgData = CfgLibraryBgmListTable[bgmID]

	UGUIUtil.SetText(self.TextBgmName, cfgData.Name)
	UGUIUtil.SetText(self.TextBgmTime, cfgData.Time)
end

return LibraryUI
