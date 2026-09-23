-- 自身強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer601900301 = oo.class(BuffBase)
function Buffer601900301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer601900301:OnRemoveBuff(caster, target)
	-- 601900303
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 3)
	for i,target in ipairs(targets) do
		self:SetProtect(BufferEffect[601900303], self.caster, target, nil, 0)
	end
end
-- 行动结束
function Buffer601900301:OnActionOver(caster, target)
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
	-- 8414
	local c14 = SkillApi:GetBeDamage(self, self.caster, target or self.owner,3)
	-- 1010
	self:AddValue(BufferEffect[1010], self.caster, self.card, nil, "dmg1",c14)
end
-- 创建时
function Buffer601900301:OnCreate(caster, target)
	-- 4606
	self:AddAttr(BufferEffect[4606], self.caster, target or self.owner, nil,"resist",0.3)
	-- 4906
	self:AddAttr(BufferEffect[4906], self.caster, target or self.owner, nil,"bedamage",-0.3)
end
