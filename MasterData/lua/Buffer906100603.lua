-- 鋼體
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer906100603 = oo.class(BuffBase)
function Buffer906100603:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 暴击伤害前(OnBefourHurt之前)
function Buffer906100603:OnBefourCritHurt(caster, target)
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
	-- 8415
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	-- 906100603
	self:AddShieldValue(BufferEffect[906100603], self.caster, self.card, nil, math.floor(c15*0.5))
end
