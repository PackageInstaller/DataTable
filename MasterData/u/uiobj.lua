--template的对象池  


---@class UIObj:BaseClass
local UIObj = class("UIObj")

---@param gameObject UnityEngine.GameObject
---@param ui UIBase
function UIObj:ctor(gameObject, ui)
    self.ui = ui
    self.index = 0
    self.data = nil
    self.gameObject = gameObject
    self.transform = gameObject.transform
end

function UIObj:Initialize()

end

function UIObj:SetData(data)
    self.data = data
end

function UIObj:SetIndex(index)
    self.index = index
end




---@param gameObject UnityEngine.GameObject
---@param ui UIBase
---@param peerTab table?
function UIObj:Create(gameObject, ui, peerTab)
    local uiObj = self:new(gameObject, ui)

    if peerTab ~= nil then
        uiObj:SetPeerTemplate(peerTab)
    end
    uiObj:Initialize()
    return uiObj
end

---获取子物体组件
---@param path string 子物体路径
---@param type userdata unityType
---@return userdata|nil
function UIObj:GetChildCompon(path, type)
    local child = self.transform
    if not string.isNullOrEmpty(path) then
        child = self.transform:Find(path)
    end
    if IsNull(child) then
        LuaLogger.es(self.__cname .. "  获取子物体错误 未找到对应子物体 " .. path)
        return nil 
    end
    local com = child:GetComponent(type)
    return com
end


function UIObj:SetPeerTemplate(template)
    self.peerTemplate = template

    local inst = self.gameObject
    EngineUtil.FillPeer(template, inst, self)
end

return UIObj