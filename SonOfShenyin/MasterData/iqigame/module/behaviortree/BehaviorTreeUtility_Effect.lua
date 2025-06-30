-- chunkname: @IQIGame\\Module\\BehaviorTree\\BehaviorTreeUtility_Effect.lua

function BehaviorTreeUtility.PlayEffectTask_Npc(effectID, npcID, offsetPosition, PlayEffectTask)
	local npc = BehaviorTreeUtility.GetNPCByNPCID(npcID)

	if not npc then
		return
	end

	local path = UIGlobalApi.GetFxEffectPathByEntityId(effectID)

	LuaUtility.LoadAsset(StoryModule, path, function(owner, assetName, asset, duration, userData)
		local effect = GameObject.Instantiate(asset, StoryModule.EffectRoot)
		local follower

		follower = LuaUtility.GetComponent(effect, typeof(TransformFollower))
		follower = follower or LuaUtility.AddComponent(effect, typeof(TransformFollower))

		follower:Init(effect.transform, npc.transform, Vector3.New(offsetPosition.x, offsetPosition.y, offsetPosition.z))
		PlayEffectTask:SetSerializeID(StoryModule.AddEffect(effect, npcID, effectID))
		PlayEffectTask:SetComplete()
	end, function()
		PlayEffectTask:SetComplete()
	end)
end

function BehaviorTreeUtility.PlayEffectTask_Bone(effectID, npcID, boneName, offsetPosition, PlayEffectTask)
	local npc = BehaviorTreeUtility.GetNPCByNPCID(npcID)

	if not npc then
		return
	end

	local path = UIGlobalApi.GetFxEffectPathByEntityId(effectID)

	LuaUtility.LoadAsset(StoryModule, path, function(owner, assetName, asset, duration, userData)
		local effect = GameObject.Instantiate(asset, GameEntry.Effect.gameObject.transform)
		local follower

		follower = LuaUtility.GetComponent(effect, typeof(TransformFollower))
		follower = follower or LuaUtility.AddComponent(effect, typeof(TransformFollower))

		local bone = npc.transform:Find("body/" .. boneName)

		if not bone then
			logError(string.format("没有找到Npc = %s身上的骨骼 = %s 节点", npcID, boneName))

			return
		end

		follower:Init(effect.transform, bone, Vector3.New(offsetPosition.x, offsetPosition.y, offsetPosition.z))
		PlayEffectTask:SetSerializeID(StoryModule.AddEffect(effect, npcID, effectID))
		PlayEffectTask:SetComplete()
	end, function()
		PlayEffectTask:SetComplete()
	end)
end

function BehaviorTreeUtility.StopEffectTask(effectIndex)
	StoryModule.StopEffect(effectIndex)
end

function BehaviorTreeUtility.PlayEffectNpc(effectID, npcID, npcOffset, PlayEffect)
	local npc = BehaviorTreeUtility.GetNPCByNPCID(npcID)
	local effectPlayID = LuaUtility.PlayNormalEffect(effectID, npc.transform.position, function(BaseEffect)
		local follower

		follower = LuaUtility.GetComponent(BaseEffect.GoEffectEntity, typeof(TransformFollower))
		follower = follower or LuaUtility.AddComponent(BaseEffect.GoEffectEntity, typeof(TransformFollower))

		follower:Init(BaseEffect.GoEffectEntity.transform, npc.transform, Vector3.New(npcOffset.x, npcOffset.y, npcOffset.z))
		PlayEffect:LoadSucceed()
	end)

	return effectPlayID
end

function BehaviorTreeUtility.PlayEffectScreen(effectID, screenPos, PlayEffect)
	local WorldPos = LuaUtility.ScreenToWorldPos(StoryModule.currentVirtualCamera, screenPos, 10)
	local effectPlayID = LuaUtility.PlayNormalEffect(effectID, WorldPos, function(BaseEffect)
		PlayEffect:LoadSucceed()
	end)

	return effectPlayID
end

function BehaviorTreeUtility.PlayEffectScene(effectID, scenePos, PlayEffect)
	local effectPlayID = LuaUtility.PlayNormalEffect(effectID, scenePos, function(BaseEffect)
		PlayEffect:LoadSucceed()
	end)

	return effectPlayID
end

function BehaviorTreeUtility.StopEffect(effectPlayID)
	LuaUtility.StopEffect(effectPlayID)
end

