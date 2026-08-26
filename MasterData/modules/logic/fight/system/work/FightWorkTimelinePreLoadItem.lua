-- chunkname: @modules/logic/fight/system/work/FightWorkTimelinePreLoadItem.lua

module("modules.logic.fight.system.work.FightWorkTimelinePreLoadItem", package.seeall)

local FightWorkTimelinePreLoadItem = class("FightWorkTimelinePreLoadItem", FightWorkItem)

function FightWorkTimelinePreLoadItem:onConstructor(timelineName, entityData)
	self.timelineName = timelineName
	self.entityData = entityData
	self.skinId = entityData.skin
end

function FightWorkTimelinePreLoadItem:onStart()
	local path = not GameResMgr.IsFromEditorDir and "rolestimeline" or ResUrl.getSkillTimeline(self.timelineName)

	self.timelineUrl = ResUrl.getSkillTimeline(self.timelineName)

	self:com_loadAsset(path, self.onTimelineLoaded)
	self:cancelFightWorkSafeTimer()
end

function FightWorkTimelinePreLoadItem:onTimelineLoaded(success, assetItem)
	if not success then
		self:onDone(true)

		return
	end

	local loaderMgr = FightGameMgr.timelinePreLoaderMgr
	local flow = self:com_registFlowParallel()
	local jsonArr = FightTLHelper.getTLJsonData(assetItem, self.timelineUrl)

	for i = 1, #jsonArr, 2 do
		local tlType = tonumber(jsonArr[i])
		local paramList = jsonArr[i + 1]

		if tlType == 32 then
			local resName = paramList[2]

			if not string.nilorempty(resName) then
				flow:registWork(FightWorkLoadAsset, ResUrl.getRoleSpineMatTex(resName), nil, loaderMgr)
			end
		elseif tlType == 11 then
			local spineName = FightTLEventCreateSpine.getSkinSpineName(paramList[1], self.skinId)

			if not string.nilorempty(spineName) then
				flow:registWork(FightWorkLoadAsset, ResUrl.getSpineFightPrefab(spineName), nil, loaderMgr)
			end
		end
	end

	local context = {}

	context.timelineDict = {}
	context.timelineDict[self.timelineUrl] = assetItem
	context.timelineUrlDict = {}
	context.timelineUrlDict[self.timelineUrl] = self.entityData.side

	flow:addWork(FightRoundPreloadEffectWork.New())
	self:playWorkAndDone(flow, context)
end

return FightWorkTimelinePreLoadItem
