-- 攻擊強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer911400301 = oo.class(BuffBase)
function Buffer911400301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer911400301:OnCreate(caster, target)
	-- 911400301
	self:AddAttrPercent(BufferEffect[911400301], self.caster, self.card, nil, "attack",0.05*self.nCount)
end
