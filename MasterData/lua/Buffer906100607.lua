-- 鋼體
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer906100607 = oo.class(BuffBase)
function Buffer906100607:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer906100607:OnCreate(caster, target)
	-- 8495
	local c95 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"maxhp")
	-- 906100607
	self:OwnerAddBuff(BufferEffect[906100607], self.caster, self.card, nil, 2119)
end
