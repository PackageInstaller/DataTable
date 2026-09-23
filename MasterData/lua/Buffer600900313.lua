-- 卡提娜修復表現
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer600900313 = oo.class(BuffBase)
function Buffer600900313:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer600900313:OnCreate(caster, target)
	-- 600900313
	self:Cure(BufferEffect[600900313], self.caster, self.card, nil, 9,0.70)
end
