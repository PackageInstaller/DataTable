-- 尤彌爾70%血拉條（標記不顯示）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer922800103 = oo.class(BuffBase)
function Buffer922800103:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer922800103:OnActionOver2(caster, target)
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
	-- 922800105
	local turncount = SkillApi:GetTurnCount(self, self.caster, target or self.owner,nil)
	-- 922800106
	if SkillJudger:Equal(self, self.caster, self.card, true,turncount,30) then
	else
		return
	end
	-- 922800103
	self:AddProgress(BufferEffect[922800103], self.caster, self.card, nil, 500)
	-- 922800104
	self:DelBufferForce(BufferEffect[922800104], self.caster, self.card, nil, 922800103)
	-- 922800301
	self:OwnerAddBuff(BufferEffect[922800301], self.caster, self.card, nil, 922800301)
end
