FsmMachine = {}
function FsmMachine:New()
    self.__index = self
    o = setmetatable({}, self)
    o.states = {}
    o.curState = nil
    return o
end

-- 添加状态
function FsmMachine:AddState(baseState)
    if self.states[baseState.stateName]==nil then
        baseState:OnInit()
        self.states[baseState.stateName] = baseState
    end
end
-- 初始化默认状态
function FsmMachine:AddInitState(stateName)
    self.curState = self.states[stateName]
    self.curState:OnEnter()
end

-- 更新当前状态
function FsmMachine:Update()
    if self.curState~=nil then
        self.curState:OnUpdate()
    end
end

function FsmMachine:GetCurrentState()
    if self.curState == nil then
        return nil
    end
    for k, v in pairs(self.states) do
        if v == self.curState then
            return k
        end
    end
    return nil
end

-- 切换状态
function FsmMachine:Switch(stateName, isForce)
    for k, v in pairs(BattleState) do
        if v == stateName then
            Logger.BattleLog("CurrentState----"..k)
            break
        end
    end
    for k, v in pairs(UnitBattleState) do
        if v == stateName then
            local bat = Game.Scene:GetComponent("BattleComponent").CurActUnit:GetComponent("SsUnitBattleComponent")
            Logger.BattleLog(bat.__entity.GameObject.name..":CurrentState----"..k)
            break
        end
    end
    if isForce == nil then isForce = true end
    if self.curState==nil then
        self:AddInitState(stateName)
    else
        if self.curState.stateName ~= stateName or isForce then
            self.curState:OnLeave()
            self.curState = self.states[stateName]
            self.curState:OnEnter()
        end
    end
end