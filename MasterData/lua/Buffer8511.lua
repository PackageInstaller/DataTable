-- 被汲取攻擊
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer8511 = oo.class(BuffBase)
function Buffer8511:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer8511:OnCreate(caster, target)
	-- 8407
	local gj1 = SkillApi:GetValue(self, self.caster, target or self.owner,4,"gj1")
	-- 8511
	self:AddAttr(BufferEffect[8511], self.caster, target or self.owner, nil,"attack",-gj1*0.2)
end
