-- 凝霜
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer601100201 = oo.class(BuffBase)
function Buffer601100201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer601100201:OnCreate(caster, target)
	-- 8605
	self:AddValue(BufferEffect[8605], self.caster, self.card, nil, "Tara",1,0,5)
	-- 8606
	local Tara = SkillApi:GetValue(self, self.caster, target or self.owner,1,"Tara")
	-- 601100201
	self:AddAttrPercent(BufferEffect[601100201], self.caster, target or self.owner, nil,"attack",0.2*self.nCount)
	-- 8606
	local Tara = SkillApi:GetValue(self, self.caster, target or self.owner,1,"Tara")
	-- 601100202
	self:AddAttr(BufferEffect[601100202], self.caster, target or self.owner, nil,"hit",0.2*self.nCount)
end
