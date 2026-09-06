-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wheelfortune/model/WheelFortuneModel.lua

module("logic.extensions.wheelfortune.model.WheelFortuneModel", package.seeall)

local WheelFortuneModel = class("WheelFortuneModel", BaseModel)

WheelFortuneModel.UpdateDrawInfos = "WheelFortuneModel.UpdateDrawInfos"
WheelFortuneModel.DrawSuccessed = "WheelFortuneModel.DrawSuccessed"

function WheelFortuneModel:ctor()
	return
end

function WheelFortuneModel:onInit()
	self:onReset()
end

function WheelFortuneModel:onReset()
	self.isDrawing = false
	self.drawInfo = nil
	self._isNextOrderIdChange = true
	self.changeSetId = nil
	self._isGetFirstPrize = false
end

function WheelFortuneModel:setDrawInfos(orderId, infos)
	self._isGetFirstPrize = false

	local datas = {}

	if infos then
		for i, v in ipairs(infos) do
			datas[v] = true

			local rewardCfg = WheelFortuneConfig.instance:getPrizeCfg(self:getCurrActId(), orderId, v)

			if rewardCfg.type == 1 then
				self._isGetFirstPrize = true
			end
		end
	end

	self.drawInfo = {
		orderId = (orderId or nil) and orderId,
		datas = datas
	}
end

function WheelFortuneModel:setSingleDrawInfo(rewardId)
	if self.drawInfo then
		self.drawInfo.datas[rewardId] = true
	else
		printInfo("===WheelFortuneModel:setSingleDrawInfo drawInfo没有数据")
	end
end

function WheelFortuneModel:getDrawInfo()
	return self.drawInfo
end

function WheelFortuneModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.WHEEL_FORTUNE)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.WHEEL_FORTUNE)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.WHEEL_FORTUNE, v.activityId) then
			local cfg = WheelFortuneConfig.instance:getActCfgById(v.activityId)

			if cfg then
				actId = cfg.id

				break
			end

			printError("====t_jackpot_activity no cfg, id = " .. v, activityId)

			break
		end
	end

	return actId
end

function WheelFortuneModel:drawSuccessed(rewardId, nextOrderId)
	self._isNextOrderIdChange = false

	WheelFortuneModel.instance:setDrawRewardId(rewardId)
	WheelFortuneModel.instance:setNextOrderId(nextOrderId)

	if self.drawInfo then
		if checknumber(nextOrderId) > 0 then
			self._isNextOrderIdChange = checknumber(nextOrderId) ~= self.drawInfo.orderId
		end

		local rewardCfg = WheelFortuneConfig.instance:getPrizeCfg(self:getCurrActId(), self.drawInfo.orderId, rewardId)

		if rewardCfg.type == 1 then
			self._isNextOrderIdChange = true
			self._isGetFirstPrize = true
		end
	else
		printInfo("===没有drawInfo")
	end
end

function WheelFortuneModel:setDrawRewardId(rewardId)
	self.drawRewardId = rewardId
end

function WheelFortuneModel:getDrawRewardId()
	return checknumber(self.drawRewardId)
end

function WheelFortuneModel:setNextOrderId(nextOrderId)
	self.nextOrderId = nextOrderId
end

function WheelFortuneModel:getNextOrderId()
	return checknumber(self.nextOrderId)
end

function WheelFortuneModel:setChangeSetId(changeSetId)
	self.changeSetId = changeSetId

	MaterialController.instance:saveChangeSetToTemp(self.changeSetId)
end

function WheelFortuneModel:getChangeSetId()
	return self.changeSetId
end

function WheelFortuneModel:isNextOrderIdChange()
	return self._isNextOrderIdChange
end

function WheelFortuneModel:isGetFirstPrize()
	return self._isGetFirstPrize
end

function WheelFortuneModel:drwaAnimEnd()
	local rewardId = self.drawRewardId

	if rewardId == 1 then
		self.drawInfo.datas = {}

		if self:getNextOrderId() == self.drawInfo.orderId then
			self._isGetFirstPrize = true
		end

		self.drawInfo.orderId = self:getNextOrderId()
	end

	self:setSingleDrawInfo(rewardId)

	local changeSetId = self:getChangeSetId()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function WheelFortuneModel:checkRedDot()
	local dot = false
	local actId = self:getCurrActId()

	if actId then
		local actCfg = WheelFortuneConfig.instance:getActCfgById(actId)
		local arr = string.split(actCfg.activityItem, ":")
		local matType = checknumber(arr[1])
		local matId = checknumber(arr[2])
		local useNum = checknumber(arr[3])
		local has_num = MaterialFacade.instance:getMatNumber(matType, matId)

		dot = useNum <= has_num
	end

	return dot
end

function WheelFortuneModel:setFortunePlayerInfo(msg)
	self._fortunePlayers = {}

	if msg.records then
		for i, v in ipairs(msg.records) do
			table.insert(self._fortunePlayers, GameUtil.pbToTable(v))
		end
	end
end

function WheelFortuneModel:getFortunePlayerInfo()
	return self._fortunePlayers
end

WheelFortuneModel.instance = WheelFortuneModel.New()

return WheelFortuneModel
