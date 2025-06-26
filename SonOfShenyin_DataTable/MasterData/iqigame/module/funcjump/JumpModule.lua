-- chunkname: @IQIGame\\Module\\FuncJump\\JumpModule.lua

JumpModule = {
	jumpCid = 0
}

function JumpModule.Jump(cid, jumpData)
	local cfgData = CfgFunctionTable[cid]

	if cfgData == nil then
		logError("JumpModule.Jump : FunctionCid={0} is invalid.", cid)

		return
	end

	local funcType = cfgData.FuncSwitchOpen

	if funcType ~= 0 and UnlockFunctionModule.OnClickInterceptor(funcType) then
		return
	end

	JumpModule.jumpCid = 0

	local funcIsOpen, uiName, userData = JumpModule.CheckCondition(cfgData)

	if funcIsOpen == false then
		if cfgData.TipsType == 1 then
			NoticeModule.ShowNotice(51012)
		elseif cfgData.TipsType == 2 then
			NoticeModule.ShowNotice(21044002)
		elseif cfgData.TipsType == 3 then
			NoticeModule.ShowNotice(11009)
		end

		return
	end

	if uiName ~= nil then
		JumpModule.CloseUIGroup()

		if uiName == Constant.UIControllerName.ChapterStageMapUI then
			UIModule.Open(Constant.UIControllerName.PlayingMethodUI, Constant.UILayer.UI)
		end

		UIModule.Open(uiName, Constant.UILayer.UI, userData)
	else
		logError("未找到对应的跳转类型   " .. tostring(cfgData.FunctionType))
		JumpModule.CloseUIGroup()
	end
end

