-- 穿甲III级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill20103 = oo.class(SkillBase)
function Skill20103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill20103:OnBefourHurt(caster, target, data)
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
	-- 8213
	if SkillJudger:IsCrit(self, caster, target, true) then
	else
		return
	end
	-- 20103
	self:AddTempAttrPercent(SkillEffect[20103], caster, target, data, "defense",-0.45)
	-- 201010
	self:ShowTips(SkillEffect[201010], caster, self.card, data, 2,"穿甲",true,201010)
end
