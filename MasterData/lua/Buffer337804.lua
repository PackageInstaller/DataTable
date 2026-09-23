-- 小公主
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337804 = oo.class(BuffBase)
function Buffer337804:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 死亡时
function Buffer337804:OnDeath(caster, target)
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 334214
	self:AddAttrPercent(BufferEffect[334214], self.caster, self.creater, nil, "attack",-0.08)
end
-- 创建时
function Buffer337804:OnCreate(caster, target)
	-- 337804
	self:AddAttrPercent(BufferEffect[337804], self.caster, self.creater, nil, "attack",0.08)
end
