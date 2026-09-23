-- 克拉肯
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill911200401 = oo.class(SkillBase)
function Skill911200401:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 攻击结束
function Skill911200401:OnAttackOver(caster, target, data)
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
	-- 911200401
	if self:Rand(2000) then
		self:BeatBack(SkillEffect[911200401], caster, target, data, 911200301)
	end
end
