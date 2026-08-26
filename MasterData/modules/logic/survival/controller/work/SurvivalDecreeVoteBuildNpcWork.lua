-- chunkname: @modules/logic/survival/controller/work/SurvivalDecreeVoteBuildNpcWork.lua

module("modules.logic.survival.controller.work.SurvivalDecreeVoteBuildNpcWork", package.seeall)

local SurvivalDecreeVoteBuildNpcWork = class("SurvivalDecreeVoteBuildNpcWork", BaseWork)

function SurvivalDecreeVoteBuildNpcWork:ctor(param)
	self:initParam(param)
end

function SurvivalDecreeVoteBuildNpcWork:initParam(param)
	self.npcDataList = param.npcDataList
	self.votePercent = param.votePercent
	self.goAgreeItem = param.goAgreeItem
	self.goDisAgreeItem = param.goDisAgreeItem
	self.mapCo = param.mapCo
	self.unitComp = param.unitComp
	self.bubbleList = param.bubbleList or {}
	self.toastList = param.toastList or {}
	self.npcList = {}
end

function SurvivalDecreeVoteBuildNpcWork:onStart()
	local npcPosList = GameUtil.splitString2(self.mapCo.npcPosition, true, "#", ",")
	local npcRoot = self.unitComp:getUnitParentGO(SurvivalEnum.ShelterUnitType.VoteEntity)
	local posCount = #npcPosList
	local agreeNpcCount = math.floor(posCount * self.votePercent)
	local disAgreeNpcCount = posCount - agreeNpcCount
	local posIndex = 1

	for i = 1, math.min(agreeNpcCount, #self.npcDataList[1]) do
		if posCount < posIndex then
			break
		end

		self:createNpc(self.npcDataList[1][i], npcRoot, npcPosList[posIndex])

		posIndex = posIndex + 1
	end

	for i = 1, math.min(disAgreeNpcCount, #self.npcDataList[2]) do
		if posCount < posIndex then
			break
		end

		self:createNpc(self.npcDataList[2][i], npcRoot, npcPosList[posIndex])

		posIndex = posIndex + 1
	end

	self:onBuildFinish()
end

function SurvivalDecreeVoteBuildNpcWork:createNpc(data, root, pos, dir)
	local npc = SurvivalDecreeVoteEntity.Create(data.resource, root, SurvivalHexNode.New(pos[1], pos[2]), dir)

	table.insert(self.npcList, npc)
	table.insert(self.toastList, data)

	if data.isAgree then
		self:createBubbleItem(self.goAgreeItem, npc.go)
	else
		self:createBubbleItem(self.goDisAgreeItem, npc.go)
	end
end

function SurvivalDecreeVoteBuildNpcWork:clearNpc()
	if self.npcList then
		for i, v in ipairs(self.npcList) do
			v:dispose()
		end
	end

	self.npcList = {}
end

function SurvivalDecreeVoteBuildNpcWork:createBubbleItem(go, followerGO)
	local cloneGO = gohelper.cloneInPlace(go)

	gohelper.setActive(cloneGO, false)

	local bubble = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGO, SurvivalDecreeVoteUIItem, followerGO)

	table.insert(self.bubbleList, bubble)
end

function SurvivalDecreeVoteBuildNpcWork:onBuildFinish()
	self:onDone(true)
end

function SurvivalDecreeVoteBuildNpcWork:onDestroy()
	self:clearNpc()
	SurvivalDecreeVoteBuildNpcWork.super.onDestroy(self)
end

return SurvivalDecreeVoteBuildNpcWork
