-- 音泉（變調）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer200300107 = oo.class(BuffBase)
function Buffer200300107:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer200300107:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 200300107
	self:Cure(BufferEffect[200300107], self.caster, self.card, nil, 8,0.09)
end
