-- 余音
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4200903 = oo.class(SkillBase)
function Skill4200903:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4200903:OnBefourHurt(caster, target, data)
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 8475
	local count75 = SkillApi:BuffCount(self, caster, target,2,4,20090)
	-- 8168
	if SkillJudger:Greater(self, caster, target, true,count75,0) then
	else
		return
	end
	-- 4200903
	self:AddTempAttr(SkillEffect[4200903], caster, caster, data, "damage",-0.08)
	-- 4200906
	self:ShowTips(SkillEffect[4200906], caster, self.card, data, 2,"余音",true,4200906)
end
