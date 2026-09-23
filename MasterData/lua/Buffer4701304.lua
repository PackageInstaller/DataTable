-- 耐久上限強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4701304 = oo.class(BuffBase)
function Buffer4701304:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4701304:OnCreate(caster, target)
	-- 4701304
	self:AddMaxHpPercent(BufferEffect[4701304], self.caster, target or self.owner, nil,0.18)
end
