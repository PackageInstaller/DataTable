-- 琶音天赋4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill329705 = oo.class(SkillBase)
function Skill329705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill329705:OnRoundBegin(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8653
	local count653 = SkillApi:BuffCount(self, caster, target,1,4,201100201)
	-- 8856
	if SkillJudger:Greater(self, caster, target, true,count653,0) then
	else
		return
	end
	-- 329705
	if self:Rand(10000) then
		self:AddSp(SkillEffect[329705], caster, caster, data, 15)
	end
end
