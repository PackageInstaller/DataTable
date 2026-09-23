-- 秩序晶體
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer984700401 = oo.class(BuffBase)
function Buffer984700401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer984700401:OnRoundBegin(caster, target)
	-- 984700402
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 4)
	for i,target in ipairs(targets) do
		self:SetValue(BufferEffect[984700402], self.caster, target, nil, "LimitDamage",-0.03*self.nCount)
	end
	-- 984700403
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 4)
	for i,target in ipairs(targets) do
		self:SetValue(BufferEffect[984700403], self.caster, target, nil, "LimitDamage2",-0.03*self.nCount)
	end
end
-- 伤害前
function Buffer984700401:OnBefourHurt(caster, target)
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
	-- 984700401
	self:AddTempAttr(BufferEffect[984700401], self.caster, self.card, nil, "bedamage2",-0.03*self.nCount)
end
