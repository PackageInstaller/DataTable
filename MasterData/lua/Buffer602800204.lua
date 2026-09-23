-- 王刃
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer602800204 = oo.class(BuffBase)
function Buffer602800204:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer602800204:OnCreate(caster, target)
	-- 602800204
	self:AddAttrPercent(BufferEffect[602800204], self.caster, target or self.owner, nil,"attack",0.13*self.nCount)
end
