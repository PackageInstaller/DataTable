-- 裝甲武裝
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer913300101 = oo.class(BuffBase)
function Buffer913300101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer913300101:OnCreate(caster, target)
	-- 913300101
	if self:Rand(5000) then
		self:AddTempAttrPercent(BufferEffect[913300101], self.caster, self.card, nil, "defense",0.2)
	end
end
