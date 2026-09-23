-- 小公主
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer337802 = oo.class(BuffBase)
function Buffer337802:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 死亡时
function Buffer337802:OnDeath(caster, target)
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 334212
	self:AddAttrPercent(BufferEffect[334212], self.caster, self.creater, nil, "attack",-0.04)
end
-- 创建时
function Buffer337802:OnCreate(caster, target)
	-- 337802
	self:AddAttrPercent(BufferEffect[337802], self.caster, self.creater, nil, "attack",0.04)
end
