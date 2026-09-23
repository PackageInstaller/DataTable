-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6200019 = oo.class(BuffBase)
function Buffer6200019:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6200019:OnCreate(caster, target)
	-- 4320
	self:AddAttr(BufferEffect[4320], self.caster, self.card, nil, "crit_rate",0.05*self.nCount)
	-- 4321
	self:AddAttr(BufferEffect[4321], self.caster, self.card, nil, "damage",0.03*self.nCount)
end
