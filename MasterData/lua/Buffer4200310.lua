-- 沉醉副歌
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4200310 = oo.class(BuffBase)
function Buffer4200310:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer4200310:OnCreate(caster, target)
	-- 4200310
	self:AddAttr(BufferEffect[4200310], self.caster, target or self.owner, nil,"bedamage",0.05*self.nCount)
end
-- 回合结束时
function Buffer4200310:OnRoundOver(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 4200315
	self:AddBuffCount(BufferEffect[4200315], self.caster, target or self.owner, nil,4200310,math.min(-math.floor(self.nCount/2),-1),10)
end
