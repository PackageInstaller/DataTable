-- 磷霧
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer402000101 = oo.class(BuffBase)
function Buffer402000101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer402000101:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8453
	local c53 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,44020)
	-- 8454
	local c54 = SkillApi:GetCount(self, self.caster, target or self.owner,3,402000101)
	-- 402000101
	self:LimitDamage(BufferEffect[402000101], self.caster, target or self.owner, nil,(1+c54)*c54*(1+(c53-1)*0.25)/200,1.5*(1+(c53-1)*0.25))
end
-- 行动结束2
function Buffer402000101:OnActionOver2(caster, target)
	-- 8454
	local c54 = SkillApi:GetCount(self, self.caster, target or self.owner,3,402000101)
	-- 8159
	if SkillJudger:Greater(self, self.caster, target, true,c54,5) then
	else
		return
	end
	-- 402000102
	self:OwnerAddBuffCount(BufferEffect[402000102], self.caster, self.card, nil, 402000101,-1,5)
	-- 8452
	local c52 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3202)
	-- 8452
	local c52 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3202)
	-- 8622
	if SkillJudger:Greater(self, self.caster, self.card, true,c52,0) then
	else
		return
	end
	-- 402000103
	self:LimitDamage(BufferEffect[402000103], self.caster, self.card, nil, 0.03*c52,0.3*c52)
end
