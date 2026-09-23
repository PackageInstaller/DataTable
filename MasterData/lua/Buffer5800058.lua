-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5800058 = oo.class(BuffBase)
function Buffer5800058:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害后
function Buffer5800058:OnAfterHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 5800068
	self:OwnerAddBuffCount(BufferEffect[5800068], self.caster, self.card, nil, 5800050,1,1000)
end
-- 伤害前
function Buffer5800058:OnBefourHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 5800058
	self:AddTempAttrPercent(BufferEffect[5800058], self.caster, self.card, nil, "attack",25,29,100)
end
