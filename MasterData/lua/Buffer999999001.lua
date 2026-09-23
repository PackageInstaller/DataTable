-- 獲得25能量值
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer999999001 = oo.class(BuffBase)
function Buffer999999001:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer999999001:OnCreate(caster, target)
	-- 999999001
	self:AddNp(BufferEffect[999999001], self.caster, target or self.owner, nil,25)
end
