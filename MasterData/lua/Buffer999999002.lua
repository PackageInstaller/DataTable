-- 獲得50能量值
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer999999002 = oo.class(BuffBase)
function Buffer999999002:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer999999002:OnCreate(caster, target)
	-- 999999002
	self:AddNp(BufferEffect[999999002], self.caster, target or self.owner, nil,50)
end
