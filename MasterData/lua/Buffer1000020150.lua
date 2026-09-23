-- 回合結束時，有60%概率獲得等同自身生命上限12%的護盾。持續一回合
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000020150 = oo.class(BuffBase)
function Buffer1000020150:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合结束时
function Buffer1000020150:OnRoundOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000020150
	if self:Rand(6000) then
		self:AddShield(BufferEffect[1000020150], self.caster, self.card, nil, 1,0.12)
	end
end
