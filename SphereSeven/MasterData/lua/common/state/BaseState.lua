BaseState = {}
function BaseState:New(stateName)
    self.__index = self
    o = setmetatable({}, self)
    o.stateName = stateName
    return o
end
-- 初始化
function BaseState:OnInit()
end
-- 进入状态
function BaseState:OnEnter()
end
-- 更新状态
function BaseState:OnUpdate()
end
-- 离开状态
function BaseState:OnLeave()
end