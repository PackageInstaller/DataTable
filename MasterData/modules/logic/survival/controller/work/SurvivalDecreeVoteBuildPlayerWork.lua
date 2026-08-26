-- chunkname: @modules/logic/survival/controller/work/SurvivalDecreeVoteBuildPlayerWork.lua

module("modules.logic.survival.controller.work.SurvivalDecreeVoteBuildPlayerWork", package.seeall)

local SurvivalDecreeVoteBuildPlayerWork = class("SurvivalDecreeVoteBuildPlayerWork", BaseWork)

function SurvivalDecreeVoteBuildPlayerWork:ctor(param)
	self:initParam(param)
end

function SurvivalDecreeVoteBuildPlayerWork:initParam(param)
	self.mapCo = param.mapCo
	self.goBubble = param.goBubble
end

function SurvivalDecreeVoteBuildPlayerWork:onStart()
	local playerPos = string.splitToNumber(self.mapCo.orderPosition, ",")
	local playerDir = self.mapCo.toward
	local playerEntity = SurvivalMapHelper.instance:getShelterEntity(SurvivalEnum.ShelterUnitType.Player, 0)

	if playerEntity then
		playerEntity:setPosAndDir(SurvivalHexNode.New(playerPos[1], playerPos[2]), playerDir)
		self:buildBubble(playerEntity)
	end

	self:onBuildFinish()
end

function SurvivalDecreeVoteBuildPlayerWork:buildBubble(entity)
	self.playerBubble = MonoHelper.addNoUpdateLuaComOnceToGo(self.goBubble, SurvivalDecreeVoteUIItem, entity.go)
end

function SurvivalDecreeVoteBuildPlayerWork:clearBubble()
	if self.playerBubble then
		self.playerBubble:dispose()

		self.playerBubble = nil
	end
end

function SurvivalDecreeVoteBuildPlayerWork:onBuildFinish()
	self:onDone(true)
end

function SurvivalDecreeVoteBuildPlayerWork:onDestroy()
	self:clearBubble()
	SurvivalDecreeVoteBuildPlayerWork.super.onDestroy(self)
end

return SurvivalDecreeVoteBuildPlayerWork
