-- chunkname: @modules/logic/jump/controller/JumpControllerHandleFunc.lua

module("modules.logic.jump.controller.JumpControllerHandleFunc", package.seeall)

local JumpController = JumpController

JumpController.DefaultToastId = 0

function JumpController.activateHandleFuncController()
	return
end

function JumpController:defaultHandleFunc(jumpParam)
	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToRoleStoryActivity(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")
	local viewName = ViewName.RoleStoryDispatchMainView

	table.insert(self.waitOpenViewNames, viewName)

	if RoleStoryController.instance:openRoleStoryDispatchMainView(jumpArray) then
		return JumpEnum.JumpResult.Success
	end

	tabletool.removeValue(self.waitOpenViewNames, viewName)

	return JumpEnum.JumpResult.Fail
end

function JumpController:jumpToStoreView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")

	table.insert(self.waitOpenViewNames, ViewName.StoreView)
	table.insert(self.closeViewNames, ViewName.NormalStoreGoodsView)
	table.insert(self.closeViewNames, ViewName.ChargeStoreGoodsView)
	table.insert(self.remainViewNames, ViewName.StoreView)

	if ViewMgr.instance:isOpen(ViewName.DungeonView) and DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.WeekWalk then
		table.insert(self.remainViewNames, ViewName.DungeonView)
	end

	if #jumpArray >= 2 then
		local jumpTab = jumpArray[2]
		local jumpGoodsId = jumpArray[3]
		local isFocus = jumpArray[4]

		if (jumpTab == StoreEnum.StoreId.Package or jumpTab == StoreEnum.StoreId.RecommendPackage or jumpTab == StoreEnum.StoreId.NormalPackage or jumpTab == StoreEnum.StoreId.OneTimePackage or jumpTab == StoreEnum.StoreId.VersionPackage or jumpTab == StoreEnum.StoreId.MediciPackage) and jumpGoodsId then
			table.insert(self.remainViewNames, ViewName.PackageStoreGoodsView)
		end

		if jumpTab == StoreEnum.StoreId.NewDecorateStore or jumpTab == StoreEnum.StoreId.OldDecorateStore then
			if jumpGoodsId then
				table.insert(self.remainViewNames, ViewName.DecorateStoreGoodsView)
			end

			DecorateStoreModel.instance:setCurGood(jumpGoodsId or 0)
		end

		StoreController.instance:openStoreView(jumpTab, jumpGoodsId, isFocus)
	else
		StoreController.instance:openStoreView()
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToSummonView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")

	table.insert(self.remainViewNames, ViewName.SummonADView)
	table.insert(self.remainViewNames, ViewName.SummonView)

	if #jumpArray >= 2 then
		local jumpPoolId = jumpArray[2]

		SummonController.instance:jumpSummon(jumpPoolId)
	else
		SummonController.instance:jumpSummon()
	end

	ViewMgr.instance:closeAllPopupViews({
		ViewName.SummonADView,
		ViewName.SummonView
	})

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToSummonViewGroup(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")

	table.insert(self.remainViewNames, ViewName.SummonADView)
	table.insert(self.remainViewNames, ViewName.SummonView)

	if #jumpArray >= 2 then
		local jumpPoolGroupId = jumpArray[2]

		SummonController.instance:jumpSummonByGroup(jumpPoolGroupId)
	else
		SummonController.instance:jumpSummon()
	end

	ViewMgr.instance:closeAllPopupViews({
		ViewName.SummonADView,
		ViewName.SummonView
	})

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToDungeonViewWithChapter(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")

	table.insert(self.waitOpenViewNames, ViewName.DungeonMapView)
	table.insert(self.closeViewNames, ViewName.HeroInvitationView)
	table.insert(self.closeViewNames, ViewName.HeroInvitationDungeonMapView)
	table.insert(self.closeViewNames, ViewName.DungeonMapView)
	table.insert(self.closeViewNames, ViewName.DungeonMapLevelView)
	table.insert(self.closeViewNames, ViewName.VersionActivity1_5DungeonMapView)
	table.insert(self.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	table.insert(self.closeViewNames, ViewName.WeekWalkView)
	table.insert(self.closeViewNames, ViewName.WeekWalkCharacterView)
	table.insert(self.closeViewNames, ViewName.WeekWalkLayerView)
	table.insert(self.closeViewNames, ViewName.WeekWalkLayerRewardView)
	table.insert(self.closeViewNames, ViewName.StoryView)
	table.insert(self.closeViewNames, ViewName.DungeonPuzzleChangeColorView)

	local chapterId = jumpArray[2]
	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)

	if chapterConfig then
		local param = {}

		param.chapterType = chapterConfig.type
		param.chapterId = chapterId

		local moduleRemainViewNames = DungeonController.instance:jumpDungeon(param)

		if moduleRemainViewNames and #moduleRemainViewNames > 0 then
			for i, viewName in ipairs(moduleRemainViewNames) do
				table.insert(self.remainViewNames, viewName)
			end

			table.insert(self.remainViewNames, ViewName.DungeonView)
		end

		return JumpEnum.JumpResult.Success
	else
		logError("找不到章节配置, chapterId: " .. tostring(chapterId))

		return JumpEnum.JumpResult.Fail
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToDungeonViewWithEpisode(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")

	table.insert(self.waitOpenViewNames, ViewName.DungeonMapView)

	if jumpArray[3] ~= 1 then
		table.insert(self.waitOpenViewNames, ViewName.DungeonMapLevelView)
	end

	table.insert(self.closeViewNames, ViewName.HeroInvitationView)
	table.insert(self.closeViewNames, ViewName.HeroInvitationDungeonMapView)
	table.insert(self.closeViewNames, ViewName.DungeonMapView)
	table.insert(self.closeViewNames, ViewName.DungeonMapLevelView)
	table.insert(self.closeViewNames, ViewName.VersionActivity1_5DungeonMapView)
	table.insert(self.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	table.insert(self.closeViewNames, ViewName.WeekWalkView)
	table.insert(self.closeViewNames, ViewName.WeekWalkCharacterView)
	table.insert(self.closeViewNames, ViewName.WeekWalkLayerView)
	table.insert(self.closeViewNames, ViewName.WeekWalkLayerRewardView)
	table.insert(self.closeViewNames, ViewName.StoryView)
	table.insert(self.closeViewNames, ViewName.DungeonPuzzleChangeColorView)
	table.insert(self.closeViewNames, ViewName.InvestigateOpinionView)
	table.insert(self.closeViewNames, ViewName.InvestigateView)

	for viewName in pairs(ActivityHelper.getJumpNeedCloseViewDict()) do
		table.insert(self.closeViewNames, viewName)
	end

	local episodeId = jumpArray[2]
	local isNoShowMapLevel = jumpArray[3] == 1
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig then
		local chapterId = episodeConfig.chapterId
		local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)

		if chapterConfig then
			local param = {}

			param.chapterType = chapterConfig.type
			param.chapterId = chapterId
			param.episodeId = episodeId
			param.isNoShowMapLevel = isNoShowMapLevel

			local moduleRemainViewNames = DungeonController.instance:jumpDungeon(param)

			if moduleRemainViewNames and #moduleRemainViewNames > 0 then
				for i, viewName in ipairs(moduleRemainViewNames) do
					table.insert(self.remainViewNames, viewName)
				end

				table.insert(self.remainViewNames, ViewName.DungeonView)
			else
				return JumpEnum.JumpResult.Fail
			end
		else
			logError("找不到章节配置, chapterId: " .. tostring(chapterId))

			return JumpEnum.JumpResult.Fail
		end
	else
		logError("找不到关卡配置, episodeId: " .. tostring(episodeId))

		return JumpEnum.JumpResult.Fail
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToDungeonViewWithType(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")

	if not jumpArray[2] then
		local jumpChapterType = JumpEnum.DungeonChapterType.Story
		local param = {}

		if jumpChapterType == JumpEnum.DungeonChapterType.Story then
			param.chapterType = DungeonEnum.ChapterType.Normal
		elseif jumpChapterType == JumpEnum.DungeonChapterType.Gold then
			param.chapterType = DungeonEnum.ChapterType.Gold
		elseif jumpChapterType == JumpEnum.DungeonChapterType.Resource then
			param.chapterType = DungeonEnum.ChapterType.Break
		elseif jumpChapterType == JumpEnum.DungeonChapterType.Explore then
			param.chapterType = DungeonEnum.ChapterType.Explore
		elseif jumpChapterType == JumpEnum.DungeonChapterType.WeekWalk then
			param.chapterType = DungeonEnum.ChapterType.WeekWalk

			if ViewMgr.instance:isOpen(ViewName.WeekWalkView) or ViewMgr.instance:isOpen(ViewName.DungeonView) and DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.WeekWalk then
				ViewMgr.instance:closeView(ViewName.TaskView)
				ViewMgr.instance:closeView(ViewName.StoreView)
				ViewMgr.instance:closeView(ViewName.BpView)

				return JumpEnum.JumpResult.Success
			end
		elseif jumpChapterType == JumpEnum.DungeonChapterType.RoleStory then
			param.chapterType = DungeonEnum.ChapterType.RoleStory
		end

		table.insert(self.closeViewNames, ViewName.HeroInvitationView)
		table.insert(self.closeViewNames, ViewName.HeroInvitationDungeonMapView)
		table.insert(self.closeViewNames, ViewName.DungeonMapView)
		table.insert(self.closeViewNames, ViewName.DungeonMapLevelView)
		table.insert(self.closeViewNames, ViewName.VersionActivity1_5DungeonMapView)
		table.insert(self.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
		table.insert(self.closeViewNames, ViewName.WeekWalkView)
		table.insert(self.closeViewNames, ViewName.WeekWalkCharacterView)
		table.insert(self.closeViewNames, ViewName.WeekWalkLayerView)
		table.insert(self.closeViewNames, ViewName.WeekWalkLayerRewardView)
		table.insert(self.closeViewNames, ViewName.StoryView)
		table.insert(self.closeViewNames, ViewName.DungeonPuzzleChangeColorView)

		local moduleRemainViewNames = DungeonController.instance:jumpDungeon(param)

		if moduleRemainViewNames and #moduleRemainViewNames > 0 then
			for i, viewName in ipairs(moduleRemainViewNames) do
				table.insert(self.remainViewNames, viewName)
			end

			table.insert(self.remainViewNames, ViewName.DungeonView)
		else
			if LuaUtil.tableContains(DungeonEnum.ChapterType, jumpChapterType) then
				DungeonModel.instance:changeCategory(jumpChapterType)
				DungeonController.instance:enterDungeonView()

				return JumpEnum.JumpResult.Success
			end

			return JumpEnum.JumpResult.Fail
		end

		return JumpEnum.JumpResult.Success
	end
end

function JumpController:jumpToCharacterBackpackViewWithCharacter(jumpParam)
	table.insert(self.waitOpenViewNames, ViewName.CharacterBackpackView)
	CharacterController.instance:enterCharacterBackpack(JumpEnum.CharacterBackpack.Character)
	table.insert(self.remainViewNames, ViewName.CharacterBackpackView)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToCharacterBackpackViewWithEquip(jumpParam)
	table.insert(self.waitOpenViewNames, ViewName.BackpackView)
	BackpackController.instance:enterItemBackpack(ItemEnum.CategoryType.Equip)
	table.insert(self.remainViewNames, ViewName.BackpackView)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToHeroGroupView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")
	local episodeId = jumpArray[2]

	if not episodeId then
		return JumpEnum.JumpResult.Fail
	end

	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	DungeonFightController.instance:enterFight(config.chapterId, episodeId)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToHeroGroupPreView(jumpParam)
	HeroGroupPresetController.instance:openHeroGroupPresetTeamView()

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToBackpackView(jumpParam)
	table.insert(self.waitOpenViewNames, ViewName.BackpackView)

	local jumpArray = string.splitToNumber(jumpParam, "#")

	BackpackController.instance:enterItemBackpack(jumpArray[2])
	table.insert(self.remainViewNames, ViewName.BackpackView)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToBackpackUseTypeView(jumpParam)
	table.insert(self.waitOpenViewNames, ViewName.BackpackView)
	BackpackController.instance:enterItemBackpack(ItemEnum.CategoryType.UseType)
	table.insert(self.remainViewNames, ViewName.BackpackView)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToSkinGiftUseTypeView(jumpParam)
	table.insert(self.waitOpenViewNames, ViewName.SkinSelfSelectView)

	local jumpArray = string.splitToNumber(jumpParam, "#")
	local itemId = jumpArray[2]

	CharacterController.instance:useSkinGiftItem(itemId)
	table.insert(self.remainViewNames, ViewName.SkinSelfSelectView)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToPlayerClothView(jumpParam)
	logError("废弃跳转到主角技能界面")

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToMainView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")
	local forceOpenMainView = jumpArray[2]

	ViewMgr.instance:closeAllPopupViews()
	MainController.instance:enterMainScene()

	if forceOpenMainView == 1 then
		ViewMgr.instance:openView(ViewName.MainView)
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToTaskView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")

	table.insert(self.waitOpenViewNames, ViewName.TaskView)
	table.insert(self.closeViewNames, ViewName.WeekWalkView)
	table.insert(self.closeViewNames, ViewName.WeekWalkCharacterView)
	table.insert(self.closeViewNames, ViewName.WeekWalkLayerView)

	local taskType

	TaskController.instance:enterTaskView((#jumpArray >= 2 or nil) and jumpArray[2])
	table.insert(self.remainViewNames, ViewName.TaskView)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToRoomView(jumpParam)
	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToRoomProductLineView(jumpParam)
	local isRoomScene = RoomController.instance:isRoomScene()

	if RoomController.instance:isEditMode() and isRoomScene then
		GameFacade.showToast(RoomEnum.Toast.RoomEditCanNotOpenProductionLevel)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(self.waitOpenViewNames, ViewName.RoomInitBuildingView)

	if not ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
		if isRoomScene then
			RoomMapController.instance:openRoomInitBuildingView(0, {
				partId = 3
			})
			ViewMgr.instance:closeAllPopupViews({
				ViewName.RoomInitBuildingView,
				ViewName.RoomFormulaView,
				ViewName.RoomInventorySelectView
			})
		else
			RoomMapController.instance:openFormulaItemBuildingViewOutSide()
		end
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToTeachNoteView(jumpParam)
	table.insert(self.waitOpenViewNames, ViewName.TeachNoteView)

	local episodeId = TeachNoteModel.instance:getJumpEpisodeId()

	TeachNoteController.instance:enterTeachNoteView(episodeId, true)
	table.insert(self.remainViewNames, ViewName.TeachNoteView)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToEquipView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")

	table.insert(self.waitOpenViewNames, ViewName.EquipView)

	local equipId = jumpArray[2]

	if equipId then
		local param = {}

		param.equipId = equipId

		EquipController.instance:openEquipView(param)
		table.insert(self.remainViewNames, ViewName.EquipView)
		table.insert(self.remainViewNames, ViewName.GiftMultipleChoiceView)
	else
		logError("equip id cant be null ...")

		return JumpEnum.JumpResult.Fail
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToHandbookView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")

	table.insert(self.waitOpenViewNames, ViewName.HandbookView)
	table.insert(self.closeViewNames, ViewName.HandBookCharacterSwitchView)
	table.insert(self.closeViewNames, ViewName.HandbookEquipView)
	table.insert(self.closeViewNames, ViewName.HandbookStoryView)
	table.insert(self.closeViewNames, ViewName.HandbookCGDetailView)
	table.insert(self.closeViewNames, ViewName.CharacterDataView)

	local moduleRemainViewNames = HandbookController.instance:jumpView(jumpArray)

	for i, moduleRemainViewName in ipairs(moduleRemainViewNames) do
		table.insert(self.remainViewNames, moduleRemainViewName)
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToSocialView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")

	table.insert(self.waitOpenViewNames, ViewName.SocialView)

	local viewParam

	SocialController.instance:openSocialView((jumpArray[2] or nil) and {
		defaultTabIds = {
			[2] = jumpArray[2]
		}
	})
	table.insert(self.remainViewNames, ViewName.SocialView)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToNoticeView(jumpParam)
	table.insert(self.waitOpenViewNames, ViewName.NoticeView)
	NoticeController.instance:openNoticeView()
	table.insert(self.remainViewNames, ViewName.NoticeView)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToSignInView(jumpParam)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		GameFacade.showToast(ToastEnum.JumpSignView)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(self.waitOpenViewNames, ViewName.SignInView)

	local data = {}

	data.isBirthday = false

	local jumpArray = string.splitToNumber(jumpParam, "#")

	data.isActiveLifeCicle = jumpArray[2] and jumpArray[2] == 1

	SignInController.instance:openSignInDetailView(data)
	table.insert(self.remainViewNames, ViewName.SignInView)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToSignInViewWithBirthDay(jumpParam)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		GameFacade.showToast(ToastEnum.JumpSignView)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(self.waitOpenViewNames, ViewName.SignInView)

	local data = {}

	data.isBirthday = true

	SignInController.instance:openSignInDetailView(data)
	table.insert(self.remainViewNames, ViewName.SignInView)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToSeasonMainView(jumpParam)
	local curSeasonId = Activity104Model.instance:getCurSeasonId()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(curSeasonId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		if toastId then
			GameFacade.showToastWithTableParam(toastId, paramList)
		end

		return JumpEnum.JumpResult.Fail
	end

	local paramsList = string.splitToNumber(jumpParam, "#")
	local jumpId = paramsList and paramsList[2]

	if jumpId == Activity104Enum.JumpId.Discount and not Activity104Model.instance:isSpecialOpen() then
		GameFacade.showToast(ToastEnum.SeasonSpecialNotOpen)

		return JumpEnum.JumpResult.Fail
	end

	VersionActivity3_0EnterController.instance:openVersionActivityEnterView(function()
		Activity104Controller.instance:openSeasonMainView({
			jumpId = jumpId
		})
	end, nil, curSeasonId)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToShow(jumpParam)
	return JumpEnum.JumpResult.Fail
end

function JumpController:jumpToBpView(jumpParam)
	table.insert(self.waitOpenViewNames, ViewName.BpView)

	local paramsList = string.splitToNumber(jumpParam, "#")
	local isSpecial = tonumber(paramsList[2]) == 1
	local isCharge = tonumber(paramsList[3]) == 1

	BpController.instance:openBattlePassView(isSpecial, nil, isCharge)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToActivityView(jumpParam)
	local paramsList = string.splitToNumber(jumpParam, "#")
	local actId = paramsList[2]
	local version = ActivityHelper.getActivityVersion(actId)
	local jumpFuncs = _G[string.format("VersionActivity%sJumpHandleFunc", version)]

	if jumpFuncs and jumpFuncs["jumpTo" .. actId] then
		return jumpFuncs["jumpTo" .. actId](self, paramsList)
	end

	local jumpFunc = JumpController.JumpActViewToHandleFunc[actId]

	if jumpFunc then
		return jumpFunc(self, actId, paramsList)
	end

	local ActivityCo = ActivityConfig.instance:getActivityCo(actId)
	local typeId = ActivityCo.typeId

	if actId == JumpEnum.ActIdEnum.Activity104 then
		table.insert(self.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(self.waitOpenViewNames, ViewName.SeasonMainView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity104Controller.instance:openSeasonMainView()
		end)
	elseif actId == JumpEnum.ActIdEnum.Act105 then
		table.insert(self.waitOpenViewNames, ViewName.VersionActivityEnterView)
		VersionActivityController.instance:openVersionActivityEnterView()
	elseif actId == JumpEnum.ActIdEnum.Act106 then
		table.insert(self.waitOpenViewNames, ViewName.ActivityBeginnerView)
		ActivityController.instance:openActivityBeginnerView(jumpParam)
	elseif actId == JumpEnum.ActIdEnum.Act107 then
		table.insert(self.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(self.waitOpenViewNames, ViewName.VersionActivityStoreView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivityController.instance:openLeiMiTeBeiStoreView()
		end)
	elseif actId == JumpEnum.ActIdEnum.Act108 then
		table.insert(self.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(self.waitOpenViewNames, ViewName.MeilanniMainView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			MeilanniController.instance:openMeilanniMainView({
				checkStory = true
			})
		end)
	elseif actId == JumpEnum.ActIdEnum.Act109 then
		table.insert(self.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(self.waitOpenViewNames, ViewName.Activity109ChessEntry)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity109ChessController.instance:openEntry(VersionActivityEnum.ActivityId.Act109)
		end)
	elseif actId == JumpEnum.ActIdEnum.Act111 then
		table.insert(self.waitOpenViewNames, ViewName.VersionActivityPushBoxLevelView)
		PushBoxController.instance:enterPushBoxGame()
	elseif actId == JumpEnum.ActIdEnum.Act112 then
		table.insert(self.waitOpenViewNames, ViewName.VersionActivityEnterView)
		table.insert(self.waitOpenViewNames, ViewName.VersionActivityExchangeView)
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			ViewMgr.instance:openView(ViewName.VersionActivityExchangeView)
		end)
	elseif actId == JumpEnum.ActIdEnum.Act113 then
		table.insert(self.waitOpenViewNames, ViewName.VersionActivityEnterView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			if #paramsList >= 3 then
				local subJumpId = paramsList[3]

				if subJumpId == JumpEnum.LeiMiTeBeiSubJumpId.DungeonStoryMode then
					table.insert(self.waitOpenViewNames, ViewName.VersionActivityDungeonMapView)
					VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)
				elseif subJumpId == JumpEnum.LeiMiTeBeiSubJumpId.DungeonHardMode then
					table.insert(self.waitOpenViewNames, ViewName.VersionActivityDungeonMapView)

					if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act113) then
						VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)
					else
						VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard)
					end
				elseif subJumpId == JumpEnum.LeiMiTeBeiSubJumpId.LeiMiTeBeiStore then
					table.insert(self.waitOpenViewNames, ViewName.ReactivityStoreView)
					ReactivityController.instance:openReactivityStoreView(actId)
				else
					logWarn("not support subJumpId : " .. jumpParam)
				end
			else
				table.insert(self.waitOpenViewNames, ViewName.VersionActivityDungeonMapView)
				VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)
			end
		end, nil, actId)
	elseif actId == ActivityEnum.Activity.Work_SignView_1_8 or actId == ActivityEnum.Activity.V2a0_SummerSign or actId == ActivityEnum.Activity.V2a1_MoonFestival or actId == ActivityEnum.Activity.V2a2_RedLeafFestival_PanelView or actId == VersionActivity2_2Enum.ActivityId.LimitDecorate or actId == ActivityEnum.Activity.V2a2_TurnBack_H5 or actId == ActivityEnum.Activity.V2a2_SummonCustomPickNew or actId == ActivityEnum.Activity.V2a3_NewCultivationGift or actId == ActivityEnum.Activity.V2a7_Labor_Sign or actId == ActivityEnum.Activity.V2a9_FreeMonthCard or actId == ActivityEnum.Activity.V2a8_DragonBoat or actId == ActivityEnum.Activity.V3a0_SummerSign or actId == ActivityEnum.Activity.V3a1_AutumnSign or actId == BpModel.instance:getCurVersionOperActId() or actId == NationalGiftModel.instance:getCurVersionActId() then
		if ActivityHelper.getActivityStatus(actId, true) ~= ActivityEnum.ActivityStatus.Normal then
			return JumpEnum.JumpResult.Fail
		end

		table.insert(self.waitOpenViewNames, ViewName.ActivityBeginnerView)
		ActivityModel.instance:setTargetActivityCategoryId(actId)
		ActivityController.instance:openActivityBeginnerView()
	elseif actId == ActivityEnum.Activity.V3a4_HeroExpBox then
		ViewMgr.instance:openView(ViewName.HeroExpBoxPanelView)
	elseif typeId == ActivityEnum.ActivityTypeID.Act125 then
		if ActivityHelper.getActivityStatus(actId, true) ~= ActivityEnum.ActivityStatus.Normal then
			return JumpEnum.JumpResult.Fail
		end

		table.insert(self.waitOpenViewNames, ViewName.ActivityBeginnerView)
		Activity125Model.instance:setSelectEpisodeId(actId, 1)
		ActivityModel.instance:setTargetActivityCategoryId(actId)
		ActivityController.instance:openActivityBeginnerView()
	elseif typeId == ActivityEnum.ActivityTypeID.Act101 then
		if ActivityHelper.getActivityStatus(actId, true) ~= ActivityEnum.ActivityStatus.Normal then
			return JumpEnum.JumpResult.Fail
		end

		table.insert(self.waitOpenViewNames, ViewName.ActivityBeginnerView)
		ActivityModel.instance:setTargetActivityCategoryId(actId)
		ActivityController.instance:openActivityBeginnerView()
	elseif typeId == ActivityEnum.ActivityTypeID.NecrologistStory then
		if ActivityHelper.getActivityStatus(actId, true) ~= ActivityEnum.ActivityStatus.Normal then
			return JumpEnum.JumpResult.Fail
		end

		local curStoryId = RoleStoryModel.instance:getCurActStoryId()

		NecrologistStoryController.instance:openGameView(curStoryId)
	elseif typeId == ActivityEnum.ActivityTypeID.Act210 then
		if ActivityHelper.getActivityStatus(actId, true) ~= ActivityEnum.ActivityStatus.Normal then
			return JumpEnum.JumpResult.Fail
		end

		GaoSiNiaoController.instance:enterLevelView()
	elseif ActivityConfig.instance:isActIdInList(actId, ActivityType100Config.instance:getWarmUpH5ActIdList()) then
		if ActivityHelper.getActivityStatus(actId, true) ~= ActivityEnum.ActivityStatus.Normal then
			return JumpEnum.JumpResult.Fail
		end

		table.insert(self.waitOpenViewNames, ViewName.ActivityBeginnerView)
		ActivityModel.instance:setTargetActivityCategoryId(actId)
		ActivityController.instance:openActivityBeginnerView()
	else
		logWarn("not support actId : " .. jumpParam)
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToLeiMiTeBeiDungeonView(jumpParam)
	local paramsList = string.splitToNumber(jumpParam, "#")
	local episodeId = paramsList[2]
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		logError("not found episode : " .. jumpParam)

		return JumpEnum.JumpResult.Fail
	end

	local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeId)

	if not episodeInfo then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(self.waitOpenViewNames, ViewName.VersionActivityDungeonMapLevelView)

	local isRetroAcitivity = ReactivityModel.instance:isReactivity(VersionActivityEnum.ActivityId.Act113)

	if isRetroAcitivity then
		VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
			ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
				isJump = true,
				episodeId = episodeId
			})
		end)
	else
		VersionActivityController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivityDungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end)
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToPushBox(jumpParam)
	return
end

function JumpController:jumpToAct117(actId, jumpParam)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
	table.insert(self.waitOpenViewNames, ViewName.ActivityTradeBargain)
	VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView(Activity117Controller.openView, Activity117Controller.instance, actId)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct114(actId, jumpParam)
	if Activity114Model.instance.serverData.battleEventId > 0 then
		local eventCo = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.battleEventId)

		Activity114Controller.instance:enterActivityFight(eventCo.config.battleId)
	else
		table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
		table.insert(self.waitOpenViewNames, ViewName.Activity114View)
		VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView(function()
			local viewParams

			ViewMgr.instance:openView(ViewName.Activity114View, (Activity114Model.instance.serverData.isEnterSchool or nil) and {
				defaultTabIds = {
					[2] = Activity114Enum.TabIndex.MainView
				}
			})
		end)
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct119(actId, jumpParam)
	if actId == VersionActivity1_3Enum.ActivityId.Act307 then
		table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
		table.insert(self.waitOpenViewNames, ViewName.Activity1_3_119View)
		VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity1_3_119Controller.instance:openView()
		end)

		return JumpEnum.JumpResult.Success
	else
		table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
		table.insert(self.waitOpenViewNames, ViewName.Activity119View)
		VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView(function()
			Activity119Controller.instance:openAct119View()
		end)

		return JumpEnum.JumpResult.Success
	end
