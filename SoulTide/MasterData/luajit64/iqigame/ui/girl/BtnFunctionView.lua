-- chunkname: @IQIGame\\UI\\Girl\\BtnFunctionView.lua

local BtnFunctionView = {}

function BtnFunctionView.__New(ui, root)
	local o = Clone(BtnFunctionView)

	o:InitView(ui, root)

	return o
end

function BtnFunctionView:InitView(ui, root)
	self.goView = ui
	self.rootParent = root

	LuaCodeInterface.BindOutlet(self.goView, self)
	UGUIUtil.SetText(self.BtnDatingTxt, GirlUIApi:GetString("DatingTxt", 1))
	UGUIUtil.SetText(self.BtnDatingTxtEng, GirlUIApi:GetString("DatingTxt", 2))
	UGUIUtil.SetText(self.BtnNewMemoryTxt, GirlUIApi:GetString("NewMemoryTxt", 1))
	UGUIUtil.SetText(self.BtnNewMemoryTxtEng, GirlUIApi:GetString("NewMemoryTxt", 2))
	UGUIUtil.SetText(self.BtnMemoryTxt, GirlUIApi:GetString("MemoryTxt", 1))
	UGUIUtil.SetText(self.BtnMemoryTxtEng, GirlUIApi:GetString("MemoryTxt", 2))
	UGUIUtil.SetText(self.TextBtnPv, GirlUIApi:GetString("TextBtnPv"))

	self.btnMood = self.BtnMood:GetComponent("Button")
	self.btnDating = self.BtnDating:GetComponent("Button")
	self.btnNewMemory = self.BtnNewMemory:GetComponent("Button")
	self.btnMemory = self.BtnMemory:GetComponent("Button")
	self.btnPv = self.BtnPv:GetComponent("Button")

	function self.delegateBtnMood()
		self:OnBtnMood()
	end

	function self.delegateBtnDating()
		self:OnBtnDating()
	end

	function self.delegateBtnNewMemory()
		self:OnBtnNewMemory()
	end

	function self.delegateBtnMemory()
		self:OnBtnMemory()
	end

	function self.delegateBtnPv()
		self:OnBtnPv()
	end

	function self.delegateHandBookRedPointChange(soulCid)
		self:OnHandbookRedPointChange(soulCid)
	end

	self:AddEventListener()
end

function BtnFunctionView:GetCfgSoulMood(soulCid)
	for i, v in pairsCfg(CfgSoulMoodTable) do
		if v.SoulId == soulCid then
			return v
		end
	end

	return nil
end

function BtnFunctionView:UpdateView(data)
	self.soulData = data

	MemoryModule.RequestSoulMemoeryChapter(self.soulData.soulCid)
	MemoryNewModule.RequestGetSoulNewStory(self.soulData.soulCid)

	if self.soulData then
		local cfgSoul = self.soulData:GetCfgSoul()

		UGUIUtil.SetText(self.TextName, cfgSoul.Name)

		local state = SoulModule.GetMoodState(self.soulData.soulCid, self.soulData.mood)
		local path = GirlMoodUINoticeUIApi:GetString("StatePath", state)

		AssetUtil.LoadImage(self, path, self.ImgMood:GetComponent("Image"))

		local cfgMood = self:GetCfgSoulMood(self.soulData.soulCid)

		UGUIUtil.SetText(self.TextMoodValue, GirlUIApi:GetString("TextMoodValue", self.soulData.mood, cfgMood.MoodRange[2]))
		UGUIUtil.SetText(self.TextSpeed, GirlUIApi:GetString("TextMoodSpeed", self.soulData.moodTimeInterval))

		local result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.DATING)

		self.BtnDating:SetActive(result)

		local num, maxNum = DatingModule.GetOpenDatingEvent(self.soulData.soulCid)

		self.SliderDating:GetComponent("Image").fillAmount = num / maxNum

		UGUIUtil.SetText(self.TextDatingPer, GirlUIApi:GetString("TextPer", math.floor(num / maxNum * 100)))

		local lv = 1
		local isGray = true

		if result then
			local top, degreeLv = DatingModule.IsCanDatingBySoulID(self.soulData.soulCid)

			lv = degreeLv
			isGray = degreeLv > self.soulData.favorLv

			self.ImgDating:GetComponent("GrayComponent"):SetGray(isGray)
			self.SliderDating:SetActive(not isGray)
			self.TextDatingPer:SetActive(not isGray)
		end

		UGUIUtil.SetText(self.TextDatingTitle, GirlUIApi:GetString("TextPerTitle", isGray, lv))

		result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.NEWSTORY)

		self.BtnNewMemory:SetActive(result)

		num = MemoryNewModule.GetRewardMemoryStoryNum()
		maxNum = MemoryNewModule.GetMaxNewStoryNum(self.soulData.soulCid)
		self.SliderNewMemory:GetComponent("Image").fillAmount = num / maxNum

		UGUIUtil.SetText(self.TextNewMemoryPer, GirlUIApi:GetString("TextPer", math.floor(num / maxNum * 100)))

		isGray = true

		if result then
			local minLv = MemoryNewModule.GetUnlockNewStoryMinLv(self.soulData.soulCid)

			lv = minLv
			isGray = minLv > self.soulData.favorLv

			self.ImgNewMemory:GetComponent("GrayComponent"):SetGray(isGray)
			self.SliderNewMemory:SetActive(not isGray)
			self.TextNewMemoryPer:SetActive(not isGray)
		end

		UGUIUtil.SetText(self.TextNewMemoryTitle, GirlUIApi:GetString("TextPerTitle", isGray, lv))

		result = UnlockFunctionModule.IsUnlock(Constant.UnlockType.MEMORY)

		self.BtnMemory:SetActive(result)

		local list = MemoryModule.GetSoulChpaterList(self.soulData.soulCid)
		local haveList = MemoryModule.arrMemoryChapterInfoList
		local maxNum = #list
		local num = 0

		for i, v in pairs(haveList) do
			if v.isGetReward then
				num = num + 1
			end
		end

		self.SliderMemory:GetComponent("Image").fillAmount = num / maxNum

		UGUIUtil.SetText(self.TextMemoryPer, GirlUIApi:GetString("TextPer", math.floor(num / maxNum * 100)))

		isGray = true

		if result then
			local minLv = MemoryModule.GetUnlockMemoryMinLv(self.soulData.soulCid)

			lv = minLv
			isGray = minLv > self.soulData.favorLv

			self.ImgMemory:GetComponent("GrayComponent"):SetGray(isGray)
			self.SliderMemory:SetActive(not isGray)
			self.TextMemoryPer:SetActive(not isGray)
		end

		UGUIUtil.SetText(self.TextMemoryTitle, GirlUIApi:GetString("TextPerTitle", isGray, lv))

		local isMemoryRed = GirlModule.CheckRedMemory(self.soulData.soulCid)
		local isNewMemoryRed = MemoryNewModule.CheckRedNewMemory(self.soulData.soulCid)
		local isDatingRed = DatingModule.DatingSoulIsRed(self.soulData.soulCid)

		self.RedDating:SetActive(isDatingRed)
		self.RedNewMemory:SetActive(isNewMemoryRed)
		self.RedMemory:SetActive(isMemoryRed)

		self.cgPvID = nil

		for i, v in pairsCfg(CfgSoulBookTable) do
			if v.SoulId == self.soulData.soulCid and v.BookType == Constant.BookType.BookTypeMovie and CfgCGTable[v.CGCVId].CGType == 3 then
				self.cgPvID = v.CGCVId

				break
			end
		end

		self.BtnPv:SetActive(self.cgPvID ~= nil)
	end
