-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\Beginner\\BeginnerManager.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local ResBeginnerGuide = require("ClientData/ResBeginnerGuide")
local ResBeginnerGuideSteps = require("ClientData/ResBeginnerGuideSteps")
local DragPlane = require("UI/Control/Com/DragPlane")
local RearHouseDragCenter = require("Logic/RearHouse/RearHouseDragCenter")
local UserData = require("Helper/UserData")
local ResHeroCrystalStory = require("ClientData/ResHeroCrystalStory")
local ResPetGashaponDrawUp = require("ClientData/ResPetGashaponDrawUp")
local ResPetGashaponDrawLib = require("ClientData/ResPetGashaponDrawLib")
local ResPetGashaponDraw = require("ClientData/ResPetGashaponDraw")
local ClimbTowerDragCenter = require("ClimbTowerDemo/ClimbTowerDragCenter")
local EliminateDragCenter = require("EliminateGame/EliminateDragCenter")
local BeginnerManager = {}
local self = BeginnerManager

function BeginnerManager.isBeginnerFinished(beginnerId)
	if CurAvatar then
		return CurAvatar.beginnerFinished[beginnerId]
	end

	return true
end

function BeginnerManager.onBeginnerFinish(beginnerId)
	CurAvatar:sendNodeAnalyticsData(Const.OSS_TYPE_FINISH_BEGINNER, beginnerId)

	if CurAvatar and not CurAvatar.beginnerFinished[beginnerId] then
		RPC.newbieReport(beginnerId)

		CurAvatar.beginnerFinished[beginnerId] = true
	end

	self.stepConditionDict[beginnerId] = nil

	CurAvatar:checkGameAssistant(Const.GAME_ASSISTANT_TRIGGER_TYPE.BeginnerFinish, {
		arg = beginnerId
	}, true)

	for triggerType, triggerInfo in pairs(self.triggerDict) do
		for index, triggerId in ipairs(triggerInfo) do
			if triggerId == beginnerId then
				table.remove(triggerInfo, index)

				return
			end
		end
	end
end

function BeginnerManager.beginnerMayBeTriggered(info, beginnerId)
	if info.trigger_always ~= 1 and self.isBeginnerFinished(beginnerId) then
		return false
	end

	if info.conditions then
		local args = info.condition_args or {}

		if info.conditions == Const.BEGINNER_CONDITION_STAGE then
			if CurAvatar:getMainStageStateByInfo(tonumber(args[1] or 1), tonumber(args[2] or 1), tonumber(args[3] or 1)) == Const.STAGE_STATE_PASSED then
				return false
			end
		elseif info.conditions == Const.BEGINNER_CONDITION_STAGE_RANGE and CurAvatar:mainStageStatePassed(tonumber(args[4] or 1), tonumber(args[5] or 1), tonumber(args[6] or 1)) then
			return false
		end
	end

	return true
end

function BeginnerManager.initPlayerData()
	local lockInfo = UserData.loadCommonData("BeginnerLock")

	if lockInfo and lockInfo ~= "" then
		ClientUtils.trySendException(lockInfo)
		UserData.saveCommonData("BeginnerLock", "")
	end

	self.corStep = {}
	self.triggerDict = {}
	self.nowBeginnerDict = {}
	self.noticeCanvas = {}
	self.noticeFuncs = {}
	self.stepNoticeCanvas = {}
	self.stepNoticeCanvasClose = {}
	self.stepNoticeBattles = {}
	self.stepNoticeFormations = {}
	self.stepConditionDict = {}
	self.beginnerCachedUI = {}
	self.stepNoticeMiniGame = {}

	for beginnerId, info in pairs(ResBeginnerGuide) do
		if info.trigger_node and self.beginnerMayBeTriggered(info, beginnerId) then
			if not self.triggerDict[info.trigger_node] then
				self.triggerDict[info.trigger_node] = {}
			end

			table.insert(self.triggerDict[info.trigger_node], beginnerId)

			if info.trigger_node == Const.BEGINNER_TRIGGER_OPEN_CANVAS and info.trigger_args and info.trigger_args[1] then
				self.noticeCanvas[info.trigger_args[1]] = true
			end

			if info.trigger_node == Const.BEGINNER_TRIGGER_SPECIAL_FUNC and info.trigger_args and info.trigger_args[1] then
				if not self.noticeFuncs[info.trigger_args[1]] then
					self.noticeFuncs[info.trigger_args[1]] = {}
				end

				self.noticeFuncs[info.trigger_args[1]][beginnerId] = info
			end
		end
	end

	for _, info in pairs(self.triggerDict) do
		table.sort(info)
	end
end

function BeginnerManager.onTriggerCanvasOpen(prefabName)
	if self.noticeCanvas and self.noticeCanvas[prefabName] then
		self.onTrigger(Const.BEGINNER_TRIGGER_OPEN_CANVAS, {
			prefabName
		})
	end

	if self.stepNoticeCanvas and self.stepNoticeCanvas[prefabName] then
		local beginnerId = self.stepNoticeCanvas[prefabName]

		self.stepNoticeCanvas[prefabName] = nil

		self._startThisStep(beginnerId)
	end
end

function BeginnerManager.onTriggerCanvasClosed(prefabName)
	if self.stepNoticeCanvasClose and self.stepNoticeCanvasClose[prefabName] then
		local beginnerId = self.stepNoticeCanvasClose[prefabName]

		self.stepNoticeCanvasClose[prefabName] = nil

		self._startThisStep(beginnerId)
	end
end

function BeginnerManager.HeroStepUp(hero)
	local triggerInfo = self.noticeFuncs.HeroStepUp

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			if beginnerData.trigger_args[2] == "1" then
				if hero.step == 1 and hero.career == Const.CAREER_TYPE.SUPPORT then
					self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {
						hero
					}, beginnerId)
				end
			elseif beginnerData.trigger_args[2] == "2" and hero.step == 1 and hero.career ~= Const.CAREER_TYPE.SUPPORT then
				self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {
					hero
				}, beginnerId)
			end
		end
	end
end

function BeginnerManager.NewBieDrawCardOver()
	local triggerInfo = self.noticeFuncs.NewBieDrawCardOver

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
		end
	end
end

function BeginnerManager.ShowHeroGrowPanel(hero)
	local triggerInfo = self.noticeFuncs.ShowHeroGrowPanel

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			if beginnerData.trigger_args[2] == "1" and hero.level >= (tonumber(beginnerData.trigger_args[3]) or 0) and hero.step == (tonumber(beginnerData.trigger_args[4]) or 0) then
				self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {
					hero
				}, beginnerId)
			end
		end
	end
