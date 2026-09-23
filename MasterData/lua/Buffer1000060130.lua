-- 反擊時概率附加冰凍狀態
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000060130 = oo.class(BuffBase)
function Buffer1000060130:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000060130:OnAttackOver(caster, target)
	-- 8244
	if SkillJudger:IsBeatBack(self, self.caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000060130
	self:AddBuff(BufferEffect[1000060130], self.caster, target or self.owner, nil,3005)
end
