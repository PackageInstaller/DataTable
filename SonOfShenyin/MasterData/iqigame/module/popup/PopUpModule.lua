-- chunkname: @IQIGame\\Module\\PopUp\\PopUpModule.lua

local MainUIPopupAsyncData = {
	needPopup = false,
	complete = false,
	data = {}
}

function MainUIPopupAsyncData.New(key)
	local obj = Clone(MainUIPopupAsyncData)

	obj:__Init(key)

	return obj
end

function MainUIPopupAsyncData:__Init(key)
	self.key = key
	self.complete = false
	self.needPopup = false
	self.data = nil
end

function MainUIPopupAsyncData:Release()
	self.needPopup = false
	self.data = nil
end

PopUpModule = {
	isShowPopupWindowing = false,
	__MainUIPopupDataTable = {}
}

function PopUpModule.Initialize()
	log("弹窗系统 - Init.")
	PopUpModule.AddEventListeners()
end

function PopUpModule.Shutdown()
	log("弹窗系统 - Shutdown.")

	if PopUpModule.coroutine then
		PopUpModule.coroutine:Stop()

		PopUpModule.coroutine = nil
	end

	PopUpModule.__MainUIPopupDataTable = {}

	PopUpModule.RemoveEventListeners()
end

function PopUpModule.AddEventListeners()
	EventDispatcher.AddEventListener(EventID.PlayerLvChange, PopUpModule.LevelChange)
	EventDispatcher.AddEventListener(EventID.SpecialPopups, PopUpModule.SpecialPopups)
	EventDispatcher.AddEventListener(EventID.StoryChapterPopups, PopUpModule.StoryChapterPopups)
	EventDispatcher.AddEventListener(EventID.UIGroupTopUIChange, PopUpModule.__OnUIGroupTopUIChange)
	EventDispatcher.AddEventListener(EventID.MainUIVisible, PopUpModule.__OnMainUIVisible)
end

function PopUpModule.RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.PlayerLvChange, PopUpModule.LevelChange)
	EventDispatcher.RemoveEventListener(EventID.SpecialPopups, PopUpModule.SpecialPopups)
	EventDispatcher.RemoveEventListener(EventID.StoryChapterPopups, PopUpModule.StoryChapterPopups)
	EventDispatcher.RemoveEventListener(EventID.UIGroupTopUIChange, PopUpModule.__OnUIGroupTopUIChange)
	EventDispatcher.RemoveEventListener(EventID.MainUIVisible, PopUpModule.__OnMainUIVisible)
end

function PopUpModule.__OnUIGroupTopUIChange(groupName, uiName)
	if GuideModule.IsGuiding then
		return
	end

	local _uiName = UIModule.GetUINameWithoutClone(uiName)
	local isInGuide = GuideModule.TriggerGuide(Constant.GuideTriggerType.OpenUI, _uiName)

	if isInGuide then
		return
	end

	if groupName == Constant.UILayer.UI then
		PopUpModule.CheckPushGiftPackByUIName(_uiName)
	end
end

function PopUpModule.__OnMainUIVisible()
	if HomeModule.isReady == false then
		return
	end

	PopUpModule.OnMainUIVisibleYieldFun(false, nil)
end

function PopUpModule.LevelChange(data)
	UIModule.Open(Constant.UIControllerName.PlayerLvUpUI, Constant.UILayer.Tooltip, data)
end

