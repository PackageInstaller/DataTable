-- 索尼子2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill339102 = oo.class(SkillBase)
function Skill339102:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill339102:OnRoundBegin(caster, target, data)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8756
	local count756 = SkillApi:BuffCount(self, caster, target,1,1,1)
	-- 8967
	if SkillJudger:Greater(self, caster, target, true,count756,0) then
	else
		return
	end
	-- 339102
	self:AddProgress(SkillEffect[339102], caster, caster, data, 200)
end
