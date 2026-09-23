-- 穿甲I级
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill20101 = oo.class(SkillBase)
function Skill20101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill20101:OnBefourHurt(caster, target, data)
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
	-- 20101
	self:AddTempAttrPercent(SkillEffect[20101], caster, target, data, "defense",-0.15)
	-- 201010
	self:ShowTips(SkillEffect[201010], caster, self.card, data, 2,"穿甲",true,201010)
end
