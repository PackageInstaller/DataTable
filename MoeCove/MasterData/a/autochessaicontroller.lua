--- 实体 AI 控制器：挂载在 Entity 上，将 Update 转交给 AI 模块
---@class AutoChessAIController
local AutoChessAIController = class("AutoChessAIController")

local AIModule = require("AIModule")

---@param owner AutoChessEntity 挂载的实体
function AutoChessAIController:ctor(owner)
	self.owner = owner
	self.aiName = AIModule.ResolveName(owner:GetAiName())
	self.ctx = AIModule.CreateContext(owner)
	self.handler = AIModule.CreateHandler(self.aiName, self.ctx)
end

---运行时切换 AI 脚本（重建 handler）
---@param aiName string
function AutoChessAIController:SetAI(aiName)
	aiName = AIModule.ResolveName(aiName)
	if self.aiName == aiName and self.handler ~= nil then
		return
	end
	self.aiName = aiName
	self.handler = AIModule.CreateHandler(aiName, self.ctx)
end

---当前 AI 逻辑名
---@return string
function AutoChessAIController:GetAIName()
	return self.aiName
end

---每帧转交 AIBase:Update（仅 AI 战斗且非子弹实体）
---@param dt number
function AutoChessAIController:Update(dt)
	if not AIModule.IsEnabled() then
		return
	end
	local owner = self.owner
	if owner == nil or owner.entityType == GE.EntityType.Bullet then
		return
	end
	local sc = owner.skillController
	if sc == nil or sc.GetBestSkillId == nil then
		return
	end
	if self.handler == nil or self.handler.Update == nil then
		return
	end
	self.handler:Update(dt)
end

return AutoChessAIController
