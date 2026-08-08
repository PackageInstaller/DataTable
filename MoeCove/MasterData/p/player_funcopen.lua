-- 功能开放相关逻辑
---@class Player
local Player = require "Player"
local json, DataLogMgr
if GV.IsServer then
    json = require "json"
    DataLogMgr = require "DataLogMgr"
end



--获取功能开启状态列表
function Player:getFunctionOpenList()
    return self.funtionOpenMap
end

--根据功能id获取功能开启状态
---@param functionId integer
---@return FunctionOpenState?
function Player:getFunctionOpenStateById(functionId)
    local Maplist = self:getFunctionOpenList()
    local state = Maplist[functionId]
    return state
end

--计算功能开启状态（内部辅助方法）
---@param functionId integer
---@return FunctionOpenState
function Player:_calcFunctionState(functionId)
    return self:canOpenFunctionById(functionId) and GE.FunctionOpenState.Open or GE.FunctionOpenState.Lock
end

--登录时检查更新功能开关配置
---@param userinfo UserInfo?
function Player:checkFunctionOpenState(userinfo)
    if not self.funtionOpenMap then
        self.funtionOpenMap = {}
    end

    local functionCfgList = Config.GetAllConfig("FunctionOpenTable") or {}
    local changed = false

    for _, cfg in pairs(functionCfgList) do
        if not self.funtionOpenMap[cfg.id] then
            self.funtionOpenMap[cfg.id] = self:_calcFunctionState(cfg.id)
            changed = true
        end
    end

    if userinfo and changed then
        userinfo.funtionOpenMap = self.funtionOpenMap
    end
end

--根据功能id查询该功能是否可以开启，返回boolean
--前端不要用这个来判断功能是否开启，前端使用 UICommonUtils.CheckFunctionOpen !!!!!再乱用打死！
---@param functionId integer
---@return boolean
function Player:canOpenFunctionById(functionId)
    local functionCfg = Config.GetFunctionOpenInfo(functionId)
    --遍历解锁条件列表，根据不同类型查找条件是否达成，列表内条件全打成返回true
    if not functionCfg then
        return false
    end
    return self:canOpenFunctionByCfg(functionCfg.unlock)
end

--根据功能id查询该功能是否可以开启，返回boolean
---@param unlockTab table
---@return boolean
function Player:canOpenFunctionByCfg(unlockTab)
    if not unlockTab then
        return false
    end
    for _, unlock in pairs(unlockTab) do
        if unlock[1] == GE.CommonLockJudgeType.Level then
            --判断当前关卡是否通关
            local levelData = self:getLevelDataByid(unlock[2])
            --如果关卡没数据或者关卡有数据但未通关返w回false
            if not levelData or levelData.state ~= GE.LevelStateType.Finish then
                return false
            end
        elseif unlock[1] == GE.CommonLockJudgeType.UserLevel then
            local nowUserLevel = self:getUserLevel()
            --判断当前玩家等级是否满足
            local minLevel = unlock[2]
            local maxLevel = unlock[3] or 9999
            if nowUserLevel < minLevel or nowUserLevel > maxLevel then
                return false
            end
        elseif unlock[1] == GE.CommonLockJudgeType.BulidLevel then
            local buildData = self:getConstructionDataById(unlock[2])
            if buildData ~= nil then
                if buildData.level < unlock[3] then
                    return false
                end
            end
        elseif unlock[1] == GE.CommonLockJudgeType.Time then
            local nowTime = DLuaUtil.GetGreenwichTime()
            if nowTime < unlock[2] then
                return false
            end
        elseif unlock[1] == GE.CommonLockJudgeType.Questionnaire then
            local qnaireInfo = self.qnaireMap[unlock[2]]
            if not qnaireInfo or not qnaireInfo.isCompleted then
                return false
            end
        elseif unlock[1] == GE.CommonLockJudgeType.ProsperityLevel then
            local prosperityInfo = self:getProsperityInfo()
            if prosperityInfo.currentLevel < unlock[2] then
                return false
            end
        end
    end
    return true