end

function JumpController:jumpToAct1_2Shop()
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_2StoreView)
	ViewMgr.instance:openView(ViewName.VersionActivity1_2StoreView)

	return JumpEnum.JumpResult.Success
end

function JumpController:ensureActStoryDone(actIdList, callback, callbackObj)
	local storyIdList = {}

	for _, actId in ipairs(actIdList) do
		if not VersionActivityBaseController.instance:isPlayedActivityVideo(actId) then
			local activityCo = ActivityConfig.instance:getActivityCo(actId)
			local storyId = activityCo.storyId

			if storyId > 0 then
				table.insert(storyIdList, storyId)
			end
		end
	end

	if #storyIdList > 0 then
		StoryController.instance:playStories(storyIdList, nil, callback, callbackObj)
	else
		callback(callbackObj)
	end
end

function JumpController:jumpToAct1_2Dungeon(actId, paramsList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_7EnterView)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_2DungeonView)

		if #paramsList >= 3 then
			local subJumpId = paramsList[3]

			if subJumpId == JumpEnum.Activity1_2DungeonJump.Shop then
				table.insert(self.waitOpenViewNames, ViewName.ReactivityStoreView)
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, nil, nil, nil, subJumpId)
			elseif subJumpId == JumpEnum.Activity1_2DungeonJump.Normal then
				VersionActivity1_2DungeonController.instance:openDungeonView()
			elseif subJumpId == JumpEnum.Activity1_2DungeonJump.Hard then
				VersionActivity1_2DungeonController.instance:openDungeonView(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard)
			elseif subJumpId == JumpEnum.Activity1_2DungeonJump.Task then
				table.insert(self.waitOpenViewNames, ViewName.ReactivityTaskView)
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, nil, nil, nil, subJumpId)
			elseif subJumpId == JumpEnum.Activity1_2DungeonJump.Jump2Dungeon then
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, paramsList[4], true)
			elseif subJumpId == JumpEnum.Activity1_2DungeonJump.Jump2Camp then
				VersionActivity1_2DungeonController.instance:openDungeonView(nil, nil, nil, true)
			end
		else
			VersionActivity1_2DungeonController.instance:openDungeonView()
		end
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToEnterView1_2(actId, paramList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
	VersionActivity1_2EnterController.instance:openVersionActivity1_2EnterView()

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToYaXianView(actId, paramList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_2EnterView)
	table.insert(self.waitOpenViewNames, ViewName.YaXianMapView)
	self:ensureActStoryDone({
		JumpEnum.ActIdEnum.EnterView1_2,
		actId
	}, function()
		VersionActivity1_2EnterController.instance:directOpenVersionActivity1_2EnterView()
		YaXianController.instance:openYaXianMapView()
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToEnterView1_3(actId, paramList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
	VersionActivity1_3EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_3Shop(actId, paramList)
	table.insert(self.waitOpenViewNames, ViewName.ReactivityStoreView)
	ReactivityController.instance:openReactivityStoreView(VersionActivity1_3Enum.ActivityId.Dungeon)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_3Dungeon(actId, paramList)
	table.insert(self.closeViewNames, ViewName.VersionActivity1_3DungeonMapLevelView)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		if #paramList >= 3 then
			local subJumpId = paramList[3]

			if subJumpId == JumpEnum.Activity1_3DungeonJump.Normal then
				table.insert(self.closeViewNames, ViewName.VersionActivity1_3BuffView)
				table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)
			elseif subJumpId == JumpEnum.Activity1_3DungeonJump.Hard then
				table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				table.insert(self.closeViewNames, ViewName.VersionActivity1_3BuffView)

				if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act1_3Dungeon) then
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)
				else
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard)
				end
			elseif subJumpId == JumpEnum.Activity1_3DungeonJump.Daily then
				table.insert(self.closeViewNames, ViewName.VersionActivity1_3AstrologyView)
				table.insert(self.closeViewNames, ViewName.VersionActivity1_3BuffView)
				table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, VersionActivity1_3DungeonEnum.DailyEpisodeId, nil, nil, {
					showDaily = true
				})
			elseif subJumpId == JumpEnum.Activity1_3DungeonJump.Astrology then
				table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_3AstrologyView)
				table.insert(self.closeViewNames, ViewName.VersionActivity1_3BuffView)

				if ViewMgr.instance:isOpen(ViewName.VersionActivity1_3DungeonMapView) then
					VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologyView()
				else
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, nil, function()
						VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologyView()
					end)
				end
			elseif subJumpId == JumpEnum.Activity1_3DungeonJump.Buff then
				table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
				table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_3BuffView)

				if ViewMgr.instance:isOpen(ViewName.VersionActivity1_3DungeonMapView) then
					VersionActivity1_3BuffController.instance:openBuffView()
				else
					VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, nil, function()
						VersionActivity1_3BuffController.instance:openBuffView()
					end)
				end
			else
				logWarn("not support subJumpId:" .. tostring(subJumpId))

				return JumpEnum.JumpResult.Fail
			end
		else
			table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapView)
			VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei)
		end
	end, nil, VersionActivity1_3Enum.ActivityId.Dungeon)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_3DungeonView(jumpParam)
	local paramsList = string.splitToNumber(jumpParam, "#")
	local episodeId = paramsList[2]
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		logError("not found episode : " .. jumpParam)

		return JumpEnum.JumpResult.Fail
	end

	local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeId)

	if not episodeInfo then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_3DungeonMapLevelView)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity1_3DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
			ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonMapLevelView, {
				isJump = true,
				episodeId = episodeId
			})
		end)
	end, nil, VersionActivity1_3Enum.ActivityId.Dungeon)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_3Act304(actId, paramList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)

	if paramList and #paramList >= 3 then
		Activity122Model.instance:setCurEpisodeId(#paramList[3])
	end

	VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.Activity1_3ChessMapView)
		Activity1_3ChessController.instance:openMapView()
	end)
	ViewMgr.instance:closeAllPopupViews({
		ViewName.VersionActivity1_3EnterView,
		ViewName.Activity1_3ChessMapView
	})

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_3Act305(actId, paramList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)
	VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.ArmMainView)
		ArmPuzzlePipeController.instance:openMainView()
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_3Act306(actId, paramList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_3EnterView)

	if paramList and #paramList >= 3 then
		Activity120Model.instance:getCurEpisodeId(#paramList[3])
	end

	VersionActivity1_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.JiaLaBoNaMapView)
		JiaLaBoNaController.instance:openMapView()
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_3Act125(actId, paramList)
	if not ActivityModel.instance:isActOnLine(actId) then
		return JumpEnum.JumpResult.Fail
	end

	table.insert(self.waitOpenViewNames, ViewName.ActivityBeginnerView)
	table.insert(self.closeViewNames, ViewName.MainThumbnailView)
	ActivityModel.instance:setTargetActivityCategoryId(actId)
	ActivityController.instance:openActivityBeginnerView(paramList)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToTurnback(jumpParam)
	if not TurnbackModel.instance:isNewType() then
		local jumpdata = string.splitToNumber(jumpParam, "#")
		local viewParam = {}

		viewParam.turnbackId = tonumber(jumpdata[2])
		viewParam.subModuleId = tonumber(jumpdata[3])

		local viewName = string.format("Turnback%sBeginnerView", viewParam.turnbackId)

		table.insert(self.waitOpenViewNames, viewName)
		TurnbackModel.instance:setCurTurnbackId(viewParam.turnbackId)
		TurnbackModel.instance:setTargetCategoryId(viewParam.subModuleId)
		TurnbackController.instance:openTurnbackBeginnerView(viewParam)

		return JumpEnum.JumpResult.Success
	elseif ViewMgr.instance:isOpen(ViewName.TurnbackNewBeginnerView) then
		local jumpdata = string.splitToNumber(jumpParam, "#")
		local viewParam = {}

		viewParam.subModuleId = tonumber(jumpdata[3])

		TurnbackModel.instance:setTargetCategoryId(viewParam.subModuleId)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshBeginner)

		return JumpEnum.JumpResult.Success
	end
