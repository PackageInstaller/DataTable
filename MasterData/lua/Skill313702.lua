-- 天赋效果313702
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill313702 = oo.class(SkillBase)
function Skill313702:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 行动开始
function Skill313702:OnActionBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8072
	if SkillJudger:TargetIsTeammate(self, caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, caster, target, true) then
	else
		return
	end
	-- 313702
	self:SetProtect(SkillEffect[313702], caster, self.card, data, 1500)
end
