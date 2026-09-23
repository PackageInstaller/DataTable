-- 角色施放普攻後，速度提高16%，持續2回合。可以疊5層
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010150 = oo.class(BuffBase)
function Buffer1000010150:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 攻击结束
function Buffer1000010150:OnAttackOver(caster, target)
	-- 8202
	if SkillJudger:IsNormal(self, self.caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000010150
	self:AddBuffCount(BufferEffect[1000010150], self.caster, self.card, nil, 1000010151,1,5)
end
