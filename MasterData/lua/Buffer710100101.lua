-- 彈藥裝填
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer710100101 = oo.class(BuffBase)
function Buffer710100101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始时
function Buffer710100101:OnRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 710100101
	self:AddSp(BufferEffect[710100101], self.caster, self.card, nil, 10)
end
-- 创建时
function Buffer710100101:OnCreate(caster, target)
	-- 710100201
	self:AddAttr(BufferEffect[710100201], self.caster, self.card, nil, "damage",0.05*self.nCount)
end
