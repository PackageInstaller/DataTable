-- chunkname: @modules/common/global/gamestate/GameTimeMgr.lua

module("modules.common.global.gamestate.GameTimeMgr", package.seeall)

local GameTimeMgr = class("GameTimeMgr")

GameTimeMgr.TimeScaleType = {
	FightKillEnemy = "FightKillEnemy",
	GM = "GM",
	AutoChess = "AutoChess",
	StoryPv = "StoryPv",
	FightTLEventSpeed = "FightTLEventSpeed"
}

function GameTimeMgr:ctor()
	self._timeScaleDict = {}
end

function GameTimeMgr:init()
	self._timeScaleDict = {}
end

function GameTimeMgr:setTimeScale(timeScaleType, timeScale)
	if GameTimeMgr.TimeScaleType[timeScaleType] then
		self._timeScaleDict[timeScaleType] = timeScale or 1
	else
		logError("没有定义时间缩放类型, timeScaleType: " .. tostring(timeScaleType))
	end

	local multiTimeScale = 1

	for type, scale in pairs(self._timeScaleDict) do
		multiTimeScale = multiTimeScale * scale
	end

	if math.abs(Time.timeScale - multiTimeScale) > 0.01 then
		logNormal("游戏速度变更: " .. tostring(multiTimeScale))
	end

	Time.timeScale = multiTimeScale

	return multiTimeScale
end

function GameTimeMgr:getTimeScale(timeScaleType)
	return self._timeScaleDict[timeScaleType] or 1
end

GameTimeMgr.instance = GameTimeMgr.New()

return GameTimeMgr
