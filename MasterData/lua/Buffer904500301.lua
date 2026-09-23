-- 蓄力
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer904500301 = oo.class(BuffBase)
function Buffer904500301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer904500301:OnRemoveBuff(caster, target)
	-- 904500402
	self:ChangeSkill(BufferEffect[904500402], self.caster, target or self.owner, nil,3,904500301)
end
-- 创建时
function Buffer904500301:OnCreate(caster, target)
	-- 904500301
	self:AddAttrPercent(BufferEffect[904500301], self.caster, target or self.owner, nil,"attack",1)
	-- 904500302
	self:AddAttrPercent(BufferEffect[904500302], self.caster, target or self.owner, nil,"defense",1)
end
