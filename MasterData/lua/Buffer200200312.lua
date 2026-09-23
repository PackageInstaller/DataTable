-- 暴傷強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200200312 = oo.class(BuffBase)
function Buffer200200312:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer200200312:OnCreate(caster, target)
	-- 200200312
	self:AddAttr(BufferEffect[200200312], self.caster, target or self.owner, nil,"crit",0.15)
end