function PopUpModule.SpecialPopups()
	if PopUpModule.isShowPopupWindowing == true then
		return
	end

	PopUpModule.isShowPopupWindowing = true
	PopUpModule.coroutine = CoroutineUtility.StartCoroutine(function()
		if MonthCardModule.GetMonthResidualDays() > 0 and not MonthCardModule.monthPrzieState then
			UIModule.Open(Constant.UIControllerName.MonthCardGetTipsUI, Constant.UILayer.UI)
			CoroutineUtility.Yield(WaitUntil(function()
				return MonthCardModule.monthPrzieState
			end))
		end

		if UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_SING) and not SignInModule.CurDateState then
			UIModule.Open(Constant.UIControllerName.SignInUI, Constant.UILayer.UI)
			CoroutineUtility.Yield(WaitUntil(function()
				return SignInModule.CurDateState
			end))
		end

		if MailModule.GetSpaceIsNotEnough() and MailModule.isNotPrompt == false and PlayerModule.CurLoginFlag then
			UIModule.Open(Constant.UIControllerName.CheckMailTipsUI, Constant.UILayer.UI, {
				type = Constant.MailTips.SpaceNotEnough
			})
			CoroutineUtility.Yield(WaitUntil(function()
				return MailModule.isNotPrompt
			end))
		elseif MailModule.GetIsExpiringSoon() and MailModule.isNotPrompt == false and PlayerModule.CurLoginFlag then
			UIModule.Open(Constant.UIControllerName.CheckMailTipsUI, Constant.UILayer.UI, {
				type = Constant.MailTips.ExpiringSoon
			})
			CoroutineUtility.Yield(WaitUntil(function()
				return MailModule.isNotPrompt
			end))
		end

		MailModule.isDelSpecialMail = false

		MailModule.SendGetMailsByType(Constant.MailType.Special, function(mails)
			if #mails > 0 then
				if #mails[1].itemList > 0 then
					UIModule.Open(Constant.UIControllerName.CheckMailTipsUI, Constant.UILayer.UI, {
						type = Constant.MailTips.HasDelMail,
						mails = mails
					})
				else
					MailModule.isDelSpecialMail = true
				end
			else
				MailModule.isDelSpecialMail = true
			end
		end)
		CoroutineUtility.Yield(WaitUntil(function()
			return MailModule.isDelSpecialMail
		end))

		PopUpModule.isShowPopupWindowing = false
	end)
end

function PopUpModule.StoryChapterPopups()
	CoroutineUtility.StartCoroutine(function()
		local unlockedChapterDict = StoryChapterModule.GetUnlockedChapterDict()
		local newUnlockedChapterDict = StoryChapterModule.DiffDict(unlockedChapterDict, StoryChapterModule.unlockedChapterDict)

		if getTableLength(newUnlockedChapterDict) > 0 then
			StoryChapterModule.unlockedChapterDict = unlockedChapterDict

			local queue = Queue.New()

			for _, chapter in pairs(newUnlockedChapterDict) do
				queue:Enqueue(chapter)
			end

			UIModule.Open(Constant.UIControllerName.ChapterUnlockUI, Constant.UILayer.UI, queue)
			CoroutineUtility.Yield(WaitUntil(function()
				return queue.Size == 0
			end))
			queue:Clear()
		end
	end)
end

function StoryChapterModule.DiffDict(aDict, bDict)
	local result = {}

	for k, v in pairs(aDict) do
		if not bDict[k] then
			result[k] = v
		end
	end

	return result
end

function PopUpModule.OnMainUIVisibleYieldFun(revertUI, args)
	if GuideModule.IsGuiding then
		return
	end

	if MazeModule.waitingForProcessingStage then
		MazeModule.ProcessingLeaveStage()

		return
	end

	if PopUpModule.CheckFunctionOpenPopup() then
		return
	end

	if PopUpModule.CheckMonthCardPopup() then
		return
	end

	if PopUpModule.CheckSignInPopup() then
		return
	end

	if PopUpModule.CheckPushGiftPackByUIName("MainUI") then
		return
	end

	local isInGuide = GuideModule.TriggerGuide(Constant.GuideTriggerType.OpenUI, "MainUI")

	if isInGuide then
		return
	end

	if PopUpModule.CheckMailSpaceIsNotEnoughPopup() then
		return
	end

	if PopUpModule.CheckMailExpiringSoonPopup() then
		return
	end

	if PopUpModule.CheckHasDelMailPopup() then
		return
	end

	if revertUI then
		SceneTransferModule.EnterCurrentDupByChapterType(args)
	end
end

