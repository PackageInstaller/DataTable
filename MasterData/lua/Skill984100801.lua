-- 小怪被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill984100801 = oo.class(SkillBase)
function Skill984100801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill984100801:OnActionOver(caster, target, data)
	-- 8065
	if SkillJudger:CasterIsSummoner(self, caster, target, true) then
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
	-- 984100804
	self:CallOwnerSkill(SkillEffect[984100804], caster, target, data, 940300201)
end
-- 死亡时
function Skill984100801:OnDeath(caster, target, data)
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 984100801
	self:AddBuffCount(SkillEffect[984100801], caster, caster, data, 21614,1,10)
end
