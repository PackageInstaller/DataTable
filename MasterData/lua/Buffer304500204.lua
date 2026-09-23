-- 甘泉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer304500204 = oo.class(BuffBase)
function Buffer304500204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer304500204:OnCreate(caster, target)
	-- 304500204
	self:AddAttr(BufferEffect[304500204], self.caster, target or self.owner, nil,"attack",1200)
end