end

function JumpController:jumpToEnterView1_4(actId, paramList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_4DungeonStore(actId, paramList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.Activity129View)
		ViewMgr.instance:openView(ViewName.Activity129View, {
			actId = actId
		})
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_4Dungeon(actId, paramList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_4DungeonView)
		ViewMgr.instance:openView(ViewName.VersionActivity1_4DungeonView, {
			actId = actId
		})
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_4Task(actId, paramList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_4TaskView)
		ViewMgr.instance:openView(ViewName.VersionActivity1_4TaskView, {
			activityId = actId
		})
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_4Role37(actId, paramList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.Activity130LevelView)
		Activity130Controller.instance:enterActivity130()
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_4Role6(actId, paramList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_4EnterView)
	VersionActivity1_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.Activity131LevelView)
		Activity131Controller.instance:enterActivity131()
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_4Role37Game(jumpParam)
	local jumpdata = string.splitToNumber(jumpParam, "#")
	local data = {}

	data.episodeId = tonumber(jumpdata[2])

	if ViewMgr.instance:isOpen(ViewName.Activity130LevelView) then
		if Activity130Model.instance:isEpisodeUnlock(data.episodeId) then
			Activity130Controller.instance:dispatchEvent(Activity130Event.EnterEpisode, data.episodeId)
		else
			GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

			return JumpEnum.JumpResult.Fail
		end
	else
		Activity130Controller.instance:openActivity130GameView(data)
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_4Role6Game(jumpParam)
	local jumpdata = string.splitToNumber(jumpParam, "#")
	local data = {}

	data.episodeId = tonumber(jumpdata[2])

	if ViewMgr.instance:isOpen(ViewName.Activity131LevelView) then
		if Activity131Model.instance:isEpisodeUnlock(data.episodeId) then
			Activity131Controller.instance:dispatchEvent(Activity131Event.EnterEpisode, data.episodeId)
		else
			GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

			return JumpEnum.JumpResult.Fail
		end
	else
		Activity131Controller.instance:openActivity131GameView(data)
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAchievement(jumpParam)
	local jumpData = string.split(jumpParam, "#")

	if #jumpData > 1 then
		AchievementJumpController.instance:jumpToAchievement(jumpData)

		return JumpEnum.JumpResult.Success
	end

	return JumpEnum.JumpResult.Fail
