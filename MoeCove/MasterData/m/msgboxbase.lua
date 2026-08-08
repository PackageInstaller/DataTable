local MsgBoxBase = class("MsgBoxBase", require("UIBase"))

function MsgBoxBase:ctor(data)
    
    self:Init(data)

end

function MsgBoxBase:Init(data)


end

function MsgBoxBase:OnDestroy(owner)

    local rootTransform
    if owner == nil then
        -- print("CommonBase OnDestroy", self.gameObject.name)
        local go = self.gameObject
        if not go or IsNull(go) then
            return
        end
        local trans = go.transform
        if not trans then
            return
        end
        -- 后续安全使用 trans
        rootTransform = self.gameObject.transform
    else
        -- print("CommonBase OnDestroy", owner.gameObject.name)
        if owner.gameObject == nil then
            return
        end
        rootTransform = owner.gameObject.transform
    end
    UICommonUtils.ClearAllListeners(rootTransform)
	
	
end

return MsgBoxBase