-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonveinnuoyaclg/model/DragonVeinNuoYaClgModel.lua

module("logic.extensions.dragonveinnuoyaclg.view.DragonVeinNuoYaClgModel", package.seeall)

local DragonVeinNuoYaClgModel = class("DragonVeinNuoYaClgModel", BaseModel)

DragonVeinNuoYaClgModel.TYPE_EMPTY = 0
DragonVeinNuoYaClgModel.TYPE_NORMALTEAM = 1
DragonVeinNuoYaClgModel.TYPE_BOSSTEAM = 2
DragonVeinNuoYaClgModel.TYPE_PRIZEBOX = 4
DragonVeinNuoYaClgModel.ReadFlag = "DragonVeinNuoYaClgModel.ReadFlag"

function DragonVeinNuoYaClgModel:ctor()
	return
end

function DragonVeinNuoYaClgModel:onInit()
	self:onReset()
end

function DragonVeinNuoYaClgModel:onReset()
	self.infos = {}
	self._openMap = {}
end

function DragonVeinNuoYaClgModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.DragonVeinNuoYaClg)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.DragonVeinNuoYaClg)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.DragonVeinNuoYaClg, v.activityId) then
			local cfg = DragonVeinNuoYaClgConfig.instance:getActivityCfg(v.activityId)

			if cfg then
				actId = cfg.activityId

				break
			end

			printError("====t_wu_wen_clg no cfg, id = " .. v, activityId)

			break
		end
	end

	return actId
end

function DragonVeinNuoYaClgModel:getGridInfo(activityId, gridId)
	local info = self.infos[activityId]

	if info then
		return info.mapInfo[gridId]
	end

	return nil
end

function DragonVeinNuoYaClgModel:getFmtMo()
	self._fmtMo = self._fmtMo or DragonVeinNuoYaClgFmtMo.New()

	return self._fmtMo
end

function DragonVeinNuoYaClgModel:saveData(msg)
	local info = GameUtil.pbToTable(msg)
	local isNeedBattle = false
	local isDoneBoss = false
	local mapInfo = {}

	if info.gridInfo then
		for i, v in ipairs(info.gridInfo) do
			mapInfo[v.gridId] = v

			if not v.done and (v.type == DragonVeinNuoYaClgModel.TYPE_NORMALTEAM or v.type == DragonVeinNuoYaClgModel.TYPE_BOSSTEAM) then
				isNeedBattle = true
			end

			if v.done and v.type == DragonVeinNuoYaClgModel.TYPE_BOSSTEAM then
				isDoneBoss = true
			end
		end
	end

	info.mapInfo = mapInfo
	info.isNeedBattle = isNeedBattle
	info.isDoneBoss = isDoneBoss
	self.infos[info.activityId] = info
end

function DragonVeinNuoYaClgModel:saveDigData(msg)
	local info = self.infos[msg.activityId]

	if info then
		info.mapInfo[msg.gridInfo.gridId] = msg.gridInfo

		if msg.gridInfo.type == DragonVeinNuoYaClgModel.TYPE_NORMALTEAM or msg.gridInfo.type == DragonVeinNuoYaClgModel.TYPE_BOSSTEAM then
			info.isNeedBattle = true
		end

		info.gridInfo = info.gridInfo or {}

		table.insert(info.gridInfo, msg.gridInfo)
	end
end

function DragonVeinNuoYaClgModel:saveBattleData(msg)
	local info = self.infos[msg.activityId]

	if info then
		info.isNeedBattle = false

		local gridInfo = info.mapInfo[msg.gridId]

		gridInfo.done = true

		if gridInfo.type == DragonVeinNuoYaClgModel.TYPE_BOSSTEAM then
			info.isDoneBoss = true
		end
	end
end

function DragonVeinNuoYaClgModel:saveBoxData(msg)
	local info = self.infos[msg.activityId]

	if info then
		local gridInfo = info.mapInfo[msg.gridId]

		gridInfo.done = msg.done
	end
end

function DragonVeinNuoYaClgModel:saveNextStageData(msg)
	local info = self.infos[msg.activityId]

	if info then
		info.curStageId = msg.newStageId
		info.mapInfo = {}
		info.isNeedBattle = false
		info.isDoneBoss = false
		info.gridInfo = nil
	end
end

function DragonVeinNuoYaClgModel:isNeedBattle(activityId)
	local info = self.infos[activityId]

	if info then
		return info.isNeedBattle
	end

	return false
end

function DragonVeinNuoYaClgModel:getStageId(activityId)
	local info = self.infos[activityId]

	if info then
		return info.curStageId
	end

	return 1
end

function DragonVeinNuoYaClgModel:isDoneBoss(activityId)
	local info = self.infos[activityId]

	if info then
		return info.isDoneBoss
	end

	return false
end

function DragonVeinNuoYaClgModel:getGridInfoList(activityId)
	local info = self.infos[activityId]

	if info then
		return info.gridInfo or {}
	end

	return {}
end

DragonVeinNuoYaClgModel.instance = DragonVeinNuoYaClgModel.New()

return DragonVeinNuoYaClgModel
