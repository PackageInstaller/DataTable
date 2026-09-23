local leftInfos = {}
local panels = {}
local currPanel = nil
local tab = nil
local currIndex = 0
local jumpIndex = 0
local top = nil

function Awake()
    tab = ComUtil.GetCom(tabs, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.LovePlus_Chat_Update,SetRed)
    eventMgr:AddListener(EventType.LovePlus_List_View_Change,OnViewChange)
end

function OnTabChanged(index)
    if leftInfos then
        for k, v in pairs(leftInfos) do
            if v.dateLabelType == index and currIndex ~= k then
                currIndex = k
                RefreshPanel()
                break
            end
        end
    end
end

function OnViewChange(type)
    if leftInfos then
        for k, v in pairs(leftInfos) do
            if v.dateLabelType == type and currIndex ~= k then
                tab.selIndex = k
                break
            end
        end
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    top = UIUtil:AddTop2("LovePlusListView", topParent, function()
        view:Close()
    end, nil, {})
end

function OnOpen()
    if data then
        SetDatas()
        SetLeft()
        -- RefreshPanel()
    end
end

function SetDatas()
    leftInfos = LovePlusMgr:GetLabelCfgs(data:GetID())
end

function SetLeft()
    for i = 1, 4 do
        CSAPI.SetGOActive(this["tabItem" .. i].gameObject, false)
    end
    local leftDatas = {}
    local index = 0
    if #leftInfos > 0 then
        for i, v in ipairs(leftInfos) do
            if index == 0 then
                index = v.dateLabelType
            end
            CSAPI.SetGOActive(this["tabItem" .. v.dateLabelType].gameObject, true)
        end
    end
    if openSetting and openSetting.type and openSetting.type > 0 then
        index = openSetting.type
    end
    if index > 0 then
        tab.selIndex = index
    end
end

function RefreshPanel()
    if currPanel then
        UIUtil:SetObjFade(currPanel.gameObject, 1, 0, function()
            CSAPI.SetGOActive(currPanel.gameObject, false)
            SetRight()
        end, 200)
    else
        SetRight()
    end
    SetRed()
end

function SetRight()
    local elseData = openSetting
    openSetting = nil
    if leftInfos[currIndex] then
        if top then
            top.SetMoney(leftInfos[currIndex].dateLabelType == 4 and {{ITEM_ID.DIAMOND,140001}} or {})   -- 需要加跳转id todo 
        end
        CSAPI.SetGOActive(bottomObj, currIndex == 2 or currIndex == 3)

        if panels[leftInfos[currIndex].dateLabelType] then
            currPanel = panels[leftInfos[currIndex].dateLabelType]
            CSAPI.SetGOActive(currPanel.gameObject, true)
            panels[leftInfos[currIndex].dateLabelType].Refresh(data, elseData)
            UIUtil:SetObjFade(currPanel.gameObject, 0, 1, nil, 200)
        else
            local viewPath = GetPathName(leftInfos[currIndex].dateLabelType)
            if viewPath ~= "" then
                ResUtil:CreateUIGOAsync(viewPath, rightParent, function(go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.Refresh(data, elseData)
                    currPanel = lua
                    UIUtil:SetObjFade(currPanel.gameObject, 0, 1, nil, 200)
                    panels[leftInfos[currIndex].dateLabelType] = lua
                end)
            end
        end

        --打点
        if leftInfos[currIndex].dateLabelType == 4 then
            BuryingPointMgr:TrackEventsByDay("love_plus_shop_view",{
                time = TimeUtil:GetTimeStr2(TimeUtil:GetTime(),true),
            })
        end
    end
end

function GetPathName(_type)
    _type = tonumber(_type)
    if _type == 1 then
        return "LovePlusChat/LovePlusChatView"
    elseif _type == 2 then
        return "LovePlusStory/LovePlusStoryView"
    elseif _type == 3 then
        return "LovePlusPic/LovePlusPicView"
    elseif _type == 4 then
        return "LovePlusShop/LovePlusShopView"
    end
end

function SetRed()
    UIUtil:SetRedPoint(redParent1,LovePlusMgr:CheckChatRed(data:GetID()))
end
