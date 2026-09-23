-- 傷害提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer330803 = oo.class(BuffBase)
function Buffer330803:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer330803:OnCreate(caster, target)
	-- 330803
	self:AddAttr(BufferEffect[330803], self.caster, self.card, nil, "damage",0.15)
end
