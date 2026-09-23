local eventMgr = nil
local time, timer, refreshTime = 0, 0, 0
local isApplyRefresh = false -- 限制发送多个协议
local sectionData = nil
-- left
local selIndex = 0
local numSlider1, numSlider2 = nil, nil
-- right
local layout = nil
local tlua = nil
local tab = nil
local curDatas = nil

function Awake()
    numSlider1 = ComUtil.GetCom(slider1, "Slider")
    numSlider2 = ComUtil.GetCom(slider2, "Slider")

    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/RogueMap/RogueMapAssistItem", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.MoveByType2, {"UTD"});

    tab = ComUtil.GetCom(tabs, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RogueMap_Assist_Refresh, SetRightPanel)
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetRed)
    eventMgr:AddListener(EventType.RogueMap_Assist_Need_Update,OnClickRefresh)
    eventMgr:AddListener(EventType.RogueMap_Update,OnPanelRefresh)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if lua then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data, selIndex == 2)
    end
end

function OnTabChanged(index)
    if selIndex == index then
        return
    end

    selIndex = index
    SetRightPanel()
end

function OnPanelRefresh()
    SetAssistNum()
end

function OnDestroy()
    RogueMapMgr:CheckRedPointData()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("RogueMapAssist", topParent, OnClickBack);
end

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = refreshTime - TimeUtil:GetTime()
        if time <= 0 then
            isApplyRefresh = false
        end
    end
end

function OnOpen()
    sectionData = DungeonMgr:GetSectionData(data and data.id)
    if sectionData then
        SetLeftPanel()
        SetTabSel()
        SetAssistNum()
        SetRed()
    end
end

function SetRed()
    UIUtil:SetRedPoint(redParent1, RogueMapMgr:IsAssistNew())
    UIUtil:SetRedPoint(redParent2, RogueMapMgr:IsRewardRed())
    UIUtil:SetRedPoint(redParent3, RogueMapMgr:CheckLogRed())
    if selIndex == 1 and RogueMapMgr:IsAssistNew() then
        RogueMapMgr:SetAssistNew(false)
    end
end
-------------------------------------------------左侧面板-------------------------------------------------
function SetLeftPanel()
    SetRewards()
end

function SetRewards()
    local ids = RogueMapMgr:GetGlobal("supportRewardId")
    local maxs = RogueMapMgr:GetGlobal("supportRewardLimit")
    local curs = RogueMapMgr:GetAssistRewardNums()
    if ids and maxs then
        for i, v in ipairs(ids) do
            SetLItem(i, v, curs[i], maxs[i])
        end
    end
end

function SetLItem(index, goodsId, cur, max)
    local goodsData = GridFakeData({
        id = goodsId
    })
    if goodsData then
        goodsData:GetIconLoader():Load(this["icon" .. index].gameObject, goodsData:GetIcon() .. "_1")
        CSAPI.SetText(this["txtName" .. index].gameObject, goodsData:GetName())
        cur = cur >= max and max or cur
        CSAPI.SetText(this["txtCur" .. index].gameObject, cur .. "")
        CSAPI.SetText(this["txtMax" .. index].gameObject, "/" .. max)
        CSAPI.SetTextColorByCode(this["txtCur" .. index].gameObject, cur == max and "ffc146" or "ffffff")
        if index == 1 then
            numSlider1.value = cur / max
        else
            numSlider2.value = cur / max
        end
    end
end

-------------------------------------------------右侧面板-------------------------------------------------
function SetTabSel()
    OnTabChanged(1)
    tab.selIndex = 1
end

function SetRightPanel()
    SetDatas()
    SetRItems()
    CSAPI.SetGOActive(btnRefresh,selIndex == 1)
end

function SetAssistNum()
    local requireMax = RogueMapMgr:GetGlobal("dailyRequestNum") or 0
    CSAPI.SetText(txtAssistNum, LanguageMgr:GetByID(76051) .. math.floor(requireMax - RogueMapMgr:GetRequireNum()))
end

function SetDatas()
    curDatas = selIndex == 1 and RogueMapMgr:GetAssistArr(sectionData:GetID()) or RogueMapMgr:GetSupportArr()
end

function SetRItems()
    tlua:AnimAgain()
    layout:IEShowList(#curDatas)
end
-------------------------------------------------按钮-------------------------------------------------
function OnClickRefresh()
    if time > 0 then
        LanguageMgr:ShowTips(1028)
        return
    end
    if isApplyRefresh then
        return
    end
    if isRequire then
        return
    end
    isRequire = true
    -- 消息超时提示
    EventMgr.Dispatch(EventType.Net_Msg_Wait, {
        msg = "rogueMap_require",
        time = 5000,
        timeOutCallBack = function()
            isRequire = false
            LanguageMgr:ShowTips(1008)
        end
    });
    FightProto:RogueMapSupportList(sectionData:GetID(), function(proto)
        EventMgr.Dispatch(EventType.Net_Msg_Getted, "rogueMap_require")
        isRequire = false
        SetRightPanel()
    end)

    refreshTime = TimeUtil:GetTime() + RogueMapMgr:GetGlobal("supportFreshTime")
    time = refreshTime - TimeUtil:GetTime()
    isApplyRefresh = true
end

function OnClickLog()
    if RogueMapMgr:CheckLogRed() then
        UIUtil:SetRedPoint(redParent3, false)
    end
    CSAPI.OpenView("RogueMapLog")
end

function OnClickBack()
    view:Close()
end
