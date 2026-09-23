local csDispatchEvent = CS.CSAPI.DispatchEvent;
function DispatchEventToCS(id,param)
    if(id == nil)then
        LogError("事件id不能为空");
        LogError(a.b);
    end
  
    csDispatchEvent(id,param);
end


function Awake()
    listenerItems = {};

    --事件管理器
    _G.EventMgr = this;
end

function OnEventFromCS(id,param)
--    LogError("===============");
--    LogError("CS事件：" .. id);
--    LogError(param);
    Dispatch(id,param);
end

--添加监听器
function AddListener(id,func,caller)
    if(func == nil)then
        LogError("注册监听器失败！！！方法为空");
        LogError(a.b);
    end

    data = data or {};
    data[id] = data[id] or {};
    local list = data[id];

    local listenerItem = GetListenerItem();
    listenerItem.caller = caller;
    listenerItem.func = func
    table.insert(list,listenerItem);
end


function GetListenerItem()
    local count = #listenerItems;
    if(count > 0)then
        local item = listenerItems[count];
        listenerItems[count] = nil;
        return item;
    else
        return {};
    end
end

--移除监听器
function RemoveListener(id,func)
     if(data ~= nil and data[id] ~= nil)then
        local list = data[id];
        for i,listener in ipairs(list)do         
            if(func == listener.func)then
                --table.remove(list,i);
                listener.func = nil;
                listener.caller = nil;
                break;                
            end
        end
    end
end
--调度事件
function Dispatch(id,param,toCS)
--    LogError("=============================");
--    LogError("调度事件：" .. id);
--    LogError(param);    
    local needFix = nil;

    if(data and data[id] ~= nil)then
        local list = data[id];
      
        for _,listener in ipairs(list)do            
            local caller = listener.caller;
            local func = listener.func;

            if(func)then
                if(caller == nil)then
                    func(param);              
                else
                    func(caller,param);              
                end
            else
                needFix = 1;
            end
        end
    end

    --调度CS事件
    if(toCS)then
        DispatchEventToCS(id,param);
    end

    if(needFix)then
        FixEventList(id);
    end
end

function FixEventList(id)
    local list = data and data[id];    
    if(list)then
        local count = #list;
        for i = 1,count do
            local index = count - i + 1;
            if(not list[index] or not list[index].func)then
                if(list[index])then
                    table.insert(listenerItems,list[index]);
                end          
                table.remove(list,index);      
            end            
        end
    end
end

function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  

end
----#End#----