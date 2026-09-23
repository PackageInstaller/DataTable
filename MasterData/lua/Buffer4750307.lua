-- 搖滾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4750307 = oo.class(BuffBase)
function Buffer4750307:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4750307:OnCreate(caster, target)
	-- 4750307
	self:AddAttr(BufferEffect[4750307], self.caster, self.card, nil, "damage",0.02*self.nCount)
	-- 8781
	local c781 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3392)
	-- 4750315
	self:AddAttr(BufferEffect[4750315], self.caster, self.card, nil, "becure",0.01*self.nCount*c781)
end
