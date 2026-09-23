-- 能量指數
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer304800101 = oo.class(BuffBase)
function Buffer304800101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer304800101:OnCreate(caster, target)
	-- 304800101
	self:AddAttrPercent(BufferEffect[304800101], self.caster, self.card, nil, "attack",0.05*self.nCount)
	-- 304800102
	self:AddAttr(BufferEffect[304800102], self.caster, self.card, nil, "bedamage",-0.05*self.nCount)
end
