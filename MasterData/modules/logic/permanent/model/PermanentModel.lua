-- chunkname: @modules/logic/permanent/model/PermanentModel.lua

module("modules.logic.permanent.model.PermanentModel", package.seeall)

local PermanentModel = class("PermanentModel", BaseModel)

function PermanentModel:onInit()
	self:reInit()
end

function PermanentModel:reInit()
	self.localReadDic = {}
end

function PermanentModel:getActivityDic()
	local permanentDic = {}
	local perDic = PermanentConfig.instance:getPermanentDic()

	for id, _ in pairs(perDic) do
		local actInfo = ActivityModel.instance:getActMO(id)

		if actInfo then
			permanentDic[id] = actInfo
		end
	end

	return permanentDic
end

function PermanentModel:undateActivityInfo(actId)
	local permanentList = {}

	if actId then
		permanentList[1] = actId
	else
		local perDic = PermanentConfig.instance:getPermanentDic()

		for id, _ in pairs(perDic) do
			local actInfo = ActivityModel.instance:getActMO(id)

			if actInfo and actInfo:isOnline() then
				permanentList[#permanentList + 1] = id
			end
		end
	end

	if #permanentList > 0 then
		ActivityRpc.instance:sendGetActivityInfosWithParamRequest(permanentList)
	end
end

function PermanentModel:hasActivityOnline()
	local activityDic = self:getActivityDic()

	for _, infoMo in pairs(activityDic) do
		if infoMo.online then
			return true
		end
	end

	return false
end

function PermanentModel:setActivityLocalRead(actId)
	self:_initLocalRead()

	if actId then
		actId = tostring(actId)
		self.localReadDic[actId] = true
	else
		local permanentDic = self:getActivityDic()

		for id, _ in pairs(permanentDic) do
			id = tostring(id)
			self.localReadDic[id] = self.localReadDic[id] or true
		end
	end

	self:_saveLocalRead()
end

function PermanentModel:isActivityLocalRead(actId)
	self:_initLocalRead()

	local activityDic = self:getActivityDic()

	if not actId then
		for id, _ in pairs(activityDic) do
			local isOnline = ActivityModel.instance:isActOnLine(id)

			id = tostring(id)

			if isOnline and not self.localReadDic[id] then
				return false
			end
		end

		return true
	end

	actId = tostring(actId)

	return self.localReadDic[actId]
end

function PermanentModel:_initLocalRead()
	if next(self.localReadDic) then
		return
	end

	local userId = PlayerModel.instance:getMyUserId()
	local str = PlayerPrefsHelper.getString(PlayerPrefsKey.PermanentLocalRead .. userId)

	if not string.nilorempty(str) then
		self.localReadDic = cjson.decode(str)
	end
end

function PermanentModel:_saveLocalRead()
	local userId = PlayerModel.instance:getMyUserId()
	local str = cjson.encode(self.localReadDic)

	PlayerPrefsHelper.setString(PlayerPrefsKey.PermanentLocalRead .. userId, str)
end

function PermanentModel:IsDotShowPermanent2_1()
	local permanentActId = VersionActivity2_1Enum.ActivityId.EnterView
	local actInfo = ActivityModel.instance:getActMO(permanentActId)

	if not actInfo then
		return false
	end

	if not actInfo:isPermanentUnlock() then
		return false
	end

	local isDotShow = false

	for _, v in ipairs(Permanent2_1EnterView.kRoleIndex2ActId or {}) do
		local _actId = v.actId

		if not v.redDotId then
			isDotShow = RedDotModel.instance:isDotShow(v.redDotId, _actId)

			if isDotShow then
				break
			end
		end
	end

	isDotShow = isDotShow or Activity165Model.instance:isShowAct165Reddot()

	return isDotShow
end

PermanentModel.instance = PermanentModel.New()

return PermanentModel
