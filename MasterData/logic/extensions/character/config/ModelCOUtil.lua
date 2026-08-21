-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/character/config/ModelCOUtil.lua

module("logic.extensions.character.config.ModelCOUtil", package.seeall)

local ModelCOUtil = {}
local kResDirTypes = {
	"character3d",
	"scenemonster"
}
local kResTagTimelineMain = "timeline_main"
local kMinMonsterCode = 120000

function ModelCOUtil.isMultiSoloAnimation(modelCO, animName)
	local animations = modelCO.multiTimelineAnims

	if animations then
		for _, iAnimName in ipairs(animations) do
			if iAnimName == animName then
				return true
			end
		end
	end

	return false
end

function ModelCOUtil.getWholeIconPositionXYZ(modelCO)
	local position = modelCO.wholeIconPosition

	return position[1], position[2], position[3]
end

function ModelCOUtil.getResDir(modelCO)
	return kResDirTypes[modelCO.resDirType + 1]
end

function ModelCOUtil.getLowModelUrl(modelCO)
	local dir = ModelCOUtil.getResDir(modelCO)
	local name = modelCO.resName

	if modelCO.modelType == ModelEnum.ModelType.Low then
		return string.format("%s/%s/general/%s-flag.prefab", dir, name, name)
	elseif modelCO.modelType == ModelEnum.ModelType.Both then
		return string.format("%s/%s/general_low/%s_low-battle.prefab", dir, name, name)
	elseif modelCO.modelType == ModelEnum.ModelType.ShowHigh then
		return false
	end
end

function ModelCOUtil.getHighModelUrl(modelCO)
	local dir = ModelCOUtil.getResDir(modelCO)
	local name = modelCO.resName

	return string.format("%s/%s/general/%s-battle.prefab", dir, name, name)
end

function ModelCOUtil.hasLowModel(modelCO)
	return true
end

function ModelCOUtil.isLinkedModel(modelCO)
	return modelCO.modelType == ModelEnum.ModelType.ShowHigh
end

function ModelCOUtil.getPositionOffsets(modelCO)
	return modelCO.positionOffsets
end

function ModelCOUtil.getPerformancePositionOffsets(modelCO)
	if modelCO.modelType == 2 then
		local modelTypeParam = modelCO.modelTypeParam
		local positionOffsets = modelTypeParam.offsets

		return positionOffsets[1], positionOffsets[2], positionOffsets[3]
	end

	return 0, 0, 0
end

function ModelCOUtil.getEmptyModelSize(modelCO)
	if modelCO.modelType == 2 then
		local modelTypeParam = modelCO.modelTypeParam
		local size = modelTypeParam.size

		return size[1], size[2]
	end

	return 0, 0
end

function ModelCOUtil.getPerformanceResName(modelCO)
	if modelCO.modelType == ModelEnum.ModelType.ShowHigh then
		local modelTypeParam = modelCO.modelTypeParam

		return modelTypeParam.performanceResName
	end

	local modelData = ModelConfig.instance:getModelData(modelCO.code)

	return modelData:getPerformanceResName()
end

function ModelCOUtil.isLockDirection(modelCO)
	return modelCO.lockDirection > 0
end

function ModelCOUtil.addResourceUrlToLoader(modelCO, resLoader)
	local url = ModelCOUtil.getLowModelUrl(modelCO)

	if url then
		resLoader:addResPath(url)
	end

	url = ModelCOUtil.getHighModelUrl(modelCO)

	if url then
		resLoader:addResPath(url)
	end
end

function ModelCOUtil.isMonsterModel(modelCO)
	return modelCO.code > kMinMonsterCode
end

function ModelCOUtil.getMainTimelinePath(modelCO)
	local resName = modelCO.mainSceneResName

	if modelCO.resTag and modelCO.resTag[kResTagTimelineMain] then
		resName = modelCO.resTag[kResTagTimelineMain]
	end

	return string.format("character3d/%s/general/timeline_main/timeline_main.prefab", resName)
end

return ModelCOUtil
