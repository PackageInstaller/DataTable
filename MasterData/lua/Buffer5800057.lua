-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer5800057 = oo.class(BuffBase)
function Buffer5800057:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害后
function Buffer5800057:OnAfterHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 5800067
	self:OwnerAddBuffCount(BufferEffect[5800067], self.caster, self.card, nil, 5800050,1,1000)
end
-- 伤害前
function Buffer5800057:OnBefourHurt(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 5800057
	self:AddTempAttrPercent(BufferEffect[5800057], self.caster, self.card, nil, "attack",20,24,100)
end
