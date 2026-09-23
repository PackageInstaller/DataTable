-- 夜幕
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer704500101 = oo.class(BuffBase)
function Buffer704500101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 暴击伤害前(OnBefourHurt之前)
function Buffer704500101:OnBefourCritHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8633
	if SkillJudger:IsTargetMech(self, self.caster, target, true,7) then
	else
		return
	end
	-- 704500101
	self:AddTempAttr(BufferEffect[704500101], self.caster, self.card, nil, "crit",-0.05*self.nCount)
end
-- 伤害前
function Buffer704500101:OnBefourHurt(caster, target)
	-- 8238
	if SkillJudger:IsCasterMech(self, self.caster, target, true,7) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 704500102
	self:AddTempAttr(BufferEffect[704500102], self.caster, self.card, nil, "defense",-50*self.nCount)
end
