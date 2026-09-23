-- 傷害弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5806 = oo.class(BuffBase)
function Buffer5806:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5806:OnCreate(caster, target)
	-- 5806
	self:AddAttr(BufferEffect[5806], self.caster, target or self.owner, nil,"damage",-0.3)
end
