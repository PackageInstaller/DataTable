local sectionDatas = nil
local isShowList = false -- 显示九宫格
local layout1 = nil
local layout2 = nil
--time
local nextTime = 0 --下次开始轮换刷新时间(结束时间由子物体控制)
local nextTimes = nil
local timer = 0
--anim
local anim = nil

function Awake()
    layout1 = ComUtil.GetCom(hsv, "UISV");
    layout1:Init("UIs/Trials/TrialsItem1", LayoutCallBack1, true);

    layout2 = ComUtil.GetCom(vsv, "UISV");
    layout2:Init("UIs/Trials/TrialsItem2", LayoutCallBack2, true);

    CSAPI.SetGOActive(animMask, false)

    anim = ComUtil.GetCom(gameObject, "Animator")

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Trials_Panel_Refresh, RefreshPanel)
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = sectionDatas[index]
        lua.SetClickCB(OnClickItemCB)
        lua.Refresh(_data)
    end
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = sectionDatas[index]
        lua.SetClickCB(OnClickItemCB)
        lua.Refresh(_data)
    end
end

function OnClickItemCB(item)
    CSAPI.OpenView("TrialsListView", {
        id = item.GetData():GetID()
    })
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("TrialsView", topObj, OnClickReturn);
end

function Update()
    UpdateTime()
end

function OnOpen()
    InitPanel()
end

function InitPanel()
    SetDatas()
    SetItems(ShowEnterAnim)
    SetText()
    SetTime()
end

function RefreshPanel()
    SetItems()
    SetText()
end

function SetDatas()
    sectionDatas = {}
    local datas = DungeonMgr:GetActivitySectionDatas(SectionActivityType.Trials, true)
    if datas and #datas > 0 then
        for i, v in ipairs(datas) do
            if v:GetCfg() and not v:GetCfg().isChain then
                table.insert(sectionDatas,v)
            end
        end
    end
    if sectionDatas and #sectionDatas> 0 then
        table.sort(sectionDatas,function (a,b)
            local isUp1,isUp2= false,false
            local info1 = a:GetOpenInfo()
            if info1 and info1:GetUpTime(a:GetID()) > 0 then
                isUp1 = true
            end
            local info2 = b:GetOpenInfo()
            if info2 and info2:GetUpTime(b:GetID()) > 0 then
                isUp2 = true
            end
            if isUp1 == isUp2 then
                return a:GetID() < b:GetID()
            else
                return isUp1
            end
        end)
    end
end

function SetItems(loadSuccess)
    CSAPI.SetGOActive(hsv, not isShowList)
    CSAPI.SetGOActive(vsv, isShowList)
    if isShowList then
        layout2:IEShowList(#sectionDatas, loadSuccess)
    else
        layout1:IEShowList(#sectionDatas, loadSuccess)
    end
end

function SetText()
    LanguageMgr:SetText(txt_show1, isShowList and 37039 or 37037)
    LanguageMgr:SetEnText(txt_show2, isShowList and 37039 or 37037)
end

function OnClickShow()
    isShowList = not isShowList
    SetItems(ShowChangeAnim)
    SetText()
end

function OnClickReturn()
    view:Close()
end
-----------------------------time-----------------------------
function SetTime()
    if nextTimes == nil then
        nextTimes = {}
        if sectionDatas and sectionDatas[1] then
            local openInfo = sectionDatas[1]:GetOpenInfo()
            if openInfo and openInfo:GetCfg() then
                local infos = openInfo:GetCfg().infos
                if infos and #infos > 0 then
                    for i, v in ipairs(infos) do
                        if v.upStartTime then
                            local sTime = TimeUtil:GetTimeStampBySplit(v.upStartTime)
                            if sTime > TimeUtil:GetTime() then
                                table.insert(nextTimes, sTime)
                            end
                        end
                    end
                end
            end
            if #nextTimes > 0 then
                table.sort(nextTimes, function(a, b)
                    return a < b
                end)
            end
        end
        if #nextTimes > 0 then
            nextTime = table.remove(nextTimes, 1)
        else
            nextTime = 0
        end
    end
end

function UpdateTime()
    if nextTime <= 0 then
        return
    end

    if timer < Time.time then
        timer = Time.time + 1
        if TimeUtil:GetTime() >= nextTime then
            SetTime()
            SetItems()
        end
    end
end

-----------------------------anim-----------------------------
function PlayAnim(delay, cb)
    CSAPI.SetGOActive(animMask, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(animMask, false)
        if cb then
            cb()
        end
    end, this, delay)
end

function ShowAction(go)
    CSAPI.SetGOActive(go, false)
    CSAPI.SetGOActive(go, true)
end

function ShowEnterAnim()
    PlayAnim(isShowList and 700 or 800)
    ShowItemAnim()
end

function ShowChangeAnim()
    PlayAnim(isShowList and 700 or 800)
    ShowAnimByName(isShowList and "TrialsView_List" or "TrialsView_Normal")
    ShowItemAnim()
end

function ShowItemAnim()
    if sectionDatas and #sectionDatas > 0 then
        local index = 0
        for i, v in ipairs(sectionDatas) do
            if isShowList then
                local lua = layout2:GetItemLua(i)
                if lua then
                    lua.ShowRefreshAction(math.floor((index) / 3) * 48)
                    index = index + 1
                end
            else
                local lua = layout1:GetItemLua(i)
                if lua then
                    lua.ShowRefreshAction(index * 48)
                    index = index + 1
                end
            end
        end
    end
end

function ShowAnimByName(str)
    if not IsNil(anim) then
        anim:Play(str)
    end
end