end

function JumpController:jumpToBossRush(jumpParam)
	local jumpData = string.splitToNumber(jumpParam, "#")
	local stage = jumpData[2]
	local layer = jumpData[3]
	local viewParam

	BossRushController.instance:openV3a2MainView((stage or nil) and {
		isOpenLevelDetail = true,
		stage = stage,
		layer = layer
	})

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToV3a9BossRush(jumpParam)
	local jumpData = string.splitToNumber(jumpParam, "#")
	local tabIndex = jumpData[2]
	local viewParam = {
		enterMode = tabIndex
	}

	V3a9_BossRushController.instance:openV3a9MainView(viewParam)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_5EnterView(jumpParam, paramList)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_5Dungeon(jumpParam, paramList)
	table.insert(self.closeViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		if #paramList >= 3 then
			local subJumpId = paramList[3]

			if subJumpId == JumpEnum.Activity1_3DungeonJump.Normal then
				table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapView)
				VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Story)
			elseif subJumpId == JumpEnum.Activity1_3DungeonJump.Hard then
				table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapView)

				if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act1_5Dungeon) then
					VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Story)
				else
					VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Hard)
				end
			else
				logWarn("not support subJumpId:" .. tostring(subJumpId))

				return JumpEnum.JumpResult.Fail
			end
		else
			table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapView)
			VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_5DungeonEnum.DungeonChapterId.Story)
		end
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_5DungeonStore(jumpParam, paramList)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(JumpEnum.ActIdEnum.Act1_5Dungeon)
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_5PeaceUluGame(jumpParam)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.PeaceUluView)
		PeaceUluController.instance:openPeaceUluView(jumpParam)
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_5SportNews(jumpParam)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.SportsNewsView)
		SportsNewsController.instance:openSportsNewsMainView(jumpParam)
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_5DungeonView(jumpParam)
	local paramsList = string.splitToNumber(jumpParam, "#")
	local episodeId = paramsList[2]
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		logError("not found episode : " .. jumpParam)

		return JumpEnum.JumpResult.Fail
	end

	local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeId)

	if not episodeInfo then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_5DungeonMapLevelView)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity1_5DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
			ViewMgr.instance:openView(ViewName.VersionActivity1_5DungeonMapLevelView, {
				isJump = true,
				episodeId = episodeId
			})
		end)
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToActivity142(jumpParam)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	VersionActivity1_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.Activity142MapView)
		Activity142Controller.instance:openMapView()
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_5AiZiLa(jumpParam)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_5EnterView)
	table.insert(self.waitOpenViewNames, ViewName.AiZiLaMapView)
	AiZiLaController.instance:openMapView()

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_6EnterView(jumpParam, paramList)
	local subJumpActId

	VersionActivity1_6EnterController.instance:openVersionActivityEnterView(nil, nil, (#paramList >= 3 or nil) and paramList[3], true)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_6Dungeon(jumpParam, paramList)
	table.insert(self.closeViewNames, ViewName.VersionActivity1_6DungeonMapLevelView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		if #paramList >= 3 then
			local subJumpId = paramList[3]

			if subJumpId == JumpEnum.Activity1_3DungeonJump.Normal then
				table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapView)
				VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Story)
			elseif subJumpId == JumpEnum.Activity1_3DungeonJump.Hard then
				table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapView)

				if not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(JumpEnum.ActIdEnum.Act1_6Dungeon) then
					VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Story)
				else
					VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Hard)
				end
			else
				logWarn("not support subJumpId:" .. tostring(subJumpId))

				return JumpEnum.JumpResult.Fail
			end
		else
			table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapView)
			VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(VersionActivity1_6DungeonEnum.DungeonChapterId.Story)
		end
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_6DungeonView(jumpParam)
	local paramsList = string.splitToNumber(jumpParam, "#")
	local episodeId = paramsList[2]
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		logError("not found episode : " .. jumpParam)

		return JumpEnum.JumpResult.Fail
	end

	local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeId)

	if not episodeInfo then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_6DungeonMapLevelView)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
			ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapLevelView, {
				isJump = true,
				episodeId = episodeId
			})
		end)
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_6DungeonStore(jumpParam, paramList)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_6StoreView)
		VersionActivity1_6EnterController.instance:openStoreView()
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_6DungeonBoss(jumpParam, paramList)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView()
		VersionActivity1_6DungeonController.instance:openDungeonBossView()
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_6Rogue(jumpParam, paramList)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, jumpParam, false)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_6QuNiang(jumpParam, paramList)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.ActQuNiangLevelView)
		ActQuNiangController.instance:enterActivity()
	end, nil, jumpParam, false)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAct1_6GeTian(jumpParam, paramList)
	VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(self.waitOpenViewNames, ViewName.ActGeTianLevelView)
		ActGeTianController.instance:enterActivity()
	end, nil, jumpParam, false)

	return JumpEnum.JumpResult.Fail
