-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\ModelStageManager.lua

local ModelStage = require("UI/Control/Com/ModelStage")
local DrawModelStage = require("UI/Control/Com/DrawModelStage")
local AvgModelStage = require("UI/Control/Com/AvgModelStage")
local AvgConfig = require("DesignerScript/AvgConfig")
local GameSettings = require("Helper/GameSettings")
local UIUtils = require("Framework.UI.UIUtils")
local ModelStageManager = {}
local self = ModelStageManager

ModelStageManager.MODEL_STAGE_INFO = {
	["ModelStage/AvgBgStage"] = {
		2,
		AvgModelStage
	},
	["ModelStage/AvgBgStage_NoDefault"] = {
		2,
		AvgModelStage
	},
	["ModelStage/HandBookDlgModelStage"] = {
		3
	},
	["ModelStage/HeroDlgModelStage"] = {
		4
	},
	["ModelStage/HeroStarUpDlgModelStage"] = {
		5
	},
	["ModelStage/ChoukaModeStage"] = {
		6,
		DrawModelStage
	},
	["ModelStage/RoleInfoHeroDlgModelStage"] = {
		7
	},
	["ModelStage/CleanModelStage"] = {
		8
	},
	["ModelStage/LoginModelStage"] = {
		9
	},
	["ModelStage/MonopolyRollStage"] = {
		10
	},
	["ModelStage/AVGModelStage"] = {
		11
	},
	["ModelStage/CleanttModelStage01"] = {
		12
	},
	["ModelStage/NewDisplayModelStage"] = {
		1
	},
	["ModelStage/NewDisplayModelStage_bili"] = {
		1
	},
	["ModelStage/NewDisplayModelStage_tap"] = {
		1
	},
	["ModelStage/NewDisplayModelStage_hay"] = {
		1
	},
	["ModelStage/NewDisplayModelStage_4399"] = {
		1
	}
}

for msName, pos in pairs(AvgConfig.MODEL_STAGE_POS) do
	ModelStageManager.MODEL_STAGE_INFO[msName] = {
		pos
	}
end

ModelStageManager.RT_SCALE = {}
ModelStageManager.RENDER_STEP = {
	["ModelStage/NewDisplayModelStage_tap"] = 4,
	["ModelStage/NewDisplayModelStage_bili"] = 4,
	["ModelStage/NewDisplayModelStage_4399"] = 4,
	["ModelStage/NewDisplayModelStage"] = 4,
	["ModelStage/NewDisplayModelStage_hay"] = 4
}
ModelStageManager.RT_ANTI_ALIASING = {
	["ModelStage/LoginModelStage"] = 4
}
ModelStageManager.DEFAULT_ANTI_ALIASING = 1

function ModelStageManager.initModelStageManager()
	self.modelStageInfo = {}
	self.uiModelStageDict = {}
	self.stageHideStates = {}
end

function ModelStageManager.createUIModelStage(parent, prefabPath, loadedCallback)
	local stageInfo = self.createModelStage(prefabPath, loadedCallback)

	stageInfo.uiUse = true

	local uiRoot = parent.mRoot or parent
	local parentUIID = uiRoot.id

	self.registerParentUI(parentUIID, prefabPath)

	return stageInfo.stage
end

function ModelStageManager.releaseUIModelStage(parentUIID, prefabPath)
	local info = self.modelStageInfo[prefabPath]

	if info then
		self.unregisterParentUI(parentUIID, prefabPath)

		info.uiUse = false

		if not info.uiUse and not info.globalUse then
			self.realDestroy(prefabPath)
		end
	end
end

function ModelStageManager.onUIDestroy(parentUIID)
	if self.uiModelStageDict[parentUIID] then
		for prefabPath, _ in pairs(self.uiModelStageDict[parentUIID]) do
			self.releaseUIModelStage(parentUIID, prefabPath)
		end

		self.uiModelStageDict[parentUIID] = nil
		self.stageHideStates[parentUIID] = nil
	end
end

function ModelStageManager.onUIHide(parentUIID, isHide)
	if self.uiModelStageDict[parentUIID] then
		self.stageHideStates[parentUIID] = isHide

		for prefabPath, _ in pairs(self.uiModelStageDict[parentUIID]) do
			local info = self.modelStageInfo[prefabPath]

			if info then
				info.stage:setHide(isHide)
			end
		end
	end
end

function ModelStageManager.onUIClose(parentUIID)
	if self.uiModelStageDict[parentUIID] then
		for prefabPath, _ in pairs(self.uiModelStageDict[parentUIID]) do
			local info = self.modelStageInfo[prefabPath]

			if info then
				info.stage:setLightHide(true)
			end
		end

		self.refreshAllLight(parentUIID)
	end
end

function ModelStageManager.hideAllLight()
	for parentUIID, _ in pairs(self.uiModelStageDict) do
		self.onUIHide(parentUIID, true)
	end
end

function ModelStageManager.refreshAllLight(sourceParentUUID)
	for parentUIID, isHide in pairs(self.stageHideStates) do
		if parentUIID ~= sourceParentUUID and not isHide then
			self.onUIHide(parentUIID, true)
			self.onUIHide(parentUIID, false)
		end
	end
end

function ModelStageManager.createGlobalModelStage(prefabPath, loadedCallback)
	local stageInfo = ModelStageManager.createModelStage(prefabPath, loadedCallback)

	stageInfo.globalUse = true

	return stageInfo.stage
