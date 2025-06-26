-- chunkname: @IQIGame\\Scene\\MemoryStory\\MemoryStoryScene.lua

local CameraCtrl = require("IQIGame.Scene.MemoryStory.MemoryStorySceneCameraCtrl")
local SceneInput = require("IQIGame.Scene.MemoryStory.MemoryStorySceneInput")
local MemoryStoryMap = require("IQIGame.Scene.MemoryStory.MemoryStoryMap")
local MemoryStoryHero = require("IQIGame.Scene.MemoryStory.Element.MemoryStoryHero")
local MemoryStoryNpc = require("IQIGame.Scene.MemoryStory.Element.MemoryStoryNpc")
local MemoryStoryBackgroundParallax = require("IQIGame.Scene.MemoryStory.MemoryStoryBackgroundParallax")
local m = {
	scenePrepareReady = false,
	soundPackageId = 0,
	elementsTab = {}
}

function m.New()
	local obj = Clone(m)

	obj:__Init()

	return obj
end

function m:__Init()
	self:__OnPrepareEventProxy()
	self:__AddEventListener()

	self.cameraCtrl = CameraCtrl.New()
	self.inputManager = SceneInput.New()
	self.inputManager.OnElementClickEvent = self.elementClickedEventProxy
end

function m:Release()
	self:__RemoveEventListener()

	if self.inputManager ~= nil then
		self.inputManager:OnDispose()

		self.inputManager = nil
	end

	self:ClearMap(true, nil)

	if self.cameraCtrl ~= nil then
		self.cameraCtrl:OnDestroy()

		self.cameraCtrl = nil
	end
end

function m:__AddEventListener()
	GameEntry.Timer:AddFrameRender(1, self.timerFrameRenderEventProxy, true)
	EventDispatcher.AddEventListener(EventID.JoystickMove, self.joystickMoveEventProxy)
end

function m:__RemoveEventListener()
	GameEntry.Timer:RemoveRender(self.timerFrameRenderEventProxy)
	EventDispatcher.RemoveEventListener(EventID.JoystickMove, self.joystickMoveEventProxy)
end

function m:__OnPrepareEventProxy()
	function self.timerFrameRenderEventProxy()
		self:OnTimerFrameRenderEventHandler()
	end

	function self.joystickMoveEventProxy(value)
		self:OnJoystickMoveEventHandler(value)
	end

	function self.elementClickedEventProxy(instanceId)
		self:OnElementClickedEventHandler(instanceId)
	end
end

function m:OnTimerFrameRenderEventHandler()
	if not self.scenePrepareReady then
		return
	end

	if self.cameraCtrl ~= nil then
		self.cameraCtrl:Update()
	end

	if self.backgroundParallax ~= nil then
		self.backgroundParallax:OnUpdate()
	end

	self:__OnElementUpdate()
end

function m:OnJoystickMoveEventHandler(moveDir)
	if not self.scenePrepareReady then
		return
	end

	if self.hero == nil or self.StoryMap == nil then
		return
	end

	if moveDir.x == 0 and moveDir.y == 0 then
		self.hero:StopWalk()

		return
	end

	local newPos = self:__OnEntityMove(self.hero, moveDir)

	self.cameraCtrl:LookAt(newPos)
end

function m:OnElementClickedEventHandler(instanceId)
	if not self.scenePrepareReady then
		return
	end

	local element = self.elementsTab[instanceId]

	if element == nil then
		return
	end

	MemoryStoryModule.ExecuteElementServices(MemoryStoryModule.ElementTriggerType.MouseClicked, element.elementId)
end

function m:__OnEntityMove(entity, moveDir)
	local curPos = Vector2.New(entity.viewRoot.transform.localPosition.x, entity.viewRoot.transform.localPosition.y)
	local p1, p2, pos = self:__CacEntityMoveData(entity.CurMoveNode, entity.NextMoveNode, moveDir, curPos)

	entity.CurMoveNode = p1
	entity.NextMoveNode = p2

	if curPos.x - pos.x < 0 then
		entity:SetEntityDir(true)
	elseif curPos.x - pos.x > 0 then
		entity:SetEntityDir(false)
	end

	entity:Walk(pos)

	return pos
end

function m:__CacEntityMoveData(startNodeId, endNodeId, moveDir, pos)
	if endNodeId == -1 then
		endNodeId = self:__GetNextMoveNode(startNodeId, moveDir)

		if endNodeId == -1 then
			return startNodeId, -1, pos
		end
	end

	local startNode = self.StoryMap:GetPathNode(startNodeId)
	local endNode = self.StoryMap:GetPathNode(endNodeId)
	local originDirection = endNode.PositionV2 - startNode.PositionV2
	local targetDirection = moveDir
	local angle = Vector2.Angle(originDirection, targetDirection)
	local moveDistance = 0.03
	local moveDirection = endNode.PositionV2 - startNode.PositionV2

	moveDirection = moveDirection.normalized

	local newPos = pos

	if angle <= 90 then
		newPos = pos + moveDirection * moveDistance
	else
		newPos = pos + moveDirection * moveDistance * -1
	end

	local distance = Vector2.Distance(startNode.PositionV2, newPos)

	if math.abs(distance) < moveDistance / 2 then
		return startNodeId, -1, startNode.PositionV2
	end

	distance = Vector2.Distance(endNode.PositionV2, newPos)

	if math.abs(distance) < moveDistance / 2 then
		return endNodeId, -1, endNode.PositionV2
	end

	return startNodeId, endNodeId, newPos
