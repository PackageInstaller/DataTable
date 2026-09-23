-- 閃翼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4501304 = oo.class(BuffBase)
function Buffer4501304:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer4501304:OnRoundBegin(caster, target)
	-- 6103
	self:ImmuneBuffQuality(BufferEffect[6103], self.caster, target or self.owner, nil,2)
end
-- 移除buff时
function Buffer4501304:OnRemoveBuff(caster, target)
	-- 6124
	self:MissSurface(BufferEffect[6124], self.caster, self.card, nil, 0)
end
-- 创建时
function Buffer4501304:OnCreate(caster, target)
	-- 4505
	self:AddAttr(BufferEffect[4505], self.caster, target or self.owner, nil,"hit",0.25)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 6123
	self:MissSurface(BufferEffect[6123], self.caster, self.card, nil, 10000)
end
-- 攻击结束
function Buffer4501304:OnAttackOver(caster, target)
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
	-- 6206
	self:DelBufferTypeForce(BufferEffect[6206], self.caster, self.card, nil, 4501301)
end
