-- 彈藥裝填
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer710100103 = oo.class(BuffBase)
function Buffer710100103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer710100103:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 710100102
	self:AddSp(BufferEffect[710100102], self.caster, self.card, nil, 15)
end
-- 创建时
function Buffer710100103:OnCreate(caster, target)
	-- 710100202
	self:AddAttr(BufferEffect[710100202], self.caster, self.card, nil, "damage",0.1*self.nCount)
end
