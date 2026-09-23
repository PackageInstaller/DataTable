-- 稽查者70%血拉條（標記不顯示）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer907800801 = oo.class(BuffBase)
function Buffer907800801:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer907800801:OnAttackOver(caster, target)
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
	-- 907800801
	self:AddProgress(BufferEffect[907800801], self.caster, self.card, nil, 500)
	-- 907800802
	self:DelBufferForce(BufferEffect[907800802], self.caster, self.card, nil, 907800801)
end
