-- 紧急避险
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill933700401 = oo.class(SkillBase)
function Skill933700401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill933700401:OnActionBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, caster, target, true) then
	else
		return
	end
	-- 4402906
	self:HpProtect(SkillEffect[4402906], caster, self.card, data, 0.7)
end
