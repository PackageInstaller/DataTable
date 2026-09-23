-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer601100101 = oo.class(BuffBase)
function Buffer601100101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer601100101:OnRoundBegin(caster, target)
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	self:AddSp(BufferEffect[710100101], self.caster, self.card, nil, 20)
end
-- 创建时
function Buffer601100101:OnCreate(caster, target)
	self:AddValue(BufferEffect[8605], self.caster, self.card, nil, "Tara",1,0,5)
	local Tara = SkillApi:GetValue(self, self.caster, target or self.owner,1,"Tara")
	self:AddAttrPercent(BufferEffect[601100201], self.caster, target or self.owner, nil,"attack",0.2*Tara)
	local Tara = SkillApi:GetValue(self, self.caster, target or self.owner,1,"Tara")
	self:AddAttrPercent(BufferEffect[601100201], self.caster, target or self.owner, nil,"attack",0.2*Tara)
end