end

function BeginnerManager.ShowHeroEnjoyPanel()
	local triggerInfo = self.noticeFuncs.ShowHeroEnjoyPanel

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
		end
	end
end

function BeginnerManager.ShowDrawStandardHero()
	local triggerInfo = self.noticeFuncs.ShowDrawStandardHero

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
		end
	end
end

function BeginnerManager.CrystalSecondUnlock()
	local triggerInfo = self.noticeFuncs.CrystalSecondUnlock

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
		end
	end
end

function BeginnerManager.CheckRearHouseLevel()
	local triggerInfo = self.noticeFuncs.CheckRearHouseLevel

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			local needLevel = tonumber(beginnerData.trigger_args[2]) or 0

			if needLevel <= CurAvatar.rearHouseData.level then
				self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
			end
		end
	end
end

function BeginnerManager.CheckHeroHatEnhance(equipGid)
	local triggerInfo = self.noticeFuncs.CheckHeroHatEnhance

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			if CurAvatar:checkHeroHatEnhance(equipGid) then
				self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
			end
		end
	end
end

function BeginnerManager.CheckGoNextLayer(args)
	local triggerInfo = self.noticeFuncs.CheckGoNextLayer
	local layer = args[1]

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			if beginnerData.trigger_args and beginnerData.trigger_args[2] == tostring(layer) then
				beginnerData.extraFuncArgs = {
					layer
				}

				self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {
					layer
				}, beginnerId)
			end
		end
	end
end

function BeginnerManager.CheckPetCanWearGem(petId)
	local triggerInfo = self.noticeFuncs.CheckPetCanWearGem

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			if CurAvatar:petGemSystemEnable() and CurAvatar.petDic[petId] and CurAvatar.petDic[petId]:checkCanWearGem() then
				self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
			end
		end
	end
end

function BeginnerManager.CheckPetGemCanLvUp()
	local triggerInfo = self.noticeFuncs.CheckPetGemCanLvUp

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			if CurAvatar:petGemSystemEnable() and CurAvatar.canLvUpGemsList and #CurAvatar.canLvUpGemsList > 0 then
				self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
			end
		end
	end
end

function BeginnerManager.CheckPaintPlusCanUnlock(...)
	local triggerInfo = self.noticeFuncs.CheckPaintPlusCanUnlock

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			if Const.PAINT_PLUS_OPEN then
				local ui = UIManager.tryGetUI("heroPaintingDlg")

				if ui and ui:getVisible() and ui.hero and ui and ui.isMaxPaintLv then
					self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
				end
			end
		end
	end
end

function BeginnerManager.CheckSneakBattleSecondLevel(...)
	local triggerInfo = self.noticeFuncs.CheckSneakBattleSecondLevel

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
		end
	end
end

function BeginnerManager.CheckSneakBattleFormation(...)
	local triggerInfo = self.noticeFuncs.CheckSneakBattleFormation

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
		end
	end
end

function BeginnerManager.CheckPetPoolCanReset()
	local triggerInfo = self.noticeFuncs.CheckPetPoolCanReset

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			if CurAvatar:checkPetPoolCanReset() then
				self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
			end
		end
	end
end

function BeginnerManager.CheckManagementAssignToyTypeOpen()
	local triggerInfo = self.noticeFuncs.CheckManagementAssignToyTypeOpen

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_MANAGEMENT)

			if actObj and actObj:isValid() and actObj.actData and actObj.actData:getLeftAssignToyTypeTimes() > 0 then
				self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
			end
		end
	end
end

function BeginnerManager.CheckManagementImproveToyQualityOpen()
	local triggerInfo = self.noticeFuncs.CheckManagementImproveToyQualityOpen

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_MANAGEMENT)

			if actObj and actObj:isValid() and actObj.actData and actObj.actData:getLeftImproveToyQualityTimes() > 0 then
				self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
			end
		end
	end
end

function BeginnerManager.CheckManagementBreakOutOpen()
	local triggerInfo = self.noticeFuncs.CheckManagementBreakOutOpen

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_MANAGEMENT)

			if actObj and actObj:isValid() and actObj.actData and actObj.actData.curLucky >= actObj.actData.maxLucky then
				self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
			end
		end
	end
end

function BeginnerManager.CheckManagementCanCommitOrder()
	local triggerInfo = self.noticeFuncs.CheckManagementCanCommitOrder

	if triggerInfo then
		for beginnerId, beginnerData in pairs(triggerInfo) do
			local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_MANAGEMENT)

			if actObj and actObj:isValid() and actObj.actData and actObj.actData:checkCanCommitOrder() then
				self.onTrigger(Const.BEGINNER_TRIGGER_SPECIAL_FUNC, {}, beginnerId)
			end
		end
	end
end

function BeginnerManager.BeforeCreateRole(condition_args)
	if CurAvatar:playerNameInited() then
		return false
	end

	if CurAvatar.roleDrawData[Const.DrawTypeStandard].totalDrawCount > 0 then
		return false
	end

	if CurAvatar:mainStageStatePassed(tonumber(condition_args[2] or 1), tonumber(condition_args[3] or 1), tonumber(condition_args[4] or 1)) then
		return true
	end

	return false
end

function BeginnerManager.MiniGamePassLevel(condition_args)
	if CurAvatar:mainStageStatePassed(1, 1, 1) then
		return false
	end

	if CurAvatar:miniGameEnable() then
		if condition_args and condition_args[2] and condition_args[3] then
			for type, data in pairs(Const.MINI_GAME_INFO) do
				if CurAvatar:isPassChapterAndStage(type, tonumber(condition_args[2]), tonumber(condition_args[3])) then
					return true
				end
			end
		end
	elseif condition_args and condition_args[4] and tonumber(condition_args[4]) == 1 then
		return true
	end

	return false
end

function BeginnerManager.HeroResetCheck(condition_args)
	if CurAvatar:beginnerHeroResetEnable() then
		return true
	end

	return false
end

function BeginnerManager.HeroResetCheck2(condition_args)
	if CurAvatar:beginnerHeroResetEnable2() then
		return true
	end

	return false
end

function BeginnerManager:CrystalFirstStepOver(condition_args)
	if CurAvatar:isCrystalFirstPartOver() then
		return true
	end

	return false
end

function BeginnerManager.CrystalSecondCheck(condition_args)
	if CurAvatar:isCrystalSecondPartNew() then
		return true
	end

	return false
end

