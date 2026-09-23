-- 使用大招並造成傷害後，80%概率提20%的條
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000050050 = oo.class(BuffBase)
function Buffer1000050050:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer1000050050:OnActionOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 8259
	if SkillJudger:IsCanHurt(self, self.caster, target, true) then
	else
		return
	end
	-- 1000050050
	if self:Rand(8000) then
		self:AddProgress(BufferEffect[1000050050], self.caster, self.card, nil, 200)
	end
end
