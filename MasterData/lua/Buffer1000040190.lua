-- 角色使用普攻後，自身可以增加5%暴擊幾率（可疊加，最多5層）
-- 本文件由工具自动生成,请不要直接编辑本文件
---------------------------------------------
-- 技能基类
Buffer1000040190 = oo.class(BuffBase)
function Buffer1000040190:Init(mgr, id, target, caster)
	BuffBase.Init(self, mgr, id, target, caster)
end
-- 战斗开始
function Buffer1000040190:OnStart(caster, target)
	do
		-- 1000040190
		self:AddAttrPercent(BufferEffect[1000040190], self.caster, self.card, nil, "damage",1)
	end
end
