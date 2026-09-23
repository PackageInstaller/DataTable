-- 肉鸽角色将角色大招获得5%暴击率，20%暴击伤害，最高12层，使用大招后有概率是怪物增加20%攻击力
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100040031 = oo.class(SkillBase)
function Skill1100040031:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill1100040031:OnAttackOver(caster, target, data)
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
	-- 1100040031
	self:OwnerAddBuffCount(SkillEffect[1100040031], caster, self.card, data, 1100040030,1,12)
end
-- 行动结束
function Skill1100040031:OnActionOver(caster, target, data)
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
	-- 1100040014
	if self:Rand(6000) then
		self:AddBuff(SkillEffect[1100040014], caster, target, data, 1100040014)
	end
end
