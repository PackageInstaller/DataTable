-- 態勢崩潰
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer303000305 = oo.class(BuffBase)
function Buffer303000305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer303000305:OnBefourHurt(caster, target)
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
	-- 8262
	if SkillJudger:IsCallSkill(self, self.caster, target, true) then
	else
		return
	end
	-- 303000305
	self:AddTempAttr(BufferEffect[303000305], self.caster, self.card, nil, "bedamage",0.05*self.nCount)
end
-- 攻击结束
function Buffer303000305:OnAttackOver(caster, target)
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
	-- 8263
	if SkillJudger:IsCallSkill(self, self.caster, target, false) then
	else
		return
	end
	-- 303000315
	if self:Rand(300*self.nCount) then
		self:AddProgress(BufferEffect[303000315], self.caster, self.card, nil, -100)
	end
end
