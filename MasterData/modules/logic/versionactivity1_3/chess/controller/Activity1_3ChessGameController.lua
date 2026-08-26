-- chunkname: @modules/logic/versionactivity1_3/chess/controller/Activity1_3ChessGameController.lua

module("modules.logic.versionactivity1_3.chess.controller.Activity1_3ChessGameController", package.seeall)

local Activity1_3ChessGameController = class("Activity1_3ChessGameController", BaseController)

function Activity1_3ChessGameController:init()
	return
end

function Activity1_3ChessGameController:reInit()
	return
end

function Activity1_3ChessGameController:release()
	return
end

function Activity1_3ChessGameController:getViewName()
	return
end

function Activity1_3ChessGameController:onInitServerMap(mapData)
	if not mapData.act122Sight then
		local addFires = mapData.act122Fire

		Activity122Model.instance:initSight(mapData.act122Sight)
		Activity122Model.instance:initFire(addFires)
		self:dispatchEvent(Activity1_3ChessEvent.InitGameScene, mapData)
	end
end

function Activity1_3ChessGameController:onUpdateServerMap(mapData)
	Activity122Model.instance:updateSight(mapData.addSights)
	Activity122Model.instance:updateFire(mapData.addFires)
	self:dispatchEvent(Activity1_3ChessEvent.UpdateGameScene, mapData)
end

function Activity1_3ChessGameController:onInitObjects()
	local actId = Va3ChessGameModel.instance:getActId()
	local mapId = Va3ChessGameModel.instance:getMapId()
	local mapConfig = Activity122Config.instance:getMapCo(actId, mapId)
	local decorateObjectStr = mapConfig.decorateObjects

	if not decorateObjectStr or string.nilorempty(decorateObjectStr) then
		return
	end

	local decorateObjects = cjson.decode(decorateObjectStr)

	for _, originData in ipairs(decorateObjects) do
		local interactObj = Va3ChessInteractObject.New()

		originData.actId = actId

		interactObj:init(originData)
		interactObj:setIgnoreSight(true)

		if interactObj.config ~= nil then
			Va3ChessGameController.instance.interacts:add(interactObj)
		end
	end
end

function Activity1_3ChessGameController:setSceneCamera(enterScene)
	if enterScene then
		local camera = CameraMgr.instance:getMainCamera()
		local unitCamera = CameraMgr.instance:getUnitCamera()

		unitCamera.orthographic = true
		unitCamera.orthographicSize = camera.orthographicSize

		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
		gohelper.setActive(PostProcessingMgr.instance._unitPPVolume.gameObject, true)
		PostProcessingMgr.instance:setUnitActive(true)
		PostProcessingMgr.instance:setUnitPPValue("localBloomActive", false)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", false)
		PostProcessingMgr.instance:setUnitPPValue("dofFactor", 0)
	else
		local unitCamera = CameraMgr.instance:getUnitCamera()

		unitCamera.orthographic = false

		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), false)
		PostProcessingMgr.instance:setUnitActive(false)
		PostProcessingMgr.instance:setUnitPPValue("localBloomActive", true)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", true)
	end
end

Activity1_3ChessGameController.instance = Activity1_3ChessGameController.New()

LuaEventSystem.addEventMechanism(Activity1_3ChessGameController.instance)

return Activity1_3ChessGameController
