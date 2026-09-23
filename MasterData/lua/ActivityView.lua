local curIndex = 1 -- 左
local index = nil -- 分页

function Awake()
    tab = ComUtil.GetCom(tab, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)

    c_MenuADItem1 = ComUtil.GetCom(icon1, "MenuADItem")
    c_MenuADItem2 = ComUtil.GetCom(icon2, "MenuADItem")

    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Activity/ActivityItem", LayoutCallBack, true)

    CSAPI.PlayUISound("ui_popup_open")
    if  CSAPI.IsADV() or CSAPI.IsDomestic() then
        BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_GAME_ANNOUNCEMENT_SHOWS)
    end
    SetShareBtnState();
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        lua.SetIndex(index)
        lua.SetClickCB(SetClickCB)
        lua.Refresh(datas[index], curIndex == index)
    end
end

function OnInit()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Main_Activity, function(type)
        if (type == BackstageFlushType.Board) then
            if(isSetTab) then 
                RefreshPanel()
            else 
                SetCTab()
            end
        end
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

-- data : 服务器时间（如果有则是在登录界面）
function OnOpen()
    time = nil
    if (data) then -- 登录界面打开
        time = data.time
        CSAPI.SetGOActive(btnSkip, false)
        ActivityMgr:Init1(data.webIp, data.webPort, data.time)
        --在 EventType.Main_Activity 中初始化界面
    else
        -- 主界面打开（主动或非主动，数据已经请求）
        isSet = ActivityMgr:IsSetToSkip()
        CSAPI.SetGOActive(skip, isSet)
        SetCTab()
    end
