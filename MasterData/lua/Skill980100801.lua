-- 超频
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980100801 = oo.class(SkillBase)
function Skill980100801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill980100801:OnActionOver(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 980100804
	self:AddBuff(SkillEffect[980100804], caster, self.card, data, 980100804)
end
