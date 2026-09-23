-- 欲壑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4600512 = oo.class(BuffBase)
function Buffer4600512:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer4600512:OnBefourHurt(caster, target)
	-- 4600512
	self:AddTempAttr(BufferEffect[4600512], self.caster, self.card, nil, "damage",0.1*self.nCount)
end
