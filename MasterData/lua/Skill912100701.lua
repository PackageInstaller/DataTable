-- 钓鱼佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill912100701 = oo.class(SkillBase)
function Skill912100701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill912100701:DoSkill(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 912102411
	if SkillJudger:HasBuff(self, caster, target, true,3,912102410) then
	else
		return
	end
	-- 912100701
	self.order = self.order + 1
	self:AddBuff(SkillEffect[912100701], caster, target, data, 912100701)
	-- 912100703
	self.order = self.order + 1
	self:DelBufferGroup(SkillEffect[912100703], caster, self.card, data, 3,2)
end
