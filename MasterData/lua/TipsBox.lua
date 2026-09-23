-- 飘字
local delayTime = 1.8; -- 显示时间
local timer = 0; -- 计时器
local canCount = false; -- 是否开始计时
local closeCallBack = nil; -- 关闭回调
local isTween = false
function Show(data)
    if data ~= nil then
        local content = data.content or "";
        CSAPI.SetText(text_content, content);
        isTween = data.isTween
        if data.closeCallBack then
            closeCallBack = data.closeCallBack;
        end
    end
    if (isTween) then
        ShowAction(function()
            canCount = true;
        end);
    else
        canCount = true;
    end
end

function ResetTime()
    timer = 0
end

function Update()
    if canCount then
        timer = timer + Time.fixedDeltaTime;
        if timer >= delayTime then
            Close();
        end
    end
end

-- 关闭
function Close(_isTween)
    _isTween = _isTween == nil and true or _isTween;
    timer = 0;
    canCount = false;
    if closeCallBack then
        closeCallBack(this);
    end
    if _isTween then
        HideAction(function()
            CSAPI.SetGOActive(gameObject, false);
            view:Close();
        end);
    else
        CSAPI.SetGOActive(gameObject, false);
        view:Close();
    end
end

function ShowAction(callBack)
    CSAPI.ApplyAction(gameObject, "View_Open_Scale2", callBack);
    -- if open_tween then
    --     open_tween:Play(callBack);
    -- else
    --     open_tween=CSAPI.ApplyAction(gameObject,"View_Open_Scale",callBack);
    -- end
end

function HideAction(callBack)
    -- CSAPI.ApplyAction(gameObject, "View_Close_Scale_Smaller", callBack);
    CSAPI.MoveTo(gameObject,"UI_Local_Move",0,150,0,callBack,0.1)
    CSAPI.ApplyAction(gameObject, "Fade_Out_100");
    -- if close_tween then
    --     close_tween:Play(callBack);
    -- else
    --     close_tween=CSAPI.ApplyAction(gameObject,"View_Close_Scale_Smaller",callBack);
    -- end
end
function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    text_content = nil;
    view = nil;
end
----#End#----
