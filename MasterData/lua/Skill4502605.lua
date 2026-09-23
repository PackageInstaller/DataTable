-- GGG
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4502605 = oo.class(SkillBase)
function Skill4502605:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill4502605:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8410
	local count10 = SkillApi:BuffCount(self, caster, target,2,1,3)
	-- 8109
	if SkillJudger:Greater(self, caster, self.card, true,count10,0) then
	else
		return
	end
	-- 4502615
	if self:Rand(5000) then
		self:CallOwnerSkill(SkillEffect[4502615], caster, self.card, data, 502600401)
	end
end
