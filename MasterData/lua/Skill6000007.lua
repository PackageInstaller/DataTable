-- 刺蝽皮肤活动新增buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill6000007 = oo.class(SkillBase)
function Skill6000007:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill6000007:OnRoundBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 60000066
	self:CallOwnerSkill(SkillEffect[60000066], caster, caster, data, 503000105)
end
