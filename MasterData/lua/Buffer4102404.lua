-- 輝石炸盾反彈標記
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4102404 = oo.class(BuffBase)
function Buffer4102404:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束
function Buffer4102404:OnActionOver(caster, target)
	-- 8446
	local c46 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,41024)
	-- 8447
	local c47 = SkillApi:GetAttr(self, self.caster, target or self.owner,4,"defense")
	-- 4102405
	self:AddHp(BufferEffect[4102405], self.caster, self.card, nil, math.floor(-(c46*0.5+2.5)*c47))
end
