-- 索爾達森70%血標記（標記不顯示）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer910600801 = oo.class(BuffBase)
function Buffer910600801:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer910600801:OnActionOver2(caster, target)
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
	-- 8147
	if SkillJudger:OwnerPercentHp(self, self.caster, target, false,0.7) then
	else
		return
	end
	-- 910600801
	self:OwnerAddBuff(BufferEffect[910600801], self.caster, self.card, nil, 910600802)
	-- 910600803
	self:DelBufferForce(BufferEffect[910600803], self.caster, self.card, nil, 910600801)
end