end

function JumpController:jumpToAct1_9WarmUp(jumpParam, paramList)
	table.insert(self.waitOpenViewNames, ViewName.ActivityBeginnerView)

	local actId = jumpParam

	ActivityModel.instance:setTargetActivityCategoryId(actId)
	Activity125Model.instance:setSelectEpisodeId(actId, 1)
	ActivityController.instance:openActivityBeginnerView(jumpParam)
end

function JumpController:jumpToVersionEnterView(jumpParam)
	local paramsList = string.splitToNumber(jumpParam, "#")
	local actId = paramsList[2]

	if not actId then
		local controller = VersionActivityFixedHelper.getVersionActivityEnterController()

		controller.instance:openVersionActivityEnterView()

		return JumpEnum.JumpResult.Success
	end

	local version = ActivityHelper.getActivityVersion(actId)

	if not version then
		return JumpEnum.JumpResult.Fail
	end

	local controllerName = string.format("VersionActivity%sEnterController", version)

	if not _G[controllerName] then
		if _G[controllerName] then
			_G[controllerName].instance:openVersionActivityEnterView(nil, nil, actId)

			return JumpEnum.JumpResult.Success
		end

		return JumpEnum.JumpResult.Fail
	end
end

function JumpController:jumpToRougeMainView(jumpParam)
	RougeController.instance:openRougeMainView()

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToRougeRewardView(jumpParam)
	table.insert(self.waitOpenViewNames, ViewName.RougeMainView)
	table.insert(self.waitOpenViewNames, ViewName.RougeRewardView)

	local paramsList = string.splitToNumber(jumpParam, "#")
	local arg1 = paramsList[2]
	local arg2 = paramsList[3]

	RougeController.instance:openRougeMainView(function()
		ViewMgr.instance:openView(ViewName.RougeRewardView, {
			version = arg1,
			stage = arg2
		})
	end)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToSeason123(jumpParam)
	local actId = Season123Model.instance:getCurSeasonId()
	local jumpArray = string.splitToNumber(jumpParam, "#")
	local controllerName = string.format("VersionActivity%sEnterController", Activity123Enum.SeasonVersionPrefix[actId])

	if #jumpArray > 1 and jumpArray[2] == Activity123Enum.JumpType.Stage and #jumpArray > 2 then
		local stage = jumpArray[3]

		_G[controllerName].instance:openVersionActivityEnterView(Season123Controller.openSeasonEntryByJump, {
			actId = actId,
			jumpId = Activity123Enum.JumpId.ForStage,
			jumpParam = {
				stage = stage
			}
		}, actId)

		return JumpEnum.JumpResult.Success
	end

	_G[controllerName].instance:openVersionActivityEnterView(Season123Controller.openSeasonEntry, Season123Controller.instance, actId)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToPermanentMainView(jumpParam)
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.PermanentActivity)
	table.insert(self.waitOpenViewNames, ViewName.DungeonView)
	DungeonController.instance:openDungeonView()

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToInvestigateView(jumpParam)
	table.insert(self.waitOpenViewNames, ViewName.InvestigateView)
	table.insert(self.closeViewNames, ViewName.InvestigateTaskView)
	InvestigateController.instance:openInvestigateView()

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToInvestigateOpinionTabView(jumpParam)
	local paramsList = string.splitToNumber(jumpParam, "#")
	local id = paramsList[2]
	local mo = lua_investigate_info.configDict[id]
	local isUnlocked = mo.episode == 0 or DungeonModel.instance:hasPassLevel(mo.episode)

	if not isUnlocked then
		GameFacade.showToast(ToastEnum.InvestigateTip1)

		return JumpEnum.JumpResult.Fail
	end

	table.insert(self.waitOpenViewNames, ViewName.InvestigateOpinionTabView)
	InvestigateController.instance:jumpToInvestigateOpinionTabView(id)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToDiceHeroLevelView(jumpParam)
	local paramsList = string.splitToNumber(jumpParam, "#")
	local chapterId = paramsList[2]

	if not DiceHeroModel.instance.unlockChapterIds[chapterId] then
		GameFacade.showToast(ToastEnum.DiceHeroLockChapter)

		return JumpEnum.JumpResult.Fail
	end

	local co = DiceHeroConfig.instance:getLevelCo(chapterId, 1)

	if not co then
		return JumpEnum.JumpResult.Fail
	end

	table.insert(self.waitOpenViewNames, ViewName.DiceHeroLevelView)
	ViewMgr.instance:openView(ViewName.DiceHeroLevelView, {
		chapterId = chapterId,
		isInfinite = co.mode == 2
	})

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToRoomFishing(jumpParam)
	local paramsList = string.splitToNumber(jumpParam, "#")

	if paramsList[2] == 1 then
		FishingController.instance:openFishingStoreView()
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToMainUISwitchInfoViewGiftSet(jumpParam)
	local paramsList = string.splitToNumber(jumpParam, "#")
	local skinUiId = paramsList[2]
	local sceneId = paramsList[3]

	MainUISwitchController.instance:openMainUISwitchInfoViewGiftSet(skinUiId, sceneId)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToPackageStoreGoodsView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")

	if jumpArray then
		local goodsId = jumpArray[2]
		local packageGoodsMO = StoreModel.instance:getGoodsMO(goodsId)

		if packageGoodsMO and not packageGoodsMO:isSoldOut() then
			self._delayOpenPackageStoreGoodsView = self._delayOpenPackageStoreGoodsView or function(pgMO)
				StoreController.instance:openPackageStoreGoodsView(pgMO)
			end

			TaskDispatcher.runDelay(self._delayOpenPackageStoreGoodsView, packageGoodsMO, 0.1)

			return JumpEnum.JumpResult.Success
		end
	end

	return JumpEnum.JumpResult.Fail
