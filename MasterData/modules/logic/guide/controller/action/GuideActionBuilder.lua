-- chunkname: @modules/logic/guide/controller/action/GuideActionBuilder.lua

module("modules.logic.guide.controller.action.GuideActionBuilder", package.seeall)

local GuideActionBuilder = class("GuideActionBuilder")

function GuideActionBuilder:ctor()
	self._ActionType2Impl = {}
	GuideActionBuilder.ActionType2Impl = self._ActionType2Impl
	self._ActionType2Impl[101] = GuideActionPlayStory
	self._ActionType2Impl[102] = GuideActionEnterEpisode
	self._ActionType2Impl[103] = GuideActionExitEpisode
	self._ActionType2Impl[104] = GuideActionCloseView
	self._ActionType2Impl[105] = GuideActionOpenView
	self._ActionType2Impl[106] = GuideActionEnterScene
	self._ActionType2Impl[107] = GuideActionOpenHelpView
	self._ActionType2Impl[108] = GuideActionSkillContinue
	self._ActionType2Impl[109] = GuideActionEntityDeadContinue
	self._ActionType2Impl[110] = GuideActionJump
	self._ActionType2Impl[111] = GuideActionEnableClick
	self._ActionType2Impl[112] = GuideActionEnablePress
	self._ActionType2Impl[113] = GuideActionDispatchFightEvent
	self._ActionType2Impl[114] = GuideActionTriggerGuide
	self._ActionType2Impl[115] = GuideActionDispatchEvent
	self._ActionType2Impl[116] = GuideActionSetFlag
	self._ActionType2Impl[117] = GuideActionPlayEffect
	self._ActionType2Impl[118] = GuideActionPlayAnimator
	self._ActionType2Impl[119] = GuideActionFightVictory
	self._ActionType2Impl[120] = GuideActionLockGuide
	self._ActionType2Impl[121] = GuideActionRoomFixBlockMaskPos
	self._ActionType2Impl[122] = GuideActionRoomFocusBlock
	self._ActionType2Impl[123] = GuideActionOpenCommonPropView
	self._ActionType2Impl[125] = GuideActionSetNextStepGOPath
	self._ActionType2Impl[126] = GuideActionShowToast
	self._ActionType2Impl[127] = GuideActionExploreShowOutline
	self._ActionType2Impl[128] = GuideActionFinishMapElement
	self._ActionType2Impl[129] = GuideActionExploreUseItem
	self._ActionType2Impl[130] = GuideActionRoomFocusBlockBuildingPut
	self._ActionType2Impl[131] = GuideActionCondition
	self._ActionType2Impl[132] = GuideActionAdditionCondition
	self._ActionType2Impl[201] = WaitGuideActionClickMask
	self._ActionType2Impl[202] = WaitGuideActionClickAnywhere
	self._ActionType2Impl[203] = WaitGuideActionStoryStart
	self._ActionType2Impl[204] = WaitGuideActionStoryFinish
	self._ActionType2Impl[205] = WaitGuideActionEnterEpisode
	self._ActionType2Impl[206] = WaitGuideActionOpenFinishView
	self._ActionType2Impl[207] = WaitGuideActionEnterScene
	self._ActionType2Impl[208] = WaitGuideActionBackToMain
	self._ActionType2Impl[209] = WaitGuideActionCloseView
	self._ActionType2Impl[210] = WaitGuideActionWaitSeconds
	self._ActionType2Impl[211] = WaitGuideActionOpenView
	self._ActionType2Impl[212] = WaitGuideActionAnyTouch
	self._ActionType2Impl[213] = WaitGuideActionEnterPassedEpisode
	self._ActionType2Impl[214] = WaitGuideActionEnterFightSubEntity
	self._ActionType2Impl[215] = WaitGuideActionBreakFightResultClose
	self._ActionType2Impl[216] = WaitGuideActionOpenViewWithEpisode
	self._ActionType2Impl[217] = WaitGuideActionOpenViewWithCondition
	self._ActionType2Impl[218] = WaitGuideActionRoomBlockClick
	self._ActionType2Impl[219] = WaitGuideActionRoomEnterMode
	self._ActionType2Impl[220] = WaitGuideActionRoomPlaceBlock
	self._ActionType2Impl[221] = WaitGuideActionWaitForGuideFinish
	self._ActionType2Impl[222] = WaitGuideActionRoomCanGetResources
	self._ActionType2Impl[223] = WaitGuideActionRoomInitBuildingLvUp
	self._ActionType2Impl[224] = WaitGuideActionHasEnoughMaterial
	self._ActionType2Impl[225] = WaitGuideActionRoomBlockSatisfy
	self._ActionType2Impl[226] = WaitGuideActionEnterRoomOrOpenView
	self._ActionType2Impl[227] = WaitGuideActionOpenDungeonMapView
	self._ActionType2Impl[228] = WaitGuideActionRoomLineLvUpSatisfy
	self._ActionType2Impl[229] = WaitGuideNotPressing
	self._ActionType2Impl[230] = WaitGuideActionOpenViewInFirstWithCondition
	self._ActionType2Impl[231] = WaitGuideActionSeasonRetail
	self._ActionType2Impl[232] = WaitGuideActionExploreLoaded
	self._ActionType2Impl[233] = WaitGuideActionExploreTweenCamera
	self._ActionType2Impl[234] = WaitGuideActionExploreClickNode
	self._ActionType2Impl[235] = WaitGuideActionExploreTrigger
	self._ActionType2Impl[236] = WaitGuideActionExploreSetFov
	self._ActionType2Impl[237] = WaitGuideActionExploreHeroStopMove
	self._ActionType2Impl[238] = WaitGuideActionExploreTransferFinish
	self._ActionType2Impl[239] = WaitGuideActionEnterBattle
	self._ActionType2Impl[240] = WaitGuideActionRoleStoryTicketExchange
	self._ActionType2Impl[241] = WaitGuideActionRoomGetBuilding
	self._ActionType2Impl[242] = WaitGuideActionRoomPutBuilding
	self._ActionType2Impl[243] = WaitGuideActionRoomBuildingClick
	self._ActionType2Impl[244] = WaitGuideActionGetCritter
	self._ActionType2Impl[245] = WaitGuideActionRoomCritterMood
	self._ActionType2Impl[246] = WaitGuideActionRoomBuildingPlaceBlock
	self._ActionType2Impl[247] = WaitGuideActionRoomPlan
	self._ActionType2Impl[248] = WaitGuideActionRoomTransport
	self._ActionType2Impl[249] = WaitGuideActionPlayStoryStep
	self._ActionType2Impl[250] = WaitGuideActionEnterChapter
	self._ActionType2Impl[251] = WaitGuideActionSurvivalBuildingLv
	self._ActionType2Impl[301] = WaitGuideActionFightRoundBegin
	self._ActionType2Impl[302] = WaitGuideActionFightRoundEnd
	self._ActionType2Impl[303] = WaitGuideActionFightResultClose
	self._ActionType2Impl[304] = WaitGuideActionFightDragCard
	self._ActionType2Impl[305] = WaitGuideActionFightEnd
	self._ActionType2Impl[306] = WaitGuideActionSkillPause
	self._ActionType2Impl[307] = WaitGuideActionEntityDeadPause
	self._ActionType2Impl[308] = WaitGuideActionUseActPoint
	self._ActionType2Impl[309] = WaitGuideActionFightWaveBegin
	self._ActionType2Impl[310] = WaitGuideActionFightSkillPlayFinish
	self._ActionType2Impl[311] = WaitGuideActionFightEvent
	self._ActionType2Impl[312] = WaitGuideActionCardEndPause
	self._ActionType2Impl[313] = WaitGuideActionAnyEvent
	self._ActionType2Impl[314] = WaitGuideActionFightEndPause
	self._ActionType2Impl[315] = WaitGuideActionFightPauseGeneral
	self._ActionType2Impl[316] = WaitGuideActionFightRoundXFail
	self._ActionType2Impl[317] = WaitGuideActionFightEndPause_sp
	self._ActionType2Impl[318] = WaitGuideActionPauseGeneral
	self._ActionType2Impl[319] = WaitGuideActionFightGetSpecificCard
	self._ActionType2Impl[320] = WaitGuideActionAnyEventWithCondition
	self._ActionType2Impl[401] = WaitGuideActionSpecialEvent
	self._ActionType2Impl[402] = GuideActionPreloadFirstFight
	self._ActionType2Impl[998] = GuideActionAppendStep
	self._ActionType2Impl[999] = GuideActionEmptyStep
