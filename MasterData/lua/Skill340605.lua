-- 奥西里斯4
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill340605 = oo.class(SkillBase)
function Skill340605:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 回合开始时
function Skill340605:OnRoundBegin(caster, target, data)
	-- 340605
	self:DelBufferForce(SkillEffect[340605], caster, self.card, data, 340605)
	-- 8795
	local count795 = SkillApi:BuffCount(self, caster, target,1,4,780500301)
	-- 780500319
	if SkillJudger:Greater(self, caster, target, true,count795,0) then
	else
		return
	end
	-- 340610
	self:AddBuff(SkillEffect[340610], caster, self.card, data, 340605)
end
