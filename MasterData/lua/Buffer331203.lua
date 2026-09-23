-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer331203 = oo.class(BuffBase)
function Buffer331203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer331203:OnCreate(caster, target)
	-- 331203
	self:AddTempAttr(BufferEffect[331203], self.caster, self.card, nil, "damage",0.06*self.nCount)
end
