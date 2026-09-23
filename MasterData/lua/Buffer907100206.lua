-- 死神標記
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer907100206 = oo.class(BuffBase)
function Buffer907100206:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer907100206:OnRoundBegin(caster, target)
	-- 6104
	self:ImmuneBufferGroup(BufferEffect[6104], self.caster, target or self.owner, nil,1)
end
-- 行动结束
function Buffer907100206:OnActionOver(caster, target)
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
	-- 4705107
	self:Cure(BufferEffect[4705107], self.caster, self.card, nil, 4,0.3)
end
-- 创建时
function Buffer907100206:OnCreate(caster, target)
	-- 8455
	local c55 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,47005)
	-- 4705105
	self:AddAttrPercent(BufferEffect[4705105], self.caster, self.card, nil, "attack",0.15+0.05*c55)
end
