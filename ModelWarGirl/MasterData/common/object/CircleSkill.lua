-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\CircleSkill.lua

local ResClanBattleSkill = require("ClientData/ResClanBattleSkill")
local strClassName = "CircleSkill"
local CircleSkill = Class(strClassName)

function CircleSkill:ctor(skillID, svrData)
	self.id = skillID
	self.resData = ResClanBattleSkill[self.id]

	if self.resData then
		self.name = self.resData.name or ""
		self.type = self.resData.type or 1
		self.desc = self.resData.desc or ""
		self.contribution = self.resData.contribution or 0
		self.heroId = self.resData.hero_id
	end

	self.isHave = svrData ~= nil

	if self.isHave then
		self.svrData = svrData
		self.leftTimes = self.svrData.left_times or 0
	else
		self.leftTimes = 0
	end
end

function CircleSkill:getUseTimes()
	local remainTimes = 0
	local totalTimes = 0

	if self.type and self.type == Const.CIRCLE_BATTLE_SKILL_TYPE_ACTIVE then
		remainTimes = self.leftTimes

		if self.resData and self.resData.effect then
			totalTimes = self.resData.effect[1].param2
		end
	end

	return remainTimes, totalTimes
end

function CircleSkill:reduceLeftTimes()
	if self.type and self.type == Const.CIRCLE_BATTLE_SKILL_TYPE_ACTIVE and self.leftTimes > 0 then
		self.leftTimes = self.leftTimes - 1
	end
end

function CircleSkill:refreshLeftTimes(leftTimes)
	self.leftTimes = leftTimes
end

function CircleSkill:getIconPath()
	if self.resData and self.resData.atlas and self.resData.sprite then
		return {
			self.resData.atlas,
			self.resData.sprite
		}
	end
end

function CircleSkill:getHeroHeadPath()
	if self.heroId then
		local limitHero = BaseObject.GetObject(self.heroId)

		return limitHero:getQIconPath()
	end
end

return CircleSkill
