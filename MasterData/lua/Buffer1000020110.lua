-- 自身護盾被打爆時，獲得自身血量25%護盾值，每場戰鬥每個角色僅生效一次
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020110 = oo.class(BuffBase)
function Buffer1000020110:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer1000020110:OnActionOver(caster, target)
	-- 8218
	if SkillJudger:IsShieldDestroy(self, self.caster, target, true) then
	else
		return
	end
	-- 1000020114
	if SkillJudger:Less(self, self.caster, self.card, true,b001,1) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000020110
	self:AddBuff(BufferEffect[1000020110], self.caster, self.card, nil, 1000020111)
end
