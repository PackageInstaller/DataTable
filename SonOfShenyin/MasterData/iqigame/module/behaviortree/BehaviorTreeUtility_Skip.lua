-- chunkname: @IQIGame\\Module\\BehaviorTree\\BehaviorTreeUtility_Skip.lua

function BehaviorTreeUtility.SetStoryUIButtonSkipShow(isShow)
	StoryModule.isCanBeSkip = isShow

	EventDispatcher.Dispatch(EventID.SetStoryButtonSkipShowEvent, isShow)
end

function BehaviorTreeUtility.SkipConversation(dialogueStartID, startConversationTask)
	if StoryModule.isSkipState then
		local cfgDialog = CfgUtil.GetCfgStoryDialogueDataWithID(dialogueStartID)

		StoryModule.AddDialogueReviewData(Constant.DialogueReviewType.Chat, cfgDialog.Id)

		while cfgDialog.NextID ~= 0 do
			cfgDialog = CfgUtil.GetCfgStoryDialogueDataWithID(cfgDialog.NextID)

			StoryModule.AddDialogueReviewData(Constant.DialogueReviewType.Chat, cfgDialog.Id)
		end

		if StoryModule.isSkipState then
			startConversationTask:Complete()

			return true
		end
	end

	return false
end

function BehaviorTreeUtility.SkipMove(autoMoveTargetType, moverCharacterID, moveTargetInfo, autoMoveNPCInstance, moveInfo)
	if StoryModule.isSkipState then
		if autoMoveTargetType == 1 then
			local targetCharacterID = moveTargetInfo
			local targetCharacter = BehaviorTreeUtility.GetNPCByNPCID(targetCharacterID)
			local moveCharacter = BehaviorTreeUtility.GetNPCByNPCID(moverCharacterID)

			moveCharacter.transform.position = targetCharacter.transform.position
		elseif autoMoveTargetType == 2 then
			local targetTransform = moveTargetInfo
			local moveCharacter = BehaviorTreeUtility.GetNPCByNPCID(moverCharacterID)

			moveCharacter.transform.position = targetTransform.position
		elseif autoMoveTargetType == 3 then
			local moveCharacter = BehaviorTreeUtility.GetNPCByNPCID(moverCharacterID)

			moveCharacter.transform.position = moveTargetInfo
		end

		autoMoveNPCInstance:Complete()

		return true
	end

	return false
end

function BehaviorTreeUtility.SkipMoveTowards(moveObject, moverNPCID, position)
	if StoryModule.isSkipState then
		if not LuaUtility.GameObjectIsNullOrEmpty(moveObject) then
			moveObject.transform.position = position

			return true
		end

		local moveCharacter = BehaviorTreeUtility.GetNPCByNPCID(moverNPCID)

		moveCharacter.transform.position = position

		return true
	end

	return false
end

function BehaviorTreeUtility.SkipTimeLine(playableDirector)
	if StoryModule.isSkipState then
		playableDirector:Play()

		return true
	end
end
