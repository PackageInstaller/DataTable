-- 慈悲模式
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer600900302 = oo.class(BuffBase)
function Buffer600900302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 移除buff时
function Buffer600900302:OnRemoveBuff(caster, target)
	-- 600900302
	self:ChangeSkill(BufferEffect[600900302], self.caster, self.card, nil, 1,600900101)
end
-- 创建时
function Buffer600900302:OnCreate(caster, target)
	-- 600900301
	self:ChangeSkill(BufferEffect[600900301], self.caster, self.card, nil, 1,600900401)
	-- 4904
	self:AddAttr(BufferEffect[4904], self.caster, target or self.owner, nil,"bedamage",-0.2)
end
