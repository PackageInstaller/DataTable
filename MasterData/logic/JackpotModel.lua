-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jackpot/model/JackpotModel.lua

module("logic.extensions.jackpot.model.JackpotModel", package.seeall)

local JackpotModel = class("JackpotModel", BaseModel)

JackpotModel.UpdateDrawInfos = "JackpotModel.UpdateDrawInfos"
JackpotModel.DrawSuccessed = "JackpotModel.DrawSuccessed"

function JackpotModel:ctor()
	return
end

function JackpotModel:onInit()
	self:onReset()
end

function JackpotModel:onReset()
	self.isDrawing = false
	self.drawInfo = nil
	self._isNextOrderIdChange = true
	self.changeSetId = nil
end

function JackpotModel:setDrawInfos(orderId, infos)
	local datas = {}

	for i, v in ipairs(infos) do
		datas[v] = true
	end

	self.drawInfo = {
		orderId = orderId,
		datas = datas
	}

	JackpotController.instance:localNotify(JackpotModel.UpdateDrawInfos)
end

function JackpotModel:setSingleDrawInfo(rewardId)
	if self.drawInfo then
		self.drawInfo.datas[rewardId] = true
	else
		printInfo("===JackpotModel:setSingleDrawInfo drawInfo没有数据")
	end
end

function JackpotModel:getDrawInfo()
	return self.drawInfo
end

function JackpotModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.Spec)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.Spec)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.Spec, v.activityId) then
			local cfg = JackpotConfig.instance:getActCfgById(v.activityId)

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

function JackpotModel:drawSuccessed(rewardId, nextOrderId)
	self._isNextOrderIdChange = true

	if self.drawInfo then
		self._isNextOrderIdChange = nextOrderId ~= self.drawInfo.orderId

		if checknumber(nextOrderId) > 0 then
			if not nextOrderId then
				printError("换了大奖不发nextOrderId")
			end

			self:drwaAnimEnd(rewardId)

			self.drawInfo.datas = {}
			self.drawInfo.orderId = nextOrderId
		end
	else
		printInfo("===没有drawInfo")
	end
end

function JackpotModel:setChangeSetId(changeSetId)
	self.changeSetId = changeSetId
end

function JackpotModel:getChangeSetId()
	return self.changeSetId
end

function JackpotModel:isNextOrderIdChange()
	return self._isNextOrderIdChange
end

function JackpotModel:drwaAnimEnd(rewardId)
	self:setSingleDrawInfo(rewardId)

	local changeSetId = self:getChangeSetId()

	if changeSetId then
		self:setChangeSetId(nil)
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
	end
end

function JackpotModel:checkRedDot()
	local dot = false
	local actId = self:getCurrActId()

	if actId then
		local actCfg = JackpotConfig.instance:getActCfgById(actId)
		local arr = string.split(actCfg.activityItem, ":")
		local matType = checknumber(arr[1])
		local matId = checknumber(arr[2])
		local useNum = checknumber(arr[3])
		local has_num = MaterialFacade.instance:getMatNumber(matType, matId)

		dot = useNum <= has_num
	end

	return dot
end

JackpotModel.instance = JackpotModel.New()

return JackpotModel
