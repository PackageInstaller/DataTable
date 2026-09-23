-- 甘泉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer304500203 = oo.class(BuffBase)
function Buffer304500203:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer304500203:OnCreate(caster, target)
	-- 304500203
	self:AddAttr(BufferEffect[304500203], self.caster, target or self.owner, nil,"attack",900)
end
