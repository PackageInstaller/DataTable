-- 受到修復強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4705 = oo.class(BuffBase)
function Buffer4705:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4705:OnCreate(caster, target)
	-- 4705
	self:AddAttr(BufferEffect[4705], self.caster, target or self.owner, nil,"becure",0.5)
end
