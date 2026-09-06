-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishiclg/model/DragonKingARuiShiClgModel.lua

module("logic.extensions.dragonkingaruishiclg.view.DragonKingARuiShiClgModel", package.seeall)

local DragonKingARuiShiClgModel = class("DragonKingARuiShiClgModel", BaseModel)

DragonKingARuiShiClgModel.RedFlag = "DragonKingARuiShiClgModel.RedFlag"

function DragonKingARuiShiClgModel:ctor()
	return
end

function DragonKingARuiShiClgModel:onInit()
	self:onReset()
end

function DragonKingARuiShiClgModel:onReset()
	self.infos = {}
	self._fmtMo = nil
end

function DragonKingARuiShiClgModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.DragonKingARuiShiClg)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.DragonKingARuiShiClg)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.DragonKingARuiShiClg, v.activityId) then
			local cfg = DragonKingARuiShiClgConfig.instance:getActivityCfg(v.activityId)

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

function DragonKingARuiShiClgModel:setInfo(msg)
	self.infos[msg.activityId] = GameUtil.pbToTable(msg)
end

function DragonKingARuiShiClgModel:getFmtMo()
	if self._fmtMo == nil then
		self._fmtMo = DragonKingARuiShiClgFmtMo.New()
	end

	return self._fmtMo
end

function DragonKingARuiShiClgModel:getPassStage(activityId)
	local info = self.infos[activityId]

	return (info or nil) and (info.stageId or 0)
end

function DragonKingARuiShiClgModel:setStageInfo(msg)
	if msg.win then
		local info = self.infos[msg.activityId]

		if not info then
			self.infos[msg.activityId] = {}
			info = self.infos[msg.activityId]
		end

		info.activityId = msg.activityId
		info.stageId = msg.stageId
	end

	self:saveChallengeRecord(msg.activityId, msg.stageId)
end

function DragonKingARuiShiClgModel:getChallengeRecord(activityId, stage)
	local key = string.format("%sRecord#%d#%d", DragonKingARuiShiClgModel.RedFlag, activityId, stage)

	return GameUtil.getUserData(key)
end

function DragonKingARuiShiClgModel:saveChallengeRecord(activityId, stage)
	local key = string.format("%sRecord#%d#%d", DragonKingARuiShiClgModel.RedFlag, activityId, stage)

	GameUtil.saveUserData(key, true)
end

DragonKingARuiShiClgModel.instance = DragonKingARuiShiClgModel.New()

return DragonKingARuiShiClgModel
