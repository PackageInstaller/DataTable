-- chunkname: @IQIGame\\Module\\MemoryStory\\MemoryStoryModule.lua

require("IQIGame.Module.MemoryStory.MemoryStoryPlayerModule")
require("IQIGame.Module.MemoryStory.MemoryStoryExecutionModule")

local MemoryStoryScene = require("IQIGame.Scene.MemoryStory.MemoryStoryScene")
local NpcController = require("IQIGame.Scene.MemoryStory.Controller.MemoryStoryNpcController")
local HeroController = require("IQIGame.Scene.MemoryStory.Controller.MemoryStoryHeroController")
local MemoryStoryDialogController = require("IQIGame.Scene.MemoryStory.Controller.MemoryStoryDialogController")

MemoryStoryModule = {
	CurStorySceneId = 0,
	MemoryEntryType = 1,
	InMemoryStoryScene = false,
	CurSoulCid = 0,
	sources = {},
	Elements = {},
	SceneElementCache = {}
}
MemoryStoryModule.EntryType = {
	LibrarySoulInfo = 2,
	Memory = 1
}
MemoryStoryModule.ElementType = {
	Npc = 2,
	Hero = 1
}
MemoryStoryModule.ElementTriggerType = {
	ColliderExit = 2,
	ColliderEnter = 1,
	MouseClicked = 3
}
MemoryStoryModule.ServiceTriggerType = {
	MouseClicked_Normal = 30,
	RECEIVE_TASK = 40,
	MouseClicked_LowPriority = 39,
	ColliderExit_Normal = 20,
	MouseClicked_HighPriority = 31,
	ColliderEnter_HighPriority = 11,
	Element_Remove = 2,
	ColliderExit_LowPriority = 29,
	SUBMIT_TASK = 41,
	ColliderExit_HighPriority = 21,
	Element_Ready = 1,
	ColliderEnter_LowPriority = 19,
	ColliderEnter_Normal = 10
}

function MemoryStoryModule.EnterStory(storySceneId, entryType, soulCid)
	MemoryStoryModule.MemoryEntryType = entryType
	MemoryStoryModule.CurSoulCid = soulCid

	MemoryStoryModule.__InitStorySceneLogicData(storySceneId)
	EventDispatcher.AddEventListener(EventID.LoadSceneSuccess, MemoryStoryModule.__OnLoadSceneSuccess)
	SceneManager.ChangeScene(SceneID.Memory)
end

function MemoryStoryModule.Reload()
	return
end

function MemoryStoryModule.__OnLoadSceneSuccess(sceneId)
	EventDispatcher.RemoveEventListener(EventID.LoadSceneSuccess, MemoryStoryModule.__OnLoadSceneSuccess)

	local mainCameraGo = UnityEngine.GameObject.Find("Main Camera")

	MemoryStoryModule.MainCamera = mainCameraGo:GetComponent("Camera")
	MemoryStoryModule.StoryDialog = MemoryStoryDialogController.New()
	MemoryStoryModule.StoryScene = MemoryStoryScene.New()

	MemoryStoryModule.StoryScene:EnterMap(function()
		EventDispatcher.Dispatch(EventID.MemoryStorySceneChangeSuccessEvent)
		GameEntry.LuaEvent:FireNow(nil, LoadSceneExtResEndEventArgs():Fill(SceneID.Memory))
	end)

	MemoryStoryModule.InMemoryStoryScene = true
end

function MemoryStoryModule.ChangeStoryScene(storySceneId)
	if MemoryStoryModule.StoryScene == nil then
		return
	end

	EventDispatcher.AddEventListener(EventID.MemoryStoryScenePrepareChangeReadyEvent, MemoryStoryModule.__DoChangeScene)
	EventDispatcher.Dispatch(EventID.MemoryStoryScenePrepareChangeEvent, storySceneId)
end

