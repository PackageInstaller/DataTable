-- 被汲取暴擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer8513 = oo.class(BuffBase)
function Buffer8513:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer8513:OnCreate(caster, target)
	-- 8409
	local bj1 = SkillApi:GetValue(self, self.caster, target or self.owner,4,"bj1")
	-- 8513
	self:AddAttr(BufferEffect[8513], self.caster, target or self.owner, nil,"crit_rate",-bj1*0.3)
end
