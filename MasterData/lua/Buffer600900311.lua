-- 卡提娜修復表現
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer600900311 = oo.class(BuffBase)
function Buffer600900311:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer600900311:OnCreate(caster, target)
	-- 600900311
	self:Cure(BufferEffect[600900311], self.caster, self.card, nil, 9,0.50)
end
