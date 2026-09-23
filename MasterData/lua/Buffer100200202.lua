-- 群山庇護
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer100200202 = oo.class(BuffBase)
function Buffer100200202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 死亡时
function Buffer100200202:OnDeath(caster, target)
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 100200206
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:AddBuff(BufferEffect[100200206], self.caster, target, nil, 4005)
	end
	-- 8466
	local c66 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3252)
	-- 100200208
	self:AddNp(BufferEffect[100200208], self.caster, self.card, nil, c66*5)
end
-- 行动结束
function Buffer100200202:OnActionOver(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8071
	if SkillJudger:TargetIsFriend(self, self.caster, target, true) then
	else
		return
	end
	-- 8222
	if SkillJudger:IsLive(self, self.caster, self.card, true) then
	else
		return
	end
	-- 8414
	local c14 = SkillApi:GetBeDamage(self, self.caster, target or self.owner,3)
	-- 8619
	if SkillJudger:Greater(self, self.caster, self.card, true,c14,0) then
	else
		return
	end
	-- 100200202
	self:AddHp(BufferEffect[100200202], self.caster, self.card, nil, math.floor(c14*0.55))
end
