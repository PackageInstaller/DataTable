-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataLottery.lua

local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local ResOpActivityLotteryDetail = require("ClientData/ResOpActivityLotteryDetail")
local ResOpActivityLotteryMsic = require("ClientData/ResOpActivityLotteryMsic")
local ResRandClient = require("ClientData/ResRandClient")
local ResOpActivityClientTemplate = require("ClientData/ResOpActivityClientTemplate")
local ActivityDataLottery = Class("ActivityDataLottery", ActivityDataBase)

function ActivityDataLottery:ctor()
	self.codeItems = {}
	self.awardInfo = {}
	self.hasDraw = false
end

function ActivityDataLottery:updateClientData(actId)
	self.actId = actId
	self.miscData = ResOpActivityLotteryMsic[actId]
	self.clientData = ResOpActivityLotteryDetail[actId] or {}

	local tempData = ResOpActivityClientTemplate[self.actId] or {}

	self.achieveActId = tonumber(tempData.template_args and tempData.template_args[1] or 0)

	if self.achieveActId ~= nil then
		CurAvatar:addActivityRelated(self.achieveActId, nil, self.actId)
	end
end

function ActivityDataLottery:updateRoleData(roleData, fromDataUpdate)
	self.codeItems = roleData.lottery.item or {}
	self.awardInfo = roleData.lottery.award_info or {}

	if fromDataUpdate then
		local obj = CurAvatar:getActivityObj(self.actId)

		if obj then
			obj:refreshUI()
		end
	end
end

function ActivityDataLottery:updateMgrData(opActivityMgrItem)
	self.drawTime = opActivityMgrItem.time.freezetime
	self.openTime = opActivityMgrItem.time.opentime
	self.svrData = opActivityMgrItem.specdata.lottery
	self.winners = self.svrData.item or {}

	local winnerIds = {}
	local showCount = self.miscData.show_count

	if self.svrData.item then
		for i, playerData in ipairs(self.winners) do
			if showCount < i then
				break
			end

			table.insert(winnerIds, playerData.uid)
		end
	end

	self.hasDraw = self.svrData.has_draw == 1 and opActivityMgrItem.state == Const.OPACT_STATE_FREEZE

	if self.hasDraw and #winnerIds > 0 then
		CurAvatar:getRoleCommInfosNoTip(winnerIds)
	end

	local obj = CurAvatar:getActivityObj(self.actId)

	if obj then
		obj:refreshUI()
	end
end

function ActivityDataLottery:onGetCode(codeTab)
	for i, code in ipairs(codeTab) do
		table.insert(self.codeItems, {
			key = tostring(code)
		})
	end
end

function ActivityDataLottery:checkNew()
	self.achieveObj = CurAvatar:getActivityObj(self.achieveActId)

	if not self.achieveObj or self.hasDraw then
		return false
	end

	local clientData = self.achieveObj.actData.clientData
	local hasNew = false

	for i, typeData in pairs(clientData) do
		local data = typeData[1]
		local achieveType = data.type
		local curState = self.achieveObj.actData:getAchieveState(achieveType, data.index)

		if curState == Const.ACT_ACHIEVE_STATE_ENOUGH then
			hasNew = true

			break
		end
	end

	return hasNew
end

return ActivityDataLottery
