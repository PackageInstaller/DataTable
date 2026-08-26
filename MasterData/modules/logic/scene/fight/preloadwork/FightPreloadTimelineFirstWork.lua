-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadTimelineFirstWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadTimelineFirstWork", package.seeall)

local FightPreloadTimelineFirstWork = class("FightPreloadTimelineFirstWork", BaseWork)

function FightPreloadTimelineFirstWork:onStart(context)
	local timelineUrlList = self:_getTimelineUrlList()

	self._loader = SequenceAbLoader.New()

	for _, resPath in ipairs(timelineUrlList) do
		self._loader:addPath(resPath)
	end

	self._loader:setConcurrentCount(10)
	self._loader:setLoadFailCallback(self._onPreloadOneFail)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function FightPreloadTimelineFirstWork:_onPreloadFinish()
	local assetItemDict = self._loader:getAssetItemDict()

	self.context.timelineDict = {}

	for url, assetItem in pairs(assetItemDict) do
		self.context.timelineDict[url] = assetItem

		self.context.callback(self.context.callbackObj, assetItem)
	end

	self:onDone(true)
end

function FightPreloadTimelineFirstWork:_onPreloadOneFail(loader, assetItem)
	logError("Timeline加载失败：" .. assetItem.ResPath)
end

function FightPreloadTimelineFirstWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function FightPreloadTimelineFirstWork:_getTimelineUrlList()
	self.context.timelineUrlDict = {}
	self.context.timelineSkinDict = {}

	local battleCO = lua_battle.configDict[self.context.battleId]

	if battleCO then
		local monsterGroupIds = FightStrUtil.instance:getSplitToNumberCache(battleCO.monsterGroupIds, "#")

		for _, monsterGroupId in ipairs(monsterGroupIds) do
			local monsterGroupCO = lua_monster_group.configDict[monsterGroupId]

			if not string.nilorempty(monsterGroupCO.appearTimeline) then
				local tlUrl = ResUrl.getSkillTimeline(monsterGroupCO.appearTimeline)

				self.context.timelineUrlDict[tlUrl] = FightEnum.EntitySide.EnemySide
				self.context.timelineSkinDict[tlUrl] = self.context.timelineSkinDict[tlUrl] or {}
				self.context.timelineSkinDict[tlUrl][0] = true
			end
		end
	end

	local timelineUrlList = {}

	for url, _ in pairs(self.context.timelineUrlDict) do
		table.insert(timelineUrlList, url)
	end

	return timelineUrlList
end

return FightPreloadTimelineFirstWork
