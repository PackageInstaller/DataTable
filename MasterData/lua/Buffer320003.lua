-- 機動提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer320003 = oo.class(BuffBase)
function Buffer320003:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer320003:OnCreate(caster, target)
	-- 8451
	local c51 = SkillApi:BuffCount(self, self.caster, target or self.owner,1,1,2)
	-- 320003
	self:AddAttr(BufferEffect[320003], self.caster, target or self.owner, nil,"speed",c51*6)
end
