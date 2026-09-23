-- 弱干涉
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer922800702 = oo.class(BuffBase)
function Buffer922800702:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer922800702:OnCreate(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 922800702
	self:AddTempAttrPercent(BufferEffect[922800702], self.caster, self.card, nil, "attack",0.05*self.nCount)
end
