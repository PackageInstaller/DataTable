-- chunkname: @modules/logic/login/controller/work/LoginParseFightConfigWork.lua

module("modules.logic.login.controller.work.LoginParseFightConfigWork", package.seeall)

local LoginParseFightConfigWork = class("LoginParseFightConfigWork", BaseWork)

function LoginParseFightConfigWork:_timeOut()
	logError("解析战斗配置出错了")

	return self:onDone(true)
end

function LoginParseFightConfigWork:onStart(context)
	TaskDispatcher.runDelay(self._timeOut, self, 10)

	self._skillCurrCardLvDict = {}
	self._skillNextCardLvDict = {}
	self._skillPrevCardLvDict = {}
	self._skillHeroIdDict = {}
	self._skillMonsterIdDict = {}
	self.parseFlow = FlowSequence.New()

	self.parseFlow:addWork(FunctionWork.New(self.parseCharacterCo, self))
	self.parseFlow:addWork(WorkWaitSeconds.New())
	self.parseFlow:addWork(FunctionWork.New(self.parseSkillExLevelCo, self))
	self.parseFlow:addWork(WorkWaitSeconds.New())
	self.parseFlow:addWork(LoginParseMonsterConfigWork.New(self._skillMonsterIdDict, self._skillCurrCardLvDict))
	self.parseFlow:addWork(WorkWaitSeconds.New())
	self.parseFlow:registerDoneListener(self.parseDone, self)
	self.parseFlow:start()
end

function LoginParseFightConfigWork:parseCharacterCo()
	for _, heroCO in ipairs(lua_character.configList) do
		local skill = heroCO.skill

		if not string.nilorempty(skill) then
			local activeSkills = FightStrUtil.instance:getSplitString2Cache(skill, true)

			for _, oneSkills in ipairs(activeSkills) do
				local s1, s2, s3 = oneSkills[2], oneSkills[3], oneSkills[4]

				self._skillCurrCardLvDict[s1] = 1
				self._skillCurrCardLvDict[s2] = 2
				self._skillCurrCardLvDict[s3] = 3
				self._skillNextCardLvDict[s1] = s2
				self._skillNextCardLvDict[s2] = s3
				self._skillPrevCardLvDict[s2] = s1
				self._skillPrevCardLvDict[s3] = s2

				local heroId = heroCO.id

				self._skillHeroIdDict[s1] = heroId
				self._skillHeroIdDict[s2] = heroId
				self._skillHeroIdDict[s3] = heroId
			end
		end
	end
end

function LoginParseFightConfigWork:parseSkillExLevelCo()
	for _, exSkillCO in ipairs(lua_skill_ex_level.configList) do
		local heroId = exSkillCO.heroId
		local skillGroup1 = exSkillCO.skillGroup1

		if not string.nilorempty(skillGroup1) then
			local temp = FightStrUtil.instance:getSplitToNumberCache(skillGroup1, "|")

			for level, skillId in ipairs(temp) do
				self._skillHeroIdDict[skillId] = heroId
				self._skillCurrCardLvDict[skillId] = level
			end
		end

		local skillGroup2 = exSkillCO.skillGroup2

		if not string.nilorempty(skillGroup2) then
			local temp = FightStrUtil.instance:getSplitToNumberCache(skillGroup2, "|")

			for level, skillId in ipairs(temp) do
				self._skillHeroIdDict[skillId] = heroId
				self._skillCurrCardLvDict[skillId] = level
			end
		end

		local skillId = exSkillCO.skillEx

		self._skillHeroIdDict[skillId] = heroId
	end
end

function LoginParseFightConfigWork:parseDone()
	if not self.parseFlow.isSuccess then
		logError("解析战斗配置出错了")

		return self:onDone(true)
	end

	FightConfig.instance:setSkillDict(self._skillCurrCardLvDict, self._skillNextCardLvDict, self._skillPrevCardLvDict, self._skillHeroIdDict, self._skillMonsterIdDict)

	return self:onDone(true)
end

function LoginParseFightConfigWork:clearWork()
	TaskDispatcher.cancelTask(self._timeOut, self)

	if self.parseFlow then
		self.parseFlow:destroy()

		self.parseFlow = nil
	end

	self._skillCurrCardLvDict = nil
	self._skillNextCardLvDict = nil
	self._skillPrevCardLvDict = nil
	self._skillHeroIdDict = nil
	self._skillMonsterIdDict = nil
end

return LoginParseFightConfigWork
