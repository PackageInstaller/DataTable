-- 山脈陣營不朽buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100020230 = oo.class(BuffBase)
function Buffer1100020230:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 死亡时
function Buffer1100020230:OnDeath(caster, target)
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
	-- 1100020230
	self:PassiveRevive(BufferEffect[1100020230], self.caster, self.card, nil, 8,0.3,{progress=700})
end
