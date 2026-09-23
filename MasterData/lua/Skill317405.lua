-- 利锋之影
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill317405 = oo.class(SkillBase)
function Skill317405:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill317405:OnBefourHurt(caster, target, data)
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
	-- 8481
	local count81 = SkillApi:BuffCount(self, caster, target,2,3,4300201)
	-- 8169
	if SkillJudger:Greater(self, caster, target, true,count81,0) then
	else
		return
	end
	-- 8202
	if SkillJudger:IsNormal(self, caster, target, true) then
	else
		return
	end
	-- 317405
	self:AddTempAttr(SkillEffect[317405], caster, self.card, data, "damage",0.5)
end
