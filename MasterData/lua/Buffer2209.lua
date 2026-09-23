-- 物理屏障
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2209 = oo.class(BuffBase)
function Buffer2209:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer2209:OnRemoveBuff(caster, target)
	-- 8458
	local c58 = SkillApi:GetCount(self, self.caster, target or self.owner,3,2309)
	-- 8613
	if SkillJudger:Less(self, self.caster, self.card, true,c58,1) then
	else
		return
	end
	-- 8459
	local c59 = SkillApi:GetCount(self, self.caster, target or self.owner,3,2209)
	-- 8614
	if SkillJudger:Less(self, self.caster, self.card, true,c59,1) then
	else
		return
	end
	-- 9404
	self:OwnerAddBuff(BufferEffect[9404], self.caster, self.card, nil, 9401)
end
-- 行动结束2
function Buffer2209:OnActionOver2(caster, target)
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
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		-- 8461
		local c61 = SkillApi:GetCount(self, self.caster, target or self.owner,2,2209)
		-- 9505
		if SkillJudger:Less(self, self.caster, target, true,c61,1) then
			-- 9506
			self:OwnerAddBuff(BufferEffect[9506], self.caster, target or self.owner, nil,9406)
		end
	end
end