function MemoryStoryModule.__DoChangeScene(storySceneId)
	MemoryStoryModule.__RecordCacheElements()
	EventDispatcher.RemoveEventListener(EventID.MemoryStoryScenePrepareChangeReadyEvent, MemoryStoryModule.__DoChangeScene)
	MemoryStoryModule.StoryScene:ClearMap(false, function()
		MemoryStoryModule.__InitStorySceneLogicData(storySceneId)
		MemoryStoryModule.__OnStorySceneClearMapSuccess()
	end)
end

function MemoryStoryModule.__OnStorySceneClearMapSuccess()
	MemoryStoryModule.StoryScene:EnterMap(MemoryStoryModule.__OnStorySceneEnterMapSuccess)
end

function MemoryStoryModule.__OnStorySceneEnterMapSuccess(scene)
	EventDispatcher.Dispatch(EventID.MemoryStorySceneChangeSuccessEvent)
end

function MemoryStoryModule.__InitStorySceneLogicData(storySceneId)
	MemoryStoryModule.CurStorySceneId = storySceneId
	MemoryStoryModule.StorySceneCfg = CfgMemoryStorySceneListTable[storySceneId]
	MemoryStoryModule.Elements = {}

	local cacheElements = MemoryStoryModule.__GetCacheElements(storySceneId)

	if #cacheElements == 0 then
		local elementList = MemoryStoryModule.StorySceneCfg.EventList

		for _, v in pairs(elementList) do
			MemoryStoryModule.__AddElement(v, nil)
		end
	else
		for elementId, cacheData in pairs(cacheElements) do
			MemoryStoryModule.__AddElement(elementId, cacheData)
		end
	end

	if MemoryStoryModule.Hero == nil then
		MemoryStoryModule.Hero = HeroController.New(MemoryStoryModule.StorySceneCfg.Hero)
	end
end

function MemoryStoryModule.OnStoryEnd(noticeCid)
	if noticeCid == 0 or noticeCid == nil then
		MemoryStoryModule.__PrepareLeave()

		return
	end

	NoticeModule.ShowNotice(noticeCid, function()
		MemoryStoryModule.__PrepareLeave()
	end)
end

function MemoryStoryModule.__PrepareLeave()
	EventDispatcher.AddEventListener(EventID.MemoryStoryScenePrepareLeaveReadyEvent, MemoryStoryModule.__DoLeaveScene)
	EventDispatcher.Dispatch(EventID.MemoryStoryScenePrepareLeaveEvent)
end

function MemoryStoryModule.__DoLeaveScene()
	EventDispatcher.RemoveEventListener(EventID.MemoryStoryScenePrepareLeaveReadyEvent, MemoryStoryModule.__DoLeaveScene)
	MemoryStoryModule.ExitScene()

	local jumpSoulData
	local soulData = SoulModule.GetSoulData(MemoryStoryModule.CurSoulCid)

	if soulData ~= nil and soulData.isUnlock then
		jumpSoulData = soulData
	end

	JumpModule.Jump(10708004, jumpSoulData)
end

function MemoryStoryModule.ExitScene()
	MemoryStoryModule.ClearOnLeaveScene()
end

function MemoryStoryModule.Shutdown()
	MemoryStoryModule.ClearOnLeaveScene()
end

function MemoryStoryModule.ClearOnLeaveScene()
	MemoryStoryModule.InMemoryStoryScene = false

	if MemoryStoryModule.StoryScene ~= nil then
		MemoryStoryModule.StoryScene:Release()
	end

	MemoryStoryModule.StoryDialog:OnDestroy()

	MemoryStoryModule.Execution = nil
	MemoryStoryModule.Condition = nil
	MemoryStoryModule.Hero = nil
	MemoryStoryModule.SceneElementCache = {}

	MemoryStoryPlayerModule.Reset()
end

