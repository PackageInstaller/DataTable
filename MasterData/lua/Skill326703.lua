-- 超速命中
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill326703 = oo.class(SkillBase)
function Skill326703:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束2
function Skill326703:OnActionOver2(caster, target, data)
	-- 8064
	if SkillJudger:CasterIsSummon(self, caster, target, true) then
	else
		return
	end
	-- 326703
	if self:Rand(4000) then
		self:AddUplimitBuff(SkillEffect[326703], caster, caster, data, 1,3,4800601,5,4800601)
	end
end
