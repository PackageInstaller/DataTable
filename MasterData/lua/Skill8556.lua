-- 天赋效果56
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8556 = oo.class(SkillBase)
function Skill8556:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8556:OnAttackOver(caster, target, data)
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 8422
	local count22 = SkillApi:BuffCount(self, caster, target,1,4,650)
	-- 8902
	if SkillJudger:Greater(self, caster, target, true,count22,0) then
	else
		return
	end
	-- 8556
	self:AddBuff(SkillEffect[8556], caster, self.card, data, 6500+count42)
end