function JumpModule.CheckCondition(cfgData)
	local funcIsOpen = true
	local userData, uiName

	if cfgData.FunctionType == Constant.Function.openRoleDevelopmentUI then
		uiName = Constant.UIControllerName.WarlockChoosePanel
	elseif cfgData.FunctionType == Constant.Function.openGameLevel then
		local tabIndex = cfgData.Params[1]

		userData = {
			forShowDetails = true,
			tabIndex = tabIndex
		}
		uiName = Constant.UIControllerName.ChapterStageMapUI
	elseif cfgData.FunctionType == Constant.Function.openFriendUI then
		uiName = Constant.UIControllerName.FriendUI
		userData = {
			cfgData.Params[1],
			cfgData.Params[2]
		}
	elseif cfgData.FunctionType == Constant.Function.openShopUI then
		uiName = Constant.UIControllerName.ShopUI
		userData = cfgData.Params
	elseif cfgData.FunctionType == Constant.Function.openMailUI then
		uiName = Constant.UIControllerName.MailUI
	elseif cfgData.FunctionType == Constant.Function.openLotteryUI then
		uiName = Constant.UIControllerName.LotteryUI
		userData = {
			cardJackpotID = cfgData.Params[1]
		}
	elseif cfgData.FunctionType == Constant.Function.openUserInfoUI then
		uiName = Constant.UIControllerName.UserInfoUI
	elseif cfgData.FunctionType == Constant.Function.openWarehouseUI then
		uiName = Constant.UIControllerName.WarehouseUI
		userData = {
			mianTable = cfgData.Params[1],
			subTable = cfgData.Params[2]
		}
	elseif cfgData.FunctionType == Constant.Function.openFormationUI then
		uiName = Constant.UIControllerName.CombatForMationUI
	elseif cfgData.FunctionType == Constant.Function.openWarlockChooseUI then
		uiName = Constant.UIControllerName.WarlockChoosePanel
	elseif cfgData.FunctionType == Constant.Function.openChapterUI then
		local conditionResults = ConditionModule.CheckMultiple(CfgDupTagTable[cfgData.Params[1]].UnlockConditionId)
		local dupCfgConditionResults = ConditionModule.CheckMultiple(CfgDupTagTable[cfgData.Params[2]].UnlockConditionId)

		funcIsOpen = ConditionModule.CheckMultipleAllIsPass(conditionResults) and ConditionModule.CheckMultipleAllIsPass(dupCfgConditionResults)

		if cfgData.Params[2] == nil then
			-- block empty
		end

		local selectedTagId = cfgData.Params[2]

		userData = {
			tagId = cfgData.Params[1],
			selectedTagId = selectedTagId
		}
		uiName = Constant.UIControllerName.ResourceStageUI
	elseif cfgData.FunctionType == Constant.Function.openNoviceSignUI then
		uiName = Constant.UIControllerName.NoviceSignUI
	elseif cfgData.FunctionType == Constant.Function.openNoviceGradeUI then
		uiName = Constant.UIControllerName.NoviceGradeUI
	elseif cfgData.FunctionType == Constant.Function.openNoviceTaskUI then
		uiName = Constant.UIControllerName.NoviceTaskUI
	elseif cfgData.FunctionType == Constant.Function.openBuyEnergyUI then
		uiName = Constant.UIControllerName.BuyEnergyUI
	elseif cfgData.FunctionType == Constant.Function.openConvertUI then
		uiName = Constant.UIControllerName.ConvertUI
	elseif cfgData.FunctionType == Constant.Function.openActivityPassUI then
		uiName = Constant.UIControllerName.ActivityPassUI
	elseif cfgData.FunctionType == Constant.Function.openComposeUI then
		uiName = Constant.UIControllerName.TransformUI
	elseif cfgData.FunctionType == Constant.Function.openActivityListUI then
		uiName = Constant.UIControllerName.ActivityListUI
		userData = {
			teamID = cfgData.Params[1],
			selectViewType = cfgData.Params[2]
		}
	elseif cfgData.FunctionType == Constant.Function.SummerActivity then
		local activityPod = ActivityModule.GetActivityPodByActivityType({
			Constant.ActivityType.ActivityType_Summer
		})[1]

		if cfgData.Params[1] == 1 then
			uiName = Constant.UIControllerName.SummerActivityStageUI

			if cfgData.Params[2] then
				userData = {
					activityPod = activityPod,
					selectChapterId = cfgData.Params[2]
				}
			else
				userData = {
					activityPod = activityPod
				}
			end
		elseif cfgData.Params[1] == 2 then
			uiName = Constant.UIControllerName.ActivityShopUI
			userData = {
				activityPod = activityPod
			}
		elseif cfgData.Params[1] == 3 then
			uiName = Constant.UIControllerName.SummerActivityTaskUI
		end
	elseif cfgData.FunctionType == Constant.Function.EnterRoom then
		WorldMapModule.EnterRoom(cfgData.Params[1], true)

		funcIsOpen = false
	elseif cfgData.FunctionType == Constant.Function.openTowerUI then
		uiName = Constant.UIControllerName.LoopTowerDungeonUI
	elseif cfgData.FunctionType == Constant.Function.openActivityPassBuyHightViewUI then
		uiName = Constant.UIControllerName.ActivityPassUI
		userData = {
			openBuyView = cfgData.Params[1] == 1
		}
	elseif cfgData.FunctionType == Constant.Function.openShopFreeUI then
		uiName = Constant.UIControllerName.ShopFreeUI
		userData = cfgData.Params
	end

	return funcIsOpen, uiName, userData
end

function JumpModule.CloseUIGroup()
	GameEntry.UI:CloseUIGroup(Constant.UILayer.Mid)
	GameEntry.UI:CloseUIGroup(Constant.UILayer.Tooltip)
end

function JumpModule.CheckContinueJump(isAddScene)
	if isAddScene then
		return
	end

	if JumpModule.jumpCid ~= 0 then
		JumpModule.Jump(JumpModule.jumpCid)
	end
end

function JumpModule.CheckConditionIsPass(cfgData)
	local isOpen = false

	if cfgData.FuncSwitchOpen == Constant.UnlockType.FUNC_DAILY_DUP then
		local conditionResults = ConditionModule.CheckMultiple(CfgDupTagTable[cfgData.Params[1]].UnlockConditionId)
		local dupCfgconditionResults = ConditionModule.CheckMultiple(CfgDupTagTable[cfgData.Params[2]].UnlockConditionId)

		isOpen = ConditionModule.CheckMultipleAllIsPass(conditionResults) and UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_DAILY_DUP) and ConditionModule.CheckMultipleAllIsPass(dupCfgconditionResults)
	else
		isOpen = JumpModule.CheckCondition(cfgData) and UnlockFunctionModule.IsUnlock(cfgData.FuncSwitchOpen)
	end

	return isOpen
end
