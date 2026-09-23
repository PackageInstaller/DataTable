-- 受到修復弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5701 = oo.class(BuffBase)
function Buffer5701:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5701:OnCreate(caster, target)
	-- 5701
	self:AddAttr(BufferEffect[5701], self.caster, target or self.owner, nil,"becure",-0.1)
end
