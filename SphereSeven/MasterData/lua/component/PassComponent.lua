
---@class PassComponent
---@field passes Pass[]
local PassComponent = BaseClass("PassComponent", Component)
local base = Component
---@type PassComponent
local this = PassComponent

function this:Awake()
    base.Awake(self)
    self.passes = {}
end

function this:CoLoadData()
    ---@type protocol.PassResp
    local request = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
            PROTOCOL.PassReq, {})

    for index, value in ipairs(request.passes) do
        self:AddOrUpdatePass(value)
    end

    return coroutine.yieldbreak(request)
end

function this:Dispose()
    base.Dispose(self)
end

---@param pass protocol.Pass
function this:AddOrUpdatePass(pass)
    if self.passes[pass.id] == nil then
        self.passes[pass.id] = Game.Registry:NewObject("Pass", pass)
    else
        self.passes[pass.id]:UpdateData(pass)
    end
    
    ---@type GameEventComponent
    local gameEventComponent = Game.Scene.Player:GetComponent("GameEventComponent")
    if gameEventComponent ~= nil then
        gameEventComponent:RefreshModuleHint(nil, "PassReward", {
            id = pass.id
        })
    end
end

function this:GetPass(id)
    if id ~= nil then
        return self.passes[id]
    else
        return self.passes
    end
end

function this:GetCurrentBattlePass()
    local retPass = nil
    for id, pass in pairs(self.passes) do
        if pass.config.IsBattlePass == 1 and pass.status == PassStatus.PassStatusProgressing then
            retPass = pass
            break
        end
    end
    return retPass
end

function this:RemovePass(id)
    self.passes[id] = nil
end

return this