-- 傷害提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer330804 = oo.class(BuffBase)
function Buffer330804:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer330804:OnCreate(caster, target)
	-- 330804
	self:AddAttr(BufferEffect[330804], self.caster, self.card, nil, "damage",0.20)
end
