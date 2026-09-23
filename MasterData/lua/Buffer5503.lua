-- 狀態命中弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5503 = oo.class(BuffBase)
function Buffer5503:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5503:OnCreate(caster, target)
	-- 5503
	self:AddAttr(BufferEffect[5503], self.caster, target or self.owner, nil,"hit",-0.15)
end
