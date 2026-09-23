-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer331202 = oo.class(BuffBase)
function Buffer331202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer331202:OnCreate(caster, target)
	-- 331202
	self:AddTempAttr(BufferEffect[331202], self.caster, self.card, nil, "damage",0.04*self.nCount)
end
