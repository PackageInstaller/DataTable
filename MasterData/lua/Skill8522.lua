-- 天赋效果22
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8522 = oo.class(SkillBase)
function Skill8522:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8522:OnAttackOver(caster, target, data)
	-- 8522
	if SkillJudger:CasterIsEnemy(self, caster, target, true) and SkillJudger:TargetIsSelf(self, caster, target, true) then
		-- 8418
		local count18 = SkillApi:GetAttr(self, caster, target,3,"sp")
		-- 8104
		if SkillJudger:Greater(self, caster, self.card, true,count18,99) then
		else
			return
		end
		-- 93002
		if SkillJudger:CheckCD(self, caster, target, false) then
		else
			return
		end
		-- 8523
		self:CallSkill(SkillEffect[8523], caster, self.card, data, 800900301)
	end
end
