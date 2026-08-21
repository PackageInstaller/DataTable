-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/think/model/ThinkingModel.lua

module("logic.extensions.think.model.ThinkingModel", package.seeall)

local M = class("ThinkingModel", BaseModel)

function M:onInit()
	self._moList = {}
	self._id2MoMap = {}

	self:onReset()
end

function M:onReset()
	table.clear(self._moList)
	table.clear(self._id2MoMap)

	for _, cfg in ipairs(ThinkingConfig.instance:getThinkingCfg()) do
		local mo = ThinkingMO.New(cfg)

		table.insert(self._moList, mo)

		self._id2MoMap[mo:getId()] = mo
	end

	self._showChangeState = false
end

function M:setData(data)
	for _, ThinkingNO in ipairs(data) do
		if not self._id2MoMap[ThinkingNO.id] then
			printError("Can't find ThinkingMO for id = " .. tostring(ThinkingNO.id))

			return
		end

		self._id2MoMap[ThinkingNO.id]:updateByAgent(ThinkingNO)
	end

	GlobalDispatcher:dispatchEvent(EventType.THINKING_REFRESH)
end

function M:getData()
	return self._moList
end

function M:getMoByIndex(index)
	return self._moList[index]
end

function M:getMoById(id)
	return self._id2MoMap[id]
end

function M:refreshHeroThinkingInfos(infos)
	for _, WearInfoNO in ipairs(infos) do
		local heroData = HeroDepotModel.instance:getHeroInfoByID(WearInfoNO.hero)

		if not heroData then
			printError("Can't find HeroData for WearInfoNO.hero = " .. tostring(WearInfoNO.hero))
		else
			local thinkingItemData = heroData:getThinkingItemData()

			thinkingItemData:setThinkingMo(self:getMoById(WearInfoNO.thinking))
			thinkingItemData:setWearingSkillId(WearInfoNO.skill)

			local unlockList = {}

			for _, v in ipairs(WearInfoNO.unlocked) do
				table.insert(unlockList, self:getMoById(v))
			end

			thinkingItemData:setUnLockList(unlockList)
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.THINKING_HERO_REFRESH)
end

function M:getThinkingSkillLevel(skillId)
	local level

	for _, thinkingMo in pairs(self._moList or {}) do
		if not level then
			for _, skillNO in ipairs(thinkingMo:getSkills() or {}) do
				if not level and skillNO.id == skillId then
					level = skillNO.level
				end
			end
		end
	end

	level = level or 0

	return level
end

function M:checkRedPoint(heroId)
	local key = RedDotType.ERedDotKey.Thinking
	local systemOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.Thought, false)

	if not systemOpen then
		GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
			isActive = false,
			key = key
		})

		return
	end

	local heroData = HeroDepotModel.instance:getHeroInfoByID(heroId)
	local thinkingItemData = heroData:getThinkingItemData()
	local usingThinkingId = thinkingItemData:getThinkingMoId()

	if usingThinkingId then
		GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
			isActive = false,
			key = key
		})

		return
	end

	local hasUnlockThinking = false

	for _, _thinkingId in ipairs(heroData:getAvailableThinkingIds()) do
		local thinkingMo = ThinkingModel.instance:getMoById(_thinkingId)

		if not hasUnlockThinking and not thinkingItemData:isThinkingUnlocked(_thinkingId) and thinkingMo:getIsOnline() then
			hasUnlockThinking = true
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
		key = key,
		isActive = hasUnlockThinking
	})
end

function M:setShowChangeState(changeState)
	self._showChangeState = changeState
end

function M:getShowChangeState()
	return self._showChangeState
end

M.instance = M.New()

return M
