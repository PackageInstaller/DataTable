-- chunkname: @IQIGame\\UI\\Map\\Area\\WorldAreaUI_WanFa.lua

local ElemView = {}

function ElemView.New(view)
	local obj = Clone(ElemView)

	obj:__Init(view)

	return obj
end

function ElemView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	UIEventUtil.AddClickEventListener_Button(self, "TZYDBtn", self.__OnButton1ClickHandler)
	UIEventUtil.AddClickEventListener_Button(self, "MazeBtn", self.__OnMazeBtnClickHandler)
	UIEventUtil.AddClickEventListener_Button(self, "ChallengeWorldBossBtn", self.__OnChallengeWorldBossBtnClickHandler)
end

function ElemView:__OnButton1ClickHandler()
	if not self.paTaFunOpen then
		NoticeModule.ShowNotice(55007)

		return
	end

	UIModule.Open(Constant.UIControllerName.LoopTowerDungeonUI, Constant.UILayer.UI)
end

function ElemView:__OnMazeBtnClickHandler()
	if not self.mazeFunOpen then
		NoticeModule.ShowNoticeByType(Constant.NoticeType.RightFloatTips, self.noticeStr)

		return
	end

	local isClick = PlayerPrefsUtil.GetInt(PlayerModule.PlayerInfo.baseInfo.guid, "IsClickMazeDupBtn", 0) == 1

	if isClick then
		UIModule.Open(Constant.UIControllerName.MazeUI, Constant.UILayer.UI)
	else
		PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.guid, "IsClickMazeDupBtn", 1)
		NoticeModule.ShowNotice(80010, function()
			UIModule.Open(Constant.UIControllerName.MazeUI, Constant.UILayer.UI)
		end)
	end
end

function ElemView:__OnChallengeWorldBossBtnClickHandler()
	if not self.challengeWorldBossFuncOpen then
		NoticeModule.ShowNotice(55008)

		return
	end

	if not self.challengeWorldBossActivityOpen then
		return
	end

	ChallengeWorldBossModule.OpenChallengeWorldBossUI()
end

function ElemView:Show()
	self.gameObject:SetActive(true)

	local paTaCondition = CfgTowerChapterTable[20800001].UnlockConditionId

	self.paTaFunOpen = ConditionModule.Check(paTaCondition)

	self.TZYDLockRoot.gameObject:SetActive(not self.paTaFunOpen)

	local activityPod = ActivityModule.GetActivityPodByActivityTypeHasAll(Constant.ActivityType.ActivityType_Maze)

	self.mazeFunOpen = false
	self.noticeStr = ""

	if activityPod ~= nil and activityPod.stage ~= 0 then
		self.mazeFunOpen = true
	else
		self.mazeFunOpen = false

		local activityCfg = CfgActivityTable[activityPod.cid]

		if activityCfg == nil then
			self.mazeFunOpen = false
		else
			ForArray(activityCfg.ConditionIds, function(_index, _conditionId)
				if ConditionModule.Check(_conditionId) == false then
					self.noticeStr = CfgConditionTable[_conditionId].Name

					return true
				end
			end)
		end

		if LuaUtility.StrIsNullOrEmpty(self.noticeStr) or activityCfg == nil then
			self.noticeStr = ChapterUIApi:GetMazeOpenTips()
		end
	end

	self.MazeLockRoot.gameObject:SetActive(not self.mazeFunOpen)

	self.challengeWorldBossFuncOpen = ChallengeWorldBossModule.IsFuncOpen()

	self.ChallengeWorldBossBtn.gameObject:SetActive(true)

	if self.challengeWorldBossFuncOpen then
		self.challengeWorldBossActivityOpen = ChallengeWorldBossModule.IsActivityOpen()

		self.ChallengeWorldBossLockRoot.gameObject:SetActive(not self.challengeWorldBossActivityOpen)
		self.ChallengeWorldBossRestRoot.gameObject:SetActive(not self.challengeWorldBossActivityOpen)
	else
		self.ChallengeWorldBossLockRoot.gameObject:SetActive(true)
		self.ChallengeWorldBossRestRoot.gameObject:SetActive(false)
	end
end

function ElemView:Hide()
	self.gameObject:SetActive(false)
end

function ElemView:Dispose()
	UIEventUtil.ClearEventListener(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return ElemView
