-- 使用大招造成傷害時，概率使目標獲得冰凍效果
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000060150 = oo.class(BuffBase)
function Buffer1000060150:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000060150:OnAttackOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8073
	if SkillJudger:TargetIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 1000060150
	if self:Rand(6000) then
		self:AddBuff(BufferEffect[1000060150], self.caster, target or self.owner, nil,3002)
	end
end
