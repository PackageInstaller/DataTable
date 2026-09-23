-- 第五章小怪被动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill110008010 = oo.class(SkillBase)
function Skill110008010:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill110008010:OnBefourHurt(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 110008010
	self:AddTempAttr(SkillEffect[110008010], caster, caster, data, "damage",0.1)
end
-- 入场时
function Skill110008010:OnBorn(caster, target, data)
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
	-- 110008011
	self:AddUplimitBuff(SkillEffect[110008011], caster, self.card, data, 3,3,4104,1,4104)
end
