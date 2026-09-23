-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4300605 = oo.class(BuffBase)
function Buffer4300605:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer4300605:OnActionOver(caster, target)
	-- 8160
	if SkillJudger:IsCasterBuff(self, self.caster, target, true) then
	else
		return
	end
	-- 8405
	local c5 = SkillApi:PercentHp(self, self.caster, target or self.owner,3)
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 8222
	if SkillJudger:IsLive(self, self.caster, self.card, true) then
	else
		return
	end
	-- 4300605
	self:AddBuffCount(BufferEffect[4300605], self.caster, self.creater, nil, 4300620,math.floor((1-c5+0.00001)*10),100)
end
