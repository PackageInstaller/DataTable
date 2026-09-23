-- 釣魚佬
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer912101301 = oo.class(BuffBase)
function Buffer912101301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer912101301:OnCreate(caster, target)
	-- 912101301
	self:AddAttr(BufferEffect[912101301], self.caster, self.card, nil, "speed",175)
end
