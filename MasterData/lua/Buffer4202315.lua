-- 漂變攻擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4202315 = oo.class(BuffBase)
function Buffer4202315:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4202315:OnCreate(caster, target)
	-- 8495
	local c95 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"maxhp")
	-- 4202315
	self:AddAttr(BufferEffect[4202315], self.caster, self.card, nil, "attack",math.floor(0.1*c95))
end
