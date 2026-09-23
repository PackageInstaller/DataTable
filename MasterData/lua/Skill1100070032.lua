-- 碎星阵营角色，角色使怪物控制时，敌方防御下降10%，最高10层
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100070032 = oo.class(SkillBase)
function Skill1100070032:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill1100070032:OnAddBuff(caster, target, data, buffer)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 9742
	if SkillJudger:IsCtrlBuff(buffer or self, caster, target, true,1) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 1100070032
	self:AddBuffCount(SkillEffect[1100070032], caster, target, data, 1100070032,1,10)
end
