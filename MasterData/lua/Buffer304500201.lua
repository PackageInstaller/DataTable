-- 甘泉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer304500201 = oo.class(BuffBase)
function Buffer304500201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer304500201:OnCreate(caster, target)
	-- 304500201
	self:AddAttr(BufferEffect[304500201], self.caster, target or self.owner, nil,"attack",300)
end
