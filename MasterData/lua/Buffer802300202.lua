-- 曜庇
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer802300202 = oo.class(BuffBase)
function Buffer802300202:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 死亡时
function Buffer802300202:OnDeath(caster, target)
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
	-- 802300202
	self:PassiveRevive(BufferEffect[802300202], self.caster, self.card, nil, 8,0.3,{progress=700})
	-- 802300203
	self:DelBufferForce(BufferEffect[802300203], self.caster, self.card, nil, 802300202)
end
-- 创建时
function Buffer802300202:OnCreate(caster, target)
	-- 802300201
	self:AddProgress(BufferEffect[802300201], self.caster, self.card, nil, 500)
end
