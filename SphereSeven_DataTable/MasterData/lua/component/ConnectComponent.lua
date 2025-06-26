
local ConnectComponent = BaseClass("ConnectComponent", Component)
local base = Component

local function Awake(self)
    base.Awake(self)
end

local function Dispose(self)
    base.Dispose(self)
end

ConnectComponent.Awake = Awake
ConnectComponent.Dispose = Dispose

return ConnectComponent