function BehaviorTreeUtility.PlayBlackInkScreenEffect(actionType, duration, PlayBlackScreenEffect)
	StoryModule.blackScreenDuration = duration

	local action

	if actionType == 1 then
		function action()
			EventDispatcher.Dispatch(EventID.StoryBlackInkIn, PlayBlackScreenEffect, duration == 0)
		end
	elseif actionType == 2 then
		function action()
			EventDispatcher.Dispatch(EventID.StoryBlackInkOut, PlayBlackScreenEffect, duration == 0)
		end
	end

	if not UIModule.HasUI(Constant.UIControllerName.StoryScreenEffectUI) then
		UIModule.Open(Constant.UIControllerName.StoryScreenEffectUI, Constant.UILayer.Mid, {
			event = action
		})
	else
		action()
	end
end

function BehaviorTreeUtility.PlayWhiteInkScreenEffect(actionType, duration, PlayBlackScreenEffect)
	StoryModule.blackScreenDuration = duration

	local action

	if actionType == 1 then
		function action()
			EventDispatcher.Dispatch(EventID.StoryWhiteInkIn, PlayBlackScreenEffect, duration == 0)
		end
	elseif actionType == 2 then
		function action()
			EventDispatcher.Dispatch(EventID.StoryWhiteInkOut, PlayBlackScreenEffect, duration == 0)
		end
	end

	if not UIModule.HasUI(Constant.UIControllerName.StoryScreenEffectUI) then
		UIModule.Open(Constant.UIControllerName.StoryScreenEffectUI, Constant.UILayer.Mid, {
			event = action
		})
	else
		action()
	end
end

function BehaviorTreeUtility.PlayBlackAlphaScreenEffect(actionType, duration, PlayBlackScreenEffect)
	StoryModule.blackScreenDuration = duration

	local action

	if actionType == 1 then
		function action()
			EventDispatcher.Dispatch(EventID.StoryBlackAlphaIn, PlayBlackScreenEffect)
		end
	elseif actionType == 2 then
		function action()
			EventDispatcher.Dispatch(EventID.StoryBlackAlphaOut, PlayBlackScreenEffect)
		end
	end

	if not UIModule.HasUI(Constant.UIControllerName.StoryScreenEffectUI) then
		UIModule.Open(Constant.UIControllerName.StoryScreenEffectUI, Constant.UILayer.Mid, {
			event = action
		})
	else
		action()
	end
end

function BehaviorTreeUtility.PlayWhiteAlphaScreenEffect(actionType, duration, PlayBlackScreenEffect)
	StoryModule.blackScreenDuration = duration

	local action

	if actionType == 1 then
		function action()
			EventDispatcher.Dispatch(EventID.StoryWhiteAlphaIn, PlayBlackScreenEffect)
		end
	elseif actionType == 2 then
		function action()
			EventDispatcher.Dispatch(EventID.StoryWhiteAlphaOut, PlayBlackScreenEffect)
		end
	end

	if not UIModule.HasUI(Constant.UIControllerName.StoryScreenEffectUI) then
		UIModule.Open(Constant.UIControllerName.StoryScreenEffectUI, Constant.UILayer.Mid, {
			event = action
		})
	else
		action()
	end
end

function BehaviorTreeUtility.PlayStoryInEffect(PlayEffect, effectDuration)
	StoryModule.blackScreenDuration = effectDuration

	if not UIModule.HasUI(Constant.UIControllerName.StoryScreenEffectUI) then
		UIModule.Open(Constant.UIControllerName.StoryScreenEffectUI, Constant.UILayer.Mid, {
			event = function()
				EventDispatcher.Dispatch(EventID.StoryBlackInkIn, PlayEffect)
			end
		})
	else
		EventDispatcher.Dispatch(EventID.StoryBlackInkIn, PlayEffect)
	end
end

function BehaviorTreeUtility.PlayStoryOutEffect(PlayEffect, effectDuration)
	StoryModule.blackScreenDuration = effectDuration

	if not UIModule.HasUI(Constant.UIControllerName.StoryScreenEffectUI) then
		UIModule.Open(Constant.UIControllerName.StoryScreenEffectUI, Constant.UILayer.Mid, {
			event = function()
				EventDispatcher.Dispatch(EventID.StoryBlackInkOut, PlayEffect)
			end
		})
	else
		EventDispatcher.Dispatch(EventID.StoryBlackInkOut, PlayEffect)
	end
end

function BehaviorTreeUtility.PlayStoryBlackScreenEffect()
	if not UIModule.HasUI(Constant.UIControllerName.StoryScreenEffectUI) then
		UIModule.Open(Constant.UIControllerName.StoryScreenEffectUI, Constant.UILayer.Mid, {
			event = function()
				EventDispatcher.Dispatch(EventID.StoryScreenPlayScreenEffectWithType, Constant.StoryScreenEffectType.BlackScreen)
			end
		})
	else
		EventDispatcher.Dispatch(EventID.StoryScreenPlayScreenEffectWithType, Constant.StoryScreenEffectType.BlackScreen)
	end

	return -1
end