function BeginnerManager.HeroStoryUnlocked(condition_args)
	if CurAvatar:isCrystalSecondPartNew() and Const.ENABLE_CRYSTAL_LEVEL_ACHIEVE then
		local heroMainDlg = UIManager.tryGetUI("heroMainDlg")

		if heroMainDlg and heroMainDlg:isInShow() then
			return true
		end
	end

	return false
end

function BeginnerManager.FirstRechargeCheck(condition_args)
	local fState = CurAvatar:getFirstRechargeState()

	if fState then
		if CurAvatar:mainStageStatePassed(1, 1, 9) then
			return false
		end

		return true
	end

	return false
end

function BeginnerManager.EquipTowerNormalOver(condition_args)
	local equipTowerLevelDlg = UIManager.tryGetUI("equipTowerLevelDlg")

	if equipTowerLevelDlg and equipTowerLevelDlg:isInShow() then
		local equipType = equipTowerLevelDlg.currentPageIndex

		if equipType then
			return CurAvatar:isEquipTowerNormalOver(equipType)
		end
	end

	return false
end

function BeginnerManager.haveOverflowHero(condition_args)
	return CurAvatar:haveOverflowHero()
end

function BeginnerManager.isCircleMaster(condition_args)
	if CurAvatar:isLeader() then
		return true
	end

	return false
end

function BeginnerManager.ConditionFuncOpenCreateNewPlan(condition_args)
	if condition_args and condition_args[2] then
		local limitID = tonumber(condition_args[2])
		local isLocked = ConditionLimitManager.inLimitState(limitID)

		if not isLocked and utils.getTableElemCount(CurAvatar.equipPlanDic) == 0 then
			return true
		end
	end

	return false
end

function BeginnerManager.ConditionFuncOpenWearInfo(condition_args)
	if condition_args and condition_args[2] then
		local limitID = tonumber(condition_args[2])

		if ConditionLimitManager.inLimitState(limitID) then
			return false
		end
	end

	local state = GameFsm.getCurState()

	if GameFsm.isInBattleState() and state.checkOpenWearInfo and state:checkOpenWearInfo() then
		return true
	end

	return false
end

function BeginnerManager.ConditionStageCanSkip(condition_args)
	if CurAvatar:checkCanSkipStage() then
		return true
	end

	return false
end

function BeginnerManager.BeginnerNodeUniqueHero(condition_args)
	if CurAvatar:HasUniqueHero() then
		return true
	end

	return false
end

function BeginnerManager.CheckPetMazeHaveBattleHeroList(condition_args)
	local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_PET_MAZE)

	if actObj and actObj:isValid() and actObj.actData and actObj.actData:checkHaveBattleFormation() then
		return true
	end

	return false
end

function BeginnerManager.CheckManagementHaveStorehouseOrder(condition_args)
	local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_MANAGEMENT)

	if actObj and actObj:isValid() and actObj.actData and actObj.actData:checkHaveStorehouseOrder() then
		return true
	end

	return false
end

function BeginnerManager.ConditionFuncMazeEffect(condition_args, beginnerId)
	return not RearHouseDragCenter.isEffectShowing()
end

function BeginnerManager.ConditionFuncHeroSkillReady(condition_args, beginnerId)
	if GameFsm.isInState(Const.STATE_BATTLE) then
		local needHero, heroPos

		if condition_args then
			needHero = tonumber(condition_args[2])
			heroPos = tonumber(condition_args[3])
		end

		local players = GameFsm.getCurState():getPlayers()
		local orderPlayers = {}

		for i = 12, 1, -1 do
			if players[i] and not players[i]:attackNear() then
				table.insert(orderPlayers, players[i])
			end
		end

		for i = 12, 1, -1 do
			if players[i] and players[i]:attackNear() then
				table.insert(orderPlayers, players[i])
			end
		end

		local skip = true

		if heroPos <= #orderPlayers then
			for index, player in pairs(orderPlayers) do
				if not needHero or player.heroID == needHero then
					skip = false

					break
				end
			end
		end

		if skip then
			local step = self.nowBeginnerDict[beginnerId]

			Const.BEGINNER_LOCK_SKILL = nil

			self.onStepOver(beginnerId, step)

			return false
		end

		for index, player in pairs(orderPlayers) do
			if player.mana >= BattleConst.MAX_MANA and not player:manualWaitingSkill() and (not needHero or player.heroID == needHero and index == heroPos) then
				Const.BEGINNER_LOCK_SKILL = nil

				return true
			end
		end

		Const.BEGINNER_LOCK_SKILL = nil

		return false
	else
		Const.BEGINNER_LOCK_SKILL = nil

		self.stopBeginnerStep(beginnerId)

		return false
	end
end

self.disable = false

function BeginnerManager.onTrigger(triggerType, triggerArgs, triggerId)
	if self.disable then
		return
	end

	if self.triggerDict[triggerType] then
		for _, beginnerId in ipairs(self.triggerDict[triggerType]) do
			if self.canTriggerBeginner(beginnerId, triggerArgs, triggerId) then
				self.startBeginnerStep(beginnerId)

				return
			end
		end
	end
end

