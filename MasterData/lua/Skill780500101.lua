-- 奥西里斯1
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780500101 = oo.class(SkillBase)
function Skill780500101:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780500101:DoSkill(caster, target, data)
	-- 12002
	self.order = self.order + 1
	self:DamageLight(SkillEffect[12002], caster, target, data, 0.5,2)
end
-- 行动结束
function Skill780500101:OnActionOver(caster, target, data)
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
	-- 780500101
	self:AddProgress(SkillEffect[780500101], caster, self.card, data, 100)
	-- 780500106
	self:AddBuffCount(SkillEffect[780500106], caster, self.card, data, 780500101,1,999)
end
-- 回合开始时
function Skill780500101:OnRoundBegin(caster, target, data)
	-- 780500111
	self:DelBufferForce(SkillEffect[780500111], caster, self.card, data, 780500106)
	-- 8795
	local count795 = SkillApi:BuffCount(self, caster, target,1,4,780500301)
	-- 780500319
	if SkillJudger:Greater(self, caster, target, true,count795,0) then
	else
		return
	end
	-- 780500112
	self:AddBuff(SkillEffect[780500112], caster, self.card, data, 780500106)
end
