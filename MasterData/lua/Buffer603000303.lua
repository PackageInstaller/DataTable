-- 暴擊弱化
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer603000303 = oo.class(BuffBase)
function Buffer603000303:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 创建时
function Buffer603000303:OnCreate(caster, target)
	-- 5306
	self:AddAttr(BufferEffect[5306], self.caster, target or self.owner, nil,"crit_rate",-0.3)
end
