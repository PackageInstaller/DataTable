-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer402000202 = oo.class(BuffBase)
function Buffer402000202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer402000202:OnCreate(caster, target)
	self:AddValue(BufferEffect[8609], self.caster, self.card, nil, "mjpx",-1,0,3)
	self:AddAttr(BufferEffect[302200201], self.caster, self.card, nil, "damage",0.2*self.nCount)
	local c50 = SkillApi:SkillLevel(self, self.caster, target or self.owner,4,3022002)
	self:AddAttr(BufferEffect[302200202], self.caster, self.card, nil, "speed",(c50+1)*5*self.nCount)
	if SkillJudger:Greater(self, self.caster, target, true,self.nCount,0) then
	else
		return
	end
	local c15 = SkillApi:GetAttr(self, self.caster, target or self.owner,3,"attack")
	self:AddAttr(BufferEffect[8516], self.caster, self.card, nil, "bedamage",-c15/30000)
end
