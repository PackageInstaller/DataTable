-- 永眠標記
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer907100202 = oo.class(BuffBase)
function Buffer907100202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer907100202:OnRoundBegin(caster, target)
	-- 6104
	self:ImmuneBufferGroup(BufferEffect[6104], self.caster, target or self.owner, nil,1)
end
-- 创建时
function Buffer907100202:OnCreate(caster, target)
	-- 8455
	local c55 = SkillApi:SkillLevel(self, self.caster, target or self.owner,3,47005)
	-- 4705005
	self:AddAttr(BufferEffect[4705005], self.caster, self.card, nil, "hit",0.15+0.05*c55)
	-- 4705007
	self:AddAttr(BufferEffect[4705007], self.caster, self.card, nil, "bedamage",-0.2)
end
