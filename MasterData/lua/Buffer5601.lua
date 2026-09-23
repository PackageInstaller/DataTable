-- 效果抵抗弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5601 = oo.class(BuffBase)
function Buffer5601:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer5601:OnCreate(caster, target)
	-- 5601
	self:AddAttr(BufferEffect[5601], self.caster, target or self.owner, nil,"resist",-0.05)
end
