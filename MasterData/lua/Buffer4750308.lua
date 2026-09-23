-- 搖滾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4750308 = oo.class(BuffBase)
function Buffer4750308:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4750308:OnCreate(caster, target)
	-- 4750308
	self:AddAttr(BufferEffect[4750308], self.caster, self.card, nil, "damage",0.03*self.nCount)
	-- 8781
	local c781 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3392)
	-- 4750315
	self:AddAttr(BufferEffect[4750315], self.caster, self.card, nil, "becure",0.01*self.nCount*c781)
	-- 4750311
	if SkillJudger:Greater(self, self.caster, self.card, true,self.nCount,4) then
	else
		return
	end
	-- 4750313
	self:AddAttr(BufferEffect[4750313], self.caster, self.card, nil, "bedamage",-0.25)
end
