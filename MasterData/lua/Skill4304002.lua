-- 秩序执行
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill4304002 = oo.class(SkillBase)
function Skill4304002:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill4304002:OnActionBegin(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 4304002
	if self:Rand(5000) then
		self:AddBuff(SkillEffect[4304002], caster, caster, data, 4802,1)
	end
end
