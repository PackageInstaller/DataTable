-- 空buff
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4801801 = oo.class(BuffBase)
function Buffer4801801:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer4801801:OnBefourHurt(caster, target)
	-- 8160
	if SkillJudger:IsCasterBuff(self, self.caster, target, true) then
	else
		return
	end
	-- 8065
	if SkillJudger:CasterIsSelf(self, self.caster, target, false) then
	else
		return
	end
	-- 8789
	local c789 = SkillApi:GetAttr(self, self.caster, target or self.owner,1,"sMech")
	-- 8790
	local c790 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"sMech")
	-- 710130111
	if SkillJudger:Equal(self, self.caster, target, true,c789,c790) then
	else
		return
	end
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 8219
	if SkillJudger:IsUltimate(self, self.caster, target, true) then
	else
		return
	end
	-- 4801801
	self:AddTempAttr(BufferEffect[4801801], self.caster, self.caster, nil, "attack",math.floor(c15*0.3))
end
