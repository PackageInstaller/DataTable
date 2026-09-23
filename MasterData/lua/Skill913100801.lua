-- 人马机神20操作数进行转换阶段
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill913100801 = oo.class(SkillBase)
function Skill913100801:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 战斗开始
function Skill913100801:OnStart(caster, target, data)
	-- 913100803
	self:SetInvincible(SkillEffect[913100803], caster, target, data, 2,1,999999999,20)
end
-- 行动结束
function Skill913100801:OnActionOver(caster, target, data)
	-- 913100805
	local angler100 = SkillApi:GetTurnCount(self, caster, self.card,nil)
	-- 913100806
	if SkillJudger:GreaterEqual(self, caster, target, true,angler100,20) then
	else
		return
	end
	-- 913100808
	self:CallOwnerSkill(SkillEffect[913100808], caster, self.card, data, 913100802)
	-- 913100804
	self:SetInvincible(SkillEffect[913100804], caster, target, data, 2,2,999999999,30)
end
-- 入场时
function Skill913100801:OnBorn(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 913110811
	self:AddBuff(SkillEffect[913110811], caster, self.card, data, 913110811)
end
