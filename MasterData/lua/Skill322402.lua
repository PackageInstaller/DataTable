-- 行动推进
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill322402 = oo.class(SkillBase)
function Skill322402:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill322402:OnRoundBegin(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8496
	local count96 = SkillApi:BuffCount(self, caster, target,3,1,1)
	-- 8193
	if SkillJudger:Greater(self, caster, target, true,count96,0) then
	else
		return
	end
	-- 322402
	self:AddProgress(SkillEffect[322402], caster, self.card, data, 200)
end
