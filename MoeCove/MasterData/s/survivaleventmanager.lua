require "class"
---@class SurvivalEventManager
local SurvivalEventManager = class("SurvivalEventManager")

function SurvivalEventManager:ctor(...)
	---待触发事件列表
	---@class waitingEvent
	---@field delay number 事件触发延迟时间
	---@field eventType number 事件类型
	---@field eventData table 事件数据
	self._waitingEventList = {}
	self._eventList = {}
	self._eventList[GE.SurvivalEventType.RoleCreate] = self.CreateRole
	self._eventList[GE.SurvivalEventType.KillEnemyAll] = self.KillEnemyAll
	self._eventList[GE.SurvivalEventType.PlayerHpChange] = self.PlayerHpChange
	self._eventList[GE.SurvivalEventType.GameOver] = self.GameOver
	self._eventList[GE.SurvivalEventType.PlayerExpChange] = self.PlayerExpChange
end

--------------------------------事件处理------------------------------
--#region

---角色生成
---@param roleData roleCreateData
function SurvivalEventManager:CreateRole(roleData)
	-- LuaLogger.ds("SurvivalEventManager创建角色", tablex.dump(roleData))
	SurvivalManager.instance():GetRoleMgr():CreateRole(roleData)
end

---击杀所有敌人
function SurvivalEventManager:KillEnemyAll()
	SurvivalManager.instance():GetRoleMgr():KillAllEnemies()
end

---玩家血量变化
function SurvivalEventManager:PlayerHpChange()
	-- LuaLogger.ds("SurvivalEventManager玩家血量变化")
	local ui = SurvivalManager.instance():GetMainUI()
	ui:UpdatePlayerHp()
end

function SurvivalEventManager:PlayerExpChange()
	local ui = SurvivalManager.instance():GetMainUI()
	if ui and ui.RefreshExpUI then
		ui:RefreshExpUI()
	end
end

function SurvivalEventManager:GameOver()
	SurvivalManager.instance():ChangeState(GE.SurvivalStateEnum.GameOver)
end


--#endregion
--------------------------------事件处理------------------------------

function SurvivalEventManager:Update(deltaTime)
	for i = #self._waitingEventList, 1, -1 do
		local event = self._waitingEventList[i]
		event.delay = event.delay - deltaTime
		if event.delay <= 0 then
			self:_TriggerEvent(event)
			table.remove(self._waitingEventList, i)
		end
	end
end

---添加事件
---@param delay number 事件触发延迟时间
---@param eventType number 事件类型 GE.SurvivalEventType
---@param eventData table 事件数据
function SurvivalEventManager:AddEvent(delay, eventType, eventData)
	local event = {
		delay = delay,
		eventType = eventType,
		eventData = eventData
	}
	-- LuaLogger.ds("SurvivalEventManager添加事件", tablex.dump(event))
	table.insert(self._waitingEventList, event)
end

---触发事件
---@param event waitingEvent
function SurvivalEventManager:_TriggerEvent(event)
	-- LuaLogger.ds("SurvivalEventManager触发事件", tablex.dump(event))
	local handler = self._eventList[event.eventType]
	if handler then
		handler(self, event.eventData)
	else
		print("未处理的事件类型:", event.eventType)
	end
end

---实例化
---@return SurvivalEventManager SurvivalEventManager
function SurvivalEventManager.instance()
	if (SurvivalEventManager._instance == nil) then
		SurvivalEventManager._instance = SurvivalEventManager:new()
	end
	return SurvivalEventManager._instance
end


function SurvivalEventManager:Clear()
	
end

return SurvivalEventManager