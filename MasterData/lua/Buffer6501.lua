-- 水能
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer6501 = oo.class(BuffBase)
function Buffer6501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer6501:OnCreate(caster, target)
	-- 6501
	self:AddAttrPercent(BufferEffect[6501], self.caster, target or self.owner, nil,"attack",0.12)
end