end

function ModelStageManager.releaseGlobalModelStage(stage)
	local prefabPath, info = self._findMSInfo(stage)

	if prefabPath and info then
		info.globalUse = false

		if not info.uiUse and not info.globalUse then
			self.realDestroy(prefabPath)
		end
	end
end

function ModelStageManager.createModelStage(prefabPath, loadedCallback)
	local stageInfo = self.modelStageInfo[prefabPath]

	if not stageInfo then
		local stage

		if ModelStageManager.MODEL_STAGE_INFO[prefabPath] and ModelStageManager.MODEL_STAGE_INFO[prefabPath][2] then
			local specialClass = ModelStageManager.MODEL_STAGE_INFO[prefabPath][2]

			stage = specialClass(prefabPath, loadedCallback)
		else
			stage = ModelStage(prefabPath, loadedCallback)
		end

		stage:startLoad(self._getMSPos(prefabPath))

		if ModelStageManager.RT_SCALE[prefabPath] then
			stage:setRTScale(ModelStageManager.RT_SCALE[prefabPath])
		end

		if ModelStageManager.RENDER_STEP[prefabPath] then
			stage:skipRenderMode(ModelStageManager.RENDER_STEP[prefabPath])
		end

		if ModelStageManager.RT_ANTI_ALIASING[prefabPath] and not GameSettings.isLowQuality() then
			stage:setRTAntiAliasing(ModelStageManager.RT_ANTI_ALIASING[prefabPath])
		else
			stage:setRTAntiAliasing(ModelStageManager.DEFAULT_ANTI_ALIASING)
		end

		self.modelStageInfo[prefabPath] = {
			stage = stage,
			id = stage.id
		}

		return self.modelStageInfo[prefabPath]
	else
		local stage = stageInfo.stage

		if stage and loadedCallback then
			if stage._obj then
				loadedCallback(stage)
			else
				stage.loadedCallback = loadedCallback
			end
		end

		return stageInfo
	end
end

function ModelStageManager.realDestroy(prefabPath)
	if self.modelStageInfo[prefabPath] and self.modelStageInfo[prefabPath].stage then
		self.modelStageInfo[prefabPath].stage:destroy()

		self.modelStageInfo[prefabPath] = nil
	end
end

function ModelStageManager.registerParentUI(parentUIID, prefabPath)
	if not self.uiModelStageDict[parentUIID] then
		self.uiModelStageDict[parentUIID] = {}
		self.stageHideStates[parentUIID] = false
	end

	self.uiModelStageDict[parentUIID][prefabPath] = true
end

function ModelStageManager.unregisterParentUI(parentUIID, prefabPath)
	if self.uiModelStageDict[parentUIID] then
		self.uiModelStageDict[parentUIID][prefabPath] = nil
	end
end

function ModelStageManager.getModelStageId(prefabPath)
	if self.modelStageInfo[prefabPath] then
		return self.modelStageInfo[prefabPath].id
	end
end

function ModelStageManager.getModelStage(prefabPath)
	if self.modelStageInfo[prefabPath] then
		return self.modelStageInfo[prefabPath].stage
	end
end

function ModelStageManager._findMSInfo(stage)
	for prefabPath, info in pairs(self.modelStageInfo) do
		if info.id == stage.id then
			return prefabPath, info
		end
	end
end

function ModelStageManager._getMSPos(prefabPath)
	local data = ModelStageManager.MODEL_STAGE_INFO[prefabPath]

	if data then
		local index = data[1]
		local row = math.floor(index / 5)
		local col = index % 5

		return Vector3(50 + 200 * col, 200 + row * 200, 0)
	else
		return Vector3(0, 0, 0)
	end
end

function ModelStageManager.activeShadow(modelStage, active)
	if not self.shadowStack then
		self.shadowStack = {}
	end

	if active then
		for i = #self.shadowStack, 1, -1 do
			if self.shadowStack[i] == modelStage then
				table.remove(self.shadowStack, i)
			end
		end

		table.insert(self.shadowStack, modelStage)
	else
		for i = #self.shadowStack, 1, -1 do
			if self.shadowStack[i] == modelStage then
				table.remove(self.shadowStack, i)
			end
		end

		if #self.shadowStack > 0 then
			local lastModelStage = self.shadowStack[#self.shadowStack]

			lastModelStage:_activeCustomShadow(true)
		end
	end
end

function ModelStageManager.registerAllModelStageLight(isOn)
	if not self.modelStageInfo then
		return
	end

	for prefabPath, stageInfo in pairs(self.modelStageInfo) do
		if stageInfo.stage then
			stageInfo.stage:registerLight(isOn)
		end
	end
end

function ModelStageManager.activeRender(modelStage, active)
	if not self.renderStack then
		self.renderStack = {}
	end

	if active then
		for i = #self.renderStack, 1, -1 do
			if self.renderStack[i] == modelStage then
				table.remove(self.renderStack, i)
			else
				self.renderStack[i]:pauseRender()
			end
		end

		table.insert(self.renderStack, modelStage)
	else
		for i = #self.renderStack, 1, -1 do
			if self.renderStack[i] == modelStage then
				table.remove(self.renderStack, i)
			end
		end

		if #self.renderStack > 0 then
			local lastModelStage = self.renderStack[#self.renderStack]

			lastModelStage:resumeRender()
		end
	end
end

return ModelStageManager