end

function JumpController:jumpToShelterBuilding(jumpParam)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.SurvivalShelter then
		return JumpEnum.JumpResult.Fail
	end

	local paramsList = string.splitToNumber(jumpParam, "#")
	local buildingId = paramsList[2]
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingInfo = weekInfo:getBuildingInfoByBuildingId(buildingId)

	if buildingInfo then
		SurvivalMapHelper.instance:gotoBuilding(buildingInfo.id, nil, true)
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToCommandStationTask(jumpParam)
	if ViewMgr.instance:isOpen(ViewName.CommandStationTaskView) then
		return JumpEnum.JumpResult.Success
	end

	CommandStationController.instance:openCommandStationPaperView(nil, true)
	CommandStationController.instance:openCommandStationTaskView()

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToTowerView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")
	local towerType = jumpArray[2]
	local towerId = jumpArray[3]
	local param = {
		towerType = towerType,
		towerId = towerId
	}

	TowerController.instance:jumpView(param)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToTowerComposeView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")
	local jumpId = jumpArray[2]
	local themeId = jumpArray[3]
	local layerId = jumpArray[4]
	local param = {
		isJump = true,
		jumpId = jumpId,
		themeId = themeId,
		layerId = layerId
	}

	TowerComposeController.instance:jumpView(param)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToOdyssey(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")
	local jumpType = jumpArray[2]
	local jumpElement = jumpArray[3]

	if jumpType == OdysseyEnum.JumpType.JumpToMainElement then
		local curMainMapCo, curMainElementCo = OdysseyDungeonModel.instance:getCurMainElement()

		if curMainElementCo then
			OdysseyDungeonController.instance:jumpToMapElement(curMainElementCo.id)
		else
			OdysseyDungeonController.instance:jumpToHeroPos()
		end
	elseif jumpType == OdysseyEnum.JumpType.JumpToElementAndOpen then
		OdysseyDungeonController.instance:jumpToMapElement(jumpElement)
	elseif jumpType == OdysseyEnum.JumpType.JumpToHeroPos then
		OdysseyDungeonController.instance:jumpToHeroPos()
	elseif jumpType == OdysseyEnum.JumpType.JumpToReligion then
		OdysseyDungeonController.instance:openMembersView()
	elseif jumpType == OdysseyEnum.JumpType.JumpToMyth then
		OdysseyDungeonController.instance:openMythView()
	elseif jumpType == OdysseyEnum.JumpType.JumpToLevelReward then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Odyssey
		}, function()
			OdysseyTaskModel.instance:setTaskInfoList()
			OdysseyDungeonController.instance:openLevelRewardView()
		end)
	elseif jumpType == OdysseyEnum.JumpType.JumpToLibrary then
		OdysseyController.instance:openLibraryView(AssassinEnum.LibraryType.Hero)
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAssassinLibraryView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")
	local jumpActId = jumpArray[2]
	local jumpLibraryType = jumpArray[3]

	AssassinController.instance:openAssassinLibraryView(jumpActId, jumpLibraryType)
