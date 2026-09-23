-- 獲得100能量值
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer999999003 = oo.class(BuffBase)
function Buffer999999003:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer999999003:OnCreate(caster, target)
	-- 999999003
	self:AddNp(BufferEffect[999999003], self.caster, target or self.owner, nil,100)
end
