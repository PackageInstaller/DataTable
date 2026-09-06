-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/model/GodDarkDragonModel.lua

module("logic.extensions.goddarkdragon.model.GodDarkDragonModel", package.seeall)

local GodDarkDragonModel = class("GodDarkDragonModel", BaseModel)

GodDarkDragonModel.ReadFlag = "GodDarkDragonModel.ReadFlag"

function GodDarkDragonModel:ctor()
	return
end

function GodDarkDragonModel:onInit()
	GodDarkDragonModel.super.onInit(self)
	self:onReset()
end

function GodDarkDragonModel:onReset()
	self.infos = {}
	self._showStageId = nil
end

function GodDarkDragonModel:saveInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local actInfo = self.infos[info.activityId] and table.clear(self.infos[info.activityId]) or {}

	actInfo.mainStageId = info.curMainStageId
	actInfo.gainedPrizeStageId = {}

	if info.gainedPrizeStageId then
		for i, v in ipairs(info.gainedPrizeStageId) do
			actInfo.gainedPrizeStageId[v] = true
		end
	end

	actInfo.dailyFinishedBuffStageIds = {}

	if info.dailyFinishedBuffStageIds then
		for i, v in ipairs(info.dailyFinishedBuffStageIds) do
			actInfo.dailyFinishedBuffStageIds[v] = true
		end
	end

	actInfo.lockRace = {}

	if info.dailyLockedRaces then
		for i, v in ipairs(info.dailyLockedRaces) do
			actInfo.lockRace[v] = true
		end
	end

	local haveBuff = false

	actInfo.myBuffs = actInfo.myBuffs and table.clear(actInfo.myBuffs) or {}
	actInfo.enemyBuffs = actInfo.enemyBuffs and table.clear(actInfo.enemyBuffs) or {}

	if info.buffs then
		for i, v in ipairs(info.buffs) do
			if v.type == 0 then
				actInfo.myBuffs[v.limitNum] = v
			elseif v.type == 1 then
				actInfo.enemyBuffs[v.limitNum] = v
			end

			if v.num > 0 then
				haveBuff = true
			end
		end
	end

	actInfo.waitConfirm = info.waitConfirm
	actInfo.todayBuffConfigDay = info.todayBuffConfigDay
	self.infos[info.activityId] = actInfo

	GuideController.instance:setViewVar("god_dark_dragon_buff", haveBuff and 1 or 0)
end

function GodDarkDragonModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.GodDarkDragon)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.GodDarkDragon)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.GodDarkDragon, v.activityId) then
			local cfg = GodDarkDragonConfig.instance:getActivityCfg(v.activityId)

			if cfg then
				actId = cfg.activityId

				break
			end

			printError("====t_liu_dao_activity no cfg, id = " .. v, activityId)

			break
		end
	end

	return actId
end

function GodDarkDragonModel:getTodayBuffConfigDay(activityId)
	if self.infos[activityId] then
		return self.infos[activityId].todayBuffConfigDay
	end

	return 0
end

function GodDarkDragonModel:getMainFmtMo()
	self._mainFmtMo = self._mainFmtMo or GodDarkDragonMainFmtMo.New()

	return self._mainFmtMo
end

function GodDarkDragonModel:getBuffFmtMo()
	self._buffFmtMo = self._buffFmtMo or GodDarkDragonBuffFmtMo.New()

	return self._buffFmtMo
end

function GodDarkDragonModel:getMyBuffMap(activityId)
	if self.infos[activityId] then
		return self.infos[activityId].myBuffs
	end

	return {}
end

function GodDarkDragonModel:getEmenyBuffMap(activityId)
	if self.infos[activityId] then
		return self.infos[activityId].enemyBuffs
	end

	return {}
end

function GodDarkDragonModel:getPassStage(activityId)
	if self.infos[activityId] then
		return self.infos[activityId].mainStageId
	end

	return 0
end

function GodDarkDragonModel:isCanGetProgressReward(activityId, stageId)
	if self.infos[activityId] then
		return stageId <= self.infos[activityId].mainStageId and not self.infos[activityId].gainedPrizeStageId[stageId]
	end

	return false
end

function GodDarkDragonModel:isGetedProgressReward(activityId, stageId)
	if self.infos[activityId] then
		return self.infos[activityId].gainedPrizeStageId[stageId]
	end

	return true
