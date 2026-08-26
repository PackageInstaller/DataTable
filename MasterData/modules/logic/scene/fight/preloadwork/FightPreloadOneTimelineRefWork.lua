-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadOneTimelineRefWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadOneTimelineRefWork", package.seeall)

local FightPreloadOneTimelineRefWork = class("FightPreloadOneTimelineRefWork", BaseWork)

function FightPreloadOneTimelineRefWork:ctor(timelineName, skinId, timelineItem)
	if string.nilorempty(timelineName) then
		logError(string.format("预加载timeline资源失败，timelineName : ", timelineName))

		return
	end

	self.skinId = skinId
	self.timelineName = timelineName
	self.assetUrl = FightHelper.getRolesTimelinePath(self.timelineName)
	self.timelineUrl = ResUrl.getSkillTimeline(self.timelineName)
	self.timelineItem = timelineItem
end

function FightPreloadOneTimelineRefWork:onStart()
	if string.nilorempty(self.assetUrl) then
		return self:onDone(true)
	end

	logNormal("加载timeline 资源 .. " .. tostring(self.timelineName))
	TaskDispatcher.runDelay(self._delayDone, self, 3)

	self.loader = self.timelineItem:addComponent(FightLoaderComponent)

	self.loader:loadAsset(self.assetUrl, self.onLoadTimelineDone, self)
end

function FightPreloadOneTimelineRefWork:onLoadTimelineDone(success, assetItem)
	if not success then
		self.timelineItem:onDone(true)

		return
	end

	self.timelineItem:setTimelineAssetItem(assetItem)
	logNormal("加载timeline资源成功")

	local refResList = FightPreloadHelper.getTimelineRefRes(assetItem, self.timelineUrl, self.skinId)

	if not refResList then
		return self:onDone(true)
	end

	if #refResList < 1 then
		return self:onDone(true)
	end

	logNormal("开始加载timeline引用的资源")
	self.loader:loadListAsset(refResList, nil, self.onLoadTimelineResDone, self)
end

function FightPreloadOneTimelineRefWork:onLoadTimelineResDone()
	logNormal("timeline引用的资源加载完成")

	return self:onDone(true)
end

function FightPreloadOneTimelineRefWork:clearWork()
	TaskDispatcher.cancelTask(self._delayDone, self)
end

function FightPreloadOneTimelineRefWork:_delayDone()
	self:onDone(true)
end

return FightPreloadOneTimelineRefWork
