-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongyanclg/model/OriginLongYanClgFmtMo.lua

module("logic.extensions.originlongyanclg.model.OriginLongYanClgFmtMo", package.seeall)

local OriginLongYanClgFmtMo = class("OriginLongYanClgFmtMo", BaseCustomFmtMo)

function OriginLongYanClgFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId
	self.stageCfg = OriginLongYanClgConfig.instance:getStageCfgById(self.activityId, self.stageId)

	local creepsMasterId = self.stageCfg.creepsMasterId

	self._masterData = OriginLongYanClgConfig.instance:getTeamCfg(creepsMasterId)
	self._creepsCfg = OriginLongYanClgConfig.instance:getCreepCfgs(creepsMasterId)
	self._positionSignIds = self.stageCfg.positionSignId or {}
	self._passSignId = self.stageCfg.passSignId or 0
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:tryInitPetList()
end

function OriginLongYanClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local buffParam = self.stageCfg

		OriginLongYanClgController.instance:setExBuffParam(buffParam)
		BattleSettlementModel.instance:setBattleTopExtView(ViewName.OriginLongYanClgBattleExView)

		local simpleForm = self:getCurSimpleForm()

		OriginLongYanClgController.instance:challenge(self.activityId, self.stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginLongYanClgFmtMo:initPetList()
	self:clearAllPetList()

	local petMoList = BagPetsController.instance:getFightBagPet()

	for _, petMo in pairs(petMoList) do
		self:addPetToList(self:_changePetMo(petMo))
	end
end

function OriginLongYanClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginLongYanClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginLongYanClgFmtMo:getExtendViewName()
	return ViewName.OriginLongYanClgFmtExView
end

function OriginLongYanClgFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if not self:_getIsMatchLimit() then
		FloatWordMgr.instance:show(lang("激活通关印记的站位上至少上阵一只精灵"))

		return true
	end

	return OriginLongYanClgFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
end

function OriginLongYanClgFmtMo:_getIsMatchLimit()
	if self._passSignId > 0 then
		for posId, signId in pairs(self._positionSignIds) do
			if signId == self._passSignId then
				local posValue = checknumber(self:getCurFormation():GetPosition(posId))

				if posValue > 0 then
					return true
				end
			end
		end
	end

	return false
end

return OriginLongYanClgFmtMo
