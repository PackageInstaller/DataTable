-- 尖兵
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer303000201 = oo.class(BuffBase)
function Buffer303000201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer303000201:OnRoundBegin(caster, target)
	-- 6107
	self:ImmuneRetreat(BufferEffect[6107], self.caster, target or self.owner, nil,nil)
	-- 6128
	self:ImmuneAddProgress(BufferEffect[6128], self.caster, target or self.owner, nil,nil)
end
-- 行动结束
function Buffer303000201:OnActionOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8262
	if SkillJudger:IsCallSkill(self, self.caster, target, true) then
	else
		return
	end
	-- 303000206
	self:AddSp(BufferEffect[303000206], self.caster, self.card, nil, 10)
end
-- 创建时
function Buffer303000201:OnCreate(caster, target)
	-- 6107
	self:ImmuneRetreat(BufferEffect[6107], self.caster, target or self.owner, nil,nil)
	-- 6128
	self:ImmuneAddProgress(BufferEffect[6128], self.caster, target or self.owner, nil,nil)
	-- 303000201
	self:AddAttrPercent(BufferEffect[303000201], self.caster, self.card, nil, "attack",0.05)
end
