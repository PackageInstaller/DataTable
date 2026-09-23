-- 平衡強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4919 = oo.class(BuffBase)
function Buffer4919:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer4919:OnBefourHurt(caster, target)
	-- 4919
	self:tFunc_4919_4920(caster, target)
	self:tFunc_4919_4921(caster, target)
end
function Buffer4919:tFunc_4919_4921(caster, target)
	-- 8064
	if SkillJudger:CasterIsSummon(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8262
	if SkillJudger:IsCallSkill(self, self.caster, target, true) then
	else
		return
	end
	-- 4921
	self:AddTempAttr(BufferEffect[4921], self.caster, self.card, nil, "bedamage2",0.3)
end
function Buffer4919:tFunc_4919_4920(caster, target)
	-- 8064
	if SkillJudger:CasterIsSummon(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8263
	if SkillJudger:IsCallSkill(self, self.caster, target, false) then
	else
		return
	end
	-- 4920
	self:AddTempAttr(BufferEffect[4920], self.caster, self.card, nil, "bedamage2",-0.5)
end
