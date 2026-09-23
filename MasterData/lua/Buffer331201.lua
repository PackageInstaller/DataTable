-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer331201 = oo.class(BuffBase)
function Buffer331201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer331201:OnCreate(caster, target)
	-- 331201
	self:AddTempAttr(BufferEffect[331201], self.caster, self.card, nil, "damage",0.02*self.nCount)
end
