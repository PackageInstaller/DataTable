-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer102301311 = oo.class(BuffBase)
function Buffer102301311:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer102301311:OnRemoveBuff(caster, target)
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 1)
	for i,target in ipairs(targets) do
		self:DelBufferTypeForce(BufferEffect[102300312], self.caster, target, nil, 10230)
	end
end
-- 行动结束
function Buffer102301311:OnActionOver(caster, target)
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	if SkillJudger:TargetIsFriend(self, self.caster, target, true) then
	else
		return
	end
	self:BeatBack(BufferEffect[102300311], self.caster, self.card, nil, nil)
end
