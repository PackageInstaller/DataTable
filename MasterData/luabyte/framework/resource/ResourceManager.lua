local ResourceManager = BaseClass("ResourceManager" , Singleton)
local M = ResourceManager

-- get view or ctrl by gameObject 
function M:GetViewAndCtrl(go)

    local uinty_view = go:GetComponent( typeof(CS.GameX.EditorUIView) )
    if IsNull(uinty_view) then 
        return nil
    end
    local luaViewClassName = uinty_view.m_Namespace .. "." .. uinty_view.m_ClassName
    if luaViewClassName == nil or luaViewClassName == '' then 
        return nil 
    end 
    local viewClass = require(luaViewClassName)
    local viewInstance = viewClass.New(go)
    if viewInstance == nil then 
        return viewInstance
    end
    
    local luaCtrlClassName = uinty_view.m_ctrlClassName
    local ctrlInstance = nil 
    if luaCtrlClassName ~= nil and  luaCtrlClassName ~= '' then 
        ctrlInstance = require(luaCtrlClassName).New(viewInstance) 
    end
    return viewInstance ,ctrlInstance
end

--create a view by path , view ctor param is gameobject 
function M:InstanceView(path,callback)
    if callback then 
        self:InstanceGameObject(path,function(go)
            local view = self:GetViewAndCtrl(go)
            callback(view)
            callback = nil 
        end)
    else
        local go = self:InstanceGameObject(path)
        return self:GetViewAndCtrl(go)
    end
end

-- create a ctrl by path , ctrl ctor param is view   
function M:InstanceCtrl(path,callback)
    if callback then 
        self:InstanceGameObject(path,function(go)
            local _,ctrl = self:GetViewAndCtrl(go)
            callback(ctrl)
            callback = nil 
        end)
    else
        local go = self:InstanceGameObject(path)
        local _,ctrl = self:GetViewAndCtrl(go)
        return ctrl
    end
end

function M:InstanceGameObject(path,callback)
    if IResourceManager == nil then 
        return 
    end
    return IResourceManager:InstanceGameObject(path,callback)
end

function M:SetRawImage( path,rawImg )
    if IResourceManager == nil then 
        return 
    end
    IResourceManager:SetRawImage(path,rawImg)
end

function M:RemoveUnusedAssets()
    if IResourceManager == nil then 
        return 
    end
    IResourceManager:RemoveUnusedAssets()
    Logger.Log("RemoveUnusedAssets")
end

return ResourceManager