local alData = nil
local cfgRewards = nil
local goodsData = nil
local lastBGM = nil

function Awake()
    CSAPI.SetGOActive(itemGet, false)
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Halloween_data_Update, OnPanelRefresh)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end

function OnPanelRefresh()
    RefreshPanel()
end

function OnViewClosed(viewKey)
    if viewKey == "Halloween" then
        CSAPI.PlayBGM("Halloween_music_01", 50)
    end
end

function OnInit()
    UIUtil:AddTop2("HalloweenMenu", topParent, OnClickBack)
end

function OnDestroy()
    FuncUtil:Call(function()
        if lastBGM ~= nil then
            CSAPI.ReplayBGM(lastBGM)
        else
            EventMgr.Dispatch(EventType.Replay_BGM, 50);
        end
    end, this, 50)
end

function OnOpen()
    lastBGM = CSAPI.PlayBGM("Halloween_music_01", 50)
    if data == nil then
        _, data = ActivityMgr:IsOpenByType(ActivityListType.Halloween)
    end
    alData = ActivityMgr:GetALData(data)
    if alData then
        SetRewards()
        SetTime()
        RefreshPanel()
    end
end

function SetRewards()
    if cfgRewards == nil then
        cfgRewards = {}
        local cfgs = Cfgs.CfgHalloweenReward:GetAll()
        if cfgs then
            for k, _cfg in pairs(cfgs) do
                table.insert(cfgRewards, _cfg)
            end
        end
        if #cfgRewards > 0 then
            table.sort(cfgRewards, function(a, b)
                return a.id < b.id
            end)
        end
    end
    local cfgItem = nil
    for i = 1, 3 do
        if cfgRewards[i] and cfgRewards[i].rewards then
            cfgItem = Cfgs.ItemInfo:GetByID(cfgRewards[i].rewards[1][1])
            if cfgItem and cfgItem.icon then
                ResUtil.IconGoods:Load(this["icon" .. i].gameObject, cfgItem.icon)
            end
        end
    end
end

function SetTime()
    local str = LanguageMgr:GetByID(22051)
    local str2 = TimeUtil:GetTimeStr2(alData:GetStartTime(), true) .. "-" ..
                     TimeUtil:GetTimeStr2(alData:GetEndTime(), true)
    CSAPI.SetText(txtTime, str .. str2)
end

function RefreshPanel()
    SetRank()
    SetItem()
    SetCount()
end

function SetRank()
    LanguageMgr:SetText(txtRank, 140002, HalloweenMgr:GetScore())
end

function SetItem()
    local curIndex = HalloweenMgr:GetRewardNum() + 1
    if curIndex > #cfgRewards then
        curIndex = #cfgRewards
        CSAPI.SetGOActive(itemGet, true)
        CSAPI.LoadImg(imgIcon, "UIs/Halloween/img_04_04.png", true, nil, true)
    end
    if cfgRewards[curIndex] and cfgRewards[curIndex].rewards then
        goodsData = BagMgr:GetFakeData(cfgRewards[curIndex].rewards[1][1], cfgRewards[curIndex].rewards[1][2])
        if goodsData and goodsData:GetIcon() then
            ResUtil.IconGoods:Load(icon, goodsData:GetIcon())
        end
    end
end

function SetCount()
    LanguageMgr:SetText(txtCount, 140003, HalloweenMgr:GetNum() .. "/1")
end

function OnClickRank()
    local sectionData = DungeonMgr:GetSectionData(21001)
    UIUtil:OpenRankView(sectionData:GetRankView(),sectionData:GetRankListInfo())
end

function OnClickItem()
    if goodsData then
        local tab = {
            data = goodsData
        }
        GridClickFunc.OpenInfoSmiple(tab)
    end
end

local gachaAnim = nil
local gachaAnim2 = nil
local animSpaceTime = 0

function OnClickGacha()
    if Time.time < animSpaceTime then
        return
    end
    animSpaceTime = Time.time + 2

    if gachaAnim == nil then
        gachaAnim = ComUtil.GetCom(gachaObj, "Animator")
    end

    if not IsNil(gachaAnim) then
        gachaAnim:Play("GachaEffect1")
    end

    if gachaAnim2 == nil then
        gachaAnim2 = ComUtil.GetCom(gachaObj2, "Animator")
    end

    if not IsNil(gachaAnim2) then
        gachaAnim2:Play("GachaEffect2")
    end
end

function OnClickReward()
    CSAPI.OpenView("SignInNReward", {"CfgHalloweenReward", HalloweenMgr:GetRewardNum()})
end

function OnClickEnter()
    CSAPI.OpenView("Halloween", 1)
end

function OnClickBack()
    view:Close()
end
