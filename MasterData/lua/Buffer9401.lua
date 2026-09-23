-- 無力狀態
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer9401 = oo.class(BuffBase)
function Buffer9401:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer9401:OnRoundBegin(caster, target)
	-- 6125
	self:ImmuneBufferGroup(BufferEffect[6125], self.caster, target or self.owner, nil,14)
	-- 6126
	self:ImmuneBufferGroup(BufferEffect[6126], self.caster, target or self.owner, nil,15)
end
-- 创建时
function Buffer9401:OnCreate(caster, target)
	-- 9401
	self:AddAttr(BufferEffect[9401], self.caster, self.card, nil, "speed",-20)
	-- 9402
	self:AddAttr(BufferEffect[9402], self.caster, self.card, nil, "bedamage",0.4)
	-- 9403
	self:AddProgress(BufferEffect[9403], self.caster, self.card, nil, -1000)
end
