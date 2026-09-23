-- 奥西里斯4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340603 = oo.class(SkillBase)
function Skill340603:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill340603:OnRoundBegin(caster, target, data)
	-- 340603
	self:DelBufferForce(SkillEffect[340603], caster, self.card, data, 340603)
	-- 8795
	local count795 = SkillApi:BuffCount(self, caster, target,1,4,780500301)
	-- 780500319
	if SkillJudger:Greater(self, caster, target, true,count795,0) then
	else
		return
	end
	-- 340608
	self:AddBuff(SkillEffect[340608], caster, self.card, data, 340603)
end
