-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearscratch/model/YearScratchModel.lua

module("logic.extensions.yirenpozhen.model.YearScratchModel", package.seeall)

local YearScratchModel = class("YearScratchModel", BaseModel)

YearScratchModel.ReadFlag = "YearScratchModel.ReadFlag"

function YearScratchModel:ctor()
	return
end

function YearScratchModel:onInit()
	self:onReset()
end

function YearScratchModel:onReset()
	return
end

function YearScratchModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.YearScratch)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.YearScratch)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.YearScratch, v.activityId) then
			local cfg = YearScratchConfig.instance:getActivityCfg(v.activityId)

			if cfg then
				actId = cfg.activityId

				break
			end
		end
	end

	return actId
end

function YearScratchModel:setInfo(msg)
	local data = GameUtil.pbToTable(msg)

	self._spaceScratchNum = msg.spaceScratchNum
	self._hadGainGodGem = msg.hadGainGodGem
	self._cycleInfo = self._cycleInfo and table.clear(self._cycleInfo) or {}
	self._isGainPrize = false

	for i, v in ipairs(data.cycles) do
		self._cycleInfo[v.cycleId] = v

		if checknumber(v.prizeId) > 0 and v.hadGainPrize then
			self._isGainPrize = true
		end
	end
end

function YearScratchModel:getCycleInfo(cycleId)
	return self._cycleInfo[cycleId]
end

function YearScratchModel:getEnterPrize(activityId)
	return GameUtil.getUserData(YearScratchModel.ReadFlag .. "#Enter#" .. activityId)
end

function YearScratchModel:saveEnterPrize(activityId)
	GameUtil.saveUserData(YearScratchModel.ReadFlag .. "#Enter#" .. activityId, true)
end

function YearScratchModel:isGainPrize()
	return self._isGainPrize or false
end

function YearScratchModel:getSpaceScratchNum()
	return self._spaceScratchNum or 0
end

function YearScratchModel:gainPrize(cycleId)
	if self._cycleInfo[cycleId] then
		self._cycleInfo[cycleId].hadGainPrize = true
	end

	self._isGainPrize = true
end

function YearScratchModel:gainGodGem()
	self._hadGainGodGem = true
end

function YearScratchModel:isHadGainGem()
	return self._hadGainGodGem
end

YearScratchModel.instance = YearScratchModel.New()

return YearScratchModel
