-- 沉醉副歌
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4200309 = oo.class(BuffBase)
function Buffer4200309:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4200309:OnCreate(caster, target)
	-- 4200309
	self:AddAttr(BufferEffect[4200309], self.caster, target or self.owner, nil,"bedamage",0.04*self.nCount)
end
-- 回合结束时
function Buffer4200309:OnRoundOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 4200314
	self:AddBuffCount(BufferEffect[4200314], self.caster, target or self.owner, nil,4200309,math.min(-math.floor(self.nCount/2),-1),10)
end
