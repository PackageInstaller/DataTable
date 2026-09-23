-- 天赋效果55
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill8555 = oo.class(SkillBase)
function Skill8555:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill8555:OnAttackOver(caster, target, data)
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
	-- 8555
	self:AddBuff(SkillEffect[8555], caster, self.card, data, 2150+count22)
end