function PopUpModule.CheckPushGiftPackByUIName(uiName)
	local pushUIType = -1

	ForArray(Constant.PushGiftUITable, function(k, _cfg)
		if _cfg.UIName ~= uiName then
			return false
		end

		pushUIType = _cfg.Type
	end)

	if pushUIType == -1 then
		return false
	end

	local commodityID = PlayerModule.GetCommoDityIDAndPushUIType(pushUIType)

	if commodityID == nil then
		return
	end

	PlayerPrefsUtil.SetString("", commodityID .. Constant.PlayerPrefsConst.LimitedTimeGiftPop .. PlayerModule.PlayerInfo.baseInfo.guid, "true")
	UIModule.Open(Constant.UIControllerName.PushGiftUI, Constant.UILayer.UI, {
		commodityID = commodityID
	})

	return true
end

function PopUpModule.CheckMonthCardPopup()
	if MonthCardModule.GetMonthResidualDays() <= 0 then
		return false
	end

	if MonthCardModule.monthPrzieState then
		return false
	end

	UIModule.Open(Constant.UIControllerName.MonthCardGetTipsUI, Constant.UILayer.UI)

	return true
end

function PopUpModule.CheckFunctionOpenPopup()
	return
end

function PopUpModule.CheckSignInPopup()
	if not UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_SING) then
		return false
	end

	if SignInModule.CurDateState then
		return false
	end

	UIModule.Open(Constant.UIControllerName.SignInUI, Constant.UILayer.UI)

	return true
end

function PopUpModule.CheckMailSpaceIsNotEnoughPopup()
	if not PlayerModule.CurLoginFlag then
		return false
	end

	if MailModule.isNotPrompt then
		return false
	end

	if not MailModule.GetSpaceIsNotEnough() then
		return false
	end

	UIModule.Open(Constant.UIControllerName.CheckMailTipsUI, Constant.UILayer.UI, {
		type = Constant.MailTips.SpaceNotEnough
	})

	return true
end

function PopUpModule.CheckMailExpiringSoonPopup()
	if not PlayerModule.CurLoginFlag then
		return false
	end

	if MailModule.isNotPrompt then
		return false
	end

	if not MailModule.GetIsExpiringSoon() then
		return false
	end

	UIModule.Open(Constant.UIControllerName.CheckMailTipsUI, Constant.UILayer.UI, {
		type = Constant.MailTips.ExpiringSoon
	})

	return true
end

function PopUpModule.CheckHasDelMailPopup()
	local asyncData = PopUpModule.__MainUIPopupDataTable[Constant.MainUIAsyncPopupKey.DelSpecialMail]

	if asyncData == nil then
		return false
	end

	if not asyncData.needPopup then
		return false
	end

	UIModule.Open(Constant.UIControllerName.CheckMailTipsUI, Constant.UILayer.UI, asyncData.data)

	PopUpModule.__MainUIPopupDataTable[Constant.MainUIAsyncPopupKey.DelSpecialMail] = nil

	return true
end

function PopUpModule.__InitMailPopupAsyncData()
	local asyncData = MainUIPopupAsyncData.New(Constant.MainUIAsyncPopupKey.DelSpecialMail)

	PopUpModule.__MainUIPopupDataTable[asyncData.key] = asyncData

	MailModule.SendGetMailsByType(Constant.MailType.Special, function(mails)
		if #mails > 0 and #mails[1].itemList > 0 then
			asyncData.needPopup = true
			asyncData.data = {
				type = Constant.MailTips.HasDelMail,
				mails = mails
			}
		end

		asyncData.complete = true
	end)
end

function PopUpModule.PrepareMainUIAsyncPopupData()
	PopUpModule.__InitMailPopupAsyncData()
end

function PopUpModule.IsMainUIAsyncPopupDataComplete()
	local complete = true

	ForPairs(PopUpModule.__MainUIPopupDataTable, function(_key, _asyncData)
		complete = _asyncData.complete

		if not complete then
			return true
		end
	end)

	return complete
end
