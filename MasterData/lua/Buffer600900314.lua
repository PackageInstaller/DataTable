-- 卡提娜修復表現
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer600900314 = oo.class(BuffBase)
function Buffer600900314:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer600900314:OnCreate(caster, target)
	-- 600900314
	self:Cure(BufferEffect[600900314], self.caster, self.card, nil, 9,0.90)
end
