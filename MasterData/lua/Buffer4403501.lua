-- 殘痕
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4403501 = oo.class(BuffBase)
function Buffer4403501:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer4403501:OnBefourHurt(caster, target)
	-- 8160
	if SkillJudger:IsCasterBuff(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 8479
	local c79 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3295)
	-- 8213
	if SkillJudger:IsCrit(self, self.caster, target, true) then
	else
		return
	end
	-- 4403511
	self:AddTempAttr(BufferEffect[4403511], self.caster, self.caster, nil, "damage",0.02*self.nCount*c79)
end
-- 行动结束
function Buffer4403501:OnActionOver(caster, target)
	-- 8160
	if SkillJudger:IsCasterBuff(self, self.caster, target, true) then
	else
		return
	end
	-- 4403501
	self:OwnerAddBuff(BufferEffect[4403501], self.caster, self.card, nil, 4403502)
	-- 4403502
	self:LimitDamage(BufferEffect[4403502], self.caster, self.card, nil, 1,0.25*self.nCount)
	-- 4403503
	self:CreaterAddBuffCount(BufferEffect[4403503], self.caster, self.card, nil, 4403501,-1,5)
end