end

function GuideActionBuilder:_noDisplay(stepCO)
	return not string.nilorempty(stepCO.tipsContent) and not string.nilorempty(stepCO.uiInfo)
end

function GuideActionBuilder:buildActionFlow(guideId, stepId, againGuideId)
	local stepGuideId = againGuideId > 0 and againGuideId or guideId
	local flow = GuideActionFlow.New(guideId, stepId, againGuideId)

	self:addActionToFlow(flow, stepGuideId, stepId)

	return flow
end

function GuideActionBuilder:addActionToFlow(flow, guideId, stepId, addtion)
	if not flow then
		return
	end

	if addtion then
		local var_4_0 = GuideConfig.instance:getAddtionStepCfg(guideId, stepId)

		if not var_4_0 then
			var_4_0 = GuideConfig.instance:getStepCO(guideId, stepId)

			local stepCO = var_4_0

			if not stepCO then
				logError(string.format("guide_%d_%d stepCO is nil", guideId, stepId))

				return
			end

			local goPath = GuideModel.instance:getStepGOPath(guideId, stepId)
			local delay = stepCO.delay

			if delay > 0 then
				local action = WaitGuideActionWaitSeconds.New(guideId, stepId, delay)

				flow:addWork(action)
			end

			if not string.nilorempty(goPath) then
				local action = GuideActionFindGO.New(guideId, stepId, goPath)

				flow:addWork(action)
			end

			if stepCO.audio and stepCO.audio > 0 then
				local action = GuideActionPlayAudio.New(guideId, stepId, stepCO.audio)

				flow:addWork(action)
			end

			if not string.nilorempty(stepCO.tipsContent) or not string.nilorempty(goPath) or not string.nilorempty(stepCO.storyContent) then
				local action = GuideActionOpenMaskHole.New(guideId, stepId)

				flow:addWork(action)
			end

			if not string.nilorempty(stepCO.action) then
				local actionStrs = string.split(stepCO.action, "|")

				for i = 1, #actionStrs do
					local index, _ = string.find(actionStrs[i], "#")
					local actionType, actionParam

					if index then
						actionType = tonumber(string.sub(actionStrs[i], 1, index - 1))
						actionParam = string.sub(actionStrs[i], index + 1)
					else
						actionType = tonumber(actionStrs[i]) or actionStrs[i]
					end

					local actionCls = self._ActionType2Impl[actionType]

					if actionCls then
						local action = actionCls.New(guideId, stepId, actionParam)

						flow:addWork(action)
					else
						logError("guide action type " .. actionType .. " not exist")
					end
				end
			end

			if #flow:getWorkList() == 0 then
				logNormal(string.format("<color=#FFA500>guide_%d_%d has no action!</color>", guideId, stepId))
			end
		end
	end
end

function GuideActionBuilder.buildAction(guideId, stepId, actionStr)
	local index, _ = string.find(actionStr, "#")
	local actionType, actionParam

	if index then
		actionType = tonumber(string.sub(actionStr, 1, index - 1))
		actionParam = string.sub(actionStr, index + 1)
	else
		actionType = tonumber(actionStr) or actionStr
	end

	local actionCls = GuideActionBuilder.ActionType2Impl[actionType]

	if actionCls then
		return (actionCls.New(guideId, stepId, actionParam))
	else
		logError("guide action type " .. actionType .. " not exist")
	end
end

return GuideActionBuilder
