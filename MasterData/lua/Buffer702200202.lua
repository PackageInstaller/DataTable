-- 火環
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer702200202 = oo.class(BuffBase)
function Buffer702200202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer702200202:OnActionOver(caster, target)
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
	-- 702200201
	self:OwnerHitAddBuff(BufferEffect[702200201], self.caster, self.caster, nil, 6000,1002,2)
end
-- 创建时
function Buffer702200202:OnCreate(caster, target)
	-- 4903
	self:AddAttr(BufferEffect[4903], self.caster, target or self.owner, nil,"bedamage",-0.15)
end
-- 行动结束2
function Buffer702200202:OnActionOver2(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
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
	-- 8203
	if SkillJudger:IsSingle(self, self.caster, target, false) then
	else
		return
	end
	-- 702200211
	self:OwnerHitAddBuff(BufferEffect[702200211], self.caster, self.caster, nil, 6000,1002,2)
end
