
---@class BattleCore
local _mt = {}
local SkillConditionHandler
local SkillTargetHandler
local BattleManager
local BattleRoleManager
local EventManager
local SkillManager
local BuffHandler
local BattleStoryManager

---获取战斗管理器
---@return BattleManager
function _mt:getBattleMgr()
    BattleManager = BattleManager or require "BattleManager"
    return BattleManager.instance()
end

---获取战斗角色管理器
---@return BattleRoleManager BattleRoleManager
function _mt:getBattleRoleMgr()
    BattleRoleManager = BattleRoleManager or require "BattleRoleManager"
    return BattleRoleManager.instance()
end

---获取事件管理器
---@return EventManager EventManager
function _mt:getEventMgr()
    EventManager = EventManager or require "EventManager"
    return EventManager.instance()
end

---获取技能管理器
---@return SkillManager SkillManager
function _mt.getSkillMgr()
    SkillManager = SkillManager or require "SkillManager"
    return SkillManager.instance()
end

---获取Buff处理器
---@return BuffHandler BuffHandler
function _mt.getBuffHandler()
    BuffHandler = BuffHandler or require "BuffHandler"
    return BuffHandler.instance()
end

---获取演出管理器
---@return BattleStoryManager BattleStoryManager
function _mt:getBattleStoryManager()
    BattleStoryManager = BattleStoryManager or require "BattleStoryManager"
    return BattleStoryManager.instance()
end

---获取目标筛选器
---@return SkillTargetHandler SkillTargetHandler
function _mt:getSkillTargetHandler()
    SkillTargetHandler = SkillTargetHandler or require "SkillTargetHandler"
    return SkillTargetHandler:instance()
end

---获取条件检测器
---@return SkillConditionHandler
function _mt:getSkillConditionHandler()
    SkillConditionHandler = SkillConditionHandler or require "SkillConditionHandler"
    return SkillConditionHandler:instance()
end

function _mt.ds(...)
    if BattleManager then
        BattleManager.ds(...)
    end
end

function _mt.ws(...)
    if BattleManager then
        BattleManager.ws(...)
    end
end

function _mt.es(...)
    if BattleManager then
        BattleManager.es(...)
    end
end

return _mt