-- 軫恤
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer2924 = oo.class(BuffBase)
function Buffer2924:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 伤害前
function Buffer2924:OnBefourHurt(caster, target)
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
	-- 8224
	if SkillJudger:IsCrit(self, self.caster, target, false) then
	else
		return
	end
	-- 600900204
	self:AddTempAttr(BufferEffect[600900204], self.caster, self.caster, nil, "damage",-0.25)
end
-- 创建时
function Buffer2924:OnCreate(caster, target)
	-- 2924
	self:AddReduceShield(BufferEffect[2924], self.caster, target or self.owner, nil,0.4,3,0.5)
end