function BeginnerManager.canTriggerBeginner(beginnerId, triggerArgs, triggerId)
	if triggerId and beginnerId ~= triggerId then
		return false
	end

	local beginnerData = ResBeginnerGuide[beginnerId] or {}

	if beginnerData.conditions then
		local args = beginnerData.condition_args or {}

		if beginnerData.conditions == Const.BEGINNER_CONDITION_STAGE then
			if CurAvatar:getMainStageStateByInfo(tonumber(args[1] or 1), tonumber(args[2] or 1), tonumber(args[3] or 1)) ~= Const.STAGE_STATE_ATK_AF then
				return false
			end
		elseif beginnerData.conditions == Const.BEGINNER_CONDITION_LEVEL then
			if CurAvatar:getLevel() < tonumber(args[1] or 1) then
				return false
			end
		elseif beginnerData.conditions == Const.BEGINNER_CONDITION_STAGE_PASSED then
			if not CurAvatar:mainStageStatePassed(tonumber(args[1] or 1), tonumber(args[2] or 1), tonumber(args[3] or 1)) then
				return false
			end
		elseif beginnerData.conditions == Const.BEGINNER_CONDITION_STEP_TOWER then
			if not CurAvatar:checkStepTowerIsNowPass(tonumber(args[1] or 1), tonumber(args[2] or 1)) then
				return false
			end
		elseif beginnerData.conditions == Const.BEGINNER_CONDITION_STAGE_RANGE then
			if not CurAvatar:mainStageStatePassed(tonumber(args[1] or 1), tonumber(args[2] or 1), tonumber(args[3] or 1)) then
				return false
			end

			if CurAvatar:mainStageStatePassed(tonumber(args[4] or 1), tonumber(args[5] or 1), tonumber(args[6] or 1)) then
				return false
			end
		elseif beginnerData.conditions == Const.BEGINNER_CONDITION_CUSTOM_FUNC then
			local funcName = args[1]

			if self[funcName] and not self[funcName](args) then
				return false
			end
		elseif beginnerData.conditions == Const.BEGINNER_CONDITION_CONDITION_LIMIT then
			local condOK = false

			for _, condiId in ipairs(args) do
				local intId = tonumber(condiId)

				if intId and not ConditionLimitManager.inLimitState(intId) then
					condOK = true

					break
				end
			end

			if not condOK then
				return false
			end
		elseif beginnerData.conditions == Const.BEGINNER_CONDITION_ACTIVITY_STATE then
			local actId = tonumber(args[1])
			local actObj = CurAvatar:getActivityObj(actId)

			if not actObj or not actObj:inOpenState() or not actObj:isValid() then
				return false
			end
		end
	end

	local needArgs = beginnerData.trigger_args

	if beginnerData.trigger_node == Const.BEGINNER_TRIGGER_BATTLE_FORMATION or beginnerData.trigger_node == Const.BEGINNER_TRIGGER_BATTLE_START then
		local pveId = triggerArgs[1]
		local stageInfo = triggerArgs[2]
		local battleType = triggerArgs[3]

		if needArgs ~= nil then
			if #needArgs == 1 then
				if tonumber(needArgs[1]) then
					if tonumber(needArgs[1]) ~= pveId then
						return false
					end
				elseif needArgs[1] ~= battleType then
					return false
				end
			elseif #needArgs == 3 then
				if stageInfo and stageInfo[1] == tonumber(needArgs[1]) and stageInfo[2] == tonumber(needArgs[2]) and stageInfo[3] == tonumber(needArgs[3]) then
					beginnerData.continueArgs = triggerArgs

					return true
				else
					return false
				end
			else
				beginnerData.continueArgs = triggerArgs
			end
		end
	elseif beginnerData.trigger_node == Const.BEGINNER_TRIGGER_OPEN_CANVAS then
		if needArgs ~= nil and triggerArgs ~= nil and needArgs[1] ~= triggerArgs[1] then
			return false
		end

		beginnerData.continueArgs = triggerArgs
	elseif beginnerData.trigger_node == Const.BEGINNER_TRIGGER_MINI_GAME then
		local miniGameType = triggerArgs[1]
		local chapter = triggerArgs[2]
		local stage = triggerArgs[3]

		if needArgs ~= nil and #needArgs == 3 then
			if miniGameType ~= tonumber(needArgs[1]) or chapter ~= tonumber(needArgs[2]) or stage ~= tonumber(needArgs[3]) then
				return false
			end

			beginnerData.continueArgs = triggerArgs
		end
	end

	return true
end

function BeginnerManager.stopBeginnerStep(beginnerId)
	for pveId, bId in pairs(self.stepNoticeBattles) do
		if bId == beginnerId then
			self.stepNoticeBattles[pveId] = nil

			break
		end
	end

	if self.beginnerCachedUI[beginnerId] and self.beginnerCachedUI[beginnerId].id then
		self.beginnerCachedUI[beginnerId]:setVisible(false)
	end

	for dstPos, bId in pairs(self.stepNoticeFormations) do
		if bId == beginnerId then
			self.stepNoticeFormations[dstPos] = nil

			break
		end
	end

	if self.corStep[beginnerId] then
		coroutine.stop(self.corStep[beginnerId])
	end

	self.stepConditionDict[beginnerId] = nil
	self.nowBeginnerDict[beginnerId] = nil

	for type, bId in pairs(self.stepNoticeMiniGame) do
		if bId == beginnerId then
			self.stepNoticeMiniGame[type] = nil

			break
		end
	end
end

function BeginnerManager.clearPushUIs()
	local uis = {
		"welfarePushGiftDlg"
	}

	for _, uiName in ipairs(uis) do
		local ui = UIManager.tryGetUI(uiName)

		if ui and ui:getVisible() then
			ui:setVisible(false)
		end
	end
end

function BeginnerManager.startBeginnerStep(beginnerId)
	CurAvatar:sendNodeAnalyticsData(Const.OSS_TYPE_START_BEGINNER, beginnerId)

	if self.nowBeginnerDict[beginnerId] then
		self.stopBeginnerStep(beginnerId)
	end

	self.nowBeginnerDict[beginnerId] = 0

	if self.corStep[beginnerId] then
		coroutine.stop(self.corStep[beginnerId])
	end

	self.corStep[beginnerId] = coroutine.start(self.startNextStep, beginnerId)
end

Const.BEGINNER_STEP_MOVIE = 1
Const.BEGINNER_STEP_BATTLE = 2
Const.BEGINNER_STEP_CLICK_BUTTON = 3
Const.BEGINNER_STEP_NOTICE = 4
Const.BEGINNER_STEP_FORMATION = 5
Const.BEGINNER_STEP_PLAY_AVG = 6
Const.BEGINNER_STEP_CHANGE_FORMATION = 7
Const.BEGINNER_STEP_FORCE_NOTICE = 8
Const.BEGINNER_STEP_HERO_OPERA = 9
Const.BEGINNER_STEP_CANVAS = 10
Const.BEGINNER_STEP_CANVAS_OPERA = 11
Const.BEGINNER_STEP_SHOW_GRAPHIC = 12
Const.BEGINNER_STEP_PLAY_AVG_FRONT = 13
Const.BEGINNER_STEP_SHOW_GRAPHIC_LIST = 14
Const.BEGINNER_STEP_MAZE_DRAG = 15
Const.BEGINNER_STEP_SHOW_GRAPHIC_LIST_MOVIE = 16
Const.BEGINNER_STEP_PLAYER_FUNC = 17
Const.BEGINNER_STEP_MINI_GAME_DRAG = 18

