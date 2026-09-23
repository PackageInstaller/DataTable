-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984010202 = oo.class(BuffBase)
function Buffer984010202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer984010202:OnCreate(caster, target)
	-- 984010202
	self:AddAttrPercent(BufferEffect[984010202], self.caster, self.card, nil, "attack",0.1*self.nCount)
end