end

function BtnFunctionView:AddEventListener()
	self.btnMood.onClick:AddListener(self.delegateBtnMood)
	self.btnDating.onClick:AddListener(self.delegateBtnDating)
	self.btnNewMemory.onClick:AddListener(self.delegateBtnNewMemory)
	self.btnMemory.onClick:AddListener(self.delegateBtnMemory)
	self.btnPv.onClick:AddListener(self.delegateBtnPv)
	EventDispatcher.AddEventListener(EventID.SoulHandbookRedPointChange, self.delegateHandBookRedPointChange)
end

function BtnFunctionView:RemoveEventListener()
	self.btnMood.onClick:RemoveListener(self.delegateBtnMood)
	self.btnDating.onClick:RemoveListener(self.delegateBtnDating)
	self.btnNewMemory.onClick:RemoveListener(self.delegateBtnNewMemory)
	self.btnMemory.onClick:RemoveListener(self.delegateBtnMemory)
	self.btnPv.onClick:RemoveListener(self.delegateBtnPv)
	EventDispatcher.RemoveEventListener(EventID.SoulHandbookRedPointChange, self.delegateHandBookRedPointChange)
end

function BtnFunctionView:OnUpdateFunctionViewRed(soulCid)
	if self.soulData ~= nil and self.soulData.soulCid == soulCid then
		local soulData = SoulModule.GetSoulData(soulCid)

		self:UpdateView(soulData)
	end
end

function BtnFunctionView:OnBtnMood()
	UIModule.Open(Constant.UIControllerName.GirlMoodUI, Constant.UILayer.UI, self.soulData)
end

function BtnFunctionView:OnBtnDating()
	local top, degreeLv = DatingModule.IsCanDatingBySoulID(self.soulData.soulCid)

	if not top then
		local cfgSoulFavorRender = self.soulData:GetCfgSoulFavor(degreeLv)

		NoticeModule.ShowNoticeByType(1, GirlUIApi:GetString("labLoveStageTxt", cfgSoulFavorRender.FavorDegree))

		return
	end

	UIModule.Open(Constant.UIControllerName.GirlDatingListUI, Constant.UILayer.UI, self.soulData.soulCid)
	self.rootParent.live2DView:Pause()
end

function BtnFunctionView:OnBtnNewMemory()
	local minLv = MemoryNewModule.GetUnlockNewStoryMinLv(self.soulData.soulCid)

	if minLv > self.soulData.favorLv then
		NoticeModule.ShowNoticeByType(1, GirlUIApi:GetString("UnlockNewMemoryLv", minLv))

		return
	end

	local unlock = MemoryNewModule.IsUnlockMemoryStoryInfo()

	if unlock == false then
		return
	end

	UIModule.Open(Constant.UIControllerName.NewMemoryUI, Constant.UILayer.UI, {
		self.soulData.soulCid
	})
end

function BtnFunctionView:OnBtnMemory()
	local minLv = MemoryModule.GetUnlockMemoryMinLv(self.soulData.soulCid)

	if minLv > self.soulData.favorLv then
		NoticeModule.ShowNoticeByType(1, GirlUIApi:GetString("UnlockMemoryLv", minLv))

		return
	end

	if MemoryModule.currentSoulChapterInfo == nil then
		return
	end

	UIModule.Open(Constant.UIControllerName.MemoryUI, Constant.UILayer.UI, self.soulData)
end

function BtnFunctionView:OnBtnPv()
	if self.cgPvID then
		UIModule.Open(Constant.UIControllerName.AvPlayUI, Constant.UILayer.UI, self.cgPvID)
	end
end

function BtnFunctionView:Dispose()
	self:RemoveEventListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return BtnFunctionView
