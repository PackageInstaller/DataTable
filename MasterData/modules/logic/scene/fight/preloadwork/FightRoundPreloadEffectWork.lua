-- chunkname: @modules/logic/scene/fight/preloadwork/FightRoundPreloadEffectWork.lua

module("modules.logic.scene.fight.preloadwork.FightRoundPreloadEffectWork", package.seeall)

local FightRoundPreloadEffectWork = class("FightRoundPreloadEffectWork", BaseWork)
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
local TimelineEventOppositeSide = {
	[1] = "FightTLEventTargetEffect"
}

function FightRoundPreloadEffectWork:onStart(context)
	if FightEffectPool.isForbidEffect then
		self:onDone(true)

		return
	end

	self._concurrentCount = 1
	self._interval = 0.1
	self._loadingCount = 0
	self._effectWrapList = {}
	self._needPreloadList = {}

	local effectPath2SideDict = {}

	for timelineUrl, tlAssetItem in pairs(self.context.timelineDict) do
		local jsonArr = FightTLHelper.getTLJsonData(tlAssetItem, timelineUrl)

		for i = 1, #jsonArr, 2 do
			local tlType = tonumber(jsonArr[i])
			local paramList = jsonArr[i + 1]
			local effectName = paramList[1]

			if TimelineEffectType[tlType] and not string.nilorempty(effectName) then
				local effectUrl = FightHelper.getEffectUrlWithLod(effectName)
				local timelineSide = self.context.timelineUrlDict[timelineUrl]
				local oldSide = effectPath2SideDict[effectUrl]
				local needSide = timelineSide

				if TimelineEventOppositeSide[tlType] then
					needSide = timelineSide == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
				end

				if oldSide and oldSide ~= needSide then
					effectPath2SideDict[effectUrl] = FightEnum.EntitySide.BothSide
				end
			end
		end
	end

	for path, side in pairs(effectPath2SideDict) do
		self:_addPreloadEffect(path, side)
	end

	self:_startPreload()
end

function FightRoundPreloadEffectWork:_addPreloadEffect(path, side)
	if FightEffectPool.hasLoaded(path) then
		return
	end

	if side == nil then
		table.insert(self._needPreloadList, {
			path = path,
			side = FightEnum.EntitySide.BothSide
		})
	end

	if side == FightEnum.EntitySide.MySide or side == FightEnum.EntitySide.BothSide then
		table.insert(self._needPreloadList, {
			path = path,
			side = FightEnum.EntitySide.MySide
		})
	end

	if side == FightEnum.EntitySide.EnemySide or side == FightEnum.EntitySide.BothSide then
		table.insert(self._needPreloadList, {
			path = path,
			side = FightEnum.EntitySide.EnemySide
		})
	end
end

function FightRoundPreloadEffectWork:_startPreload()
	self._loadingCount = math.min(self._concurrentCount, #self._needPreloadList)

	if self._loadingCount > 0 then
		for i = 1, self._loadingCount do
			local last = table.remove(self._needPreloadList, #self._needPreloadList)

			if FightEffectPool.hasLoaded(last.path) or FightEffectPool.isLoading(last.path) then
				self:_detectAfterLoaded()
			else
				local effect = FightEffectPool.getEffect(last.path, last.side, self._onPreloadOneFinish, self, nil, true)

				effect:setLocalPos(50000, 50000, 50000)
				table.insert(self._effectWrapList, effect)
			end
		end
	else
		self:_onPreloadAllFinish()
	end
end

function FightRoundPreloadEffectWork:_onPreloadOneFinish(effectWrap, success)
	if not success then
		logError("战斗特效加载失败：" .. effectWrap.path)
	end

	self:_detectAfterLoaded()
end

function FightRoundPreloadEffectWork:_detectAfterLoaded()
	self._loadingCount = self._loadingCount - 1

	if self._loadingCount <= 0 then
		TaskDispatcher.runDelay(self._startPreload, self, self._interval)
	end
end

function FightRoundPreloadEffectWork:_onPreloadAllFinish()
	self:onDone(true)
end

function FightRoundPreloadEffectWork:clearWork()
	TaskDispatcher.cancelTask(self._startPreload, self, 0.01)

	if self._effectWrapList then
		for _, effectWrap in ipairs(self._effectWrapList) do
			FightEffectPool.returnEffect(effectWrap)
			effectWrap:setCallback(nil, nil)
		end
	end

	self._effectWrapList = nil
end

return FightRoundPreloadEffectWork
