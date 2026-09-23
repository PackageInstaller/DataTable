-- 不朽陵墓
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer908800306 = oo.class(BuffBase)
function Buffer908800306:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer908800306:OnCreate(caster, target)
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 8070
	if SkillJudger:TargetIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 908800306
	self:AddAttrPercent(BufferEffect[908800306], self.caster, self.card, nil, "bedamage",-0.03*self.nCount)
end