function BeginnerManager.startNextStep(beginnerId)
	local step = (self.nowBeginnerDict[beginnerId] or 0) + 1
	local stepData = ResBeginnerGuideSteps[beginnerId] or {}

	if step > #stepData then
		self.onBeginnerFinish(beginnerId)

		self.nowBeginnerDict[beginnerId] = nil

		local ui = UIManager.getUI("rookieMainDlg", nil, false)

		if ui then
			ui:setVisible(false)
		end

		local beginnerData = ResBeginnerGuide[beginnerId] or {}

		if beginnerData.continue then
			if beginnerData.trigger_node == Const.BEGINNER_TRIGGER_SPECIAL_FUNC then
				if beginnerData.trigger_args and beginnerData.trigger_args[1] and BeginnerManager[beginnerData.trigger_args[1]] then
					if beginnerData.extraFuncArgs then
						BeginnerManager[beginnerData.trigger_args[1]](beginnerData.extraFuncArgs)
					else
						BeginnerManager[beginnerData.trigger_args[1]]()
					end
				end
			else
				self.onTrigger(beginnerData.trigger_node, beginnerData.continueArgs or {})
			end
		end

		return
	end

	self.nowBeginnerDict[beginnerId] = step
	stepData = stepData[step]

	local operaType = stepData.operate_type

	if operaType == Const.BEGINNER_STEP_FORMATION or operaType == Const.BEGINNER_STEP_CHANGE_FORMATION then
		coroutine.wait(0.3)
	elseif step == 1 and (operaType == Const.BEGINNER_STEP_CLICK_BUTTON or operaType == Const.BEGINNER_STEP_NOTICE or operaType == Const.BEGINNER_STEP_FORCE_NOTICE) then
		coroutine.wait(0.05)
	end

	self._startThisStep(beginnerId)
end

function BeginnerManager._startThisStep(beginnerId)
	self.clearPushUIs()

	local step = self.nowBeginnerDict[beginnerId]
	local stepData = ResBeginnerGuideSteps[beginnerId] or {}

	stepData = stepData[step]

	if not stepData then
		return
	end

	if not self._checkStepCondition(beginnerId, stepData.conditions, stepData.condition_args) then
		self.stepConditionDict[beginnerId] = stepData

		self.StepConditionTimer:Restart()

		return
	end

	self.stepConditionDict[beginnerId] = nil

	local startAction = stepData.start_action

	if startAction then
		self.doAction(startAction)
	end

	local voice_id = stepData.voice_id

	if voice_id then
		CueManager.playVocal(voice_id)
	end

	local operaType = stepData.operate_type

	CurAvatar:sendBeginnerAnalytics(beginnerId, step, operaType)

	if operaType == Const.BEGINNER_STEP_MOVIE then
		local playerDlg = UIManager.getUI("sequenceFramePlayer", true)

		playerDlg:playVideo(stepData.other_info1, nil, Functor(self.onStepOver, beginnerId, step), true)
	elseif operaType == Const.BEGINNER_STEP_BATTLE then
		self.startFixedBattle(beginnerId, step, stepData.other_info1)
	elseif operaType == Const.BEGINNER_STEP_CLICK_BUTTON then
		self.startClickButton(stepData, beginnerId, step, stepData.button_info, {
			stepData.notice_info,
			stepData.notice_offset,
			stepData.notice_dir,
			stepData.notice_icon
		})
	elseif operaType == Const.BEGINNER_STEP_NOTICE then
		self.startUnForceNotice(beginnerId, step, stepData.button_info, {
			stepData.notice_info,
			stepData.notice_offset,
			stepData.notice_dir,
			stepData.notice_icon
		}, stepData.other_info1, stepData.other_info2)
	elseif operaType == Const.BEGINNER_STEP_FORCE_NOTICE then
		self.startForceNotice(beginnerId, step, stepData.button_info, {
			stepData.notice_info,
			stepData.notice_offset,
			stepData.notice_dir,
			stepData.notice_icon
		}, stepData.other_info1, stepData.other_info2, stepData.more_args)
	elseif operaType == Const.BEGINNER_STEP_FORMATION then
		self.startFormation(beginnerId, step, stepData.other_info1, stepData.other_info2, stepData.button_info, {
			stepData.notice_info,
			stepData.notice_offset,
			stepData.notice_dir,
			stepData.notice_icon
		})
	elseif operaType == Const.BEGINNER_STEP_PLAY_AVG then
		self.startAVG(beginnerId, step, stepData.other_info1)
	elseif operaType == Const.BEGINNER_STEP_PLAY_AVG_FRONT then
		self.startAVG(beginnerId, step, stepData.other_info1, true)
	elseif operaType == Const.BEGINNER_STEP_CHANGE_FORMATION then
		self.startChangeFormation(beginnerId, step, stepData.other_info1, stepData.other_info2, stepData.button_info, {
			stepData.notice_info,
			stepData.notice_offset,
			stepData.notice_dir,
			stepData.notice_icon
		})
	elseif operaType == Const.BEGINNER_STEP_CANVAS then
		self.startShowCanvas(beginnerId, step, stepData.other_info1, stepData.other_info2)
	elseif operaType == Const.BEGINNER_STEP_CANVAS_OPERA then
		self.startCanvasOpera(beginnerId, step, stepData.other_info1, stepData.other_info2, stepData.more_args)
	elseif operaType == Const.BEGINNER_STEP_SHOW_GRAPHIC then
		self.startShowGraphic(beginnerId, step, stepData.other_info1, stepData.other_info2)
	elseif operaType == Const.BEGINNER_STEP_SHOW_GRAPHIC_LIST then
		self.startShowGraphicList(beginnerId, step, stepData.other_info1)
	elseif operaType == Const.BEGINNER_STEP_SHOW_GRAPHIC_LIST_MOVIE then
		self.startShowGraphicMovieList(beginnerId, step, stepData.other_info1)
	elseif operaType == Const.BEGINNER_STEP_MAZE_DRAG then
		self.startMazeDrag(beginnerId, step, stepData.button_info, {
			stepData.notice_info,
			stepData.notice_offset,
			stepData.notice_dir,
			stepData.notice_icon
		})
	elseif operaType == Const.BEGINNER_STEP_MINI_GAME_DRAG then
		self.startShowMiniGameOpera(beginnerId, step, stepData.other_info1, stepData.other_info2, stepData.button_info, {
			stepData.notice_info,
			stepData.notice_offset,
			stepData.notice_dir,
			stepData.notice_icon
		}, stepData.more_args)
	else
		if operaType == Const.BEGINNER_STEP_PLAYER_FUNC then
			local funcName = stepData.other_info1

			if funcName and CurAvatar and CurAvatar[funcName] then
				CurAvatar[funcName](CurAvatar, stepData.other_info2)
			end
		end

		self.onStepOver(beginnerId, step)
	end
end

