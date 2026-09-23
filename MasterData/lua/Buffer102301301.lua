-- 反擊提升
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer102301301 = oo.class(BuffBase)
function Buffer102301301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer102301301:OnCreate(caster, target)
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
	-- 8201
	if SkillJudger:IsSingle(self, self.caster, target, true) then
	else
		return
	end
	-- 102301301
	self:AddAttr(BufferEffect[102301301], self.caster, self.caster, nil, "damage",-0.5)
end