end
-- 页判断
function SetCTab()
    if (isSetTab) then
        return
    end
    isSetTab = true

    local _selIndex = -1
    for i = 1, 3 do
        local _data = ActivityMgr:GetDatasByType(BackstageFlushType.Board, time, i) or {}
        CSAPI.SetGOActive(this["page" .. i], #_data > 0)
        if(#_data > 0 and _selIndex == -1)then 
            _selIndex = i - 1
        end
    end
    tab.selIndex = _selIndex==-1 and 0 or _selIndex
end

function OnTabChanged(_index)
    if (index and index == _index) then
        return
    end
    index = _index
    curIndex = 1
    RefreshPanel()
end


function RefreshPanel()
    local page = index or 0
    page = page + 1

    local _datas, _nextTime = ActivityMgr:GetDatasByType(BackstageFlushType.Board, time, page)
    datas = _datas or {}

    if (#datas <= 0) then
        nextTime = nil
    else
        if (_nextTime) then
            --nextTime = _nextTime > TimeUtil:GetTime() and (_nextTime - TimeUtil:GetTime()) or 0
            --nextTime = nextTime > 0 and Time.time + nextTime or nil
            nextTime = _nextTime > TimeUtil:GetTime() and _nextTime or nil
        else
            nextTime = nil
        end
    end
    if (openSetting) then
        for i, v in ipairs(datas) do
            if (v:GetID() == tostring(openSetting)) then
                curIndex = i
                break
            end
        end
        openSetting = nil
    end
    if (#datas > 0 and curIndex > #datas) then
        curIndex = 1
    end
    SetCurInfo()
    layout:IEShowList(#datas)

    CSAPI.SetGOActive(nonePanel, #datas == 0)

end

function Update()
    if (nextTime and TimeUtil:GetTime() > nextTime) then
        nextTime = nil
        RefreshPanel()
    end
end

function SetClickCB(index)
    curIndex = index
    layout:UpdateList()

    SetCurInfo()
end

function SetCurInfo()
    curData = datas[curIndex]
    local showType = curData and curData:GetShowType() or -1
    CSAPI.SetGOActive(right1, showType == 0)
    CSAPI.SetGOActive(right2, showType == 1)
    CSAPI.SetGOActive(right3, showType == 2)
    if (curData) then
        if (showType == 0) then
            SetCurInfo1()
        elseif (showType == 1) then
            SetCurInfo2()
        elseif (showType == 2) then
            SetCurInfo3()
        end
    end

    if curData and curData:can_share() and curData:can_share()=="1" then
        SetShareBtnState();
    else
        CSAPI.SetGOActive(ShareBtn, false)
    end
end
function SetShareBtnState()
    CSAPI.SetGOActive(ShareBtn,CSAPI.IsSharePicture())
end
function SetCurInfo3()
    local tabs = curData:GetDescTables()
    items3 = items3 or {}
    ItemUtil.AddItems("Activity/ActivityItem3", items3, tabs, Content3, nil, 1, curData)
end
function OnClickShareBtn()
    CSAPI.OpenView("ShareView",{LocationSource=5,key="ShareView",bgName=curData:GetImageName2(),url=curData:GetBoardImgUrl()})
end
function SetCurInfo2()
    -- icon
    c_MenuADItem2:SetImage(icon2, "activityview", curData:GetImageName2(), curData:GetBoardImgUrl())
end

function SetCurInfo1()
    CSAPI.SetGOActive(rPanel, true)
    -- icon
    c_MenuADItem1:SetImage(icon1, "activityview", curData:GetImageName(), curData:GetBoardImgUrl(), function()
        CSAPI.SetScale(icon1, 1, 1, 1)
    end)
    -- title
    CSAPI.SetText(txtTitle, curData:GetTitle())
    -- time
    local showTime = curData:GetShowTime()
    CSAPI.SetGOActive(txtTime, showTime ~= nil)
    if (showTime) then
        local timeData = TimeUtil:GetTimeHMS(showTime)
        CSAPI.SetText(txtTime, string.format("%s-%s-%s", timeData.year, timeData.month, timeData.day))
    end
    -- desc
    SetDesc(curData:GetDesc())
    -- btn
    CSAPI.SetGOActive(btnS, curData:GetSkipID())

    -- www 调查问卷
    local isShow = false
    local addinfo = curData:GetAddInfo()
    if (addinfo and addinfo == "dcwj") then
        isShow = true
    end
    CSAPI.SetGOActive(btnWWW, isShow)
end
-- 8行 325
function SetDesc(str)
    CSAPI.SetText(txtDesc, str)
    -- --适配
    -- local text = ComUtil.GetCom(txtDesc, "Text")
    -- local height = text.preferredHeight
    -- height = height > 325 and height or 325
    -- CSAPI.SetRTSize(txtDesc, 1260, height)
end

function OnClickGO()
    local lua = datas[curIndex]
    local jumpId = lua and lua:GetSkipID() or nil
    if (jumpId) then
        JumpMgr:Jump(tonumber(jumpId))
        view:Close()
    end
end

function OnClickSkip()
    if (not isSet) then
        local day = TimeUtil:GetTime3("day")
        PlayerPrefs.SetString(PlayerClient:GetUid() .. "ActivityTips_Day", tostring(day))
    else
        PlayerPrefs.SetString(PlayerClient:GetUid() .. "ActivityTips_Day", "0")
    end
    isSet = not isSet
    CSAPI.SetGOActive(skip, isSet)
end

-- 调查问卷入口
function OnClickWWW()
    CSAPI.OpenWebBrowser("https://jinshuju.net/f/Ha2OgN")
    MailProto:QueryMail() -- 领取奖励
end

function OnClickClose()
    view:Close()
end

function OnClickRight2()
    if (data) then
        local lua = datas[curIndex]
        local jumpId = lua and lua:GetSkipID() or nil
        if (jumpId) then
            local cfg = Cfgs.CfgJump:GetByID(tonumber(jumpId))
            if(cfg and cfg.page) then 
                UnityEngine.Application.OpenURL(cfg.page)
            end 
        end
    elseif (not data) then
        OnClickGO()
    end
end

