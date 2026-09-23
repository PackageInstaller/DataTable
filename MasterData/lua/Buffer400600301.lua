-- 風眼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer400600301 = oo.class(BuffBase)
function Buffer400600301:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer400600301:OnCreate(caster, target)
	-- 400600301
	self:AddAttrPercent(BufferEffect[400600301], self.caster, self.card, nil, "speed",-1)
	-- 400600302
	self:AddProgress(BufferEffect[400600302], self.caster, self.card, nil, -1000)
end
-- 攻击结束
function Buffer400600301:OnAttackOver(caster, target)
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
	-- 400600304
	self:AddBuffCount(BufferEffect[400600304], self.caster, self.card, nil, 400600302,1,2)
end
