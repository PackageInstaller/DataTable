

---@class AutoChessBuffManager
local AutoChessBuffManager = class("AutoChessBuffManager")

---@param owner AutoChessEntity
function AutoChessBuffManager:ctor(owner)
	self.owner = owner
	self.buffMap = {}
end

---@param dt number
function AutoChessBuffManager:Update(dt)
	for buffId, buff in pairs(self.buffMap) do
		buff:Update(dt)
		if buff.isRemoved then
			self.buffMap[buffId] = nil
		end
	end
end

---@param buffId int
---@param source int 来源
function AutoChessBuffManager:AddBuff(buffId, source, runtimeData)
	local cfg = self:GetBuffConfig(buffId)
	if cfg == nil then
		return nil
	end
	local oldBuff = self.buffMap[buffId]
	if oldBuff then
		oldBuff:AddStack(runtimeData and runtimeData.stack or 1)
		oldBuff:Refresh(runtimeData)
		return oldBuff
	end
	local handler = self:CreateHandler(buffId, cfg)
	local buff = AutoChessBuff:new(self.owner, buffId, source, cfg, runtimeData, handler)
	self.buffMap[buffId] = buff
	buff:OnAdd()
	return buff
end

function AutoChessBuffManager:RemoveBuff(buffId)
	local buff = self.buffMap[buffId]
	if buff then
		buff:Remove()
		self.buffMap[buffId] = nil
	end
end

function AutoChessBuffManager:HasBuff(buffId)
	return self.buffMap[buffId] ~= nil
end

function AutoChessBuffManager:GetBuffConfig(buffId)
	if Config.GetAutoChessBuffInfo then
		return Config.GetAutoChessBuffInfo(buffId)
	end
	local cfgs = _G.AutoChessBuffConfigs
	return cfgs and cfgs[buffId] or nil
end

function AutoChessBuffManager:CreateHandler(buffId, buffConfig)
	local scriptName = buffConfig and buffConfig.script
	if scriptName == nil or scriptName == "" then
		scriptName = "Buff_" .. buffId
	end
	local ok, handler = pcall(require, "Buff." .. scriptName)
	if ok and handler then
		if type(handler) == "table" and handler.new then
			return handler:new()
		end
		return handler
	end
	return BuffHandlerBase:new()
end

return AutoChessBuffManager
