-- 换皮虚蚀显化者 2技能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913230201 = oo.class(SkillBase)
function Skill913230201:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动结束
function Skill913230201:OnActionOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 913210201
	local targets = SkillFilter:All(self, caster, target, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[913210201], caster, target, data, 4004)
	end
end
