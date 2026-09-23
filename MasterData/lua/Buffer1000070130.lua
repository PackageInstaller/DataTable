-- 我方全體獲得【追擊】技能，45%概率觸發
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000070130 = oo.class(BuffBase)
function Buffer1000070130:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000070130:OnAttackOver(caster, target)
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
	-- 1000070130
	if self:Rand(6500) then
		self:BeatAgain(BufferEffect[1000070130], self.caster, target or self.owner, nil,nil)
	end
end
