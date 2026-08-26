-- chunkname: @modules/logic/autochess/main/controller/AutoChessEntityMgr.lua

module("modules.logic.autochess.main.controller.AutoChessEntityMgr", package.seeall)

local AutoChessEntityMgr = class("AutoChessEntityMgr")

function AutoChessEntityMgr:init(scene)
	self.scene = scene
	self._entityDic = {}
	self._cacheEntityDic = {}
	self._leaderEntityDic = {}
end

function AutoChessEntityMgr:addEntity(warZone, data, pos)
	if not self.scene then
		return
	end

	warZone = tonumber(warZone)
	pos = tonumber(pos)

	local entity = self._cacheEntityDic[data.uid]

	if entity then
		entity:setData(data, warZone, pos)

		self._cacheEntityDic[data.uid] = nil
	else
		entity = self.scene:createEntity(warZone, data, pos)
	end

	if self.scene.viewType == AutoChessEnum.ViewType.All then
		entity:setScale(0.8)
		entity:activeExpStar(false)
	end

	self._entityDic[data.uid] = entity

	return entity
end

function AutoChessEntityMgr:removeEntity(uid)
	local entity = self._entityDic[uid]

	if entity then
		gohelper.destroy(entity.go)

		self._entityDic[uid] = nil
	end
end

function AutoChessEntityMgr:addLeaderEntity(data, showBattle)
	if not self.scene then
		return
	end

	local entity = self.scene:createLeaderEntity(data)

	self._leaderEntityDic[data.uid] = entity

	if showBattle then
		entity:showBattle()
	end
end

function AutoChessEntityMgr:cacheAllEntity()
	for uid, entity in pairs(self._entityDic) do
		entity:hide()

		self._cacheEntityDic[uid] = entity
		self._entityDic[uid] = nil
	end

	for uid, entity in pairs(self._leaderEntityDic) do
		gohelper.destroy(entity.go)

		self._leaderEntityDic[uid] = nil
	end
end

function AutoChessEntityMgr:clearEntity()
	for uid, entity in pairs(self._entityDic) do
		gohelper.destroy(entity.go)

		self._entityDic[uid] = nil
	end

	for uid, entity in pairs(self._cacheEntityDic) do
		gohelper.destroy(entity.go)

		self._cacheEntityDic[uid] = nil
	end

	for uid, entity in pairs(self._leaderEntityDic) do
		gohelper.destroy(entity.go)

		self._leaderEntityDic[uid] = nil
	end
end

function AutoChessEntityMgr:getEntity(uid)
	local entity = self._entityDic[uid]

	if not entity then
		logError(string.format("异常:不存在棋子UID%s", uid))
	end

	return entity
end

function AutoChessEntityMgr:tryGetEntity(uid)
	return self._entityDic[uid] or self._leaderEntityDic[uid]
end

function AutoChessEntityMgr:getLeaderEntity(uid)
	return self._leaderEntityDic[uid]
end

function AutoChessEntityMgr:dispose()
	self:clearEntity()

	self.scene = nil
end

function AutoChessEntityMgr:flyStarByTeam(teamType)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_star_collect)

	for _, chess in pairs(self._entityDic) do
		if chess.teamType == teamType and chess.config.type == AutoChessStrEnum.ChessType.Attack then
			chess:flyStar()
		end
	end
end

AutoChessEntityMgr.instance = AutoChessEntityMgr.New()

return AutoChessEntityMgr
