-- 傷害提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer330805 = oo.class(BuffBase)
function Buffer330805:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer330805:OnCreate(caster, target)
	-- 330805
	self:AddAttr(BufferEffect[330805], self.caster, self.card, nil, "damage",0.25)
end