end

function GodDarkDragonModel:getPassBuffStage(activityId)
	if self.infos[activityId] then
		return self.infos[activityId].dailyFinishedBuffStageIds
	end

	return {}
end

function GodDarkDragonModel:setWaitConfirm(activityId, confirmInfo)
	if self.infos[activityId] then
		self.infos[activityId].waitConfirm = confirmInfo
	end
end

function GodDarkDragonModel:getWaitConfirm(activityId)
	if self.infos[activityId] then
		return self.infos[activityId].waitConfirm
	end

	return nil
end

function GodDarkDragonModel:addBuffInfoByWait(activityId)
	if self.infos[activityId] and self.infos[activityId].waitConfirm then
		local configInfo = self.infos[activityId].waitConfirm
		local info = self.infos[activityId]

		if info.myBuffs and info.myBuffs[configInfo.myLimitNum] then
			self.infos[activityId].myBuffs[configInfo.myLimitNum].num = info.myBuffs[configInfo.myLimitNum].num + 1
		else
			self.infos[activityId].myBuffs[configInfo.myLimitNum] = {
				num = 1,
				type = 0,
				limitNum = configInfo.myLimitNum
			}
		end

		if info.enemyBuffs and info.enemyBuffs[configInfo.enemyLimitNum] then
			self.infos[activityId].enemyBuffs[configInfo.enemyLimitNum].num = info.enemyBuffs[configInfo.enemyLimitNum].num + 1
		else
			self.infos[activityId].enemyBuffs[configInfo.enemyLimitNum] = {
				num = 1,
				type = 1,
				limitNum = configInfo.enemyLimitNum
			}
		end

		self.infos[activityId].dailyFinishedBuffStageIds[configInfo.buffStageId] = true

		for i, v in ipairs(configInfo.lockedRaces) do
			self.infos[activityId].lockRace[v] = true
		end

		self.infos[activityId].waitConfirm = nil

		GuideController.instance:setViewVar("god_dark_dragon_buff", 1)
	end
end

function GodDarkDragonModel:clearWaitBuffInfo(activityId)
	if self.infos[activityId] then
		self.infos[activityId].waitConfirm = nil
	end
end

function GodDarkDragonModel:getLockPet(activityId)
	if self.infos[activityId] then
		return self.infos[activityId].lockRace or {}
	end

	return {}
end

function GodDarkDragonModel:handleGainPrize(msg)
	if self.infos[msg.activityId] and self.infos[msg.activityId].gainedPrizeStageId then
		self.infos[msg.activityId].gainedPrizeStageId[msg.stageId] = true
	end
end

function GodDarkDragonModel:handlePassMainStage(msg)
	if self.infos[msg.activityId] then
		self.infos[msg.activityId].mainStageId = msg.stageId

		if self.infos[msg.activityId].myBuffs[msg.myFormPetNum].num <= 1 then
			self.infos[msg.activityId].myBuffs[msg.myFormPetNum] = nil
		else
			self.infos[msg.activityId].myBuffs[msg.myFormPetNum].num = self.infos[msg.activityId].myBuffs[msg.myFormPetNum].num - 1
		end

		if self.infos[msg.activityId].enemyBuffs[msg.enemyFormPetNum].num <= 1 then
			self.infos[msg.activityId].enemyBuffs[msg.enemyFormPetNum] = nil
		else
			self.infos[msg.activityId].enemyBuffs[msg.enemyFormPetNum].num = self.infos[msg.activityId].enemyBuffs[msg.enemyFormPetNum].num - 1
		end
	end
end

function GodDarkDragonModel:getIsNotFirstEnter(activityId)
	return GameUtil.getUserData(GodDarkDragonModel.ReadFlag .. "#firstEnter#" .. activityId)
end

function GodDarkDragonModel:saveIsNotFirstEnter(activityId)
	GameUtil.saveUserData(GodDarkDragonModel.ReadFlag .. "#firstEnter#" .. activityId, true)
end

function GodDarkDragonModel:getShowStage()
	return self._showStageId
end

function GodDarkDragonModel:setShowStage(stageId)
	self._showStageId = stageId
end

GodDarkDragonModel.instance = GodDarkDragonModel.New()

return GodDarkDragonModel