function MemoryStoryModule.ExecuteElementServices(triggerType, elementId)
	local element = MemoryStoryModule.Elements[elementId]

	if element == nil then
		return
	end

	if triggerType == MemoryStoryModule.ElementTriggerType.ColliderEnter then
		element:ExecuteColliderEnterServices()
	elseif triggerType == MemoryStoryModule.ElementTriggerType.ColliderExit then
		EventDispatcher.Dispatch(EventID.SetMemoryStoryOptionUIActiveEvent, false, elementId)
		element:ExecuteColliderExitServices()
	elseif triggerType == MemoryStoryModule.ElementTriggerType.MouseClicked then
		element:ExecuteMouseClickServices()
	else
		logError("错误的触发类型" .. tostring(triggerType))
	end
end

function MemoryStoryModule.ExecuteService(element, service, condition)
	local tempCondition, _ = ConditionModule.Check(service.ConditionID)

	if condition ~= nil and tempCondition ~= condition then
		return false
	end

	if tempCondition then
		MemoryStoryExecutionModule.ExecuteService(element, service.ExecutionID)
	else
		MemoryStoryExecutionModule.ExecuteService(element, service.VetoExecutionID)
	end

	return true
end

function MemoryStoryModule.ExecuteServicesByElementId(elementId, serviceId)
	local element = MemoryStoryModule.__GetElementById(elementId)

	if element == nil then
		return
	end

	local service = CfgMemoryStoryServiceTable[serviceId]

	if service == nil then
		return
	end

	MemoryStoryModule.ExecuteService(element, service, nil)
end

function MemoryStoryModule.DoExecution(elementId, executionIds, conditionList)
	local element = MemoryStoryModule.__GetElementById(elementId)

	if element == nil then
		return
	end

	for i = 1, #executionIds do
		local executionCid = executionIds[i]
		local conditionCid = conditionList[i]
		local result, failedReason = ConditionModule.Check(conditionCid)

		if result then
			MemoryStoryExecutionModule.ExecuteService(element, {
				executionCid
			})
		end
	end
end

function MemoryStoryModule.__RecordCacheElements()
	local cacheElements = {}

	for elementId, npcController in pairs(MemoryStoryModule.Elements) do
		local cacheData = {
			bindingTasks = Clone(npcController.bindingTasks)
		}

		cacheElements[elementId] = cacheData
	end

	MemoryStoryModule.SceneElementCache[MemoryStoryModule.CurStorySceneId] = cacheElements
end

function MemoryStoryModule.__GetCacheElements(storySceneId)
	if MemoryStoryModule.SceneElementCache[storySceneId] == nil then
		MemoryStoryModule.SceneElementCache[storySceneId] = {}
	end

	return MemoryStoryModule.SceneElementCache[storySceneId]
end

function MemoryStoryModule.__AddElement(elementId, cacheData)
	if MemoryStoryModule.Elements[elementId] ~= nil then
		return nil
	end

	MemoryStoryModule.Elements[elementId] = NpcController.New(elementId, cacheData)

	return MemoryStoryModule.Elements[elementId]
end

function MemoryStoryModule.__RemoveElement(elementId)
	local element = MemoryStoryModule.Elements[elementId]

	if element ~= nil then
		element:RemoveToScene()

		element = nil
	end

	MemoryStoryModule.Elements[elementId] = nil
end

function MemoryStoryModule.HasElement(elementId)
	local elem = MemoryStoryModule.__GetElementById(elementId)

	return elem ~= nil
end

function MemoryStoryModule.AddElement(elementId)
	local element = MemoryStoryModule.__AddElement(elementId, nil)

	if element == nil then
		return
	end

	MemoryStoryModule.StoryScene:AddNpcInScene(element)
end

function MemoryStoryModule.RemoveElement(elementId)
	MemoryStoryModule.StoryScene:RemoveNpcInScene(elementId)
	MemoryStoryModule.__RemoveElement(elementId)
end

function MemoryStoryModule.OnElementReadyInScene(elementId, executeService)
	local element = MemoryStoryModule.__GetElementById(elementId)

	if element == nil then
		return
	end

	if element.CfgData.ElementType == MemoryStoryModule.ElementType.Npc then
		MemoryStoryModule.__DoRefreshElementTaskTag(element)
	end

	if not executeService then
		return
	end

	element:ExecuteReadyInSceneService()