end

--根据功能id查询该功能是否可以开启，返回boolean
---@param unlockTab table
---@return boolean
function Player.canOpenFunctionByCfg2(self, unlockTab)
    if not unlockTab then
        return false
    end
    for _, unlock in pairs(unlockTab) do
        if unlock[1] == GE.CommonLockJudgeType.Level then
            --判断当前关卡是否通关
            local levelData = self.pveLevelMap[unlock[2]]
            --如果关卡没数据或者关卡有数据但未通关返回false
            if not levelData or levelData.state ~= GE.LevelStateType.Finish then
                return false
            end
        elseif unlock[1] == GE.CommonLockJudgeType.UserLevel then
            local nowUserLevel = self.level
            --判断当前玩家等级是否满足
            if nowUserLevel < unlock[2] then
                return false
            end
        elseif unlock[1] == GE.CommonLockJudgeType.BulidLevel then
            local buildData = self.homeland.buildingList[unlock[2]]
            if buildData ~= nil then
                if buildData.level < unlock[3] then
                    return false
                end
            end
        elseif unlock[1] == GE.CommonLockJudgeType.Time then
            local nowTime = DLuaUtil.GetGreenwichTime()
            if nowTime < unlock[2] then
                return false
            end
        elseif unlock[1] == GE.CommonLockJudgeType.Questionnaire then
            local qnaireInfo = self.qnaireMap[unlock[2]]
            if not qnaireInfo or not qnaireInfo.isCompleted then
                return false
            end
        elseif unlock[1] == GE.CommonLockJudgeType.ProsperityLevel then
            local prosperityInfo = self:getProsperityInfo()
            if prosperityInfo.currentLevel < unlock[2] then
                return false
            end
        end
    end
    return true
end

--请求开启某个功能（用于埋在系统里）
---@param functionType CommonLockJudgeType
---@param proto UserInfo?
function Player:FunctionOpenTrigger(functionType, proto)
    --遍历配置，找到解锁条件相同的配置
    local funtionOpenMap = self:getFunctionOpenList()
    local functionCfgList = Config.GetFunctionOpenInfoByType(functionType)
    if not functionCfgList then
        return
    end

    for _, cfg in pairs(functionCfgList) do
            local canOpen = self:canOpenFunctionById(cfg.id)
            local state = self:getFunctionOpenStateById(cfg.id)
            if canOpen and state == GE.FunctionOpenState.Lock then
                funtionOpenMap[cfg.id] = GE.FunctionOpenState.Open
                --如果拥有上一级，需要将上一级的状态改为Open
                if cfg.preId ~= 0 then
                    local preState = self:getFunctionOpenStateById(cfg.preId)
                    if preState ~= nil then
                        funtionOpenMap[cfg.preId] = GE.FunctionOpenState.Open
                    end
                end
            end
        end

    if proto then
        if not proto.funtionOpenMap then
            proto.funtionOpenMap = {}
        end
        proto.funtionOpenMap = funtionOpenMap
    end
    -- GameMsgMgr:sendEvent(GameMsgType.FunctionOpenMapUpdate)
end

--根据功能id修改功能开启状态
---@param functionId integer
---@param proto UserInfo?
---@return ActionFailReason
function Player:setFunctionReadById(functionId, proto)
    if not functionId then
        return ActionFailReason.ParameterInvalid
    end
    local nowState = self:getFunctionOpenStateById(functionId)
    if not nowState then
        return ActionFailReason.FunctionOpenNotExist
    end

    --判断是否已经开启
    if nowState ~= GE.FunctionOpenState.Open then
        return ActionFailReason.None
    end

    self:getFunctionOpenList()[functionId] = GE.FunctionOpenState.Read

    if proto then
        if not proto.funtionOpenMap then
            proto.funtionOpenMap = {}
        end
        proto.funtionOpenMap = self:getFunctionOpenList()
    end
    return ActionFailReason.None
end


return Player
