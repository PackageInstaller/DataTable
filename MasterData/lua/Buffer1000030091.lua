-- 造成的傷害提高20%，持續1回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030091 = oo.class(BuffBase)
function Buffer1000030091:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1000030091:OnBefourHurt(caster, target)
	-- 1000030091
	self:AddAttrPercent(BufferEffect[1000030091], self.caster, self.card, nil, "damage",0.2)
end