function BeginnerManager.checkStepConditionDict()
	for beginnerId, stepData in pairs(self.stepConditionDict) do
		if self.nowBeginnerDict[beginnerId] == stepData.step then
			if self._checkStepCondition(beginnerId, stepData.conditions, stepData.condition_args) then
				self.stepConditionDict[beginnerId] = nil

				if next(self.stepConditionDict) == nil then
					self.StepConditionTimer:Stop()
				end

				BeginnerManager._startThisStep(beginnerId)

				break
			end
		else
			self.stepConditionDict[beginnerId] = nil

			if next(self.stepConditionDict) == nil then
				self.StepConditionTimer:Stop()
			end
		end
	end
end

function BeginnerManager._checkStepCondition(beginnerId, stepConditions, conditionArgs)
	if stepConditions == 1 then
		local prefabName = conditionArgs[1]
		local uiName = UIManager.prefabKeyDict[prefabName]
		local ui = UIManager.getUI(uiName, nil, false)

		if not ui or not ui:windowBeginnerReady() then
			self.stepNoticeCanvas[prefabName] = beginnerId

			return false
		end
	elseif stepConditions == 4 then
		local prefabName = conditionArgs[1]
		local uiName = UIManager.prefabKeyDict[prefabName]
		local ui = UIManager.getUI(uiName, nil, false)

		if ui and ui:getVisible() then
			self.stepNoticeCanvasClose[prefabName] = beginnerId

			return false
		end
	elseif stepConditions == 2 then
		if GameFsm.isInState(Const.STATE_BATTLE) then
			local needHero

			if conditionArgs then
				needHero = tonumber(conditionArgs[1])
			end

			local players = GameFsm.getCurState():getPlayers()

			for pos, player in pairs(players) do
				if player.mana >= BattleConst.MAX_MANA and not player:manualWaitingSkill() and (not needHero or player.heroID == needHero) then
					Const.BEGINNER_LOCK_SKILL = nil

					return true
				end
			end

			Const.BEGINNER_LOCK_SKILL = true

			return false
		else
			Const.BEGINNER_LOCK_SKILL = nil

			self.stopBeginnerStep(beginnerId)

			return false
		end
	elseif stepConditions == 3 then
		if GameFsm.isInState(Const.STATE_BATTLE) then
			local state = GameFsm.getCurState()
			local needTime = 0

			if conditionArgs then
				needTime = tonumber(conditionArgs[1])
			end

			if state.mMatrixInstance and needTime <= state.mMatrixInstance.bObjMgr:getBattleTime() then
				return true
			end

			return false
		else
			self.stopBeginnerStep(beginnerId)

			return false
		end
	elseif stepConditions == 5 then
		local funcName = conditionArgs[1]

		if self[funcName] and not self[funcName](conditionArgs, beginnerId) then
			return false
		end
	end

	return true
end

function BeginnerManager.suitExitCondition(stepData, isPre)
	local exitCondition = stepData.exit_conditions
	local exitConditionArgs = stepData.exit_conditions_args

	if exitCondition == 1 then
		local heroID = tonumber(exitConditionArgs[1])
		local needLevel = tonumber(exitConditionArgs[2])
		local heroMainDlg = UIManager.getUI("heroMainDlg", nil, false)

		if heroMainDlg and heroMainDlg.heroContentPanel.hero then
			if isPre then
				return needLevel <= heroMainDlg.heroContentPanel.hero.level
			else
				return heroMainDlg.heroContentPanel.hero.level >= needLevel - 1
			end
		end
	end

	return false
end

function BeginnerManager.onStepOver(beginnerId, step, gmJump)
	if self.nowBeginnerDict[beginnerId] and (step == nil or self.nowBeginnerDict[beginnerId] == step) then
		step = self.nowBeginnerDict[beginnerId]

		local stepData = ResBeginnerGuideSteps[beginnerId] or {}
		local nowStepData = stepData[step]

		CurAvatar:sendBeginnerAnalytics(beginnerId, step, nowStepData.operate_type, true)

		if nowStepData.exit_conditions and not self.suitExitCondition(nowStepData) then
			-- block empty
		else
			local ui = UIManager.getUI("rookieMainDlg", nil, false)

			if ui then
				ui:setVisible(false, false)
			end

			if nowStepData and nowStepData.end_step or gmJump then
				self.onBeginnerFinish(beginnerId)
			end

			if nowStepData.end_action then
				self.doAction(nowStepData.end_action)
			end

			if self.corStep[beginnerId] then
				coroutine.stop(self.corStep[beginnerId])
			end

			self.corStep[beginnerId] = coroutine.start(self.startNextStep, beginnerId)
		end
	end
end

function BeginnerManager.startFixedBattle(beginnerId, step, pveId)
	local pveId = tonumber(pveId)

	if pveId then
		local battleData = {}

		battleData.beginnerData = {}
		battleData.beginnerData.pveId = pveId

		CurAvatar:enterFormation(pveId, BattleConst.BATTLE_TYPE_BEGINNER, battleData)

		self.stepNoticeBattles[pveId] = beginnerId
	end
end

local RectTransformType = typeof(UnityEngine.RectTransform)

function BeginnerManager.startClickButton(stepData, beginnerId, step, buttonPath, noticeInfo)
	local clickCb = Functor(self.onStepOver, beginnerId, step)

	if stepData.exit_conditions and self.suitExitCondition(stepData, true) then
		clickCb()
	else
		local uiNode = UnityEngine.GameObject.Find("/UIRoot/" .. buttonPath)

		if not uiNode then
			if CurAvatar.beginnerFinished[beginnerId] then
				self.stopBeginnerStep(beginnerId)
			else
				self.onStepOver(beginnerId, step)
			end

			return
		end

		local widget = uiNode:GetComponent(RectTransformType)

		UIManager.getUI("rookieMainDlg", true):startClickOpera(widget, noticeInfo, clickCb, beginnerId, step)
	end
end

function BeginnerManager.startForceNotice(beginnerId, step, buttonPath, noticeInfo, closeBlack, extraChild, extraCoord)
	local clickCb = Functor(self.onStepOver, beginnerId, step)
	local widget

	if buttonPath then
		local uiNode = UnityEngine.GameObject.Find("/UIRoot/" .. buttonPath)

		if not uiNode then
			if CurAvatar.beginnerFinished[beginnerId] then
				self.stopBeginnerStep(beginnerId)
			else
				self.onStepOver(beginnerId, step)
			end

			return
		end

		widget = uiNode:GetComponent(RectTransformType)
	end

	UIManager.getUI("rookieMainDlg", true):startForceNoticeOpera(widget, noticeInfo, clickCb, beginnerId, step, closeBlack == "1", extraChild, extraCoord)
