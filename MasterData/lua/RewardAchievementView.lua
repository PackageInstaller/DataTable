-- 奖励面板
local isCanBack = false
local layout = nil;
local svUtil = nil
local currLevel = 1

local fade = nil
local datas = nil

function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/Popup/RewardAchievementItem", LayoutCallBack, true)
    layout:AddOnValueChangeFunc(OnValueChange)
    svUtil = SVCenterDrag.New()

    fade = ComUtil.GetCom(gameObject, "ActionFade")

    CSAPI.SetGOActive(clickMask,false)
end

function OnValueChange()
    local index = layout:GetCurIndex()
    if index + 1 ~= currLevel then
        currLevel = index + 1
    end
    svUtil:Update()
end

function OnEnable()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RewardPanel_Post_Close, OnClickMask)
end

function OnDisable()
    eventMgr:ClearListener()
    CloseCallBack();
end

function OnDestroy()
    CloseCallBack();
    ReleaseCSComRefs()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        lua.SetIndex(index)
        lua.Refresh(datas[index])
    end
end

function CloseCallBack()
    -- 关闭回调
    if (openSetting.closeCallBack) then
        local callBack = openSetting.closeCallBack;
        local caller = openSetting.caller;
        openSetting.closeCallBack = nil;
        openSetting.caller = nil;
        callBack(caller);
    end
end

-- rewardDatas list|sNumInfo  
function OnOpen()
    -- music
    CSAPI.PlayUISound("ui_getitems")
    PlayAnim(900)
    -- fade
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(bg1, false)
        CSAPI.SetGOActive(black, false)
        CSAPI.SetGOActive(shaderObj, true)
    end,this,767)

    datas = data
    if (datas) then
        ShowList()
    end
    CSAPI.SetGOActive(txtMask, true)
end

function ShowList()
    layout:IEShowList(#datas)
    svUtil:Init(layout, #datas, {237, 237}, 5, 0.1, 0.82)
end

function OnClickMask()
    EventMgr.Dispatch(EventType.RewardPanel_Close);
    EventMgr.Dispatch(EventType.Money_Update);
    EventMgr.Dispatch(EventType.Dungeon_Group_Open)

    fade:Play(1, 0, 167, 0, function()
        view:Close()
    end)
end

function OnClickNext()
    currLevel = currLevel + 1
    layout:MoveToIndex(currLevel)
end

function OnClickBack()
    currLevel = currLevel - 1
    layout:MoveToIndex(currLevel)
end

function PlayAnim(time)
    CSAPI.SetGOActive(clickMask, true)
    time = time or 0
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(clickMask, false)
    end,this,time)
end


----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    bg1 = nil;
    black = nil;
    shaderObj = nil;
    txtTitle1 = nil;
    txtMask = nil;
    shaderRoot = nil;
    shaderCamera = nil;
    shaderNode = nil;
    shader2 = nil;
    node = nil;
    hpage = nil;
    sr = nil;
    Content = nil;
    bar = nil;
    points = nil;
    mask2 = nil;
    barAction = nil;
    view = nil;
end
----#End#----
