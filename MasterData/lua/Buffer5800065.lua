-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5800065 = oo.class(BuffBase)
function Buffer5800065:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害后
function Buffer5800065:OnAfterHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 5800069
	self:OwnerAddBuffCount(BufferEffect[5800069], self.caster, self.card, nil, 5800050,5,1000)
end
-- 伤害前
function Buffer5800065:OnBefourHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 5800065
	self:AddTempAttrPercent(BufferEffect[5800065], self.caster, self.card, nil, "attack",0.3)
end
