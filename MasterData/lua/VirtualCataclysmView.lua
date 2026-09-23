local sectionData = nil
local openInfo = nil
local curDatas = nil
local items = nil
local currItem = nil
local pos = {{-543, 122}, {0, -100}, {543, 122}}
local stage = 0
local jumpId = nil
local cfgVirCat = nil
local rewardItems = nil

function Awake()
    CSAPI.SetGOActive(infoMask, false)
    CSAPI.SetGOActive(animMask, false)
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.VirtualCataclysm_Panel_Update, OnStageCheck)
    eventMgr:AddListener(EventType.Guide_VirtualCataclysm_Item_Select,OnGuideTrigger)
end

function OnStageCheck()
    if stage ~= VirCatMgr:GetStage() then
        if GuideMgr:IsGuiding() then --强制完成引导
            GuideMgr:GuideComplete()
        end
        CSAPI.CloseAllOpenned();
        CSAPI.OpenView("Section", {
            type = 4
        });
        CSAPI.OpenView("VirtualCataclysmMenu", {
            id = data.id,
            itemId = 1
        }) -- 假定1用于跳转
    else
        RefreshPanel()
    end
end

function OnGuideTrigger()
    if items then
        for i, v in ipairs(items) do
            if not v.IsKill() then
                v.OnClick()
                break
            end
        end
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("VirtualCataclysmView", topParent, OnClickReturn);
end

function OnOpen()
    stage = VirCatMgr:GetStage()
    sectionData = DungeonMgr:GetSectionData(data and data.id)
    cfgVirCat = Cfgs.CfgVirtualCataclysm:GetByID(sectionData:GetInfoContent("VirCatId"))
    openInfo = sectionData and sectionData:GetOpenInfo()
    InitPanel()
end

function InitPanel()
    SetBGScale()
    SetDatas()
    SetItems()
    SetRewards()
end

function RefreshPanel()
    SetDatas()
    SetItems()
    SetRewards()
    if isActive then
        ShowInfo(currItem.GetCfg())
    end
end

function SetBGScale()
    local size = CSAPI.GetSizeOffset()
    CSAPI.SetScale(bgObj, size, size, size)
end

function SetDatas()
    curDatas = VirCatMgr:GetArr(stage, 1)
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("VirtualCataclysm/VirtualCataclysmItem", items, curDatas, itemParent, OnItemClickCB, 1, nil,
        OnLoadItemSuccess)
end

function OnItemClickCB(item)
    if currItem and currItem.index == item.index then
        return
    end
    currItem = item
    local cfg = item and item.GetCfg() or nil
    ShowInfo(cfg)
end

function OnLoadItemSuccess()
    if isFirst then
        return
    end
    isFirst = true
    for i, v in ipairs(items) do
        CSAPI.SetAnchor(v.gameObject, pos[i][1], pos[i][2])
        if data.itemId and data.itemId == v.GetData():GetDungeonId() then
            v.OnClick()
        end
    end
end

function SetRewards()
    local cfg = Cfgs.CfgVirtualCataclysmReward:GetByID(cfgVirCat.rewardId)
    if cfg and cfg.infos then
        rewardItems = rewardItems or {}
        ItemUtil.AddItems("VirtualCataclysm/VirtualCataclysmItem2", rewardItems, cfg.infos, rewardParent,
            OnRewardClickCB)
        local cur, max = 14, 0
        local cell, space = 97, 80
        local lastRate = 0
        local curRate = VirCatMgr:GetStagePro()
        for i, v in ipairs(cfg.infos) do
            if curRate > lastRate then
                if curRate >= v.rate then
                    cur = i == 1 and cur + (cell / 2 + space) or cur + cell + space
                else
                    cur = i == 1 and cur + (cell / 2 + space) * (curRate / v.rate) or cur + (cell + space) *
                            ((curRate - lastRate) / (v.rate - lastRate))
                end
            end
            max = i == 1 and cell / 2 + space or max + cell + space
            lastRate = v.rate
        end
        CSAPI.SetRTSize(nol, max, 4)
        CSAPI.SetRTSize(rewardCur, cur, 18)
        CSAPI.SetText(txtRewardPro,curRate .. "%")
    end
end

function OnRewardClickCB(item)
    CrossBossProto:CrossBossGetStageReward(VirCatMgr:GetActiveId(),item.index)
end

function OnClickSweep()
    CSAPI.OpenView("VirtualCataclysmSweep")
end

function OnClickReturn()
    if isActive then
        ShowInfo()
        return
    end
    view:Close()
end

----------------------------------------------关卡信息----------------------------------------------
function ShowInfo(cfg)
    isActive = cfg ~= nil;
    CSAPI.SetGOActive(infoMask, isActive)
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("VirtualCataclysm/DungeonItemInfo", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            itemInfo.Show(cfg, DungeonInfoType.VirtualCataclysm, OnLoadCallBack)
        end)
    else
        itemInfo.Show(cfg, DungeonInfoType.VirtualCataclysm, OnLoadCallBack)
    end
    PlayAnim(300)
end

function OnLoadCallBack()
    local curPro, maxPro = currItem.GetProgress()
    itemInfo.CallFunc("Progress", "SetProgress", curPro, maxPro)
    itemInfo.CallFunc("Progress", "SetTitle", LanguageMgr:GetByID(380016))
    itemInfo.CallFunc("Target", "ShowGoals", GetTargetInfos())
    itemInfo.SetFunc("Button", "OnClickEnter", OnBattleEnter)
    itemInfo.SetFunc("Button", "OnClickDirll", OnDirllEnter)
    SetInfoItemPos()
end

function GetTargetInfos()
    return {{
        tips = LanguageMgr:GetByID(stage == 1 and 380019 or 380020),
        isComplete = currItem and currItem.IsKill()
    }}
end

function SetInfoItemPos()
    if itemInfo then
        itemInfo.SetPanelPos("Title", 13, 415)
        itemInfo.SetPanelPos("Progress", 13, 235)
        itemInfo.SetPanelPos("Target", 13, 107)
        itemInfo.SetPanelPos("Output", 13, -21)
        itemInfo.SetPanelPos("Details", 13, -197)
        itemInfo.SetPanelPos("Button", 13, -351)
        CSAPI.SetRTSize(itemInfo.layout, 779, 1004)
    end
end

function OnBattleEnter()
    if currItem then
        if currItem.IsKill() then
            LanguageMgr:ShowTips(80003)
            return
        end
        local cost = DungeonUtil.GetCost(currItem.GetCfg())
        if cost then
            local cur = BagMgr:GetCount(cost[1])
            if cur < cost[2] then
                LanguageMgr:ShowTips(80002)
                return
            end
        end
    end
    OnTeamShow()
end

function OnDirllEnter()
    OnTeamShow(true)
end

function OnTeamShow(isDirll)
    if openInfo and not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    if currItem then
        local _data = currItem.GetData()
        CSAPI.OpenView("VirtualCataclysmTeam", {
            isDirll = isDirll,
            dungeonId = _data:GetDungeonId(),
            nodeId = _data:GetID()
        })
    end
end

function OnClickMask()
    currItem = nil
    ShowInfo()
end

---------------------------------------------anim---------------------------------------------
function PlayAnim(delay)
    CSAPI.SetGOActive(animMask, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(animMask, false)
    end, this, delay)
end
