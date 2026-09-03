-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/service/WorldPeaceService.lua

WorldPeaceService = class("WorldPeaceService", Service, _M)

function WorldPeaceService:initialize()
	super.initialize(self)
end

function WorldPeaceService:listenPushBattleField(callback)
	self:addPushHandler(2401, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceService:listenPushClubBossDead(callback)
	self:addPushHandler(3000, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceService:listenPushClubBossResetOne(callback)
	self:addPushHandler(3001, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceService:listenPushClubBossEnterTwo(callback)
	self:addPushHandler(3002, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceService:listenPushClubBossPlayerDead(callback)
	self:addPushHandler(3003, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceService:listenPushWordPeaceSwear(callback)
	self:addPushHandler(2405, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceService:listenPushWordBossReward(callback)
	self:addPushHandler(2412, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceService:listenPushWordBossBattleField(callback)
	self:addPushHandler(2411, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceService:enterBossBattle(params, blockUI, callback)
	local request = self:newRequest(38001, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:getPersonRankInfo(params, blockUI, callback)
	local request = self:newRequest(35021, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:getBossRewards(params, blockUI, callback)
	local request = self:newRequest(38004, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:worldBossFinish(params, blockUI, callback)
	local request = self:newRequest(38003, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:startAttackWordBoss(params, blockUI, callback)
	local request = self:newRequest(38002, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:enterBattle(params, blockUI, callback)
	local request = self:newRequest(35002, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:defenceBoss(params, blockUI, callback)
	local request = self:newRequest(35005, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:speedUp(params, blockUI, callback)
	local request = self:newRequest(35008, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:quitBattle(params, blockUI, callback)
	local request = self:newRequest(35009, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:attackBoss(params, blockUI, callback)
	local request = self:newRequest(35004, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:recallTeam(params, blockUI, callback)
	local request = self:newRequest(35006, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:cureTeam(params, blockUI, callback)
	local request = self:newRequest(35007, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:chooseBoss(params, blockUI, callback)
	local request = self:newRequest(35003, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:sendBossTag(params, blockUI, callback)
	local request = self:newRequest(35013, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:dispose()
	super.dispose(self)
end

function WorldPeaceService:enterSwearMain(params, blockUI, callback)
	local request = self:newRequest(35015, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:getOtherClubDetail(params, blockUI, callback)
	local request = self:newRequest(11930, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:chatWithBoss(params, blockUI, callback)
	local request = self:newRequest(35017, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:changeChatBoss(params, blockUI, callback)
	local request = self:newRequest(35016, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:clubBossHeart(params, blockUI, callback)
	local request = self:newRequest(36002, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:clubBossOneStageAttack(params, blockUI, callback)
	local request = self:newRequest(36004, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:clubBossTwoStageAttack(params, blockUI, callback)
	local request = self:newRequest(36005, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:clubBossRecover(params, blockUI, callback)
	local request = self:newRequest(36006, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:requestRank(params, blockUI, callback)
	local request = self:newRequest(35010, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:requestApply(params, blockUI, callback)
	local request = self:newRequest(35001, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:requestReward(params, blockUI, callback)
	local request = self:newRequest(35011, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:listenBattleFinish(callback)
	self:addPushHandler(2402, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceService:listenMatchFinish(callback)
	self:addPushHandler(2403, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceService:listenRewardReissue(callback)
	self:addPushHandler(2404, function(op, response)
		if callback then
			callback(response)
		end
	end)
end

function WorldPeaceService:requestSimpleBattleInfo(params, blockUI, callback)
	local request = self:newRequest(35012, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:requestInteractWithBoss(params, blockUI, callback)
	local request = self:newRequest(35017, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:requestInteractWithClub(params, blockUI, callback)
	local request = self:newRequest(35018, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:requestChangeChatBoss(params, blockUI, callback)
	local request = self:newRequest(35016, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:requestClubRank(params, blockUI, callback)
	local request = self:newRequest(35020, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:requestTaskInfo(params, blockUI, callback)
	local request = self:newRequest(35022, params, callback)

	self:sendRequest(request, blockUI)
end

function WorldPeaceService:requestTaskReward(params, blockUI, callback)
	local request = self:newRequest(35023, params, callback)

	self:sendRequest(request, blockUI)
end
