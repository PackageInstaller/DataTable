-- 亢奋
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill302202 = oo.class(SkillBase)
function Skill302202:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 死亡时
function Skill302202:OnDeath(caster, target, data)
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
	-- 302202
	self:AddSp(SkillEffect[302202], caster, self.card, data, 15)
end
