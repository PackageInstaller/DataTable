-- chunkname: @IQIGame\\UI\\ActivitySignUI.lua

local ActivitySignUI = {
	weekCellPool = {},
	dayCellPool = {},
	detailCellPool = {},
	signSignInCellPool = {}
}

ActivitySignUI = Base:Extend("ActivitySignUI", "IQIGame.Onigao.UI.ActivitySignUI", ActivitySignUI)

local DayCell = require("IQIGame.UI.ActivitySign.DayCell")
local DayDetailCell = require("IQIGame.UI.ActivitySign.DayDetailCell")

function ActivitySignUI:OnInit()
	self:Initialize()
end

function ActivitySignUI:GetPreloadAssetPaths()
	return nil
end

function ActivitySignUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ActivitySignUI:IsManualShowOnOpen(userData)
	return false
end

function ActivitySignUI:GetBGM(userData)
	return nil
end

function ActivitySignUI:OnOpen(userData)
	self:Refresh(userData)
end

function ActivitySignUI:OnClose(userData)
	self:OnHide()
end

function ActivitySignUI:OnPause()
	return
end

function ActivitySignUI:OnResume()
	return
end

function ActivitySignUI:OnCover()
	return
end

function ActivitySignUI:OnReveal()
	return
end

function ActivitySignUI:OnRefocus(userData)
	return
end

function ActivitySignUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ActivitySignUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ActivitySignUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ActivitySignUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ActivitySignUI:Initialize()
	self.goWeekCell:GetComponent("Toggle").isOn = false

	for i = 1, 7 do
		local go = self.goWeekCell

		if i ~= 1 then
			go = UnityEngine.Object.Instantiate(self.goWeekCell)

			go.transform:SetParent(self.goWeekCell.transform.parent, false)
		end

		go:GetComponent("ToggleHelperComponent").text = ActivitySignUIApi:GetString("weekTxt", i)
		self.weekCellPool[i] = go
	end

	for i = 1, 6 do
		local transWeekRoot = self.calendarRoot.transform:Find("Grid_Week_0" .. i)

		for m = 1, 7 do
			local goDay = transWeekRoot:Find("Point_mould_0" .. m).gameObject

			self.dayCellPool[#self.dayCellPool + 1] = DayCell.New(goDay, self)
		end
	end

	self.tfLeftTitle2 = self.goLeftTitle2:GetComponent("Text")
	self.tfMonth = self.goMonth:GetComponent("Text")
	self.tfSignDesc = self.goSignDesc:GetComponent("Text")
	self.tfYear = self.goYear:GetComponent("Text")
	self.tfSignProgress = self.goSignProgress:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnClose2 = self.goBtnClose2:GetComponent("Button")
	self.btnSign = self.goBtnSign:GetComponent("Button")
	self.btnGetReward = self.goSignSignInCellLast:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickCloseBtn()
	end

	function self.onClickBtnSignDelegate()
		self:OnClickBtnSign()
	end

	function self.onClickBtnGetRewardDelegate()
		self:OnGetReward()
	end

	function self.onUpdateSignInDelegate()
		self:OnUpdateSignIn()
	end

	function self.onTaskUpdateDelegate(id)
		self:OnTaskUpdate(id)
	end

	function self.onTaskCommitSuccessDelegate(cids, awards)
		self:OnTaskCommitSuccess(cids, awards)
	end

	self.goLeftTitle1:GetComponent("Text").text = ActivitySignUIApi:GetString("leftTitle1")
	self.goSignProgressTitle:GetComponent("Text").text = ActivitySignUIApi:GetString("signProgressTitle")
	self.goBtnSign.transform:Find("Text"):GetComponent("Text").text = ActivitySignUIApi:GetString("btnSignTxt")
	self.goSignSigned.transform:Find("Text"):GetComponent("Text").text = ActivitySignUIApi:GetString("signedTxt")

	self.goDetailCell:SetActive(false)
end

function ActivitySignUI:Refresh(userData)
	self:RefreshDatum()
	self:RefreshCalendarBlock()
	self:RefreshSignBlock()
	self:RefreshSignProgressBlock()

	SignInModule.hasOpenedSignUI = true
end

function ActivitySignUI:OnHide()
	for i, v in pairs(self.dayCellPool) do
		v:OnHide()
	end
end

function ActivitySignUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.dayCellPool) do
		v:OnDestroy()
	end

	for i, v in pairs(self.detailCellPool) do
		v:OnDestroy()
	end
end

function ActivitySignUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnSign.onClick:AddListener(self.onClickBtnSignDelegate)
	self.btnGetReward.onClick:AddListener(self.onClickBtnGetRewardDelegate)
	EventDispatcher.AddEventListener(EventID.UpdateSignInEvent, self.onUpdateSignInDelegate)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.onTaskCommitSuccessDelegate)
end

function ActivitySignUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnSign.onClick:RemoveListener(self.onClickBtnSignDelegate)
	self.btnGetReward.onClick:RemoveListener(self.onClickBtnGetRewardDelegate)
	EventDispatcher.RemoveEventListener(EventID.UpdateSignInEvent, self.onUpdateSignInDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.onTaskCommitSuccessDelegate)
end

function ActivitySignUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function ActivitySignUI:OnGetReward()
	if self.taskData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and self.taskData.CurrentNum >= self.taskData.TaskStatus then
		TaskModule.SendCommitTaskMsg(self.taskData.cid)
	end
end

function ActivitySignUI:OnUpdateSignIn()
	self:RefreshDatum()
	self:RefreshCalendarBlock()
	self:RefreshSignBlock()
	self:RefreshSignProgressBlock()
end

function ActivitySignUI:OnTaskUpdate(id)
	self:RefreshSignProgressBlock()
end

function ActivitySignUI:OnTaskCommitSuccess(cids, awards)
	if #awards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, awards)
	end
end

function ActivitySignUI:OnClickBtnSign()
	SignInModule.ReqSign()
end

