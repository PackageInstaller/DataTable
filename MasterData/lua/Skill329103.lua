-- 丝卡蒂天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill329103 = oo.class(SkillBase)
function Skill329103:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击开始
function Skill329103:OnAttackBegin(caster, target, data)
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
	-- 8650
	local count650 = SkillApi:GetAttr(self, caster, target,2,"resist")
	-- 8852
	if SkillJudger:GreaterEqual(self, caster, target, true,count650,0.3) then
	else
		return
	end
	-- 329103
	self:AddBuff(SkillEffect[329103], caster, target, data, 320403)
end
