-- 开局时，我方每存在一个角色，敌方减少2%血量（蓝色）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill1100020070 = oo.class(SkillBase)
function Skill1100020070:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 入场时
function Skill1100020070:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 1100020070
	local targets = SkillFilter:All(self, caster, target, 4)
	for i,target in ipairs(targets) do
		self:AddBuff(SkillEffect[1100020070], caster, target, data, 1100020070)
	end
end
