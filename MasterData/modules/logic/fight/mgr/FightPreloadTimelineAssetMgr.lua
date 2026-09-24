-- chunkname: @modules/logic/fight/mgr/FightPreloadTimelineAssetMgr.lua

module("modules.logic.fight.mgr.FightPreloadTimelineAssetMgr", package.seeall)

local FightPreloadTimelineAssetMgr = class("FightPreloadTimelineAssetMgr", FightBaseClass)

function FightPreloadTimelineAssetMgr:onConstructor()
	self.preLoadList = {}
	self.listCount = 0
	self.curIndex = 0
	self.curLoadCount = 0
	self.preLoadDict = {}

	self:com_registMsg(FightMsgId.ReleasePreloadTimelineAssetByStepId, self.onReleasePreloadTimelineAssetByStepId)
end

function FightPreloadTimelineAssetMgr:addPreLoad(timelineName, fightStepData)
	local classObj = self:newClass(FightPreloadTimelineAssetItem, timelineName, fightStepData)

	self.preLoadDict[fightStepData.stepUid] = classObj

	table.insert(self.preLoadList, classObj)

	self.listCount = self.listCount + 1
	classObj.listIndex = self.listCount

	if self.curLoadCount < 2 then
		self.curLoadCount = self.curLoadCount + 1

		classObj:startLoad()
	end
end

function FightPreloadTimelineAssetMgr:onReleasePreloadTimelineAssetByStepId(stepId)
	local classObj = self.preLoadDict[stepId]

	if classObj then
		classObj:disposeSelf()

		self.preLoadDict[stepId] = nil

		local nextIndex = classObj.listIndex + 1
		local nextClassObj = self.preLoadList[nextIndex]

		if nextClassObj then
			if nextClassObj:__isActive() then
				nextClassObj:startLoad()
			elseif nextClassObj.fightStepData then
				self:onReleasePreloadTimelineAssetByStepId(nextClassObj.fightStepData.stepUid)
			end
		end
	end
end

function FightPreloadTimelineAssetMgr:onDestructor()
	return
end

return FightPreloadTimelineAssetMgr
