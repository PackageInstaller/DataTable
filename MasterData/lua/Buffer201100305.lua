-- 傷害強化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer201100305 = oo.class(BuffBase)
function Buffer201100305:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer201100305:OnCreate(caster, target)
	-- 201100305
	self:AddProgress(BufferEffect[201100305], self.caster, self.card, nil, 200)
	-- 201100313
	self:AddAttr(BufferEffect[201100313], self.caster, self.card, nil, "damage",0.2)
	-- 201100321
	self:Cure(BufferEffect[201100321], self.caster, self.card, nil, 8,0.1)
end
