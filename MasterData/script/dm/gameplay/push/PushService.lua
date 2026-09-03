-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/push/PushService.lua

PushService = class("PushService", Service, _M)

function PushService:initialize()
	super.initialize(self)
end

function PushService:dispose()
	super.dispose(self)
end

function PushService:listenLoginByOthers(callback)
	self:addPushHandler(9999, function(op, response)
		callback(response)
	end)
end

function PushService:listenTimeChange(callback)
	self:addPushHandler(1002, function(op, response)
		callback(response)
	end)
end

function PushService:listenNewMail(callback)
	self:addPushHandler(1003, function(op, response)
		callback(response)
	end)
end

function PushService:listenFriendPower(callback)
	self:addPushHandler(1005, function(op, response)
		callback(response)
	end)
end

function PushService:listenFriendNewApply(callback)
	self:addPushHandler(1006, function(op, response)
		callback(response)
	end)
end

function PushService:listenFriendCountChange(callback)
	self:addPushHandler(1007, function(op, response)
		callback(response)
	end)
end

function PushService:listenArenaSeasonOver(callback)
	self:addPushHandler(1006, function(op, response)
		callback(response)
	end)
end

function PushService:listenBattleCheckFail(callback)
	self:addPushHandler(1086, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenWelfareCode(callback)
	self:addPushHandler(1601, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenForcedToLeaveClubCode(callback)
	self:addPushHandler(1013, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenRankingRewardCode(callback)
	self:addPushHandler(1266, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenClubBossKilledCode(callback)
	self:addPushHandler(1300, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenClubBossTVTipCode(callback)
	self:addPushHandler(1301, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenClubBossHurtCode(callback)
	self:addPushHandler(1302, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenClubBossBattleStartCode(callback)
	self:addPushHandler(1303, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenClubBossBattleEndCode(callback)
	self:addPushHandler(1304, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenCommonTipsCode(callback)
	self:addPushHandler(1704, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenClubHouseChange(callback)
	self:addPushHandler(1800, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenClubApplyAgreeEnd(callback)
	self:addPushHandler(1305, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenCooperateBoss(code, callback)
	self:addPushHandler(code, function(op, response)
		if callback then
			callback(code, response)
		end
	end)
end

function PushService:listenFriendLogin(callback)
	self:addPushHandler(1110, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenFriendLogout(callback)
	self:addPushHandler(1112, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenHistoryRankChange(callback)
	self:addPushHandler(1150, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenPlayerDataChange(callback)
	self:addPushHandler(111, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function PushService:listenPushPackage(callback)
	self:addPushHandler(2308, function(op, response)
		if callback then
			callback(response)
		end
	end)
end
