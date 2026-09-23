-- 赤溟2
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Skill333905 = oo.class(SkillBase)
function Skill333905:Init(skillID, card)
	SkillBase.Init(self, skillID, card)
end
-- 加buff时
function Skill333905:OnAddBuff(caster, target, data, buffer)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8256
	if SkillJudger:IsCtrlBuff(buffer or self, caster, target, true) then
	else
		return
	end
	-- 333915
	self:AddBuffCount(SkillEffect[333915], caster, self.card, data, 304900101,1,10)
	-- 8686
	local count686 = SkillApi:SkillLevel(self, caster, target,3,3049001)
	-- 333925
	if self:Rand(5000) then
		self:CallSkill(SkillEffect[333925], caster, target, data, 304900100+count686)
	end
end
-- 伤害前
function Skill333905:OnBefourHurt(caster, target, data)
	-- 8060
	if SkillJudger:CasterIsSelf(self, caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, caster, target, true) then
	else
		return
	end
	-- 8214
	if SkillJudger:IsTypeOf(self, caster, target, true,2) then
	else
		return
	end
	-- 333905
	self:AddTempAttr(SkillEffect[333905], caster, self.card, data, "damage",0.30)
end
