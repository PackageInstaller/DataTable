-- 狂热
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4302002 = oo.class(SkillBase)
function Skill4302002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 伤害前
function Skill4302002:OnBefourHurt(caster, target, data)
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
	-- 8441
	local count41 = SkillApi:BuffCount(self, caster, target,2,1,15)
	-- 8124
	if SkillJudger:Greater(self, caster, self.card, true,count41,0) then
	else
		return
	end
	-- 4302002
	self:LimitDamage(SkillEffect[4302002], caster, target, data, 0.03,0.36)
	-- 4302006
	self:ShowTips(SkillEffect[4302006], caster, self.card, data, 2,"狂热",true,4302006)
end
