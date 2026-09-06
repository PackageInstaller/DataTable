-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/controller/MakeCakeController.lua

module("logic.extensions.anniversarycake.controller.MakeCakeController", package.seeall)

local MakeCakeController = class("MakeCakeController", BaseController)
local SceneElementId1 = 333
local SceneElementId2 = 334
local SceneElementId3 = 335
local SceneElementId4 = 338

function MakeCakeController:ctor()
	local str = MakeCakeConfig.instance:getConstValue("ChangeCakePic")
	local list = string.split(str, ",")

	self._scoreList = {}
	self._scoreList[SceneElementId1] = checknumber(list[1])
	self._scoreList[SceneElementId2] = checknumber(list[2])
	self._scoreList[SceneElementId3] = checknumber(list[3])
	self._scoreList[SceneElementId4] = checknumber(list[4])
	self._isClickDown = false
end

function MakeCakeController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._updateByDay, self)
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._onSceneLoadedFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.OnSceneElementVisible, self._onSceneElementVisible, self)
end

function MakeCakeController:_updateByDay()
	self:loadMakeCakeInfo()
	MakeCakeModel.instance:resetGameCount()
end

function MakeCakeController:_onSceneLoadedFinish(sceneType, sceneId)
	if sceneType == SceneType.City and sceneId == 1001 then
		settimer(0, self._onUpdate, self)

		self._isClickDown = false
		self._mousePos = Vector2.New(0, 0)
	else
		removetimer(self._onUpdate, self)
	end
end

function MakeCakeController:_onSceneElementVisible(sceneId, elementId, go, visible)
	local worldProgress = MakeCakeModel.instance:getWorldProgress()

	if elementId == SceneElementId1 then
		goutil.setActive(go, worldProgress < self._scoreList[SceneElementId1])
	elseif elementId == SceneElementId2 then
		goutil.setActive(go, worldProgress >= self._scoreList[SceneElementId1] and worldProgress < self._scoreList[SceneElementId2])
	elseif elementId == SceneElementId3 then
		goutil.setActive(go, worldProgress >= self._scoreList[SceneElementId2] and worldProgress < self._scoreList[SceneElementId3])
	elseif elementId == SceneElementId4 then
		goutil.setActive(go, worldProgress >= self._scoreList[SceneElementId3])
	end
end

function MakeCakeController:_onUpdate()
	if UGUIToolHelper.IsTouchDown() then
		if not UGUIToolHelper.IsOverUI() and ViewMgr.instance:isOpen(ViewName.MainUI) then
			local cameraTarget = CameraTargetMgr.instance:getMainCameraTarget()

			if cameraTarget then
				local mousePos = UGUIToolHelper.GetTouchPosition()
				local ray = cameraTarget:getCamera():ScreenPointToRay(mousePos)
				local isHit, hitResult = UnityEngine.Physics.Raycast(ray, nil)
				local parent

				if hitResult then
					parent = hitResult.collider.gameObject.transform.parent
				end

				if isHit and not goutil.isNil(parent) then
					local name = parent.name

					if name == "SceneElement_" .. SceneElementId1 or name == "SceneElement_" .. SceneElementId2 or name == "SceneElement_" .. SceneElementId3 or name == "SceneElement_" .. SceneElementId4 then
						self._isClickDown = true
						self._mousePos = UGUIToolHelper.GetTouchPosition()
					else
						self._isClickDown = false
					end
				else
					self._isClickDown = false
				end
			end
		end
	elseif UGUIToolHelper.IsTouchUp() then
		if not UGUIToolHelper.IsOverUI() and ViewMgr.instance:isOpen(ViewName.MainUI) then
			local cameraTarget = CameraTargetMgr.instance:getMainCameraTarget()

			if cameraTarget then
				local mousePos = UGUIToolHelper.GetTouchPosition()
				local ray = cameraTarget:getCamera():ScreenPointToRay(mousePos)
				local isHit, hitResult = UnityEngine.Physics.Raycast(ray, nil)
				local parent

				if hitResult then
					parent = hitResult.collider.gameObject.transform.parent
				end

				if isHit and not goutil.isNil(parent) then
					local name = parent.name

					if (name == "SceneElement_" .. SceneElementId1 or name == "SceneElement_" .. SceneElementId2 or name == "SceneElement_" .. SceneElementId3 or name == "SceneElement_" .. SceneElementId4) and self._isClickDown then
						local d = UnityEngine.Vector2.Distance(self._mousePos, UGUIToolHelper.GetTouchPosition())

						if d < 10 then
							self:openMakeCakeView()
						end
					end
				end
			end
		end

		self._isClickDown = false
	end
end

function MakeCakeController:openMakeCakeView()
	FuncOpenController.instance:openFunc(FuncConst.AnniversaryCake)
end

function MakeCakeController:loadMakeCakeInfo()
	local activityId = MakeCakeModel.instance:getActivityId()
	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.AnniversaryCake, activityId)

	if isInTime then
		AnniversaryCakeAgent.instance:sendPM_ACGetMakeCakeInfoReq(activityId)
	end
end

MakeCakeController.instance = MakeCakeController.New()

return MakeCakeController
