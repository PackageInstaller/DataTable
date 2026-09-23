-- 當角色身上有【增傷】詞條時，增加暴擊率+30%
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000030130 = oo.class(BuffBase)
function Buffer1000030130:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000030130:OnCreate(caster, target)
	-- 1000030131
	if SkillJudger:HasBuff(self, self.caster, target, true,1,1000030010) then
	else
		return
	end
	-- 1000030130
	self:AddAttr(BufferEffect[1000030130], self.caster, self.card, nil, "crit_rate",0.6)
end