end

function BeginnerManager.startShowGraphic(beginnerId, step, imgPath, smallMode)
	local clickCb = Functor(self.onStepOver, beginnerId, step)

	if imgPath then
		if smallMode == "1" then
			UIManager.getUI("rookieMainDlg", true):showRawImage(imgPath, true, clickCb)
		else
			UIManager.getUI("rookieMainDlg", true):showRawImage(imgPath, false, clickCb)
		end
	else
		clickCb()
	end
end

function BeginnerManager.startShowGraphicList(beginnerId, step, listId)
	listId = tonumber(listId)

	local clickCb = Functor(self.onStepOver, beginnerId, step)

	if listId then
		UIManager.getUI("graphicListDlg", true):startGraphicList(listId, clickCb)
	else
		clickCb()
	end
end

function BeginnerManager.startShowGraphicMovieList(beginnerId, step, listId)
	listId = tonumber(listId)

	local clickCb = Functor(self.onStepOver, beginnerId, step)

	if listId then
		UIManager.getUI("graphicListMovieDlg", true):startGraphicList(listId, clickCb)
	else
		clickCb()
	end
end

function BeginnerManager.startFormation(beginnerId, step, needHeroId, dstPos, buttonPath, noticeInfo)
	local startPos, arrowEnd

	needHeroId = tonumber(needHeroId)
	dstPos = tonumber(dstPos) or 1

	if DragPlane._plane then
		for pos = 1, BattleConst.BATTLE_MAX_POS do
			if pos == dstPos then
				DragPlane._plane:LockGrid(0, pos)
			else
				DragPlane._plane:LockGrid(1, pos)
			end
		end

		arrowEnd = DragPlane._plane:GetGridPos(dstPos)
	end

	local ui = UIManager.getUI("battleDragHeroDlg", nil, false)

	if ui then
		ui.listHeros.panelSort:setVisible(false)
		ui.btnClose:setVisible(false)
		ui.btnConfirm:setVisible(false)
		ui.btnInfoMode:setVisible(false)

		local grid

		for index, cell in pairs(ui.listHeros.cells) do
			if cell.hero and cell.hero.id == needHeroId and not grid then
				startPos = cell:getController().transform.position
				cell.dragEnable = true
				grid = cell
			else
				cell.dragEnable = false
			end
		end

		ui.btnListHide:setEnable(false)
	end

	self.stepNoticeFormations[dstPos] = {
		beginnerId,
		Const.BEGINNER_STEP_FORMATION,
		needHeroId
	}

	if noticeInfo[1] then
		local widget

		if buttonPath then
			local uiNode = UnityEngine.GameObject.Find("/UIRoot/" .. buttonPath)

			widget = uiNode:GetComponent(RectTransformType)
		end

		local rookieMainDlg = UIManager.getUI("rookieMainDlg", true)

		rookieMainDlg:startNoticeOpera(widget, noticeInfo)

		if startPos and arrowEnd then
			rookieMainDlg:startArrowNotice(startPos, 0, arrowEnd, 1)
		end
	end
end

function BeginnerManager.startChangeFormation(beginnerId, step, startPos, dstPos, buttonPath, noticeInfo)
	local arrowStart, arrowEnd

	startPos = tonumber(startPos) or 1
	dstPos = tonumber(dstPos) or 1

	if not DragPlane.fieldObjs[startPos] then
		self.onStepOver(beginnerId)

		return
	end

	if DragPlane._plane then
		for pos = 1, BattleConst.BATTLE_MAX_POS do
			if pos == dstPos or pos == startPos then
				DragPlane._plane:LockGrid(0, pos)
			else
				DragPlane._plane:LockGrid(1, pos)
			end
		end

		arrowStart = DragPlane._plane:GetGridPos(startPos)
		arrowEnd = DragPlane._plane:GetGridPos(dstPos)
		DragPlane.DISABLE_DELETE = true
	end

	local ui = UIManager.getUI("battleDragHeroDlg", nil, false)

	if ui then
		ui.listHeros.panelSort:setVisible(false)
		ui.btnClose:setVisible(false)
		ui.btnConfirm:setVisible(false)
		ui.btnInfoMode:setVisible(false)
		ui.btnListOpen:setEnable(false)
	end

	self.stepNoticeFormations[dstPos] = {
		beginnerId,
		Const.BEGINNER_STEP_CHANGE_FORMATION,
		startPos
	}

	if noticeInfo[1] then
		local widget

		if buttonPath then
			local uiNode = UnityEngine.GameObject.Find("/UIRoot/" .. buttonPath)

			widget = uiNode:GetComponent(RectTransformType)
		end

		local rookieMainDlg = UIManager.getUI("rookieMainDlg", true)

		rookieMainDlg:startNoticeOpera(widget, noticeInfo)

		if arrowStart and arrowEnd then
			rookieMainDlg:startArrowNotice(arrowStart, 1, arrowEnd, 1)
		end
	end
end

function BeginnerManager.startShowMiniGameOpera(beginnerId, step, startPos, dstPos, buttonPath, noticeInfo, args)
	local arrowStart, arrowEnd, type

	startPos = tonumber(startPos) or 1002
	dstPos = tonumber(dstPos) or 2001

	local index1 = math.floor(startPos / 1000)
	local layer1 = startPos - 1000 * index1
	local index2 = math.floor(dstPos / 1000)
	local layer2 = dstPos - 1000 * index2

	if args and args[1] then
		type = args[1]
	end

	if not type then
		self.onStepOver(beginnerId)

		return
	end

	if type == Const.MINI_GAME_TYPE_CLIMB_TOWER then
		arrowStart = ClimbTowerDragCenter.getPutPos(index1, layer1)
		arrowEnd = ClimbTowerDragCenter.getPutPos(index2, layer2)
	elseif type == Const.MINI_GAME_TYPE_ELIMINATE then
		arrowStart = EliminateDragCenter.getPutPos(index1, layer1)
		arrowEnd = EliminateDragCenter.getPutPos(index2, layer2)
	end

	local rookieMainDlg = UIManager.getUI("rookieMainDlg", true)
	local widget

	if buttonPath then
		local uiNode = UnityEngine.GameObject.Find("/UIRoot/" .. buttonPath)

		widget = uiNode:GetComponent(RectTransformType)
	end

	rookieMainDlg:startNoticeOpera(widget, noticeInfo)

	if arrowStart and arrowEnd then
		rookieMainDlg:startArrowNotice(arrowStart, 1, arrowEnd, 1)
	end

	self.stepNoticeMiniGame[type] = beginnerId
