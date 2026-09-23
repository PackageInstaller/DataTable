-- 闪翼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4501301 = oo.class(SkillBase)
function Skill4501301:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill4501301:OnActionOver2(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, caster, target, true) then
	else
		return
	end
	-- 4501301
	self:AddBuff(SkillEffect[4501301], caster, self.card, data, 4501301)
end
