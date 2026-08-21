local GameObjectMgr = BaseClass("GameObjectMgr" , Singleton )

local M = GameObjectMgr 

function M:__init()
    self._viewDic = {}
end

function M:AddView(view)
    if view == nil then 
        return 
    end
    local id = view:GetInstanceID()
    if id == 0 then 
        return 
    end
    self._viewDic[id] = view 
end

function M:GetView(goInstanceId)
    if self._viewDic[goInstanceId] then 
        return self._viewDic[goInstanceId]
    end
    return nil 
end

function M:Remove(goInstanceId)
    if self._viewDic[goInstanceId] then 
        self._viewDic[goInstanceId] = nil  
    end
end

function M:Clear()
    self._viewDic = {}
end

return GameObjectMgr