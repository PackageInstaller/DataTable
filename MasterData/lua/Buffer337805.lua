-- 小公主
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337805 = oo.class(BuffBase)
function Buffer337805:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 死亡时
function Buffer337805:OnDeath(caster, target)
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 334215
	self:AddAttrPercent(BufferEffect[334215], self.caster, self.creater, nil, "attack",-0.10)
end
-- 创建时
function Buffer337805:OnCreate(caster, target)
	-- 337805
	self:AddAttrPercent(BufferEffect[337805], self.caster, self.creater, nil, "attack",0.10)
end
