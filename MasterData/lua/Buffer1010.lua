-- 傷害引爆（把自己的存儲傷害分攤到敵人身上）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1010 = oo.class(BuffBase)
function Buffer1010:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer1010:OnCreate(caster, target)
	-- 1012
	local dmg1 = SkillApi:GetValue(self, self.caster, target or self.owner,3,"dmg1")
	-- 8413
	local c13 = SkillApi:LiveCount(self, self.caster, target or self.owner,2)
	-- 1016
	local targets = SkillFilter:All(self, self.caster, target or self.owner, 4)
	for i,target in ipairs(targets) do
		self:AddHp(BufferEffect[1016], self.caster, target, nil, math.floor(-dmg1/c13*2))
	end
	-- 1013
	self:DelValue(BufferEffect[1013], self.caster, self.card, nil, "dmg1")
end
