-- 雷雲減攻擊,命中
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer700100201 = oo.class(BuffBase)
function Buffer700100201:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer700100201:OnRemoveBuff(caster, target)
	-- 8303
	self:DelValue(BufferEffect[8303], self.caster, target or self.owner, nil,"ly")
end
-- 创建时
function Buffer700100201:OnCreate(caster, target)
	-- 8406
	local c6 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,7001002)
	-- 700100201
	self:AddAttrPercent(BufferEffect[700100201], self.caster, target or self.owner, nil,"attack",-(0.05+0.02*c6))
	-- 8301
	self:AddValue(BufferEffect[8301], self.caster, target or self.owner, nil,"ly",1)
	-- 8406
	local c6 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,7001002)
	-- 700100202
	self:AddAttr(BufferEffect[700100202], self.caster, target or self.owner, nil,"hit",-(0.05+0.02*c6))
end
