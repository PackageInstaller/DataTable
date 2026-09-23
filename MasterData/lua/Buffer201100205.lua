-- 音律盾
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer201100205 = oo.class(BuffBase)
function Buffer201100205:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 回合开始处理完成后
function Buffer201100205:OnAfterRoundBegin(caster, target)
	-- 8060
	if SkillJudger:CasterIsSelf(self, self.caster, target, true) then
	else
		return
	end
	-- 201100206
	self:AddNp(BufferEffect[201100206], self.caster, self.card, nil, 5)
end
-- 回合开始时
function Buffer201100205:OnRoundBegin(caster, target)
	-- 201100207
	self:AddBuff(BufferEffect[201100207], self.caster, self.card, nil, 201100206)
end
-- 移除buff时
function Buffer201100205:OnRemoveBuff(caster, target)
	-- 201100208
	self:DelBufferTypeForce(BufferEffect[201100208], self.caster, self.card, nil, 201100201)
end
-- 创建时
function Buffer201100205:OnCreate(caster, target)
	-- 201100205
	self:AddShield(BufferEffect[201100205], self.caster, self.card, nil, 1,0.16)
end