end

function BeginnerManager.startAVG(beginnerId, step, avg, isFront)
	local clickCb = Functor(self.onStepOver, beginnerId, step)

	UIManager.playAVG(tonumber(avg), nil, clickCb, isFront)
end

function BeginnerManager.startShowCanvas(beginnerId, step, canvasName, opera)
	if opera == "1" then
		local ui = UIManager.getUI(canvasName, nil, false)

		if ui then
			ui:setVisible(false)
		end
	elseif opera == "2" then
		-- block empty
	else
		UIManager.getUI(canvasName, true)
	end

	self.onStepOver(beginnerId, step)
end

function BeginnerManager.startCanvasOpera(beginnerId, step, canvasName, funcName, moreArgs)
	local ui = UIManager.getUI(canvasName, nil, false)

	if ui and ui[funcName] then
		if moreArgs then
			ui[funcName](ui, unpack(moreArgs))
		else
			ui[funcName](ui)
		end
	end

	self.onStepOver(beginnerId, step)
end

local UIUtils = require("Framework.UI.UIUtils")
local RookieFocusChild = require("Logic/Beginner/RookieFocusChild")
local RookieFocusRedDotChild = require("Logic/Beginner/RookieFocusRedDotChild")
local UIMarkPath = "System/PlayerGuide/HighLightPanel"
local RedDotMarkPath = "System/PlayerGuide/NewOpenPanel"

function BeginnerManager.startUnForceNotice(beginnerId, step, buttonPath, noticeInfo, clickWait, dynamicNew)
	if buttonPath then
		local uiNode = UnityEngine.GameObject.Find("/UIRoot/" .. buttonPath)

		if not uiNode then
			if CurAvatar.beginnerFinished[beginnerId] then
				self.stopBeginnerStep(beginnerId)
			else
				self.onStepOver(beginnerId, step)
			end

			return
		end

		local uiTransform = uiNode.transform
		local path, parent

		parent, path = UIUtils.GetLuaObjByTransform(uiTransform, path)

		if parent then
			if not parent.beginnerFocusChild then
				parent.beginnerFocusChild = {}
			end

			if not parent.beginnerFocusChild[buttonPath] then
				if dynamicNew == "2" then
					parent.beginnerFocusChild[buttonPath] = RookieFocusRedDotChild(parent, path, RedDotMarkPath, 0, 0)
				else
					parent.beginnerFocusChild[buttonPath] = RookieFocusChild(parent, path, UIMarkPath, 0, 0)
				end
			end

			if dynamicNew ~= "2" then
				parent.beginnerFocusChild[buttonPath]:focus(uiTransform, noticeInfo, dynamicNew)
			end

			local function OnButtonClick()
				if parent.mWindow and parent.mWindow.id then
					parent.beginnerFocusChild[buttonPath]:setVisible(false)
				end

				if clickWait == "1" then
					self.onStepOver(parent.beginnerFocusChild[buttonPath].clickInfo[1], parent.beginnerFocusChild[buttonPath].clickInfo[2])
				end
			end

			local ButtonType = typeof(UnityEngine.UI.Button)
			local btn = uiTransform:GetComponent(ButtonType)

			if btn then
				parent:getController():AddButtonOnceOnClick(btn, OnButtonClick)
			end
		end

		parent.beginnerFocusChild[buttonPath].clickInfo = {
			beginnerId,
			step
		}

		parent.beginnerFocusChild[buttonPath]:setVisible(true)

		self.beginnerCachedUI[beginnerId] = parent.beginnerFocusChild[buttonPath]

		if parent.mWindow then
			parent.mWindow.BeginnerMark = true
		end
	end

	if clickWait ~= "1" then
		self.onStepOver(beginnerId, step)
	end
end

function BeginnerManager.startMazeDrag(beginnerId, step, buttonPath, noticeInfo)
	local clickCb = Functor(self.onStepOver, beginnerId, step)
	local widget

	if buttonPath then
		local uiNode = UnityEngine.GameObject.Find("/UIRoot/" .. buttonPath)

		if not uiNode then
			if CurAvatar.beginnerFinished[beginnerId] then
				self.stopBeginnerStep(beginnerId)
			else
				self.onStepOver(beginnerId, step)
			end

			return
		end

		widget = uiNode:GetComponent(RectTransformType)
	end

	UIManager.getUI("rookieMainDlg", true):startMazeDragOpera(widget, noticeInfo, clickCb)
end

function BeginnerManager.noticeBattleOver(pveId)
	if self.stepNoticeBattles[pveId] then
		self.onStepOver(self.stepNoticeBattles[pveId])

		self.stepNoticeBattles[pveId] = nil
	end
end

function BeginnerManager.noticeFormation(dragObj, srcPos, dstPos)
	if self.stepNoticeFormations[dstPos] then
		local noticeInfo = self.stepNoticeFormations[dstPos]

		if noticeInfo[2] == Const.BEGINNER_STEP_CHANGE_FORMATION then
			DragPlane.DISABLE_DELETE = nil
			self.stepNoticeFormations[dstPos] = nil

			local ui = UIManager.getUI("battleDragHeroDlg", nil, false)

			if ui then
				ui.btnConfirm:setVisible(true)
				ui.btnListOpen:setEnable(true)
			end

			self.onStepOver(noticeInfo[1])
		elseif dragObj.hero.id ~= noticeInfo[3] then
			MsgManager.notice(Lang.get(29955))
		else
			self.stepNoticeFormations[dstPos] = nil

			local ui = UIManager.getUI("battleDragHeroDlg", nil, false)

			if ui then
				ui.btnConfirm:setVisible(true)
				ui.btnListHide:setEnable(true)
			end

			self.onStepOver(noticeInfo[1])
		end
	end
end

function BeginnerManager.noticeMiniGame(type)
	if self.stepNoticeMiniGame[type] then
		self.onStepOver(self.stepNoticeMiniGame[type])

		self.stepNoticeMiniGame[type] = nil
	end
end

function BeginnerManager.doAction(actionId)
	if actionId == 1 then
		if GameFsm.isInState(Const.STATE_BATTLE) then
			GameFsm.getCurState():onPause()
		end
	elseif actionId == 2 and GameFsm.isInState(Const.STATE_BATTLE) then
		GameFsm.getCurState():onResume()
	end
end

self.StepConditionTimer = Timer.New(self.checkStepConditionDict, 0.2, -1)

return BeginnerManager
