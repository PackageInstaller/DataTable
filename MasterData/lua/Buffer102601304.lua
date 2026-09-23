-- 赤髓防禦750%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer102601304 = oo.class(BuffBase)
function Buffer102601304:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer102601304:OnCreate(caster, target)
	-- 8447
	local c47 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"defense")
	-- 102601304
	self:AddHp(BufferEffect[102601304], self.caster, target or self.owner, nil,math.floor(-c47*7.5))
end
