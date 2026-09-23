-- 奖励面板
local isCanBack = false
local currLevel = 1

local fade = nil
local datas = nil

function Awake()
    fade = ComUtil.GetCom(gameObject, "ActionFade")

    CSAPI.SetGOActive(clickMask,false)
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
end

function CloseCallBack()
    -- 关闭回调
    if (openSetting and openSetting.closeCallBack) then
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

    SetLv()
    CSAPI.SetGOActive(txtMask, true)
end

function SetLv()
    if data then
        CSAPI.SetText(txtLv1,(data.oldLv or 1) .. "")
        CSAPI.SetText(txtLv2,(data.newLv or 1) .. "")
        CSAPI.SetText(txtDesc,data.desc or "")
    end
end

function OnLoadSuccse()
    CSAPI.SetScriptEnable(sr,"Image",#datas > 3)
    if #datas < 4 then
        local x = (4-#datas) * 165
        CSAPI.SetAnchor(sr, x, 0)
    end
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
