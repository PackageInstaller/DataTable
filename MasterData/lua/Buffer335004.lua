-- 暴擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer335004 = oo.class(BuffBase)
function Buffer335004:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer335004:OnCreate(caster, target)
	-- 8484
	local c84 = SkillApi:GetAttr(self, self.caster, target or self.owner,6,"crit")
	-- 335004
	self:AddAttr(BufferEffect[335004], self.caster, self.card, nil, "crit",c84*0.30)
end
