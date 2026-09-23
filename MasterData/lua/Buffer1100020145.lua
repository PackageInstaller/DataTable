-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100020145 = oo.class(BuffBase)
function Buffer1100020145:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1100020145:OnAttackOver(caster, target)
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
	-- 8468
	local c68 = SkillApi:GetDamage(self, self.caster, target or self.owner,3)
	-- 1100020145
	if self:Rand(3000) then
		self:AddHp(BufferEffect[1100020145], self.caster, self.card, nil, -math.floor(c68,1))
	end
end
