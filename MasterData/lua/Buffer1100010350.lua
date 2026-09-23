-- 山脈陣營蟲洞buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1100010350 = oo.class(BuffBase)
function Buffer1100010350:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer1100010350:OnBefourHurt(caster, target)
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
	-- 8259
	if SkillJudger:IsCanHurt(self, self.caster, target, true) then
	else
		return
	end
	-- 8227
	if SkillJudger:IsCasterMech(self, self.caster, target, false,1) then
	else
		return
	end
	-- 1100010350
	self:AddBuff(BufferEffect[1100010350], self.caster, self.card, nil, 1001,2)
end
