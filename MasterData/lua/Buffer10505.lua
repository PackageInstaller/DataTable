-- 命中強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer10505 = oo.class(BuffBase)
function Buffer10505:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer10505:OnCreate(caster, target)
	-- 4505
	self:AddAttr(BufferEffect[4505], self.caster, target or self.owner, nil,"hit",0.25)
end
