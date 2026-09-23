-- 索爾達森30%血標記（標記不顯示）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer910600901 = oo.class(BuffBase)
function Buffer910600901:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer910600901:OnActionOver2(caster, target)
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
	-- 8143
	if SkillJudger:OwnerPercentHp(self, self.caster, target, false,0.3) then
	else
		return
	end
	-- 910600901
	self:AddProgress(BufferEffect[910600901], self.caster, self.card, nil, 1001)
	-- 910600902
	self:AddSp(BufferEffect[910600902], self.caster, self.card, nil, 100)
	-- 910600903
	self:DelBufferForce(BufferEffect[910600903], self.caster, self.card, nil, 910600901)
end
