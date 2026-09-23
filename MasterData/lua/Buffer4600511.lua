-- 欲壑
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4600511 = oo.class(BuffBase)
function Buffer4600511:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer4600511:OnBefourHurt(caster, target)
	-- 4600511
	self:AddTempAttr(BufferEffect[4600511], self.caster, self.card, nil, "damage",0.05*self.nCount)
end
