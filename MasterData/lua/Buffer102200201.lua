-- 戰術屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer102200201 = oo.class(BuffBase)
function Buffer102200201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer102200201:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8763
	local c763 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,1022002)
	-- 102200211
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:Cure(BufferEffect[102200211], self.caster, target, nil, 8,(0.02+math.floor((c763+1)/2)/100)*self.nCount)
	end
end
-- 创建时
function Buffer102200201:OnCreate(caster, target)
	-- 8762
	local c762 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,41022)
	-- 102200201
	self:AddMaxHpPercent(BufferEffect[102200201], self.caster, self.card, nil, (0.02*c762)*self.nCount)
end
-- 回合结束时
function Buffer102200201:OnRoundOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8763
	local c763 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,1022002)
	-- 102200221
	self:AddProgress(BufferEffect[102200221], self.caster, self.card, nil, 50+math.floor((c763+1)/2)*50)
end
