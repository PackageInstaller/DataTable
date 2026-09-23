-- 修復增益
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3308 = oo.class(BuffBase)
function Buffer3308:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer3308:OnCreate(caster, target)
	-- 3308
	self:AddAttr(BufferEffect[3308], self.caster, target or self.owner, nil,"cure",0.8)
end
