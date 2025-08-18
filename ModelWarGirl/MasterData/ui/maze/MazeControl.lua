-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeControl.lua

local MazeControllerType = typeof(Framework.Drag.MazeController)
local Entity = require("Entity/Entity")
local ResHero = require("ClientData/ResHero")
local ModelTool = require("Entity/ModelTool")
local strClassName = "MazeControl"
local MazeControl = {}
local self = MazeControl

function MazeControl.init(mazeMain)
	if self.checkUnityObj(self.controller) == false then
		local root = UnityEngine.GameObject.Find("maze_root")

		self.controller = root:GetComponent(MazeControllerType)

		if self.controller == nil then
			self.controller = root:AddComponent(MazeControllerType)
		end
	end

	self.mazeMain = mazeMain

	self.changeLayer()
	self.setVisible(true)
	self.createModel()
end

function MazeControl.changeLayer(layer)
	layer = layer or CurAvatar.mazeData.layer

	if self.checkUnityObj(self.controller) then
		self.controller:InitMazeLayer(layer)

		self.firstPos = self.controller:GetStartPos()
	end
end

function MazeControl.createModel(...)
	local modelId, baseId = self.mazeMain:getBestHeroId()

	self.entity = Entity(9999, "maze")
	self.commonModelId = modelId
	self.commonBaseId = baseId
	self.modelPosOffset = {
		x = 0,
		y = 0.05
	}

	local modelData = {}

	if self.commonModelId then
		modelData.model_type = Const.MODEL_TYPE.ShowMain
		modelData.model_id = self.commonModelId
		modelData.use_lod = Const.MODEL_LOD_LV1
	end

	self.entity.mModelLoadedCallback = self.onModelLoadedEnd

	self.entity:createModel(modelData)
end

function MazeControl.onModelLoadedEnd(...)
	self.entity:setRotation(-90)
	ModelTool.addBaseModel(self.entity.entityModel:getModelInsId(), self.commonBaseId or self.commonModelId, 1, Const.HERO_BASE_TYPE.Main)
	self.entity.entityModel:setModelLayer(Const.LAYER_PLAYER)

	if self.lightObj == nil and self.checkUnityObj(self.controller) then
		self.lightObj = self.controller:GetFollowLightObj("art_effect/Point Light")
	end

	if self.checkUnityObj(self.lightObj) then
		self.lightObj.transform.parent = self.entity.controller.transform

		self.lightObj:SetActive(true)

		self.lightObj.transform.localPosition = Vector3(0, 1.94, 0)
	end
end

function MazeControl.teleport(pos)
	self.entity:teleport(pos.x, pos.y + self.modelPosOffset.y, pos.z)
end

function MazeControl.getNode(id)
	if self.checkUnityObj(self.controller) then
		return self.controller:GetNode(id)
	end
end

function MazeControl.checkRay(...)
	if self.checkUnityObj(self.controller) then
		return self.controller:CheckRay()
	end

	return -1
end

function MazeControl.teleportModel(pos, callBack)
	self.mCallBack = callBack

	local endPos = Vector3(pos.x, self.entity:getPosition().y, pos.z)

	self.entity:teleportInTime(endPos, 1, self.openNodeUI)

	self.isMovingModel = true
end

function MazeControl.openNodeUI(...)
	if self.mCallBack then
		self.mCallBack()
	end

	self.isMovingModel = false
end

function MazeControl.setVisible(v)
	if self.checkUnityObj(self.controller) then
		self.controller:SetVisible(v)
	end
end

function MazeControl.checkUnityObj(obj)
	local state = obj ~= nil and not tolua.isnull(obj) and not tolua.isnull(obj.gameObject)

	return state
end

function MazeControl.preDestroy(...)
	self.isMovingModel = false

	if self.checkUnityObj(self.lightObj) then
		self.lightObj.transform.parent = nil

		self.lightObj:SetActive(false)
	end

	self.mazeMain = nil

	if self.entity then
		self.entity:destroy()
	end
end

function MazeControl.destroy(...)
	self.lightObj = nil
	self.controller = nil
end

return MazeControl
