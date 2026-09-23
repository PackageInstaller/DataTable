-- 傷害標記
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4302205 = oo.class(BuffBase)
function Buffer4302205:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合结束时
function Buffer4302205:OnRoundOver(caster, target)
	-- 4302205
	self:DelBufferGroup(BufferEffect[4302205], self.caster, self.card, nil, 1,1)
	-- 4302215
	self:AddProgress(BufferEffect[4302215], self.caster, self.card, nil, 500)
	-- 4302207
	self:OwnerAddBuffCount(BufferEffect[4302207], self.caster, self.card, nil, 302200201,1,3)
	-- 4302209
	self:OwnerAddBuff(BufferEffect[4302209], self.caster, self.card, nil, 302200204)
	-- 4302208
	self:DelBufferTypeForce(BufferEffect[4302208], self.caster, self.card, nil, 4302201)
end
