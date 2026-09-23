-- 本能解放
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer336802 = oo.class(BuffBase)
function Buffer336802:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer336802:OnRemoveBuff(caster, target)
	-- 336807
	self:DelValue(BufferEffect[336807], self.caster, self.card, nil, "gc")
end
-- 伤害前
function Buffer336802:OnBefourHurt(caster, target)
	-- 336806
	local gc = SkillApi:GetValue(self, self.caster, target or self.owner,1,"gc")
	-- 8202
	if SkillJudger:IsNormal(self, self.caster, target, true) then
	else
		return
	end
	-- 336802
	self:AddTempAttr(BufferEffect[336802], self.caster, self.card, nil, "damage",0.015*gc)
end
-- 创建时
function Buffer336802:OnCreate(caster, target)
	-- 8766
	local c766 = SkillApi:GetCount(self, self.caster, target or self.owner,3,750200201)
	-- 336808
	self:AddValue(BufferEffect[336808], self.caster, self.card, nil, "gc",c766)
end
