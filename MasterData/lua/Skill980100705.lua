-- 启动4（回血添加启动标记）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980100705 = oo.class(SkillBase)
function Skill980100705:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 治疗时
function Skill980100705:OnCure(caster, target, data)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 980100728
	self:AddBuff(SkillEffect[980100728], caster, self.card, data, 980100702)
end
-- 行动结束2
function Skill980100705:OnActionOver2(caster, target, data)
	-- 980100731
	local count980100703 = SkillApi:GetCount(self, caster, target,3,980100703)
	-- 980100730
	if SkillJudger:GreaterEqual(self, caster, target, true,count980100703,8) then
	else
		return
	end
	-- 980100729
	self:AddBuffCount(SkillEffect[980100729], caster, self.card, data, 980100703,-8,8)
	-- 980100720
	self:AddBuff(SkillEffect[980100720], caster, self.card, data, 980100720,1)
	-- 980100723
	self:AlterBufferByGroup(SkillEffect[980100723], caster, self.card, data, 2,1)
	-- 980100721
	self:AddProgress(SkillEffect[980100721], caster, self.card, data, 1020)
end
