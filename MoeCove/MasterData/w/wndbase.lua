local WndBase = class("WndBase", require("UIBase"))

function WndBase:ctor(data)
    
    WndBase.Init(self, data)

end

function WndBase:Init(data)

end

function WndBase:OnDestroy(owner)

    local rootTransform
    if owner == nil then
        -- print("WndBase OnDestroy", self.gameObject.name)
        rootTransform = self.gameObject.transform
    else
        -- print("WndBase OnDestroy", owner.gameObject.name)
        rootTransform = owner.gameObject.transform
    end
    UICommonUtils.ClearAllListeners(rootTransform)
	
end

return WndBase