end

function m:__GetNextMoveNode(startNodeId, moveDir)
	local nodeData = self.StoryMap:GetPathNode(startNodeId)
	local nextNodeId = -1
	local tempAngle = 360

	for _, v in pairs(nodeData.ConnectNodeId) do
		local tempNodeData = self.StoryMap:GetPathNode(v)
		local angle = Vector2.Angle(tempNodeData.PositionV2 - nodeData.PositionV2, moveDir)

		if angle < 90 then
			if nextNodeId ~= -1 then
				if angle < tempAngle then
					nextNodeId = v
					tempAngle = angle
				end
			else
				nextNodeId = v
				tempAngle = angle
			end
		end
	end

	return nextNodeId
end

function m:AddNpcInScene(npc)
	self:__DoAddElementInScene(npc)
end

function m:RemoveNpcInScene(elementId)
	self:__DoRemoveElementInScene(elementId)
end

function m:PlayAnim(elementId, anim, loop)
	local element = self:__GetElementByElementId(elementId)

	if element == nil then
		return
	end

	element:PlayAnim(anim, loop)
end

function m:ResetHeroPoint(pointId, forward)
	local position = self.StoryMap:GetPathNode(pointId).Position

	self.hero:UpdateMoveNode(pointId, -1)

	self.hero.viewRoot.transform.localPosition = position

	self.hero:SetEntityDir(forward)

	return position
end

function m:SetElementOutlineActive(elementId, active)
	local element = self:__GetElementByElementId(elementId)

	if element == nil then
		return
	end

	element:__SetOutlineActive(active)
end

function m:SetElementOutlineLightActive(elementId, active)
	local element = self:__GetElementByElementId(elementId)

	if element == nil then
		return
	end

	element:__SetOutlineLightActive(active)
end

function m:ElementLookAtElement(element, lookAtElement)
	if element == nil then
		return
	end

	if lookAtElement == nil then
		return
	end

	local x1 = element.viewRoot.transform.localPosition.x
	local x2 = lookAtElement.viewRoot.transform.localPosition.x

	if x2 < x1 then
		element:SetEntityDir(false)
		lookAtElement:SetEntityDir(true)
	else
		element:SetEntityDir(true)
		lookAtElement:SetEntityDir(false)
	end

	local forward = lookAtElement:IsLookForward()

	element:SetEntityDir(not forward)
end

function m:ElementLookAtElementByElementId(elementId, lookAtElementId)
	local element = self:__GetElementByElementId(elementId)

	if element == nil then
		return
	end

	local lookAtElement = self:__GetElementByElementId(lookAtElementId)

	if lookAtElement == nil then
		return
	end

	self:ElementLookAtElement(element, lookAtElement)
end

function m:PlayElementEffect(elementId, effectCid, delay)
	local element = self:__GetElementByElementId(elementId)

	if element == nil then
		return
	end

	element:__PlayEffect(effectCid, delay)
end

function m:StopElementEffect(elementId, effectCid)
	local element = self:__GetElementByElementId(elementId)

	if element == nil then
		return
	end

	element:__RemoveEffect(effectCid)
end

function m:PlaySceneEffect(effectCid, delay)
	if self.StoryMap == nil then
		return
	end

	self.StoryMap:__PlayEffect(effectCid, delay)
end

function m:StopSceneEffect(effectCid)
	if self.StoryMap == nil then
		return
	end

	self.StoryMap:__RemoveEffect(effectCid)
end

function m:AutoMoveHero(dir)
	local timer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.MemoryStory, function()
		self:OnJoystickMoveEventHandler(dir)
	end, 0, -1)

	function self.hero.StopWalkAction()
		ModuleTimerUtil.StopTimer(timer)
	end

	timer:Start()
end

function m:RefreshElementTaskTag(elementId, taskState)
	local element = self:__GetElementByElementId(elementId)

	if element == nil then
		return
	end

	element:ShowTaskTag(taskState)
end

function m:Transfiguration(elementId, entityId)
	local element = self:__GetElementByElementId(elementId)

	if element == nil then
		return
	end

	element:Transfiguration(entityId)
end

