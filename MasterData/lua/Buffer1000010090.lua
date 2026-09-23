-- 角色解除任意友方的控制後75%概率再立即行動一次
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010090 = oo.class(BuffBase)
function Buffer1000010090:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 驱散buff时
function Buffer1000010090:OnDelBuff(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000010090
	if self:Rand(7500) then
		self:AddProgress(BufferEffect[1000010090], self.caster, self.card, nil, 1000)
	end
end
