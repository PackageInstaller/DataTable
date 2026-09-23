-- 卡提那·联域3(OD)
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill780201302 = oo.class(SkillBase)
function Skill780201302:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 执行技能
function Skill780201302:DoSkill(caster, target, data)
	-- 780201302
	self.order = self.order + 1
	self:AddBuffCount(SkillEffect[780201302], caster, self.card, data, 780200302,25,999)
	-- 780201306
	self.order = self.order + 1
	self:AddBuff(SkillEffect[780201306], caster, self.card, data, 780201301)
end
-- 回合结束时
function Skill780201302:OnRoundOver(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8768
	local count768 = SkillApi:BuffCount(self, caster, target,3,4,780200301)
	-- 780201309
	if SkillJudger:Greater(self, caster, target, false,count768,0) then
	else
		return
	end
	-- 780201308
	self:DelBufferForce(SkillEffect[780201308], caster, self.card, data, 780200302)
end
