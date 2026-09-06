-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpsychicji/model/OriginpsychicjiModel.lua

module("logic.extensions.originpsychicji.view.OriginpsychicjiModel", package.seeall)

local OriginpsychicjiModel = class("OriginpsychicjiModel", BaseModel)

function OriginpsychicjiModel:ctor()
	return
end

function OriginpsychicjiModel:onInit()
	self:onReset()
end

function OriginpsychicjiModel:onReset()
	self._msgInfos = {}
	self._fmtMo = nil
end

function OriginpsychicjiModel:setInfo(msg)
	self._msgInfos[msg.activityId] = GameUtil.pbToTable(msg)

	self:setDefaultValue(msg.activityId)
end

function OriginpsychicjiModel:getInfo(activityId)
	return self._msgInfos[activityId]
end

function OriginpsychicjiModel:getFmtMo()
	self._fmtMo = self._fmtMo or OriginpsychicjiFmtMo.New()

	return self._fmtMo
end

function OriginpsychicjiModel:setDefaultValue(activityId)
	if self._msgInfos[activityId] then
		for i, v in ipairs(self._msgInfos[activityId].commonStageInfo) do
			v.typeToEnergy = v.typeToEnergy or {}
		end

		for i, v in ipairs(self._msgInfos[activityId].extStageInfo) do
			v.typeToEnergy = v.typeToEnergy or {}
		end
	end
end

function OriginpsychicjiModel:isAllNormalStagePass(activityId)
	local info = self:getInfo(activityId)
	local cfgs = OriginpsychicjiConfig.instance:getNormalStageCfgs(activityId)

	for i, v in ipairs(cfgs) do
		if not self:isNormalStagePass(activityId, v.stageId) then
			return false
		end
	end

	return true
end

function OriginpsychicjiModel:isNormalStagePass(activityId, stageId)
	local value = self:getStageEnergyValue(activityId, OriginpsychicjiController.ClgType.Normal, stageId)
	local cfg = OriginpsychicjiConfig.instance:getNormalStageCfg(activityId, stageId)

	return value >= cfg.passNeedEnergy
end

function OriginpsychicjiModel:getExtStageTypeToEnergy(activityId, stageId)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.extStageInfo) do
		if v.stageId == stageId then
			return v.typeToEnergy
		end
	end
end

function OriginpsychicjiModel:getStageEnergyValue(activityId, clgType, stageId)
	local info = self:getInfo(activityId)
	local stageInfo

	for i, v in ipairs(clgType == OriginpsychicjiController.ClgType.Normal and info.commonStageInfo or info.extStageInfo) do
		if v.stageId == stageId then
			local value = 0

			for j, p in ipairs(v.typeToEnergy) do
				value = value + OriginpsychicjiConfig.instance:getSettleEnergyByNum(activityId, p.left, p.right)
			end

			return value
		end
	end

	return 0
end

function OriginpsychicjiModel:getStageIsPass(activityId, clgType, stageId)
	local info = self:getInfo(activityId)

	if clgType == OriginpsychicjiController.ClgType.Normal then
		return self:isNormalStagePass(activityId, stageId)
	else
		for i, v in ipairs(info.extStageInfo) do
			if v.stageId == stageId then
				if #v.typeToEnergy <= 0 then
					return false
				end

				local energy = self:getStageEnergyValue(activityId, clgType, stageId)
				local cfg = OriginpsychicjiConfig.instance:getExtStageCfg(activityId, stageId)
				local actCfg = OriginpsychicjiConfig.instance:getActCfg(activityId)

				for i, cStageId in ipairs(cfg.connectStage) do
					if cStageId ~= stageId then
						local cStageValue = self:getStageEnergyValue(activityId, clgType, cStageId)
						local diff = math.abs(energy - cStageValue)

						if diff >= actCfg.differenceLimit[1] and diff <= actCfg.differenceLimit[2] then
							return true
						end
					end
				end
			end
		end
	end
end

function OriginpsychicjiModel:onNotifyCommonClgRes(msg)
	if msg.isWin then
		local info = self:getInfo(msg.activityId)

		for i, v in ipairs(info.commonStageInfo) do
			if v.stageId == msg.stageId then
				local value = OriginpsychicjiController.instance:getEnergyValue(msg.activityId, msg.typeToEnergy)
				local stageCfg = OriginpsychicjiConfig.instance:getNormalStageCfg(msg.activityId, msg.stageId)

				if value >= stageCfg.passNeedEnergy then
					v.typeToEnergy = GameUtil.pbToTable(msg.typeToEnergy) or {}
				end

				break
			end
		end
	end
end

function OriginpsychicjiModel:onSaveRes(activityId, stageId, typeToEnergy)
	local info = self:getInfo(activityId)

	for i, v in ipairs(info.extStageInfo) do
		if v.stageId == stageId then
			v.typeToEnergy = GameUtil.pbToTable(typeToEnergy) or {}

			break
		end
	end
end

function OriginpsychicjiModel:onExtClgFinish(activityId)
	local info = self:getInfo(activityId)

	info.hasPassExtStage = true
end

OriginpsychicjiModel.instance = OriginpsychicjiModel.New()

return OriginpsychicjiModel
