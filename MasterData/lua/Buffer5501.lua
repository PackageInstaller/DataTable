-- 狀態命中弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5501 = oo.class(BuffBase)
function Buffer5501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5501:OnCreate(caster, target)
	-- 5501
	self:AddAttr(BufferEffect[5501], self.caster, target or self.owner, nil,"hit",-0.05)
end
