-- 淨化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer802200401 = oo.class(BuffBase)
function Buffer802200401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer802200401:OnCreate(caster, target)
	-- 802200401
	self:DelBuffQuality(BufferEffect[802200401], self.caster, target or self.owner, nil,2,3)
	-- 802200402
	self:Cure(BufferEffect[802200402], self.caster, target or self.owner, nil,8,0.2)
end