end

function JumpController:jumpToStoreSupplementMonthCardUseView(jumpParam)
	local currencyParam = {}
	local item = {
		isHideAddBtn = true,
		id = StoreEnum.SupplementMonthCardItemId,
		type = MaterialEnum.MaterialType.SpecialExpiredItem
	}

	table.insert(currencyParam, item)
	SignInController.instance:showPatchpropUseView(MessageBoxIdDefine.SupplementMonthCardUseTip, MsgBoxEnum.BoxType.Yes_No, currencyParam, self._useSupplementMonthCard, nil, nil, self, nil, nil, SignInModel.instance:getCanSupplementMonthCardDays())
end

function JumpController:jumpToLaplaceChatRoomView()
	LaplaceForumController.instance:openLaplaceChatRoomView()
end

function JumpController:jumpToSurvivalView()
	SurvivalController.instance:openSurvivalView()
end

function JumpController:jumpToAbyss()
	local constConfig = AbyssConfig.instance:getConstConfig(AbyssEnum.ConstId.ActId)

	if not constConfig or string.nilorempty(constConfig.value) then
		logError("新深渊 不存在常量活动id配置")

		return JumpEnum.JumpResult.Fail
	end

	local jumpActId = tonumber(constConfig.value)
	local status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(jumpActId)
	local canJump = status == ActivityEnum.ActivityStatus.Normal

	if not canJump then
		return JumpEnum.JumpResult.Fail
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.AbyssMainView)
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		AbyssController.instance:openMainView(jumpActId, true)
	end, nil, jumpActId, true)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToWeekWalk(jumpParam)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		GameFacade.showToast(ToastEnum.ActivityWeekWalkDeepShowView)

		return JumpEnum.JumpResult.Fail
	end

	local info = WeekWalkModel.instance:getInfo()
	local mapLayerInfo = info and info:getMapInfoByLayer(WeekWalkEnum.LastShallowLayer)
	local isShallowLayerFinish = mapLayerInfo and mapLayerInfo.isFinished >= 1

	if not isShallowLayerFinish then
		GameFacade.showToast(ToastEnum.ActivityWeekWalkDeepShowView)

		return JumpEnum.JumpResult.Fail
	end

	local jumpArray = string.splitToNumber(jumpParam, "#")
	local weekWalkType = jumpArray[2]

	if weekWalkType == 1 then
		WeekWalkController.instance:jumpWeekWalkDeepLayerView()
	elseif weekWalkType == 2 then
		local weekWalkInfo = WeekWalk_2Model.instance:getInfo()

		if not weekWalkInfo or not weekWalkInfo:isOpen() then
			GameFacade.showToast(ToastEnum.ActivityWeekWalkDeepShowView)

			return JumpEnum.JumpResult.Fail
		end

		WeekWalk_2Controller.instance:jumpWeekWalkHeartLayerView()
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAnniversary3GameView()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]
	local isExpire = actInfoMo:isExpired()

	if isExpire then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return JumpEnum.JumpResult.Fail
	end

	local isUnlock = actInfoMo:isOnline() and actInfoMo:isOpen()

	if not isUnlock then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return JumpEnum.JumpResult.Fail
	end

	Anniversary3Controller.instance:openGuessGameMainView()

	return JumpEnum.JumpResult.Success
end

function JumpController:_useSupplementMonthCard()
	SignInRpc.instance:sendSupplementMonthCardRequest()
end

function JumpController:jumpToAct236()
	Act236Controller.instance:openMainView(ActivityEnum.Activity.V3a7_Act236)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToAtomicDungeonView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")
	local jumpType = jumpArray[2]
	local jumpMapId = jumpArray[3]
	local param = {
		jumpType = jumpType,
		jumpMapId = jumpMapId
	}

	AtomicDungeonController.instance:jumpView(param)

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToActivityCenterView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")
	local activityType = jumpArray[2]

	if activityType == ActivityEnum.ActivityType.Normal then
		ActivityController.instance:openActivityNormalView(jumpParam)
	elseif activityType == ActivityEnum.ActivityType.Welfare then
		ActivityController.instance:openActivityWelfareView(jumpParam)
	else
		ActivityController.instance:openActivityBeginnerView(jumpParam)
	end

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToPlayerCardView(jumpParam)
	local playerInfo = PlayerModel.instance:getPlayinfo()

	PlayerCardController.instance:openPlayerCardView({
		userId = playerInfo.userId
	})

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToTeachingMainiew(jumpParam)
	TeachingController.instance:openTeachingMainView()

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToUdimoView(jumpParam)
	UdimoController.instance:enterUdimo()

	return JumpEnum.JumpResult.Success
end

function JumpController:jumpToMainSwitchView(jumpParam)
	local jumpArray = string.splitToNumber(jumpParam, "#")
	local jumpTabs = {}

	for i = 2, #jumpArray do
		table.insert(jumpTabs, jumpArray[i])
	end

	local param = {
		isSwitch = true,
		jumpTabs = jumpTabs
	}

	NavigateButtonsView.homeClick()
	MainController.instance:openMainThumbnailView(param, true)

	return JumpEnum.JumpResult.Success
end

