-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/scene/RogueViewMgr.lua

module("logic.extensions.roguelike.scene.RogueViewMgr", package.seeall)

local M = class("RogueViewMgr", ISceneFlowComp)
local kGridMainColorID = UnityEngine.Shader.PropertyToID("_BaseColor")

function M:onEnter()
	self:_setEvent(true)
end

function M:findSceneObject()
	local goNear = UnityEngine.GameObject.Find("near")
	local mapParent1 = goutil.findChild(goNear, "xuanrenchangjing")
	local mapParent2 = goutil.findChild(goNear, "dachangjing")

	RoguelikeController.instance:setMapParent(1, mapParent1)
	RoguelikeController.instance:setMapParent(2, mapParent2)

	if not goutil.isNil(mapParent1) then
		removetimer(self.findSceneObject, self)
		GlobalDispatcher:dispatchEvent(EventType.ROGUE_SCENE_LOAD_FINISH)
	end
end

function M:onSceneLoadDone()
	settimer(0.1, self.findSceneObject, self, true)

	local goNear = UnityEngine.GameObject.Find("near")
	local mapParent1 = goutil.findChild(goNear, "xuanrenchangjing")
	local mapParent2 = goutil.findChild(goNear, "dachangjing")

	RoguelikeController.instance:setMapParent(1, mapParent1)
	RoguelikeController.instance:setMapParent(2, mapParent2)
	goutil.setActive(mapParent1, false)
	goutil.setActive(mapParent2, not RoguelikeController.instance:getIsSelectRoleScene())

	if RoguelikeController.instance:getIsSelectRoleScene() and not goutil.isNil(mapParent1) then
		settimer(0.5, function()
			goutil.setActive(mapParent1, true)

			if not goutil.isNil(mapParent1) then
				local animator = mapParent1:GetComponent(ComponentType.Animation)

				animator:Play("xuanrenchangjing_cx")
			end
		end, self, false)
	end

	if RoguelikeController.instance:getIsSelectRoleScene() then
		local pos = Vector3.New(-3.26, -3.34, 9.91)

		VirtualCameraMgr.instance:setDampingX(0)
		VirtualCameraMgr.instance:setDampingZ(0)
		VirtualCameraMgr.instance:forceSetFollowPosition(pos.x, pos.y, pos.z)
		LoadingFacade.instance:hideLoading()

		local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()

		if virtualCamera:getMainGO() and not goutil.isNil(virtualCamera:getMainGO()) then
			virtualCamera:doRotation(20, 0, 0, 0.5)
		else
			virtualCamera:setLoadedCallback(self._onCameraLoad, self)
		end
	end
end

function M:_onCameraLoad()
	local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()

	virtualCamera:doRotation(20, 0, 0, 0.5)
	virtualCamera:setLoadedCallback(nil, nil)
end

function M:onEnterDone()
	if RoguelikeController.instance:getIsSelectRoleScene() then
		return
	end

	ViewMgr.instance:open(ViewName.RogueMap, {
		true,
		function()
			RoguelikeController.instance:showEnterSceneAni(function()
				RogueCameraUtil.instance:playEnterSceneCamera()
			end)
		end
	})

	local mapRoot = RogueMapGenerator.getMapsRoot()
	local mapRoot2 = RogueMapGenerator.getMapsRoot2()

	goutil.setActive(mapRoot, true)
	goutil.setActive(mapRoot2, true)
end

function M:onExit()
	self:_setEvent(false)
	goutil.destroy(self._tempGo)
	removetimer(self.findSceneObject, self)
	RoguelikeUtil.instance:destroySelectRoles()
end

function M:_setEvent(add)
	if add then
		-- block empty
	end
end

return M
