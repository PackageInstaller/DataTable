-- 落日熔金：推進
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer330402 = oo.class(BuffBase)
function Buffer330402:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合结束时
function Buffer330402:OnRoundOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 330402
	self:AddProgress(BufferEffect[330402], self.caster, self.card, nil, 1010)
	-- 330403
	self:DelBufferForce(BufferEffect[330403], self.caster, self.card, nil, 330402)
end
