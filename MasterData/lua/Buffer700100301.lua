-- 重電磁場
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer700100301 = oo.class(BuffBase)
function Buffer700100301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 入场时
function Buffer700100301:OnBorn(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8302
	local ly = SkillApi:GetValue(self, self.caster, target or self.owner,2,"ly")
	-- 8304
	if SkillJudger:Less(self, self.caster, target, true,ly,1) then
	else
		return
	end
	-- 700100211
	self:OwnerAddBuff(BufferEffect[700100211], self.caster, self.caster, nil, 700100201)
end
-- 移除buff时
function Buffer700100301:OnRemoveBuff(caster, target)
	-- 700100212
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 4)
	for i,target in ipairs(targets) do
		self:DelBufferForce(BufferEffect[700100212], self.caster, target, nil, 700100201)
	end
end
-- 创建时
function Buffer700100301:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 4)
	for i,target in ipairs(targets) do
		-- 8302
		local ly = SkillApi:GetValue(self, self.caster, target or self.owner,2,"ly")
		-- 700100215
		if SkillJudger:Less(self, self.caster, target, true,ly,1) then
			-- 700100214
			self:OwnerAddBuff(BufferEffect[700100214], self.caster, target or self.owner, nil,700100201)
		end
	end
end