function m:ClearMap(destroyHero, callback)
	self.scenePrepareReady = false

	self:__StopSound()

	if self.backgroundParallax ~= nil then
		self.backgroundParallax:OnDestroy()

		self.backgroundParallax = nil
	end

	self:__ReleaseElements()
	self:__ReleaseHero(destroyHero)

	if self.StoryMap ~= nil then
		self.StoryMap:OnDestroy()
	end

	self.StoryMap = nil

	if callback ~= nil then
		callback()
	end
end

function m:EnterMap(callback)
	self.StoryMap = MemoryStoryMap.New(MemoryStoryModule.StorySceneCfg.ScenePrefab, function()
		self:__OnStoryMapSuccessEventHandler(callback)
	end)
end

function m:__OnStoryMapSuccessEventHandler(callback)
	self:__PlaySound()
	self:__OnPrepareBackgroundParallax()
	self:__OnPrepareSceneHero()
	self:__OnPrepareSceneElement()

	self.scenePrepareReady = true

	callback()
end

function m:__OnPrepareBackgroundParallax()
	if self.StoryMap.goBg ~= nil then
		self.backgroundParallax = MemoryStoryBackgroundParallax.New(self.StoryMap.goBg)
	else
		self.backgroundParallax = nil
	end
end

function m:__OnPrepareSceneHero()
	if self.hero == nil then
		self.hero = MemoryStoryHero.New(MemoryStoryModule.Hero, self.StoryMap:GetFreeElementRoot())
	else
		self.StoryMap:MountElement(self.hero.viewRoot.transform)
		self.hero:ReEnterScene()
	end

	local pos = self:ResetHeroPoint(MemoryStoryModule.StorySceneCfg.BornPoint, MemoryStoryModule.StorySceneCfg.Direction)
	local top, right, bottom, left = self.StoryMap:GetMapLimitPos()

	self.cameraCtrl:Refresh(MemoryStoryModule.MainCamera, 2, top, right, bottom, left, pos)
end

function m:__OnPrepareSceneElement()
	for _, v in pairs(MemoryStoryModule.Elements) do
		self:__DoAddElementInScene(v)
	end
end

function m:__DoAddElementInScene(element)
	local view = self.StoryMap:GetFreeElementRoot()
	local elem = MemoryStoryNpc.New(element, view)

	self.elementsTab[view:GetInstanceID()] = elem
end

function m:__DoRemoveElementInScene(elementId)
	local instanceId = self:__DoFindElementInstanceIdByElementId(elementId)

	if instanceId == 0 then
		return
	end

	local element = self.elementsTab[instanceId]

	element:OnDestroy()

	self.elementsTab[instanceId] = nil
end

function m:__DoFindElementInstanceIdByElementId(elementId)
	for i, v in pairs(self.elementsTab) do
		if v.elementId == elementId then
			return i
		end
	end

	return 0
end

function m:__GetElementByElementId(elementId)
	if elementId == self.hero.elementId then
		return self.hero
	end

	local instanceId = self:__DoFindElementInstanceIdByElementId(elementId)

	if instanceId == 0 then
		return nil
	end

	return self.elementsTab[instanceId]
end

function m:__ReleaseElements()
	if self.elementsTab ~= nil then
		for instanceId, memoryStorySceneElement in pairs(self.elementsTab) do
			memoryStorySceneElement:OnDestroy()
		end

		self.elementsTab = {}
	end
end

function m:__ReleaseHero(destroy)
	if self.hero == nil then
		return
	end

	if destroy then
		self.hero:OnDestroy()

		self.hero = nil
	else
		self.hero:SetFree()
	end
end

function m:__OnElementUpdate()
	for _, element in pairs(self.elementsTab) do
		if self.hero == nil then
			return
		end

		if element == nil then
			return
		end

		element:OnUpdate()

		local isIntersects = self.hero:ColliderBoundsIntersects(element.Collider)

		if isIntersects then
			element:OnCollisionEnter2D()
		else
			element:OnCollisionExit2D()
		end
	end
end

function m:__PlaySound()
	local environmentalSounds

	if MemoryStoryModule.StorySceneCfg.EnvironmentalSound ~= 0 then
		environmentalSounds = {
			MemoryStoryModule.StorySceneCfg.EnvironmentalSound
		}
	end

	local soundPackage = SoundPackageData.New(MemoryStoryModule.StorySceneCfg.BGM, environmentalSounds)

	if self.soundPackageId ~= 0 then
		self.SoundPackagePlayer.Replace(self.soundPackageId, soundPackage)
	else
		self.soundPackageId = SoundPackagePlayer.Add(soundPackage)
	end
end

function m:__StopSound()
	if self.soundPackageId ~= 0 then
		SoundPackagePlayer.Remove(self.soundPackageId)
	end

	self.soundPackageId = 0
end

function m:CameraLookAtPosition(position, interpolation)
	self.cameraCtrl:LookAt(position, interpolation)
end

function m:CameraLookAtHero(interpolation)
	local position = self.hero:GetPosition()

	self.cameraCtrl:LookAt(position, interpolation)
end

return m
