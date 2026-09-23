-- 防禦增加
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer923700501 = oo.class(BuffBase)
function Buffer923700501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer923700501:OnCreate(caster, target)
	-- 923700501
	self:AddAttrPercent(BufferEffect[923700501], self.caster, self.card, nil, "defense",0.05*self.nCount)
end
