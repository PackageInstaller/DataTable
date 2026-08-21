require "class"

---@class RoomDoor
local RoomDoor = class("RoomDoor")


---@class RoomDoorData
---@field timeType string 时间配置类型
---@field obj UnityEngine.GameObject 门的游戏对象

function RoomDoor:ctor(data)
    if data.timeType == nil or UICommonUtils.Checkobj(data.obj) == false then
        LuaLogger.e("RoomDoor:ctor error param")
        return
    end
    if data.timeType == "elevator" then
        self.minOpenTime = Config.GetConfigInfo("ElevatorOpenLast")[1]
        self.maxOpenTime = Config.GetConfigInfo("ElevatorOpenLast")[2]
        self.minCloseTime = Config.GetConfigInfo("ElevatorInterval")[1]
        self.maxCloseTime = Config.GetConfigInfo("ElevatorInterval")[2]
    else
        self.minOpenTime = Config.GetConfigInfo("DoorOpenLast")[1]
        self.maxOpenTime = Config.GetConfigInfo("DoorOpenLast")[2]
        self.minCloseTime = Config.GetConfigInfo("DoorInterval")[1]
        self.maxCloseTime = Config.GetConfigInfo("DoorInterval")[2]
    end
    self.animator = data.obj.transform:GetComponent(TypeInfo.Animator)
    self.animOverCallBack = data.obj.transform:GetComponent(TypeInfo.AnimOverCallBack)
    self.state = GE.RoomDoorState.Close  -- 初始状态为关闭


    self.doorColliderComponent = data.obj.transform:Find("DoorCollider")

    self.playersInTrigger = 0
    self.doorColliderCallBack = self.doorColliderComponent:GetComponent("DoorColliderCallBack")
    self.doorColliderCallBack.OnTriggerEnterAction = function(other) self:OnTriggerEnter(other) end
    self.doorColliderCallBack.OnTriggerExitAction = function(other) self:OnTriggerExit(other) end


    ---@type DTimer.TimerInfo
    self.openTimer = nil  -- 开启计时器
    ---@type DTimer.TimerInfo
    self.closeTimer = nil  -- 关闭计时器
end


function RoomDoor:OnTriggerEnter(other)

    if other.gameObject.layer == LayerMask.NameToLayer("SeaMapPlayer") then
        -- LuaLogger.es("OnTriggerEnter ===",other.gameObject.name)

        self.playersInTrigger = self.playersInTrigger + 1

        if self.playersInTrigger == 1 then
            self:passDoorSelf()

        end

    end
    
end


function RoomDoor:OnTriggerExit(other)

    if other.gameObject.layer == LayerMask.NameToLayer("SeaMapPlayer") then
        -- LuaLogger.es("OnTriggerExit ===",other.gameObject.name)

        self.playersInTrigger = self.playersInTrigger - 1
        
        -- 确保计数不小于 0
        self.playersInTrigger = math.max(0, self.playersInTrigger)

        -- 如果玩家计数归零，则关门
        if self.playersInTrigger == 0 then
            self:closeDoorSelf()
        end

        local roleMgr = CoveRoleManager.instance() --角色管理器
        if roleMgr ~= nil then
            
            roleMgr:ShowRoleHomeMood(other)
        end

    end

    
end

--能否通过
function RoomDoor:canPass()
    return true
end

--通过门（通过canPass判断能通过时调用）
function RoomDoor:passDoor()

end

--关闭门
function RoomDoor:closeDoor()

end

function RoomDoor:passDoorSelf()
    --门处于开启状态直接通过
    if self.state == GE.RoomDoorState.Open then
        return
    end
    --门处于关闭状态，开启门
    self.state = GE.RoomDoorState.Open
    --播放开门动画
    self.animator:SetTrigger("Open")
    self.animOverCallBack:SetCallBack(function()
        self.animator:SetTrigger("Idle2")
        --播放开门动画结束回调
    end)
    
end

--关闭门
function RoomDoor:closeDoorSelf()
    self.state = GE.RoomDoorState.Lock
    --播放关门动画
    self.animator:SetTrigger("Close")
    self.animOverCallBack:SetCallBack(function()
        self.animator:SetTrigger("Idle1")
        --播放关门动画结束回调
    end)

end

function RoomDoor:clear()
    if self.doorColliderCallBack ~= nil then
        self.doorColliderCallBack.OnTriggerEnterAction = nil
        self.doorColliderCallBack.OnTriggerExitAction = nil
        self.doorColliderCallBack = nil
    end
    if self.animator ~= nil then
        self.animator:SetTrigger("Idle1")
        self.animator = nil
    end
    if self.animOverCallBack ~= nil then
        self.animOverCallBack:SetCallBack(nil)
        self.animOverCallBack = nil
    end
end
return RoomDoor