end

function MemoryStoryModule.RefreshElementTaskTag(elementId)
	local controller = MemoryStoryModule.Elements[elementId]

	if controller == nil then
		return
	end

	MemoryStoryModule.__DoRefreshElementTaskTag(controller)
end

function MemoryStoryModule.RefreshElementTaskTagByController(controller)
	if controller == nil then
		return
	end

	MemoryStoryModule.__DoRefreshElementTaskTag(controller)
end

function MemoryStoryModule.__DoRefreshElementTaskTag(controller)
	local _, state = controller:GetCurrentShowTagTas()

	MemoryStoryModule.StoryScene:RefreshElementTaskTag(controller.CfgData.Id, state)
end

function MemoryStoryModule.TransferToPoint(pointId, forward)
	MemoryStoryModule.StoryScene:ResetHeroPoint(pointId, forward)
end

function MemoryStoryModule.PlayAnimation(elementId, anim, delay, loop)
	if delay == 0 then
		MemoryStoryModule.StoryScene:PlayAnim(elementId, anim, loop)

		return
	end

	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.MemoryStory, function()
		MemoryStoryModule.StoryScene:PlayAnim(elementId, anim, loop)
	end, delay, false)

	timer:Start()
end

function MemoryStoryModule.AutoMoveHero(dir)
	MemoryStoryModule.StoryScene:AutoMoveHero(dir)
end

function MemoryStoryModule.StopHeroMove()
	MemoryStoryModule.StoryScene.hero:StopWalk()
end

function MemoryStoryModule.SetElementOutlineActive(elementId, active)
	MemoryStoryModule.StoryScene:SetElementOutlineActive(elementId, active)
end

function MemoryStoryModule.SetElementOutlineLightActive(elementId, active)
	MemoryStoryModule.StoryScene:SetElementOutlineLightActive(elementId, active)
end

function MemoryStoryModule.PlayElementEffect(elementId, effectCid, delay)
	if delay == nil then
		delay = 0
	end

	MemoryStoryModule.StoryScene:PlayElementEffect(elementId, effectCid, delay)
end

function MemoryStoryModule.StopElementEffect(elementId, effectCid)
	MemoryStoryModule.StoryScene:StopElementEffect(elementId, effectCid)
end

function MemoryStoryModule.PlaySceneEffect(effectCid, delay)
	if delay == nil then
		delay = 0
	end

	MemoryStoryModule.StoryScene:PlaySceneEffect(effectCid, delay)
end

function MemoryStoryModule.StopSceneEffect(effectCid)
	MemoryStoryModule.StoryScene:StopSceneEffect(effectCid)
end

function MemoryStoryModule.Transfiguration(elementId, entityId)
	MemoryStoryModule.StoryScene:Transfiguration(elementId, entityId)
end

function MemoryStoryModule.__GetElementById(elementId)
	if MemoryStoryModule.Hero ~= nil and elementId == MemoryStoryModule.Hero.CfgData.Id then
		return MemoryStoryModule.Hero
	end

	return MemoryStoryModule.Elements[elementId]
end

function MemoryStoryModule.CameraLookAt(position, interpolation)
	MemoryStoryModule.StoryScene:CameraLookAtPosition(position, interpolation)
end

function MemoryStoryModule.CameraLookAtHero(interpolation)
	MemoryStoryModule.StoryScene:CameraLookAtHero(interpolation)
end

function MemoryStoryModule.ElementLookAtPlayer(elementId)
	MemoryStoryModule.StoryScene:ElementLookAtElementByElementId(elementId, MemoryStoryModule.Hero.CfgData.Id)
end

function MemoryStoryModule.CallNextDialog(selectIndex)
	MemoryStoryModule.StoryDialog:Next(selectIndex)
end

function MemoryStoryModule.CallEndDialog()
	MemoryStoryModule.StoryDialog:JumpToEnd()
end
