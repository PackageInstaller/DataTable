-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadRoleEffectWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadRoleEffectWork", package.seeall)

local FightPreloadRoleEffectWork = class("FightPreloadRoleEffectWork", BaseWork)

function FightPreloadRoleEffectWork:onStart(context)
	if GameResMgr.IsFromEditorDir then
		self:onDone(true)

		return
	end

	if FightEffectPool.isForbidEffect then
		self:onDone(true)

		return
	end

	self._startTime = Time.time

	local effectUrlList, replayAb2EffectUrlList = self:_analyseEffectUrlList()

	self._replayAb2EffectUrlList = replayAb2EffectUrlList
	self._loader = SequenceAbLoader.New()

	self._loader:setPathList(effectUrlList)
	self._loader:setConcurrentCount(1)
	self._loader:setInterval(0.01)
	self._loader:setOneFinishCallback(self._onPreloadOneFinish, self)
	self._loader:setLoadFailCallback(self._onPreloadOneFail, self)
	self._loader:startLoad(self._onPreloadFinish, self)
	logNormal("preload 开始预加载角色特效 " .. Time.time)
end

function FightPreloadRoleEffectWork:_onPreloadOneFinish(loader, assetItem)
	local now = Time.time
	local elapse = now - self._startTime

	logNormal(string.format("preload %.2f_%.2f %s", Time.time, elapse, assetItem.ResPath))

	self._startTime = now

	local effectUrlList = self._replayAb2EffectUrlList[assetItem.ResPath]

	if effectUrlList then
		for _, effectUrl in ipairs(effectUrlList) do
			local effectWrap = FightEffectPool.getEffect(effectUrl, FightEnum.EntitySide.MySide, nil, nil, nil, true)

			FightEffectPool.returnEffect(effectWrap)
		end
	end
end

function FightPreloadRoleEffectWork:_onPreloadFinish()
	local assetItemDict = self._loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self.context.callback(self.context.callbackObj, assetItem)
	end

	self:onDone(true)
end

function FightPreloadRoleEffectWork:_onPreloadOneFail(loader, assetItem)
	logError("战斗资源加载失败：" .. assetItem.ResPath)
end

function FightPreloadRoleEffectWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function FightPreloadRoleEffectWork:_analyseEffectUrlList()
	local skillId2UrlList = {}
	local otherUrlList = {}
	local mySideList = FightDataHelper.entityMgr:getMyNormalList()

	for _, entityMO in ipairs(mySideList) do
		local skillList = entityMO.skillList

		for _, skillId in ipairs(skillList) do
			if entityMO:isActiveSkill(skillId) then
				local timeline = FightConfig.instance:getSkinSkillTimeline(entityMO.skin, skillId)
				local timelineList = FightHelper.getTimelineListByName(timeline, entityMO.skin)

				for i, v in ipairs(timelineList) do
					timeline = v

					if not string.nilorempty(v) then
						local timelineEffectUrlList, othersList = self:_analyseSingleTimeline(timeline)

						skillId2UrlList[skillId] = skillId2UrlList[skillId] or {}

						tabletool.addValues(skillId2UrlList[skillId], timelineEffectUrlList)
						tabletool.addValues(otherUrlList, othersList)
					end
				end
			end
		end
	end

	local replayEffectUrlList = {}
	local fightParam = FightModel.instance:getFightParam()

	if fightParam.isReplay then
		local handCards = FightDataHelper.handCardMgr.handCard
		local replayList = FightReplayModel.instance:getList()
		local firstOperRecordMO = replayList and replayList[1]

		if firstOperRecordMO then
			for _, beginRoundOp in ipairs(firstOperRecordMO.opers) do
				if beginRoundOp.operType == FightEnum.CardOpType.PlayCard then
					local cardMO = handCards and handCards[beginRoundOp.param1]
					local skillId = cardMO and cardMO.skillId
					local list1 = skillId and skillId2UrlList[skillId]

					if list1 then
						tabletool.addValues(replayEffectUrlList, list1)

						skillId2UrlList[skillId] = nil
					end
				end

				break
			end
		end
	end

	local abPathList = {}
	local replayAb2EffectUrlList = {}

	for _, effectUrl in ipairs(replayEffectUrlList) do
		self:_addAbByEffectUrl(abPathList, effectUrl)

		local abPath = FightHelper.getEffectAbPath(effectUrl)

		replayAb2EffectUrlList[abPath] = replayAb2EffectUrlList[abPath] or {}

		if not tabletool.indexOf(replayAb2EffectUrlList[abPath], effectUrl) then
			table.insert(replayAb2EffectUrlList[abPath], effectUrl)
		end
	end

	for skillId, urlList in pairs(skillId2UrlList) do
		for _, effectUrl in ipairs(urlList) do
			self:_addAbByEffectUrl(abPathList, effectUrl)
		end
	end

	for _, effectUrl in ipairs(otherUrlList) do
		self:_addAbByEffectUrl(abPathList, effectUrl)
	end

	return abPathList, replayAb2EffectUrlList
end

function FightPreloadRoleEffectWork:_addAbByEffectUrl(abPathList, effectUrl)
	local abPath = FightHelper.getEffectAbPath(effectUrl)

	if not tabletool.indexOf(abPathList, abPath) then
		table.insert(abPathList, abPath)
	end
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

function FightPreloadRoleEffectWork:_analyseSingleTimeline(timeline)
	local list = {}
	local list2 = {}
	local tlAssetItem = FightPreloadController.instance:getFightAssetItem(ResUrl.getSkillTimeline(timeline))
	local timelineUrl = ResUrl.getSkillTimeline(timeline)
	local jsonArr = FightTLHelper.getTLJsonData(tlAssetItem, timelineUrl)

	for i = 1, #jsonArr, 2 do
		local tlType = tonumber(jsonArr[i])
		local paramList = jsonArr[i + 1]
		local effectName = paramList[1]

		if TimelineEffectType[tlType] and not string.nilorempty(effectName) then
			local effectUrl = FightHelper.getEffectUrlWithLod(effectName)

			if not string.find(effectUrl, "/buff/") and not string.find(effectUrl, "/roleeffects/") then
				table.insert(list, effectUrl)
			else
				table.insert(list2, effectUrl)
			end
		end
	end

	return list, list2
end

return FightPreloadRoleEffectWork
