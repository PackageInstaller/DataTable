-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhuociyuan/model/OriginHuociyuanFmtMo.lua

module("logic.extensions.originhuociyuan.model.OriginHuociyuanFmtMo", package.seeall)

local OriginHuociyuanFmtMo = class("OriginHuociyuanFmtMo", BaseCustomFmtMo)

function OriginHuociyuanFmtMo:initParams(activityId, stageId, extView)
	self.activityId = activityId
	self.stageId = stageId
	self._extView = extView
	self._tagBuffInfoMap = {}

	local info = OriginHuociyuanModel.instance:getInfo(self.activityId) or {}

	if not info.stageInfos then
		local stageInfos = {}

		self._lockedRaceMap = {}

		for i, v in ipairs(stageInfos) do
			if not v.lockRaceIds then
				for j, raceId in ipairs(v.lockRaceIds) do
					self._lockedRaceMap[raceId] = true
				end
			end
		end

		local groupCfg = OriginHuociyuanConfig.instance:getStageCfgById(activityId, stageId) or {}

		self.creepsMasterId = groupCfg.creepsMasterId
		self.masterCfg = OriginHuociyuanConfig.instance:getMonsterCfgById(self.creepsMasterId)
		self.creeps = OriginHuociyuanConfig.instance:getCreepsById(self.creepsMasterId)

		self:setFormCondition(self.masterCfg.formCondition)

		self.isShowTab = false
		self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
		self.strShowRuleFlagKey = "OriginHuociyuanFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
		self.topTitleStr = self.masterCfg.name
		self.ruleDescStr = self.masterCfg.ruleDesc
		self.isPopRuleDesc = true
	end
end

function OriginHuociyuanFmtMo:getMonsterConfigList()
	return self.creeps
end

function OriginHuociyuanFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function OriginHuociyuanFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local buffIds = {}
		local fmo = self:getCurFormation()

		for buffId, pid in pairs(self._tagBuffInfoMap) do
			if fmo:HasPet(pid) then
				local pb = CommonStructDef_pb.PM_PairInt()

				pb.left = pid
				pb.right = buffId

				table.insert(buffIds, pb)
			end
		end

		OriginHuociyuanController.instance:sendStartFight(self.activityId, self.stageId, buffIds, self:getCurSimpleForm())
	end, nil)
end

function OriginHuociyuanFmtMo:getExtendViewName()
	return self._extView
end

function OriginHuociyuanFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedRaceMap[petMo.raceId])
end

function OriginHuociyuanFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已封印")
end

function OriginHuociyuanFmtMo:setBuffInfo(buffId, petId)
	self._tagBuffInfoMap[buffId] = petId
end

function OriginHuociyuanFmtMo:getBuffInfo(buffId)
	return checknumber(self._tagBuffInfoMap[buffId])
end

function OriginHuociyuanFmtMo:getPetBuff(petId)
	for k, v in pairs(self._tagBuffInfoMap) do
		if v == petId then
			return k
		end
	end

	return 0
end

function OriginHuociyuanFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local stageCfg = OriginHuociyuanConfig.instance:getStageCfgById(self.activityId, self.stageId) or {}

	if not stageCfg.needUseBlockBuff then
		local tagList = {}
		local fmo = self:getCurFormation()

		for i, v in ipairs(tagList) do
			local pid = self._tagBuffInfoMap[v]

			if not pid then
				FloatWordMgr.instance:show("必须完成标记选择后才能进入战斗")
				GlobalDispatcher:dispatch(GlobalNotify.ORIGIN_HUOCIYUAN_BUFF_SELECT_TIPS)

				return true
			elseif not fmo:HasPet(pid) then
				FloatWordMgr.instance:show("必须完成标记选择后才能进入战斗")
				GlobalDispatcher:dispatch(GlobalNotify.ORIGIN_HUOCIYUAN_BUFF_SELECT_TIPS)

				return true
			end
		end

		return OriginHuociyuanFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
	end
end

return OriginHuociyuanFmtMo
