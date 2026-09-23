-- 秩序执行
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4304005 = oo.class(SkillBase)
function Skill4304005:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill4304005:OnActionBegin(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4304005
	if self:Rand(8000) then
		self:AddBuff(SkillEffect[4304005], caster, caster, data, 4802,1)
	end
end
