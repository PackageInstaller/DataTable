-- 高能核心
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill315601 = oo.class(SkillBase)
function Skill315601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill315601:OnActionBegin(caster, target, data)
	-- 8166
	if SkillJudger:CasterIsOwnSummon(self, caster, target, true) then
	else
		return
	end
	-- 315601
	self:AddBuff(SkillEffect[315601], caster, caster, data, 4002,1)
end
