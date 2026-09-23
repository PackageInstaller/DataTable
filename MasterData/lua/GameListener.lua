

--收集打开页面
local OpenViewList={};
--点击虚拟按钮 可以关闭的按钮
local VirtualkeysBackCloseView={}


---是否移动平台
local IsMobileplatform=false;
--inpt
local Input=CS.UnityEngine.Input
local KeyCode=CS.UnityEngine.KeyCode

function Awake()
    CSAPI.Getplatform();
    IsMobileplatform=CSAPI.IsMobileplatform;
    --EventMgr.AddListener(EventType.Scene_Load_Complete,OnSceneLoadComplete);
    EventMgr.AddListener(EventType.Game_Log_Changed,OnGameLogChanged); 
    EventMgr.AddListener(EventType.Show_Prompt,OnShowPrompt);    
    EventMgr.AddListener(EventType.Web_Error,OnWebError);   
    --EventMgr.AddListener(EventType.Game_Quality_Changed,OnGameQualityChanged);    
    --SetGameLv(CSAPI.GetImgLv());
    --print("-----------------Awake----GameListener---------------")
    EventMgr.AddListener(EventType.View_Lua_Opened, VirtualkeysViewOpen);
    EventMgr.AddListener(EventType.View_Lua_Closed, VirtualkeysViewClose)
    local cfgs = Cfgs.view:GetAll()
    for _, v in pairs(cfgs) do
        local Virtualkeys_close = v.Virtualkeys_close and true or false
        if Virtualkeys_close then
            -- print("可以关闭的按钮："..v.key)
            table.insert(VirtualkeysBackCloseView, v.key);
        end
    end
    AdaptiveConfiguration.OnInit();
end

--function OnGameQualityChanged(lv)
--   SetGameLv(CSAPI.GetImgLv());
--end

function OnGameLogChanged(logState)
    _G.noLog = not logState;
end


function OnShowPrompt(content)
    CSAPI.OpenView("Prompt", 
    {
        content = content,
    });
end

function OnWebError(param)
    CSAPI.OpenView("Prompt", 
    {
        content = LanguageMgr:GetByID(38013),
    });
end



function Update()
    AdaptiveConfiguration.MonitorExecutiondata();
    CheckVirtualkeys()
end
---判断检测是否按了返回键
function CheckVirtualkeys()
    --仅仅安卓或者苹果平台生效
    if IsMobileplatform then
        if(Input.GetKeyDown(KeyCode.Escape))then
            OnVirtualkey()
        end
    end
end
--打开UI页面收集
function VirtualkeysViewOpen(event)
     --print("添加UI---"..tostring(event))
    table.insert(OpenViewList, event);
end
--关闭UI页面时候移除
function VirtualkeysViewClose(event)
    if #OpenViewList > 0 then
        local index = 0;
        for i = #OpenViewList, 1, -1 do
            if OpenViewList[i] == event then
                index = i;
                --print("移除页面："..table.tostring(OpenViewList[i]))
                break
            end
        end
        if index ~= 0 then
            table.remove(OpenViewList, index);
        end
    end
end

--获取最后一个 打开UI
function GetVirtualkeysLastViewKey()
    if OpenViewList and #OpenViewList > 0 then
        return OpenViewList[#OpenViewList];
    end
end
--关闭页面
function OnVirtualkey()
    local Viewname= GetVirtualkeysLastViewKey()
    --print("获取到："..Viewname)
    if VirtualkeyCloseView(Viewname) then
        -- print("关闭:"..Viewname)
       -- CSAPI.CloseView(Viewname);
         --特殊页面处理
        local viewGO = CSAPI.GetView(Viewname)
        if (viewGO) then
            if CSAPI.IsBeginnerGuidance()==false then
                local view = ComUtil.GetLuaTable(viewGO)
                if view.OnClickVirtualkeysClose then
                    ---print("关闭指定"..Viewname)
                    view.OnClickVirtualkeysClose()
                else
                    ---print("正常关闭整个"..Viewname)
                    CSAPI.CloseView(Viewname);
                end
            else
                --print("CSAPI.IsBeginnerGuidance()==true")
            end
        else
            Log("获取脚本信息失败："..Viewname)
        end

    else
        Log("未配置无法关闭："..Viewname);
    end
end

---判断是否可以关闭
function VirtualkeyCloseView(Viewname)
    if Viewname~=nil then
        if VirtualkeysBackCloseView and #VirtualkeysBackCloseView > 0 then
            for i = 1, #VirtualkeysBackCloseView do
                if VirtualkeysBackCloseView[i]==Viewname then
                    return true;
                end
            end
            return false;
        else
            return false;
        end
    else
        return false;
    end
end
function OnDestroy()
    -- print("-----------------OnDestroy---------GameListener----------")
    EventMgr.RemoveListener(EventType.View_Lua_Opened, VirtualkeysViewOpen);
    EventMgr.RemoveListener(EventType.View_Lua_Closed, VirtualkeysViewClose)
    Input=nil;
    KeyCode=nil
end