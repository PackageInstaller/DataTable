-- 行動提前buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer914100508 = oo.class(BuffBase)
function Buffer914100508:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer914100508:OnActionOver2(caster, target)
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
	-- 8145
	if SkillJudger:OwnerPercentHp(self, self.caster, target, false,0.5) then
	else
		return
	end
	-- 914100508
	self:AddProgress(BufferEffect[914100508], self.caster, self.card, nil, 1000)
	-- 914100509
	self:DelBufferForce(BufferEffect[914100509], self.caster, self.card, nil, 914100508)
end
