-- 我方全體獲得【反擊】技能，45%概率觸發
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000070120 = oo.class(BuffBase)
function Buffer1000070120:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000070120:OnAttackOver(caster, target)
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000070120
	if self:Rand(6500) then
		self:BeatBack(BufferEffect[1000070120], self.caster, target or self.owner, nil,nil)
	end
end
