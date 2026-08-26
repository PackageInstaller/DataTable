-- chunkname: @modules/logic/bossrush/rpc/BossRushRpc.lua

module("modules.logic.bossrush.rpc.BossRushRpc", package.seeall)

local BossRushRpc = class("BossRushRpc", Activity128Rpc)

function BossRushRpc:ctor()
	Activity128Rpc.instance = self
end

local function _isValid(resultCode, msg)
	local activityId = msg.activityId

	if not BossRushConfig.instance:isCurActivityIds(activityId) then
		return false
	end

	if resultCode ~= 0 then
		return false
	end

	return true
end

function BossRushRpc:sendGet128InfosRequest(callback, cbObj)
	local actIds = BossRushConfig.instance:getActivityIds()
	local waitActInfos = {}

	for _, actId in ipairs(actIds) do
		if ActivityHelper.isOpen(actId) then
			waitActInfos[actId] = true

			self:sendAct128InfosRequest(actId, function(cmd, resultCode, msg)
				waitActInfos[actId] = nil

				if (not waitActInfos or #waitActInfos == 0) and callback then
					callback(cbObj, cmd, resultCode, msg)
				end
			end)
		end
	end
end

function BossRushRpc:sendAct128InfosRequest(actId, callback, cbObj)
	Activity128Rpc.sendGet128InfosRequest(self, actId, function(cmd, resultCode, msg)
		if callback then
			callback(cbObj, cmd, resultCode, msg)
		end
	end)
end

function BossRushRpc:sendAct128GetTotalRewardsRequest(bossId)
	local activityId = BossRushConfig.instance:getActivityId()

	Activity128Rpc.sendAct128GetTotalRewardsRequest(self, activityId, bossId)
end

function BossRushRpc:sendAct128DoublePointRequest(bossId)
	local activityId = BossRushConfig.instance:getActivityId()

	Activity128Rpc.sendAct128DoublePointRequest(self, activityId, bossId)
end

function BossRushRpc:sendAct128GetTotalSingleRewardRequest(bossId, index)
	local activityId = BossRushConfig.instance:getActivityId()

	Activity128Rpc.sendAct128GetTotalSingleRewardRequest(self, activityId, bossId, index)
end

function BossRushRpc:_onReceiveGet128InfosReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	BossRushModel.instance:onReceiveGet128InfosReply(msg)
	V2a9BossRushModel.instance:onRefresh128InfosReply(msg)
	V3a2_BossRushModel.instance:onRefresh128InfosReply(msg)
	V3a9_BossRushModel.instance:onRefresh128InfosReply(msg)
end

function BossRushRpc:_onReceiveAct128GetTotalRewardsReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	BossRushModel.instance:onReceiveAct128GetTotalRewardsReply(msg)
end

function BossRushRpc:_onReceiveAct128DoublePointReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	BossRushModel.instance:onReceiveAct128DoublePointReply(msg)
end

function BossRushRpc:_onReceiveAct128InfoUpdatePush(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	BossRushModel.instance:onReceiveAct128InfoUpdatePush(msg)
	V2a9BossRushModel.instance:onRefresh128InfosReply(msg)
	V3a2_BossRushModel.instance:onRefresh128InfosReply(msg)
	V3a9_BossRushModel.instance:onRefresh128InfosReply(msg)
end

function BossRushRpc:_onReceiveAct128GetTotalSingleRewardReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	BossRushModel.instance:onReceiveAct128SingleRewardReply(msg)
end

function BossRushRpc:_onReceiveAct128SpFirstHalfSelectItemReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	V2a9BossRushModel.instance:onReceiveAct128SpFirstHalfSelectItemReply(msg)
	BossRushController.instance:dispatchEvent(BossRushEvent.onReceiveAct128SpFirstHalfSelectItemReply)
end

function BossRushRpc:_onReceiveAct128GetExpReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	V3a2_BossRushModel.instance:onReceiveAct128GetExpReply(msg)
	V3a2_BossRushModel.instance:refreshRankMos()
	BossRushController.instance:dispatchEvent(BossRushEvent.onReceiveAct128GetExpReply)
end

function BossRushRpc:_onReceiveAct128GetMilestoneBonusReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	V3a2_BossRushModel.instance:_onReceiveAct128GetMilestoneBonusReply(msg)
end

function BossRushRpc:_onReceiveGetGalleryInfosReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	V3a2_BossRushModel.instance:onRefreshHandBookInfo(msg)
end

function BossRushRpc:sendAct128ChangeActModeRequest(isActivityModeOpen, callback, callbackobj)
	local actIds = BossRushConfig.instance:getActivityIds()
	local waitActInfos = {}

	for _, actId in ipairs(actIds) do
		waitActInfos[actId] = true

		Activity128Rpc.sendAct128ChangeActModeRequest(self, actId, isActivityModeOpen, function()
			waitActInfos[actId] = nil

			if (not waitActInfos or #waitActInfos == 0) and callback then
				callback(callbackobj)
			end
		end)
	end
end

function BossRushRpc:_onReceiveAct128ChangeActModeReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end
end

function BossRushRpc:_onReceiveSetAct128TeamReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	V3a9_BossRushModel.instance:onRefreshActModeTeam(msg)
end

function BossRushRpc:_onReceiveResetAct128TeamReply(resultCode, msg)
	if not _isValid(resultCode, msg) then
		return
	end

	V3a9_BossRushModel.instance:onResetActModeTeam(msg)
	V3a9_BossRushController.instance:dispatchEvent(V3a9_BossRushEvent.OnResetStage)
end

BossRushRpc.instance = BossRushRpc.New()

return BossRushRpc
