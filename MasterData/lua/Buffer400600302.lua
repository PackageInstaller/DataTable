-- 風眼
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer400600302 = oo.class(BuffBase)
function Buffer400600302:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer400600302:OnActionOver2(caster, target)
	-- 8768
	local c768 = SkillApi:GetCount(self, self.caster, target or self.owner,3,400600302)
	-- 8634
	if SkillJudger:Greater(self, self.caster, self.card, true,c768,1) then
	else
		return
	end
	-- 8063
	if SkillJudger:CasterIsEnemy(self, self.caster, target, true) then
	else
		return
	end
	-- 400600305
	self:DelBufferForce(BufferEffect[400600305], self.caster, self.card, nil, 400600301)
	-- 400600306
	self:DelBufferForce(BufferEffect[400600306], self.caster, self.card, nil, 400600302)
	-- 400600303
	self:AddProgress(BufferEffect[400600303], self.caster, self.card, nil, 1000)
end
