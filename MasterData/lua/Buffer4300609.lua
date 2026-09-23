-- 沉思求解
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4300609 = oo.class(BuffBase)
function Buffer4300609:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer4300609:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 4300630
	self:DelBufferForce(BufferEffect[4300630], self.caster, self.card, nil, 4300609)
end
-- 行动结束
function Buffer4300609:OnActionOver(caster, target)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, self.caster, target, true) then
	else
		return
	end
	-- 8230
	if SkillJudger:IsCasterMech(self, self.caster, target, true,3) then
	else
		return
	end
	-- 4300609
	self:Cure(BufferEffect[4300609], self.caster, self.card, nil, 6,0.1)
	-- 8062
	if SkillJudger:CasterIsTeammate(self, self.caster, target, true) then
	else
		return
	end
	-- 8230
	if SkillJudger:IsCasterMech(self, self.caster, target, true,3) then
	else
		return
	end
	-- 8783
	local c783 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3394)
	-- 4300621
	if SkillJudger:HasBuff(self, self.caster, target, true,3,339401) then
	else
		return
	end
	-- 4300619
	if self:Rand(2000*c783) then
		self:Cure(BufferEffect[4300619], self.caster, self.card, nil, 6,0.1)
	end
end
