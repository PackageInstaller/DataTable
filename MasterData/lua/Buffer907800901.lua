-- 稽查者30%血拉條（標記不顯示）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer907800901 = oo.class(BuffBase)
function Buffer907800901:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer907800901:OnAttackOver(caster, target)
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
	-- 907800901
	self:AddProgress(BufferEffect[907800901], self.caster, self.card, nil, 500)
	-- 907800902
	self:DelBufferTypeForce(BufferEffect[907800902], self.caster, self.card, nil, 9078,2)
end
