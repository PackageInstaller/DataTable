-- chunkname: @modules/logic/fight/system/work/FightWorkTimelineAssetItem.lua

module("modules.logic.fight.system.work.FightWorkTimelineAssetItem", package.seeall)

local FightWorkTimelineAssetItem = class("FightWorkTimelineAssetItem", FightWorkItem)

function FightWorkTimelineAssetItem:onConstructor(loaderComp, entityData, timelineName, fightStepData)
	self.loaderComp = loaderComp
	self.entityData = entityData
	self.skinId = entityData and entityData.skin
	self.timelineName = timelineName
	self.timelineUrl = ResUrl.getSkillTimeline(self.timelineName)
	self.fightStepData = fightStepData
end

function FightWorkTimelineAssetItem:onStart()
	self.assetUrl = FightWorkTimelineItem.getTimelineAssetUrl(self.timelineName)

	self.loaderComp:loadAsset(self.assetUrl, self.onTimelineLoaded, self)
	self:cancelFightWorkSafeTimer()
end

local TimelineEffectType = {
	"FightTLEventTargetEffect",
	nil,
	nil,
	nil,
	"FightTLEventAtkEffect",
	"FightTLEventAtkFlyEffect",
	"FightTLEventAtkFullEffect",
	"FightTLEventDefEffect",
	[28] = "FightTLEventDefEffect"
}

function FightWorkTimelineAssetItem:onTimelineLoaded(success, assetItem)
	if not success then
		self:onDone(true)

		return
	end

	local loaderComp = self.loaderComp
	local flow = self:com_registFlowParallel()
	local jsonArr = FightTLHelper.getTLJsonData(assetItem, self.timelineUrl)
	local urlList = {}

	for i = 1, #jsonArr, 2 do
		local tlType = tonumber(jsonArr[i])
		local paramList = jsonArr[i + 1]

		if tlType == 32 then
			local resName = paramList[2]

			if not string.nilorempty(resName) then
				table.insert(urlList, ResUrl.getRoleSpineMatTex(resName))
			end
		elseif tlType == 11 then
			local spineName = FightTLEventCreateSpine.getSkinSpineName(paramList[1], self.skinId)

			if not string.nilorempty(spineName) then
				if string.sub(spineName, 1, 8) == "roles_3d" then
					table.insert(urlList, string.format("%s.prefab", spineName))
				else
					table.insert(urlList, ResUrl.getSpineFightPrefab(spineName))
				end
			end
		elseif TimelineEffectType[tlType] then
			local effectName = paramList[1]

			if not string.nilorempty(effectName) then
				local effectUrl = FightHelper.getEffectUrlWithLod(effectName)

				table.insert(urlList, effectUrl)
			end
		end
	end

	loaderComp:loadListAsset(urlList, nil, self.onAllLoaded, self)
end

function FightWorkTimelineAssetItem:onAllLoaded()
	self:onDone(true)
end

return FightWorkTimelineAssetItem
