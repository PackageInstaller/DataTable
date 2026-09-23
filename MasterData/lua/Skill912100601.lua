-- 钓鱼佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill912100601 = oo.class(SkillBase)
function Skill912100601:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
function Skill912100601:CanSummon()
	return self.card:CanSummon(50601411,3,{3,1},{progress=500},nil,nil)
end
-- 执行技能
function Skill912100601:DoSkill(caster, target, data)
	-- 912100501
	self.order = self.order + 1
	self:SummonTeammate(SkillEffect[912100501], caster, target, data, 50601411,3,{3,1},{progress=500},nil,nil)
	-- 912102400
	self.order = self.order + 1
	self:SetInvincible(SkillEffect[912102400], caster, target, data, 4,4,99999999,50)
	-- 912102410
	self.order = self.order + 1
	self:AddBuff(SkillEffect[912102410], caster, self.card, data, 912102410)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8200
	if SkillJudger:IsCurrSkill(self, caster, target, true) then
	else
		return
	end
	-- 912100601
	self.order = self.order + 1
	self:AddBuff(SkillEffect[912100601], caster, self.card, data, 912100101)
end
