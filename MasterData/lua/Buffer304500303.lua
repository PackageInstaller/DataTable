-- 水蝕
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer304500303 = oo.class(BuffBase)
function Buffer304500303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer304500303:OnBefourHurt(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8780
	local c780 = SkillApi:BuffCount(self, self.caster, target or self.owner,1,4,304500201)
	-- 304500303
	self:AddTempAttr(BufferEffect[304500303], self.caster, self.card, nil, "defense",-8*c780*self.nCount)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8230
	if SkillJudger:IsCasterMech(self, self.caster, target, true,3) then
	else
		return
	end
	-- 304500308
	self:AddTempAttr(BufferEffect[304500308], self.caster, self.card, nil, "bedamage",0.02*self.nCount)
end