JumpController.JumpViewToHandleFunc = {
	[JumpEnum.JumpView.StoreView] = JumpController.jumpToStoreView,
	[JumpEnum.JumpView.SummonView] = JumpController.jumpToSummonView,
	[JumpEnum.JumpView.SummonViewGroup] = JumpController.jumpToSummonViewGroup,
	[JumpEnum.JumpView.DungeonViewWithChapter] = JumpController.jumpToDungeonViewWithChapter,
	[JumpEnum.JumpView.DungeonViewWithEpisode] = JumpController.jumpToDungeonViewWithEpisode,
	[JumpEnum.JumpView.DungeonViewWithType] = JumpController.jumpToDungeonViewWithType,
	[JumpEnum.JumpView.CharacterBackpackViewWithCharacter] = JumpController.jumpToCharacterBackpackViewWithCharacter,
	[JumpEnum.JumpView.CharacterBackpackViewWithEquip] = JumpController.jumpToCharacterBackpackViewWithEquip,
	[JumpEnum.JumpView.HeroGroupView] = JumpController.jumpToHeroGroupView,
	[JumpEnum.JumpView.BackpackView] = JumpController.jumpToBackpackView,
	[JumpEnum.JumpView.PlayerClothView] = JumpController.jumpToPlayerClothView,
	[JumpEnum.JumpView.MainView] = JumpController.jumpToMainView,
	[JumpEnum.JumpView.TaskView] = JumpController.jumpToTaskView,
	[JumpEnum.JumpView.RoomView] = JumpController.jumpToRoomView,
	[JumpEnum.JumpView.RoomProductLineView] = JumpController.jumpToRoomProductLineView,
	[JumpEnum.JumpView.TeachNoteView] = JumpController.jumpToTeachNoteView,
	[JumpEnum.JumpView.EquipView] = JumpController.jumpToEquipView,
	[JumpEnum.JumpView.HandbookView] = JumpController.jumpToHandbookView,
	[JumpEnum.JumpView.SocialView] = JumpController.jumpToSocialView,
	[JumpEnum.JumpView.NoticeView] = JumpController.jumpToNoticeView,
	[JumpEnum.JumpView.SignInView] = JumpController.jumpToSignInView,
	[JumpEnum.JumpView.SignInViewWithBirthDay] = JumpController.jumpToSignInViewWithBirthDay,
	[JumpEnum.JumpView.SeasonMainView] = JumpController.jumpToSeasonMainView,
	[JumpEnum.JumpView.Show] = JumpController.jumpToShow,
	[JumpEnum.JumpView.BpView] = JumpController.jumpToBpView,
	[JumpEnum.JumpView.ActivityView] = JumpController.jumpToActivityView,
	[JumpEnum.JumpView.LeiMiTeBeiDungeonView] = JumpController.jumpToLeiMiTeBeiDungeonView,
	[JumpEnum.JumpView.Act1_3DungeonView] = JumpController.jumpToAct1_3DungeonView,
	[JumpEnum.JumpView.PushBox] = JumpController.jumpToPushBox,
	[JumpEnum.JumpView.Turnback] = JumpController.jumpToTurnback,
	[JumpEnum.JumpView.Role37Game] = JumpController.jumpToAct1_4Role37Game,
	[JumpEnum.JumpView.Role6Game] = JumpController.jumpToAct1_4Role6Game,
	[JumpEnum.JumpView.Achievement] = JumpController.jumpToAchievement,
	[JumpEnum.JumpView.RoleStoryActivity] = JumpController.jumpToRoleStoryActivity,
	[JumpEnum.JumpView.BossRush] = JumpController.jumpToBossRush,
	[JumpEnum.JumpView.Tower] = JumpController.jumpToTowerView,
	[JumpEnum.JumpView.TowerCompose] = JumpController.jumpToTowerComposeView,
	[JumpEnum.JumpView.Odyssey] = JumpController.jumpToOdyssey,
	[JumpEnum.JumpView.AssassinLibraryView] = JumpController.jumpToAssassinLibraryView,
	[JumpEnum.JumpView.Challenge] = Act183JumpController.jumpToAct183,
	[JumpEnum.JumpView.V1a5Dungeon] = JumpController.jumpToAct1_5DungeonView,
	[JumpEnum.JumpView.V1a6Dungeon] = JumpController.jumpToAct1_6DungeonView,
	[JumpEnum.JumpView.Season123] = JumpController.jumpToSeason123,
	[JumpEnum.JumpView.VersionEnterView] = JumpController.jumpToVersionEnterView,
	[JumpEnum.JumpView.RougeMainView] = JumpController.jumpToRougeMainView,
	[JumpEnum.JumpView.RougeRewardView] = JumpController.jumpToRougeRewardView,
	[JumpEnum.JumpView.PermanentMainView] = JumpController.jumpToPermanentMainView,
	[JumpEnum.JumpView.InvestigateView] = JumpController.jumpToInvestigateView,
	[JumpEnum.JumpView.InvestigateOpinionTabView] = JumpController.jumpToInvestigateOpinionTabView,
	[JumpEnum.JumpView.DiceHero] = JumpController.jumpToDiceHeroLevelView,
	[JumpEnum.JumpView.RoomFishing] = JumpController.jumpToRoomFishing,
	[JumpEnum.JumpView.MainUISwitchInfoViewGiftSet] = JumpController.jumpToMainUISwitchInfoViewGiftSet,
	[JumpEnum.JumpView.PackageStoreGoodsView] = JumpController.jumpToPackageStoreGoodsView,
	[JumpEnum.JumpView.ShelterBuilding] = JumpController.jumpToShelterBuilding,
	[JumpEnum.JumpView.CommandStationTask] = JumpController.jumpToCommandStationTask,
	[JumpEnum.JumpView.BackpackUseType] = JumpController.jumpToBackpackUseTypeView,
	[JumpEnum.JumpView.SkinGiftUseType] = JumpController.jumpToSkinGiftUseTypeView,
	[JumpEnum.JumpView.StoreSupplementMonthCardUseView] = JumpController.jumpToStoreSupplementMonthCardUseView,
	[JumpEnum.JumpView.LaplaceChatRoom] = JumpController.jumpToLaplaceChatRoomView,
	[JumpEnum.JumpView.SurvivalView] = JumpController.jumpToSurvivalView,
	[JumpEnum.JumpView.Abyss] = JumpController.jumpToAbyss,
	[JumpEnum.JumpView.WeekWalk] = JumpController.jumpToWeekWalk,
	[JumpEnum.JumpView.Anniversary3Game] = JumpController.jumpToAnniversary3GameView,
	[JumpEnum.JumpView.Act236] = JumpController.jumpToAct236,
	[JumpEnum.JumpView.AtomicDungeon] = JumpController.jumpToAtomicDungeonView,
	[JumpEnum.JumpView.ActivityCenter] = JumpController.jumpToActivityCenterView,
	[JumpEnum.JumpView.PlayerCard] = JumpController.jumpToPlayerCardView,
	[JumpEnum.JumpView.TeachingMain] = JumpController.jumpToTeachingMainiew,
	[JumpEnum.JumpView.Udimo] = JumpController.jumpToUdimoView,
	[JumpEnum.JumpView.MainSwitchView] = JumpController.jumpToMainSwitchView,
	[JumpEnum.JumpView.V3a9BossRush] = JumpController.jumpToV3a9BossRush,
	[JumpEnum.JumpView.HeroGroupPreView] = JumpController.jumpToHeroGroupPreView
}
JumpController.JumpActViewToHandleFunc = {
	[JumpEnum.ActIdEnum.Act117] = JumpController.jumpToAct117,
	[JumpEnum.ActIdEnum.Act114] = JumpController.jumpToAct114,
	[JumpEnum.ActIdEnum.Act119] = JumpController.jumpToAct119,
	[JumpEnum.ActIdEnum.Act1_2Dungeon] = JumpController.jumpToAct1_2Dungeon,
	[JumpEnum.ActIdEnum.Act1_2Shop] = JumpController.jumpToAct1_2Shop,
	[JumpEnum.ActIdEnum.EnterView1_2] = JumpController.jumpToEnterView1_2,
	[JumpEnum.ActIdEnum.YaXian] = JumpController.jumpToYaXianView,
	[JumpEnum.ActIdEnum.EnterView1_3] = JumpController.jumpToEnterView1_3,
	[JumpEnum.ActIdEnum.Act1_3Dungeon] = JumpController.jumpToAct1_3Dungeon,
	[JumpEnum.ActIdEnum.Act1_3Shop] = JumpController.jumpToAct1_3Shop,
	[JumpEnum.ActIdEnum.Act1_3Act304] = JumpController.jumpToAct1_3Act304,
	[JumpEnum.ActIdEnum.Act1_3Act305] = JumpController.jumpToAct1_3Act305,
	[JumpEnum.ActIdEnum.Act1_3Act306] = JumpController.jumpToAct1_3Act306,
	[JumpEnum.ActIdEnum.Act1_3Act307] = JumpController.jumpToAct119,
	[JumpEnum.ActIdEnum.Act1_3Act125] = JumpController.jumpToAct1_3Act125,
	[JumpEnum.ActIdEnum.EnterView1_4] = JumpController.jumpToEnterView1_4,
	[JumpEnum.ActIdEnum.Act1_4DungeonStore] = JumpController.jumpToAct1_4DungeonStore,
	[JumpEnum.ActIdEnum.Act1_4Dungeon] = JumpController.jumpToAct1_4Dungeon,
	[JumpEnum.ActIdEnum.Act1_4Task] = JumpController.jumpToAct1_4Task,
	[JumpEnum.ActIdEnum.Role37] = JumpController.jumpToAct1_4Role37,
	[JumpEnum.ActIdEnum.Role6] = JumpController.jumpToAct1_4Role6,
	[JumpEnum.ActIdEnum.EnterView1_5] = JumpController.jumpToAct1_5EnterView,
	[JumpEnum.ActIdEnum.Act1_5Dungeon] = JumpController.jumpToAct1_5Dungeon,
	[JumpEnum.ActIdEnum.Act1_5Shop] = JumpController.jumpToAct1_5DungeonStore,
	[JumpEnum.ActIdEnum.Act1_5PeaceUlu] = JumpController.jumpToAct1_5PeaceUluGame,
	[JumpEnum.ActIdEnum.Act1_5SportNews] = JumpController.jumpToAct1_5SportNews,
	[JumpEnum.ActIdEnum.Activity142] = JumpController.jumpToActivity142,
	[JumpEnum.ActIdEnum.Act1_5AiZiLa] = JumpController.jumpToAct1_5AiZiLa,
	[JumpEnum.ActIdEnum.Act1_6EnterView] = JumpController.jumpToAct1_6EnterView,
	[JumpEnum.ActIdEnum.Act1_6Dungeon] = JumpController.jumpToAct1_6Dungeon,
	[JumpEnum.ActIdEnum.Act1_6DungeonStore] = JumpController.jumpToAct1_6DungeonStore,
	[JumpEnum.ActIdEnum.Act1_6DungeonBossRush] = JumpController.jumpToAct1_6DungeonBoss,
	[JumpEnum.ActIdEnum.Act1_6Rougue] = JumpController.jumpToAct1_6Rogue,
	[JumpEnum.ActIdEnum.Act1_6QuNiang] = JumpController.jumpToAct1_6QuNiang,
	[JumpEnum.ActIdEnum.Act1_6GeTian] = JumpController.jumpToAct1_6GeTian,
	[JumpEnum.ActIdEnum.Act1_9WarmUp] = JumpController.jumpToAct1_9WarmUp
}

return JumpController