function BehaviorTreeUtility.StopStoryBlackScreenEffect()
	EventDispatcher.Dispatch(EventID.StoryScreenStopScreenEffectWithType, Constant.StoryScreenEffectType.BlackScreen)
end

function BehaviorTreeUtility.PlayStoryCutToEffect()
	if not UIModule.HasUI(Constant.UIControllerName.StoryScreenEffectUI) then
		UIModule.Open(Constant.UIControllerName.StoryScreenEffectUI, Constant.UILayer.Mid, {
			event = function()
				EventDispatcher.Dispatch(EventID.StoryCutTo)
			end
		})
	else
		EventDispatcher.Dispatch(EventID.StoryCutTo)
	end
end

function BehaviorTreeUtility.ShowThinkingFilter(duration, task)
	StoryModule.thinkFilterDuration = duration

	if not UIModule.HasUI(Constant.UIControllerName.StoryScreenEffectUI) then
		UIModule.Open(Constant.UIControllerName.StoryScreenEffectUI, Constant.UILayer.Mid, {
			event = function()
				EventDispatcher.Dispatch(EventID.StoryScreenPlayScreenEffectWithType, Constant.StoryScreenEffectType.ThinkingFilter, task)
			end
		})
	else
		EventDispatcher.Dispatch(EventID.StoryScreenPlayScreenEffectWithType, Constant.StoryScreenEffectType.ThinkingFilter, task)
	end
end

function BehaviorTreeUtility.HideThinkingFilter(duration, task)
	StoryModule.thinkFilterDuration = duration

	EventDispatcher.Dispatch(EventID.StoryScreenStopScreenEffectWithType, Constant.StoryScreenEffectType.ThinkingFilter, task)
end

function BehaviorTreeUtility.ShowMemoryFilter(duration, task)
	LuaUtility.SetMemoryFilterVolumeEnable(true)
	LuaUtility.DoTweenTo_Float(0, 1, duration, function(v)
		LuaUtility.SetMemoryFilterVolumeControl(v)

		if v >= 1 and task then
			task:SetComplete()
		end
	end)
end

function BehaviorTreeUtility.HideMemoryFilter(duration, task)
	LuaUtility.DoTweenTo_Float(1, 0, duration, function(v)
		LuaUtility.SetMemoryFilterVolumeControl(v)

		if v <= 0 then
			LuaUtility.SetMemoryFilterVolumeEnable(false)

			if task then
				task:SetComplete()
			end
		end
	end)
end

function BehaviorTreeUtility.ShowRegularFilterByUI()
	EventDispatcher.Dispatch(EventID.SetRegularEnableEvent, true)
end

function BehaviorTreeUtility.HideRegularFilterByUI()
	EventDispatcher.Dispatch(EventID.SetRegularEnableEvent, false)
end

function BehaviorTreeUtility.ShowRegularFilter(duration, task)
	LuaUtility.SetLvFilterVolumeEnable(true)
	LuaUtility.DoTweenTo_Float(0, 1, duration, function(v)
		LuaUtility.SetLvFilterVolumeControl(v)

		if v >= 1 and task then
			task:SetComplete()
		end
	end)
end

function BehaviorTreeUtility.HideRegularFilter(duration, task)
	LuaUtility.DoTweenTo_Float(1, 0, duration, function(v)
		LuaUtility.SetLvFilterVolumeControl(v)

		if v <= 0 then
			LuaUtility.SetLvFilterVolumeEnable(false)

			if task then
				task:SetComplete()
			end
		end
	end)
end

function BehaviorTreeUtility.ShowTimeStopFilter(duration, lerp, task)
	LuaUtility.SetTimeStopFilterVolumeEnable(true)
	LuaUtility.SetTimeStopFilterVolumeLerp(lerp)
	LuaUtility.DoTweenTo_Float(0, 1, duration, function(v)
		LuaUtility.SetTimeStopFilterVolumeControl(v)

		if v >= 1 and task then
			task:SetComplete()
		end
	end)
end

function BehaviorTreeUtility.StopTimeStopFilter(duration, lerp, task)
	LuaUtility.SetTimeStopFilterVolumeLerp(lerp)
	LuaUtility.DoTweenTo_Float(1, 0, duration, function(v)
		LuaUtility.SetTimeStopFilterVolumeControl(v)

		if v <= 0 then
			LuaUtility.SetTimeStopFilterVolumeEnable(false)
			LuaUtility.SetTimeStopFilterVolumeLerp(0)

			if task then
				task:SetComplete()
			end
		end
	end)
end

function BehaviorTreeUtility.SetDirectionShow(direction, show)
	if show then
		EventDispatcher.Dispatch(EventID.MainUI_ShowHudDirectEvent, direction)
	else
		EventDispatcher.Dispatch(EventID.MainUI_HideHudDirectEvent, direction)
	end
end
