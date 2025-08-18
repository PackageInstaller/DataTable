-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Entity\\DynamicStage.lua

local DynamicStageUtils = DynamicStageSp.DynamicStageUtils
local ModelTool = require("Entity/ModelTool")
local strClassName = "DynamicStage"
local DynamicStage = Class(strClassName)

function DynamicStage:ctor(sceneNo)
	self._modelDict = {}
	self.sceneNo = sceneNo
end

function DynamicStage:destroy(...)
	if self._stageObj then
		DynamicStageUtils.DestroyDynamicStage(self._stageObj)

		self._stageObj = nil
	end
end

function DynamicStage:loadGameOjbect(prefabPath, loadedCallback)
	self.goLoadedCallback = loadedCallback

	DynamicStageUtils.CreateDynamicStageAsync(prefabPath, Slot(self._onGameObjectLoaded, self))
end

function DynamicStage:_onGameObjectLoaded(obj)
	self._stageObj = obj

	self._stageObj:Init()

	if self.goLoadedCallback then
		self.goLoadedCallback()

		self.goLoadedCallback = nil
	end
end

function DynamicStage:setPosition(x, y, z)
	if self._stageObj then
		self._stageObj:SetPosition(x, y, z)
	end
end

function DynamicStage:setScale(scale)
	if self._stageObj then
		self._stageObj:SetScale(scale)
	end
end

function DynamicStage:setRotation(x, y, z)
	if self._stageObj then
		self._stageObj:SetRotation(x, y, z)
	end
end

function DynamicStage:addModel(modelResId, usageString, idx, callback)
	if not self._stageObj then
		return
	end

	if self._modelDict[idx] then
		self._stageObj:DelModel(self._modelDict[idx])

		self._modelDict[idx] = nil
	end

	local modelData = ModelTool.analyzeModelData({
		model_type = Const.MODEL_TYPE.ShowMain,
		model_id = modelResId
	})

	local function addModelCallback(modelInsId)
		self._stageObj:SetModelScale(modelInsId, 1)
		self:_onModelLoaded(modelInsId, idx)

		if callback then
			callback(idx)
		end
	end

	self._stageObj:AddModel(modelData, addModelCallback, idx, true)
end

function DynamicStage:_onModelLoaded(modelInsId, idx)
	self._modelDict[idx] = modelInsId

	self._stageObj:SetModelTonemapping(modelInsId, true)
end

function DynamicStage:modelPlayAnim(idx, animName)
	local modelInsId = self._modelDict[idx]

	if not modelInsId or not self._stageObj then
		return
	end

	self._stageObj:ModelPlayAnimator(modelInsId, animName)
end

function DynamicStage:modelVisible(idx, isVisible)
	local modelInsId = self._modelDict[idx]

	if not modelInsId or not self._stageObj then
		return
	end

	self._stageObj:SetModelVisible(modelInsId, isVisible)
end

function DynamicStage:playStageAnim(animName)
	if self._stageObj then
		self._stageObj:PlayStageAnimator(animName)
	end
end

return DynamicStage
