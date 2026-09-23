--场景加载，加载完回调
SceneLoader = {};
local this = SceneLoader;

function this:Load(scene,callBack,caller)
    if(self.isInited == nil)then    
        self.isInited = 1;
        EventMgr.AddListener(EventType.Scene_Load_Complete,self.OnSceneLoadComplete);
    end
    if(callBack)then
        self.list = self.list or {};
         table.insert(self.list,{caller = caller,callBack = callBack});
    end
   
    EventMgr.Dispatch(EventType.Scene_Load,scene);
end


--场景加载完成
function this.OnSceneLoadComplete(param)
   this:SceneLoadComplete(param);
end

function this:SceneLoadComplete(param)
    if(self.list)then
        for _,data in ipairs(self.list)do
            if(data.caller)then
                data.callBack(data.caller);
            else
                data.callBack();
            end
        end
        self.list = nil;
    end
end

--加载指定场景并打开指定界面
function this:LoadAndOpen(scene,viewKey,viewData,viewSetting)
    self.loadedData = {viewKey = viewKey,viewData = viewData,viewSetting = viewSetting};
    self:Load(scene,self.OnLoadCallBack,self)
end
function this:OnLoadCallBack()
    local data = self.loadedData;
    if(data and not MenuMgr:CheckOpenList())then
        CSAPI.OpenView(data.viewKey,data.viewData,data.viewSetting);
    end
    self.loadedData = nil;
end

return this;