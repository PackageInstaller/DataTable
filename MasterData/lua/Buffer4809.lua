-- None
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer4809 = oo.class(BuffBase)
function Buffer4809:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer4809:OnBefourHurt(caster, target)
	-- 8201
	if SkillJudger:IsSingle(self, self.caster, target, true) then
	else
		return
	end
	-- 4809
	self:AddTempAttr(BufferEffect[4809], self.caster, self.card, nil, "damage",1)
end
