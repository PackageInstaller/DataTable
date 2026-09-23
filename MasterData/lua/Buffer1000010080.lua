-- 戰鬥開始時+50np，同時提供一層【加速】
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010080 = oo.class(BuffBase)
function Buffer1000010080:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1000010080:OnCreate(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000010080
	self:AddNp(BufferEffect[1000010080], self.caster, self.card, nil, 10)
end
