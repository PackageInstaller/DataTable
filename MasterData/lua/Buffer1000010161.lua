-- 迅捷：脫兔
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000010161 = oo.class(BuffBase)
function Buffer1000010161:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer1000010161:OnActionOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000010161
	self:AddAttr(BufferEffect[1000010161], self.caster, self.card, nil, "speed",30)
end
