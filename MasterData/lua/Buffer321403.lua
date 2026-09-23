-- 修復增益
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer321403 = oo.class(BuffBase)
function Buffer321403:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer321403:OnCreate(caster, target)
	-- 321403
	self:AddAttr(BufferEffect[321403], self.caster, target or self.owner, nil,"cure",0.2)
end
