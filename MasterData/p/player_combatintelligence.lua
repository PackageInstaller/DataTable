-- Desc: 玩家战斗情报功能
---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end


------------------WorkOrder------------------
local secrteIngelligence = 2 	--秘密情报类型
---获得情报数据
function Player:GetCombatIngelligenctInfo()
	return self.combatIntelligenctInfo
end


---监测情报过期 清理过期情报
---@param userinfo UserInfo
function Player:checkCombatIntelligence(userinfo)
	local info = self:GetCombatIngelligenctInfo()
	local curTime = DLuaUtil.GetGreenwichTime()

	local delKey = {}
	for k, v in pairs(info) do
		local id = v.id
		local cfg = Config.GetIntelligenceById(id)
		if cfg == nil then
			table.insert(delKey, k)
			goto continue
		end
		if id == self.curBattlLevelId then	--进行中的战斗不删除
			goto continue
		end
		---持续中的 不删除
		if curTime <= (v.createTime + cfg.countDown) then
			goto continue
		end
		table.insert(delKey, k)
		::continue::
	end
	if #delKey == 0 then
		return
	end

	for k, v in ipairs(delKey) do
		info[v] = nil
		userinfo.combatIntelligenctInfo = userinfo.combatIntelligenctInfo or {}
		userinfo.combatIntelligenctInfo[v] = {}
	end
end


---随机情报
---@param eventId integer 事件id
---@param userinfo UserInfo
function Player:RandomCombatIntellgence(eventId, userinfo)
	if self:getFunctionOpenStateById(GE.FunctionOpenModule.CombatIntelligenct) == GE.FunctionOpenState.Lock then
		return
	end
	local eventCfg = Config.GetEventTriggerInfo(eventId)
	if eventCfg == nil then
		return
	end
	local r = eventCfg.parameter
	---@type IntelligenceTable[]1
	local tab = {}
	local allWeight = 0
	local allCfg = Config.GetIntelligenceTable()
	if allCfg == nil then
		return
	end

	local curTime = DLuaUtil.GetGreenwichTime()
	local info = self:GetCombatIngelligenctInfo()

	---移除过期情报
	self:checkCombatIntelligence(userinfo)

	for k, v in pairs(allCfg) do
		if v.page ~= secrteIngelligence then
			goto continue
		end
		if info[v.id] ~= nil then
			goto continue
		end
		if r ~= nil and tablex.indexof(r, v.sign) < 0 then
			goto continue
		end
		local isOpen = self:canOpenFunctionByCfg(v.unlock)
		if not isOpen then
			goto continue
		end
		table.insert(tab, v)
		allWeight = allWeight + v.weight
		::continue::
	end
	if allWeight == 0 then
		return
	end

	local randomVal = math.random(allWeight)
    local randomId = 0
	local t = 0
    for i = 1, #tab, 1 do
        local cfg = tab[i]
		t = t + cfg.weight
        if t >= randomVal then
            randomId = cfg.id
            break
        end
    end
	if randomId == 0 then
		return
	end

	info[randomId] = {
		id = randomId,
		createTime = curTime,
		finish = false,
	}
	userinfo.combatIntelligenctInfo = userinfo.combatIntelligenctInfo or {}
	userinfo.combatIntelligenctInfo[randomId] = info[randomId]

	--日志
	if DataLogMgr then
		DataLogMgr.LogHomeCombatIntelligence({
			intelId = randomId,
			state = 1,
		}, self)
	end

	return ActionFailReason.None
end

---进入战斗判断情报战斗是否可以开启
---@param battleId integer
---@return ActionFailReason
function Player:CheckEnterIntelligenceBattle(battleId)
	local cfg = Config.GetIntelligenceById(battleId)
	if cfg == nil then
		return ActionFailReason.None
	end

	if self:getFunctionOpenStateById(GE.FunctionOpenModule.CombatIntelligenct) == GE.FunctionOpenState.Lock then
		return ActionFailReason.FunctionOpenNotOpen
	end

	if cfg.page ~= secrteIngelligence then		
		local levelData = self:getLevelDataByid(battleId)
        if levelData ~= nil and levelData.completeNum > 0 then
           return ActionFailReason.Intelligence_EnterBattle_IsFinish  --当前情报已经完成
        end
	else
		local ingelligenctInfo = self:GetCombatIngelligenctInfo()
		local info = ingelligenctInfo[battleId]
		if info == nil then
			return ActionFailReason.Intelligence_EnterBattle_IsLock  --当前情报未开启
		end
		if info.finish then
			return ActionFailReason.Intelligence_EnterBattle_IsFinish  --当前情报已经完成
		end
		local serverTime = DLuaUtil.GetGreenwichTime()
		if serverTime > info.createTime + cfg.countDown then
			return ActionFailReason.Intelligence_EnterBattle_IsPast  --当前情报已经过期
		end
	end
	return ActionFailReason.None
end

---完成情报
---@param battleId integer
---@param userinfo UserInfo
function Player:FinishCombatIntellgence(battleId, userinfo)
	local info = self:GetCombatIngelligenctInfo()
	if info[battleId] == nil then
		return
	end
	info[battleId].finish = true
	userinfo.combatIntelligenctInfo = userinfo.combatIntelligenctInfo or {}
	userinfo.combatIntelligenctInfo[battleId] = {
		id = battleId,
		finish = true,
	}

	--日志
	if DataLogMgr then
		DataLogMgr.LogHomeCombatIntelligence({
			intelId = battleId,
			state = 2,
		}, self)
	end
end

---获取情报数量 按类型分类
---@return int[]
function Player:GetIntelligenctInfoCount()
    local num = {0, 0, 0}
	local infoDatas = self:GetCombatIngelligenctInfo()
	local serverTime = EngineUtil.ServerTime_Seconds()

	if self.intelCfgArray == nil then
		local cfg = Config.GetIntelligenceTable()
		self.intelCfgArray = {}
		for k, v in pairs(cfg) do
			table.insert(self.intelCfgArray, v)	
		end
		table.sort(self.intelCfgArray, function(a, b)
			return a.id < b.id
		end)
	end
    for i = 1, #self.intelCfgArray do
		local v = self.intelCfgArray[i]
		if num[v.type] == nil then
			goto continue
		end
        local levelData = self:getLevelDataByid(v.id)
        if levelData ~= nil and levelData.completeNum > 0 then
           goto continue
        end
        if not self:canOpenFunctionByCfg(v.show) then
            goto continue
        end
		if v.type == 3 then
			if infoDatas == nil then
				goto continue
			end
			local infoData = infoDatas[v.id]
			if infoData == nil or infoData.finish then
				goto continue
			end
			local dur = v.countDown
            if serverTime > (infoData.createTime + dur) then
               goto continue
            end
		end
		num[v.type] = num[v.type] + 1
        ::continue::
    end
	return num
end

--更新情报数据 前端用
function Player:updateCombatIntelligenctInfo(data)
    local info = self:GetCombatIngelligenctInfo()
	DLuaUtil.UpdateTable(info, data)
end

return Player