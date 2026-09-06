-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcetrace/controller/SourceTraceController.lua

module("logic.extensions.sourcetrace.controller.SourceTraceController", package.seeall)

local SourceTraceController = class("SourceTraceController", BaseController)

SourceTraceController.DEFAULT_ACTIVE_NODE_ID = 1

function SourceTraceController:ctor()
	return
end

function SourceTraceController:onInit()
	self:onReset()
end

function SourceTraceController:onReset()
	return
end

function SourceTraceController:handlePM_SourceTraceUnlockNodeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_SourceTraceUnlockNodeRes)
end

function SourceTraceController:handlePM_SourceTraceChangeEffectRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_SourceTraceChangeEffectRes)
end

function SourceTraceController:PM_SourceTraceOneKeyUnlockNodeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_SourceTraceChangeEffectRes)
end

function SourceTraceController:calcBySourceTracesAttrs(sourceTraces, isMyPackPet)
	if sourceTraces == nil then
		return {}
	end

	local attrMap = {}

	for i, v in ipairs(sourceTraces) do
		local effectCfg = SourceTraceConfig.instance:getEffectCfg(v.effectId)
		local attrValue = FightingPowerFormula.instance:parseAttrValues(effectCfg.propertyParam) or {}

		for attrType, value in pairs(attrValue) do
			attrMap[attrType] = checknumber(attrMap[attrType]) + value
		end
	end

	return attrMap
end

function SourceTraceController:getEvolveTip()
	return "材料精灵已学习源核技能，若将其作为材料进行操作，源核材料不返还，是否确定操作？"
end

local function isSourceTraceCfg(cfg)
	return cfg and cfg.evolutionType == EvolveEnum.EvolveType.SourceTrace
end

function SourceTraceController:getEvolveOpenTime(cfg)
	if not isSourceTraceCfg(cfg) or string.nilorempty(cfg.beginTime) then
		return 0
	end

	return GameUtil.string2time(cfg.beginTime)
end

function SourceTraceController:isEvolveVisible(cfg)
	if not isSourceTraceCfg(cfg) then
		return false
	end

	local beginTime = self:getEvolveOpenTime(cfg)

	if beginTime <= 0 then
		return true
	end

	local date = GameUtil.time2date(beginTime)
	local day430Ts = GameUtil.date2time(date.year, date.month, date.day, 4, 30, 0)

	return day430Ts <= ServerTime.now()
end

function SourceTraceController:isEvolveOpen(cfg)
	if not isSourceTraceCfg(cfg) then
		return false
	end

	local beginTime = self:getEvolveOpenTime(cfg)

	if beginTime <= 0 then
		return true
	end

	return beginTime <= ServerTime.now()
end

function SourceTraceController:isEvolvePreviewState(cfg)
	return self:isEvolveVisible(cfg) and not self:isEvolveOpen(cfg)
end

function SourceTraceController:getEvolvePreviewVisibleList()
	local cfgList = EvolveConfig.instance:getDivineEvolvePlusList() or {}
	local result = {}

	for i = #cfgList, 1, -1 do
		local cfg = cfgList[i]

		if self:isEvolveVisible(cfg) then
			result[#result + 1] = cfg
		end
	end

	return result
end

function SourceTraceController:getSourceTraceUnlockMat(raceId)
	local petCfg = CharacterConfig.instance:getPetCo(raceId)
	local sourceTraceId = petCfg.sourceTraceId
	local nodesCfg = SourceTraceConfig.instance:getSourceTraceNodeCfgs(sourceTraceId)
	local map = {}

	for i, v in ipairs(nodesCfg) do
		if not string.nilorempty(v.unlockCost) then
			local matType, matId, matNum = MaterialMgr.getMatParams(v.unlockCost)
			local matString = string.format("%d:%d", matType, matId)

			map[matString] = true
		end
	end

	local result = {}

	for k, v in pairs(map) do
		table.insert(result, k)
	end

	return result
end

SourceTraceController.instance = SourceTraceController.New()

return SourceTraceController
