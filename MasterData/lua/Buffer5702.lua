-- 受到修復弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5702 = oo.class(BuffBase)
function Buffer5702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5702:OnCreate(caster, target)
	-- 5702
	self:AddAttr(BufferEffect[5702], self.caster, target or self.owner, nil,"becure",-0.2)
end
