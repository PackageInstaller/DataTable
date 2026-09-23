-- 肉鸽角色将角色大招获得5%暴击率，20%暴击伤害，最高16层
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100040032 = oo.class(SkillBase)
function Skill1100040032:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100040032:OnAttackOver(caster, target, data)
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
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 1100040032
	self:OwnerAddBuffCount(SkillEffect[1100040032], caster, self.card, data, 1100040030,1,16)
end
