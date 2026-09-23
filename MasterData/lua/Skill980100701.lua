-- 启动
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill980100701 = oo.class(SkillBase)
function Skill980100701:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill980100701:OnAddBuff(caster, target, data, buffer)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8258
	if SkillJudger:IsCtrlBuff(buffer or self, caster, target, true,2) then
	else
		return
	end
	-- 980100701
	self:AddBuffCount(SkillEffect[980100701], caster, self.card, data, 980100701,1,10)
end
-- 行动结束2
function Skill980100701:OnActionOver2(caster, target, data)
	-- 8654
	local count654 = SkillApi:GetCount(self, caster, target,3,980100701)
	-- 8860
	if SkillJudger:GreaterEqual(self, caster, target, true,count654,10) then
	else
		return
	end
	-- 980100702
	self:AddBuffCount(SkillEffect[980100702], caster, self.card, data, 980100701,-10,10)
	-- 980100703
	self:CallOwnerSkill(SkillEffect[980100703], caster, self.card, data, 980101001)
end
