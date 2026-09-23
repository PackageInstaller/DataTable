-- 當角色身上有【強化】詞條時，增加暴擊率+30%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050150 = oo.class(BuffBase)
function Buffer1000050150:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer1000050150:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000050022
	if SkillJudger:HasBuff(self, self.caster, target, true,1,1000050021) then
	else
		return
	end
	-- 1000050150
	self:AddAttr(BufferEffect[1000050150], self.caster, self.card, nil, "crit_rate",0.3)
end
