-- 尤彌爾70%血拉條（標記不顯示）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer922800101 = oo.class(BuffBase)
function Buffer922800101:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 行动结束2
function Buffer922800101:OnActionOver2(caster, target)
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
	-- 8147
	if SkillJudger:OwnerPercentHp(self, self.caster, target, false,0.7) then
	else
		return
	end
	-- 922800101
	self:AddProgress(BufferEffect[922800101], self.caster, self.card, nil, 500)
	-- 922800102
	self:DelBufferForce(BufferEffect[922800102], self.caster, self.card, nil, 922800101)
	-- 922800301
	self:OwnerAddBuff(BufferEffect[922800301], self.caster, self.card, nil, 922800301)
end
