-- 淨化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer802200402 = oo.class(BuffBase)
function Buffer802200402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer802200402:OnCreate(caster, target)
	-- 802200403
	self:DelBuffQuality(BufferEffect[802200403], self.caster, target or self.owner, nil,2,3)
	-- 802200404
	self:Cure(BufferEffect[802200404], self.caster, target or self.owner, nil,3,2)
end
