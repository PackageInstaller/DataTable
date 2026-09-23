
local layout = nil
local datas = nil
local key = nil
local isClick = false
local isClose = false
local alData =nil
local info = nil
local signInfo = nil
local isSignIn = false
local curDay = nil
local data = nil


function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/SignInContinue14/AnniversarySignInItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Activity_SignIn, ESignCB)
    eventMgr:AddListener(EventType.Update_Everyday, OnDayRefresh)

    CSAPI.SetGOActive(clickMask, false)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = datas[index]
        lua.SetIndex(index)
        lua.Refresh(_data)
    end
end

function ESignCB(proto)
    -- if(isClick) then return end
    local _key = SignInMgr:GetDataKey(proto.id, proto.index)
    if (key ~= _key) then
        return
    end
    if proto.isOk == false then
        EventMgr.Dispatch(EventType.Acitivty_List_Pop)
        return
    end
    local lua = layout:GetItemLua(curDay)
    if lua then
        lua.PlayGetAnim()
    end
    SignInMgr:AddCacheRecord(key)
    ActivityMgr:CheckRedPointData(ActivityListType.SignInContinue)
    signInfo = SignInMgr:GetDataByKey(key)
    RefreshPanel()
    isClose = false
    isClick = false
end

function OnDayRefresh()
    -- 清除弹出缓存
    ActivityPopUpMgr:ClearPopUpInfos()
    isClose = true
    UIUtil:ToHome()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Refresh(_data,_elseData)
    alData = _data
    if alData then
        key = SignInMgr:GetDataKeyById(alData:GetID())
        cfg = alData:GetCfg()
        signInfo = SignInMgr:GetDataByKey(key)
        if signInfo and not signInfo:CheckIsDone() then
            EventMgr.Dispatch(EventType.Activity_Click)
        end
        SetTime()
        RefreshPanel()
    end
end

function SetTime()
    local str1 = TimeUtil:GetTimeHMS(alData:GetStartTime(), "%m/%d %H:%M")
    local str2 = TimeUtil:GetTimeHMS(alData:GetEndTime(), "%m/%d %H:%M")
    LanguageMgr:SetText(txtTime, 13033, str1 .. "-" .. str2)
end

function RefreshPanel()
    isSignIn = signInfo:CheckIsDone()
    curDay = signInfo:GetRealDay()
    datas = SignInMgr:GetDayInfos(key)
    SetItems()
    SetMask()
end

function SetItems()
    if isFirst then
        layout:UpdateList()
        return
    end
    layout:IEShowList(#datas,OnItemLoadSuccess,curDay)
end

function OnItemLoadSuccess()
    if isFirst then
        return
    end
    isFirst = true
    if datas and #datas > 0 then
        for i, v in ipairs(datas) do
            local lua = layout:GetItemLua(i)
            if lua then
                lua.PlayEnterAnim()
            end
        end
    end
end

function SetMask()
    CSAPI.SetGOActive(clickMask, not isSignIn)
end

function OnClickMask()
    if isClick then
        return
    end
    isClick = true
    ClientProto:AddSign(signInfo:GetID())
end

function OnClickBack()
    view:Close()
end

