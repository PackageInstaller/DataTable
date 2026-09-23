-- 守護
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer102300304 = oo.class(BuffBase)
function Buffer102300304:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer102300304:OnBefourHurt(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8201
	if SkillJudger:IsSingle(self, self.caster, target, true) then
	else
		return
	end
	-- 102300304
	self:AddTempAttr(BufferEffect[102300304], self.caster, self.caster, nil, "damage",-0.25)
end
