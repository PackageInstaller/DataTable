-- 力場殘留
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4102101 = oo.class(BuffBase)
function Buffer4102101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer4102101:OnBefourHurt(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8221
	if SkillJudger:IsDamageType(self, self.caster, target, true,2) then
	else
		return
	end
	-- 8447
	local c47 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"defense")
	-- 4102101
	self:AddTempAttr(BufferEffect[4102101], self.caster, self.caster, nil, "damage",-(0.1+c47/10000))
end
