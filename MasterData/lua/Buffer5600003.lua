-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5600003 = oo.class(BuffBase)
function Buffer5600003:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5600003:OnCreate(caster, target)
	-- 336206
	self:AddMaxHpPercent(BufferEffect[336206], self.caster, self.card, nil, 0.95)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 4913
	self:AddValue(BufferEffect[4913], self.caster, self.card, nil, "LimitDamage",-0.3,-0.3,0)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 4914
	self:AddAttr(BufferEffect[4914], self.caster, self.card, nil, "bedamage2",-0.3)
end
