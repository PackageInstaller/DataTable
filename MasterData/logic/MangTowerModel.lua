-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/model/MangTowerModel.lua

module("logic.extensions.mangtower.model.MangTowerModel", package.seeall)

local MangTowerModel = class("MangTowerModel", BaseModel)

MangTowerModel.TOWER_TYPE_1V1 = 1
MangTowerModel.TOWER_TYPE_3V3 = 2

function MangTowerModel:ctor()
	return
end

function MangTowerModel:onInit()
	self:onReset()
end

function MangTowerModel:onReset()
	self._curPos = nil
	self._activityId = 39001
	self._selectType = MangTowerModel.TOWER_TYPE_1V1
	self._selectFmtTab = 1
	self.hasGetInfo = false
	self.normalPhase = 1
	self.excitedPhase = 1
	self.score = 0
	self.hasGainDailyBonus = false
	self._normalFmt = nil
	self._exFmt = {}
	self._curCfg = nil
end

function MangTowerModel:setHasGetInfo(torf)
	self.hasGetInfo = torf
end

function MangTowerModel:getHasGetInfo()
	return self.hasGetInfo
end

function MangTowerModel:setNormalPhase(phase)
	self.normalPhase = phase
end

function MangTowerModel:getNormalPhase()
	return checknumber(self.normalPhase)
end

function MangTowerModel:setExcitedPhase(phase)
	self.excitedPhase = phase
end

function MangTowerModel:getExcitedPhase()
	return self.excitedPhase
end

function MangTowerModel:setScore(score)
	self.score = score
end

function MangTowerModel:getScore()
	return self.score
end

function MangTowerModel:setHasGainDailyBonus(torf)
	self.hasGainDailyBonus = torf
end

function MangTowerModel:getHasGainDailyBonus()
	return self.hasGainDailyBonus
end

function MangTowerModel:setActId(_activityId)
	self._activityId = _activityId
end

function MangTowerModel:getActId()
	return self._activityId
end

function MangTowerModel:setPlanId(planId)
	self._planId = planId
end

function MangTowerModel:getPlanId()
	return self._planId
end

function MangTowerModel:setSelectType(type)
	self._selectType = type
end

function MangTowerModel:getSelectType()
	return self._selectType
end

function MangTowerModel:setNeedToShowNewUnit(torf)
	self._needToShowNewUnit = torf
end

function MangTowerModel:getNeedToShowNewUnit()
	return self._needToShowNewUnit
end

function MangTowerModel:setCurCfg(cfg)
	self._curCfg = cfg
end

function MangTowerModel:getCurCfg()
	return self._curCfg
end

function MangTowerModel:setSelectFmtTab(selectFmtTab)
	self._selectFmtTab = selectFmtTab
end

function MangTowerModel:getSelectFmtTab()
	return self._selectFmtTab
end

function MangTowerModel:setFmt(fmt, type, tab)
	if type == MangTowerModel.TOWER_TYPE_1V1 then
		self._normalFmt = FormationMO.New()

		self._normalFmt:SetData(fmt)
	elseif type == MangTowerModel.TOWER_TYPE_3V3 then
		self._exFmt[tab] = FormationMO.New()

		self._exFmt[tab]:SetData(fmt)
	end
end

function MangTowerModel:getFmt(type, tab)
	if type == MangTowerModel.TOWER_TYPE_1V1 then
		return self._normalFmt
	elseif type == MangTowerModel.TOWER_TYPE_3V3 then
		return self._exFmt[tab]
	end
end

MangTowerModel.instance = MangTowerModel.New()

return MangTowerModel