function ActivitySignUI:OnClickDayCell(cell)
	self.tfLeftTitle2.text = ActivitySignUIApi:GetString("leftTitle2", cell.curMonth, cell.day)

	for i, v in pairs(self.detailCellPool) do
		v:SetActive(false)
	end

	local detailCellNeedCount = 0
	local cfgSoulDatum = {}

	for i, v in ipairs(SoulModule.GetSortedSoulDataList()) do
		local cfgData = v:GetCfgSoul()
		local m, d = SignInModule.GetMonthDay(cfgData.BirthDay)

		if tonumber(m) == cell.curMonth and tonumber(d) == cell.day then
			cfgSoulDatum[#cfgSoulDatum + 1] = cfgData
		end
	end

	if #cfgSoulDatum > 0 then
		detailCellNeedCount = detailCellNeedCount + 1

		local detailCell = self:GetDetailCell(detailCellNeedCount)

		detailCell:RefreshBirthday(cfgSoulDatum)
	end

	local cfgSignInDatumFestival = {}
	local cfgSignInDatumActivity = {}

	if cell.cfgSignInData.HolidayName ~= "" or cell.cfgSignInData.FestivalName ~= "" then
		cfgSignInDatumFestival[#cfgSignInDatumFestival + 1] = cell.cfgSignInData
	end

	for j, k in ipairs(cell.cfgSignInData.EventName) do
		if k ~= "" then
			cfgSignInDatumActivity[#cfgSignInDatumActivity + 1] = cell.cfgSignInData
		end
	end

	if #cfgSignInDatumFestival > 0 then
		detailCellNeedCount = detailCellNeedCount + 1

		local detailCell = self:GetDetailCell(detailCellNeedCount)

		detailCell:RefreshFestival(cfgSignInDatumFestival)
	end

	if #cfgSignInDatumActivity > 0 then
		detailCellNeedCount = detailCellNeedCount + 1

		local detailCell = self:GetDetailCell(detailCellNeedCount)

		detailCell:RefreshActivity(cfgSignInDatumActivity)
	end

	local rewardDatum = {}

	for m, n in ipairs(cell.cfgSignInData.Reward) do
		if m % 2 ~= 0 then
			rewardDatum[#rewardDatum + 1] = {
				id = n,
				count = cell.cfgSignInData.Reward[m + 1]
			}
		end
	end

	if #rewardDatum > 0 then
		detailCellNeedCount = detailCellNeedCount + 1

		local detailCell = self:GetDetailCell(detailCellNeedCount)

		detailCell:RefreshReward(rewardDatum)
	end

	for i, v in pairs(self.dayCellPool) do
		v:SetSignSelectActive(false)
	end

	cell:SetSignSelectActive(true)
end

function ActivitySignUI:RefreshDatum()
	local serverTime = SignInModule.GetServerTime() + 2
	local dateTable = getDateTimeTable(serverTime)

	self.curYear = dateTable.year
	self.curMonth = dateTable.month
	self.curDayWeek = dateTable.wday - 1

	if self.curDayWeek == 0 then
		self.curDayWeek = 7
	end

	self.curDay = dateTable.day
end

function ActivitySignUI:RefreshCalendarBlock()
	local dayCount = SignInModule.GetDayByYearMonth(self.curYear, self.curMonth)
	local firstDayWeek = os.date("*t", os.time({
		day = 1,
		year = self.curYear,
		month = self.curMonth
	})).wday - 1

	if firstDayWeek == 0 then
		firstDayWeek = 7
	end

	local invalidDayCountInWeek = 0
	local day = 0
	local dayWeek = 0

	for i, v in ipairs(self.dayCellPool) do
		dayWeek = dayWeek + 1

		if firstDayWeek <= i and i < firstDayWeek + dayCount then
			day = day + 1

			v:Refresh(self.curYear, self.curMonth, self.curDay, day, dayWeek)
		else
			v:SetActive(false)

			invalidDayCountInWeek = invalidDayCountInWeek + 1
		end

		if dayWeek == 7 then
			v:SetParentActive(invalidDayCountInWeek ~= 7)

			invalidDayCountInWeek = 0
			dayWeek = 0
		end
	end

	for i, v in ipairs(self.weekCellPool) do
		v:GetComponent("Toggle").isOn = self.curDayWeek == i
	end

	self.calendarRoot.transform.anchoredPosition = Vector2.New(self.calendarRoot.transform.anchoredPosition.x, 0)

	if self.curDay + firstDayWeek - 1 >= 36 then
		self.calendarRoot.transform.anchoredPosition = Vector2.New(self.calendarRoot.transform.anchoredPosition.x, 93)
	end
end

function ActivitySignUI:RefreshSignBlock()
	self.tfMonth.text = ActivitySignUIApi:GetString("monthDesc", self.curMonth)
	self.tfSignDesc.text = ActivitySignUIApi:GetString("signDesc")
	self.tfYear.text = ActivitySignUIApi:GetString("yearDesc", self.curYear)

	self.goBtnSign:SetActive(not SignInModule.CheckIsSign(self.curDay))
	self.goSignSigned:SetActive(SignInModule.CheckIsSign(self.curDay))
end

function ActivitySignUI:RefreshSignProgressBlock()
	self.taskData = SignInModule.GetSignProgressTaskData()

	if self.taskData == nil then
		return
	end

	local cfgTaskData = CfgMainQuestTable[self.taskData.cid]

	for i, v in ipairs(self.signSignInCellPool) do
		v:SetActive(i <= self.taskData.TargetNum)
	end

	for i = 1, self.taskData.TargetNum - 1 do
		local go = self.signSignInCellPool[i]

		if go == nil then
			if i == 1 then
				go = self.goSignSignInCell
			else
				go = UnityEngine.Object.Instantiate(self.goSignSignInCell)
			end

			go.transform:SetParent(self.goSignSignInCell.transform.parent, false)

			self.signSignInCellPool[i] = go
		end

		go:SetActive(true)

		local signCur = go.transform:Find("Stage_01").gameObject
		local signInedState = go.transform:Find("Stage_02").gameObject

		signInedState:SetActive(i <= self.taskData.CurrentNum)
		signCur:SetActive(not SignInModule.CheckIsSign(self.curDay) and i == self.taskData.CurrentNum + 1)
	end

	local goSignCanGet = self.goSignSignInCellLast.transform:Find("Point_Red").gameObject
	local goSignGot = self.goSignSignInCellLast.transform:Find("Stage_01").gameObject
	local tfCount = self.goSignSignInCellLast.transform:Find("Text_01"):GetComponent("Text")
	local tfGot = self.goSignSignInCellLast.transform:Find("Stage_01/Text_02"):GetComponent("Text")
	local imgIcon = self.goSignSignInCellLast.transform:Find("Icon_Image"):GetComponent("Image")

	tfGot.text = ActivitySignUIApi:GetString("signGotTxt")
	self.tfSignProgress.text = ActivitySignUIApi:GetString("signProgress", self.taskData.CurrentNum, self.taskData.TargetNum)
	tfCount.text = ActivitySignUIApi:GetString("signProgressRewardCount", cfgTaskData.Reward[2])

	goSignCanGet:SetActive(self.taskData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and self.taskData.CurrentNum >= self.taskData.TargetNum)
	goSignGot:SetActive(self.taskData.TaskStatus == TaskModule.TaskStatus.FINISH_TASK)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[cfgTaskData.Reward[1]].Icon), imgIcon)
end

function ActivitySignUI:GetDetailCell(index)
	local ret = self.detailCellPool[index]

	if ret == nil then
		local go = UnityEngine.Object.Instantiate(self.goDetailCell)

		go.transform:SetParent(self.goDetailCell.transform.parent, false)

		ret = DayDetailCell.New(go)
		self.detailCellPool[index] = ret
	end

	ret:SetActive(true)

	return ret
end

return ActivitySignUI
