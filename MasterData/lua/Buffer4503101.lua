-- 伏筆
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4503101 = oo.class(BuffBase)
function Buffer4503101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer4503101:OnBefourHurt(caster, target)
	-- 8758
	local c154 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,45031)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8133
	if SkillJudger:OwnerPercentHp(self, self.caster, target, true,0.3) then
	else
		return
	end
	-- 4503102
	self:AddTempAttr(BufferEffect[4503102], self.caster, self.card, nil, "bedamage",0.02*c154)
end
-- 创建时
function Buffer4503101:OnCreate(caster, target)
	-- 8475
	local c75 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"attack")
	-- 4503101
	self:AddMaxHpPercent(BufferEffect[4503101], self.caster, self.card, nil, -0.06,-c75*8)
end
