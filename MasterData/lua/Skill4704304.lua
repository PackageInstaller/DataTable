-- 岁稔被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4704304 = oo.class(SkillBase)
function Skill4704304:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合结束时
function Skill4704304:OnRoundOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8705
	local count705 = SkillApi:SkillLevel(self, caster, target,3,7043001)
	-- 8704
	local count704 = SkillApi:BuffCount(self, caster, target,3,4,704300301)
	-- 8921
	if SkillJudger:Greater(self, caster, target, true,count704,0) then
	else
		return
	end
	-- 4704304
	if self:Rand(8000) then
		self:CallOwnerSkill(SkillEffect[4704304], caster, caster, data, 704300100+count705)
	end
end
-- 入场时
function Skill4704304:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 4704324
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddSkillAttr(SkillEffect[4704324], caster, target, data, "np",-4)
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8706
	local count706 = SkillApi:SkillLevel(self, caster, target,3,7043002)
	-- 4704311
	self:CallSkillEx(SkillEffect[4704311], caster, self.card, data, 704300200+count706)
end
-- 变身时
function Skill4704304:OnTransform(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4704329
	self:AddSkillAttr(SkillEffect[4704329], caster, caster, data, "np",-4)
end
