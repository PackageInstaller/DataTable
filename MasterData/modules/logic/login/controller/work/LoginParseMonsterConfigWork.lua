-- chunkname: @modules/logic/login/controller/work/LoginParseMonsterConfigWork.lua

module("modules.logic.login.controller.work.LoginParseMonsterConfigWork", package.seeall)

local LoginParseMonsterConfigWork = class("LoginParseMonsterConfigWork", BaseWork)

function LoginParseMonsterConfigWork:ctor(skillMonsterIdDict, skillCurrCardLvDict)
	self._skillMonsterIdDict = skillMonsterIdDict
	self._skillCurrCardLvDict = skillCurrCardLvDict
end

function LoginParseMonsterConfigWork:_timeOut()
	logError("解析战斗Monster配置出错了")

	return self:onDone(false)
end

function LoginParseMonsterConfigWork:onStart()
	TaskDispatcher.runDelay(self._timeOut, self, 10)

	self.curIndex = 0

	TaskDispatcher.runRepeat(self.parseMonsterCo, self, 0.0001)
end

LoginParseMonsterConfigWork.Interval = 160

function LoginParseMonsterConfigWork:parseMonsterCo()
	local configList = lua_monster.configList

	for _ = 1, LoginParseMonsterConfigWork.Interval do
		self.curIndex = self.curIndex + 1

		local monsterCO = configList[self.curIndex]

		if not monsterCO then
			TaskDispatcher.cancelTask(self.parseMonsterCo, self)

			return self:onDone(true)
		end

		local monsterId = monsterCO.id
		local activeSkill = FightStrUtil.instance:getSplitString2Cache(monsterCO.activeSkill, true, "|", "#")

		if activeSkill then
			for _, ids in ipairs(activeSkill) do
				local lv = 1

				for _, skillId in ipairs(ids) do
					local skillCO = lua_skill.configDict[skillId]

					if skillCO then
						self._skillMonsterIdDict[skillId] = monsterId
						self._skillCurrCardLvDict[skillId] = lv
						lv = lv + 1
					end
				end
			end
		end

		local uniqueSkill = monsterCO.uniqueSkill

		if uniqueSkill and #uniqueSkill > 0 then
			for _, skillId in ipairs(uniqueSkill) do
				self._skillMonsterIdDict[skillId] = monsterId
			end
		end
	end
end

function LoginParseMonsterConfigWork:clearWork()
	TaskDispatcher.cancelTask(self._timeOut, self)
	TaskDispatcher.cancelTask(self.parseMonsterCo, self)
end

return LoginParseMonsterConfigWork
