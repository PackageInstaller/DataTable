local cfgs = nil
local curIndex = 0
local rightItems = {}
local datas = {} -- 开启的活动
local curItem = nil
local btnCallBack = nil
local top = nil
local isClickMask = true
local group = 1
curIndex1, curIndex2 = 1, 1;

function OnInit()
    top = UIUtil:AddTop2("ActivityListView", topParent.gameObject, CloseView, nil, {})
    CSAPI.SetGOActive(top.btn_home, false)
    -- CSAPI.SetGOActive(top.moneys, false)
end

function OnEnable()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Activity_OpenQueue, OnItemSelect);
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClose);
    eventMgr:AddListener(EventType.Activity_Click, OnBtnCallBack);
    eventMgr:AddListener(EventType.RedPoint_Refresh, OnRedPointRefresh)
    eventMgr:AddListener(EventType.Update_Everyday, OnDayRefresh)
    eventMgr:AddListener(EventType.Acitivty_List_Pop, SetRightPanel)
    eventMgr:AddListener(EventType.Activity_List_Panel_Refresh, OnPanelRefresh)
    eventMgr:AddListener(EventType.Activity_List_Cfg_Change, OnPanelRefresh)
end

function OnItemSelect(_type)
    SetRightPanel(_type)
end

function OnViewClose(key)
    if (key == "RewardPanel") then
        ActivityPopUpMgr:TryPopUpView("ActivityListView")
    end
end

function OnBtnCallBack()
    isClickMask = true
    CSAPI.SetGOActive(clickMask, true)
end

function OnRedPointRefresh()
    if leftPanel and leftPanel.leftItems then
        for i, v in ipairs(leftPanel.leftItems) do
            if datas and datas[i] then
                local isRed = ActivityMgr:CheckRed(datas[i]:GetID())
                isRed = i == curIndex1 and false or isRed
                v.SetRed(isRed)
            end
        end
    end
end

function OnDayRefresh()
    -- 清除弹出缓存
    ActivityPopUpMgr:ClearPopUpInfos()

    UIUtil:ToHome()
end

function OnPanelRefresh()
    local _data = datas[curIndex]
    if not _data:IsOpen() then
        curIndex = 0
        curIndex1 = 1
        InitLeftPanel()
        CSAPI.SetGOActive(emptyObj, datas == nil or #datas < 1)
    end
    SetRightPanel()
end

function OnDisable()
    eventMgr:ClearListener();
end

function OnOpen()
    group = openSetting or 1
    InitLeftPanel()
    if datas and #datas > 0 then
        SetRightPanel(data and data.id)
    end

    CSAPI.SetGOActive(emptyObj, datas == nil or #datas < 1)
end

function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", left.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    curIndex1 = 1
    local leftDatas = {}
    datas = ActivityMgr:GetArr(tonumber(group))
    if CSAPI.IsADV() then
        if AdvBindingRewards.isHadReward == false then
            if #datas > 0 then
                for i, v in ipairs(datas) do
                    if v:GetID() == 2001 then
                        table.remove(datas, i)
                        break
                    end
                end
            end
        end
    end
    if #datas > 0 then
        for i, v in ipairs(datas) do
            if v:GetLeftInfos() then
                table.insert(leftDatas, {v:GetLeftInfos()[1].id, v:GetLeftInfos()[1].path})
            end
        end
    end
    leftPanel.Init(this, leftDatas)
end

function SetRightPanel(_id)
    if (_id and datas) then
        for i, v in ipairs(datas) do
            if (v:GetID() == _id) then
                curIndex1 = i
                break
            end
        end
    end
    RefreshPanel()
end

function RefreshPanel()
    leftPanel.Anim()
    leftPanel.leftItems[curIndex1].SetRed(false)

    local isRefresh = curIndex ~= curIndex1
    if (isRefresh) then
        curIndex = curIndex1
        if (curItem) then
            UIUtil:SetObjFade(curItem.gameObject, 1, 0, function()
                if curItem then
                    CSAPI.SetGOActive(curItem.gameObject, false)
                    curItem = nil
                    SetRight()
                end
            end, 200)
        else
            SetRight()
        end
    end
    OnRedPointRefresh()
end

function SetRight()
    local _data = datas[curIndex]
    if (_data) then
        CSAPI.SetGOActive(imgParent, _data:IsShowImg())

        ShowTop(_data)
        ShowQusetion(_data)

        if (rightItems[_data:GetID()]) then
            CSAPI.SetGOActive(rightItems[_data:GetID()].gameObject, true)
            rightItems[_data:GetID()].isFirst = false
            rightItems[_data:GetID()].Refresh(_data, {
                cfg = _data:GetCfg()
            })
            UIUtil:SetObjFade(rightItems[_data:GetID()].gameObject, 0, 1, nil, 200)
            curItem = rightItems[_data:GetID()]
        else
            if (_data:GetPath()) then
                ResUtil:CreateUIGOAsync(_data:GetPath(), right, function(go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.Refresh(_data, {
                        cfg = _data:GetCfg()
                    })
                    UIUtil:SetObjFade(go, 0, 1, nil, 200)
                    rightItems[_data:GetID()] = lua
                    curItem = lua
                end)
            else
                LogError("找不到对应位置的预设体！！！" .. _data:GetID())
            end
        end
        curData = nil

        PlayerPrefs.SetInt(PlayerClient:GetUid() .. "_Activity_Red_" .. _data:GetID(), 1)
        ActivityMgr:CheckRedPointData(_data:GetType())
    end
end

function ShowTop(_data)
    if _data:GetPath() and _data:GetType() == ActivityListType.Investment then
        top.SetMoney({{ITEM_ID.DIAMOND, 140001}})
    elseif _data:GetType() == ActivityListType.Exchange then
        local info = _data:GetInfo() and _data:GetInfo()[1] or nil
        local tab = {}
        if info and info.goodId then
            tab = {{info.goodId}}
        end
        top.SetMoney(tab)
    else
        top.SetMoney()
    end
end

function ShowQusetion(_data)
    local info = _data:GetInfo()
    local isShow = false
    if info and info[1] and info[1].moduleInfo then
        UIUtil:AddQuestionItem(info[1].moduleInfo, gameObject, qusetion)
        isShow = true
    end
    CSAPI.SetGOActive(qusetion, isShow)
end

function CloseView()
    CSAPI.SetGOActive(top.btn_home, true)
    view:Close()
end

function OnClick()
    local func = curItem and curItem.OnClickMask
    if func and isClickMask then
        func()
        isClickMask = false
    end
    CSAPI.SetGOActive(clickMask, false)
end
