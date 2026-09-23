-- 使用大招後提100%條，僅存在一場戰鬥
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050100 = oo.class(BuffBase)
function Buffer1000050100:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer1000050100:OnActionOver(caster, target)
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 1000050100
	self:AddProgress(BufferEffect[1000050100], self.caster, self.card, nil, 1000)
end
