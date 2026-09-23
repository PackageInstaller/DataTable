-- 不顯示
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer334201 = oo.class(BuffBase)
function Buffer334201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 死亡时
function Buffer334201:OnDeath(caster, target)
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 334211
	self:AddAttrPercent(BufferEffect[334211], self.caster, self.creater, nil, "attack",-0.02)
end
-- 创建时
function Buffer334201:OnCreate(caster, target)
	-- 334201
	self:AddAttrPercent(BufferEffect[334201], self.caster, self.creater, nil, "attack",0.02)
end
