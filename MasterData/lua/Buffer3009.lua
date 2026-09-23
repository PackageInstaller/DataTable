-- 麻痹
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer3009 = oo.class(BuffBase)
function Buffer3009:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始处理完成后
function Buffer3009:OnAfterRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 3009
	if self:Rand(5000) then
		self:Palsy(BufferEffect[3009], self.caster, target or self.owner, nil,nil)
	end
end
