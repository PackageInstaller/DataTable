-- 機動提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer320005 = oo.class(BuffBase)
function Buffer320005:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer320005:OnCreate(caster, target)
	-- 8451
	local c51 = SkillApi:BuffCount(self, self.caster, target or self.owner,1,1,2)
	-- 320005
	self:AddAttr(BufferEffect[320005], self.caster, target or self.owner, nil,"speed",c51*10)
end
