local sectionData = nil
local openInfo = nil
local hpSlider = nil
local curData = nil
local cfgDungeon = nil
local cfgVirCat = nil
local rewardItems = nil
function Awake()
    hpSlider = ComUtil.GetCom(sliderHp, "Slider")
    CSAPI.SetGOActive(infoMask, false)
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.VirtualCataclysm_Panel_Update,OnPanelRefresh)
end

function OnPanelRefresh()
    RefreshPanel()
    if curData:IsPass() and GuideMgr:IsGuiding() then
        GuideMgr:GuideComplete()
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("VirtualCataclysmView2", topParent, OnClickReturn);
end

function OnOpen()
    sectionData = DungeonMgr:GetSectionData(data and data.id)
    openInfo = sectionData and sectionData:GetOpenInfo()
    cfgVirCat = Cfgs.CfgVirtualCataclysm:GetByID(sectionData:GetInfoContent("VirCatId"))
    InitPanel()
end

function InitPanel()
    SetBGScale()
    SetData()
    SetTitle()
    SetHp()
    SetRewards()
end

function RefreshPanel()
    SetData()
    SetHp()
    SetRewards()
    if isActive then
        ShowInfo(cfgDungeon)
    end
end

function SetBGScale()
    local size = CSAPI.GetSizeOffset()
    CSAPI.SetScale(bgObj, size, size, size)
end

function SetData()
    local _datas = VirCatMgr:GetArr(VirCatMgr:GetStage())
    curData = _datas[1]
    cfgDungeon = Cfgs.MainLine:GetByID(curData and curData:GetDungeonId())
end

function SetTitle()
    CSAPI.SetText(txtBossName, cfgDungeon and cfgDungeon.name or "")
end

function SetHp()
    if curData then
        local cur, max = curData:GetProgress()
        CSAPI.SetText(txtHP, math.floor(cur / max * 10000 + 0.5) / 100 .. "%")
        hpSlider.value = cur / max
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

function OnClickEnter()
    if curData:IsPass() then
        LanguageMgr:ShowTips(80003)
        return
    end
    local _data = {}
    _data.okCallBack = function()
        ShowInfo(cfgDungeon)
    end
    CSAPI.OpenView("VirtualCataclysmBuff",_data)
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
    CSAPI.SetGOActive(infoMask,isActive)
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
    local curPro,maxPro = curData:GetProgress()
    itemInfo.CallFunc("Progress","SetProgress",curPro,maxPro)
    itemInfo.CallFunc("Progress","SetTitle",LanguageMgr:GetByID(380016))
    itemInfo.CallFunc("Target","ShowGoals",GetTargetInfos())
    itemInfo.SetFunc("Button","OnClickEnter",OnBattleEnter)
    itemInfo.SetFunc("Button","OnClickDirll",OnDirllEnter)
    SetInfoItemPos()
end

function GetTargetInfos()
    return {{tips = LanguageMgr:GetByID(stage == 1 and 380019 or 380020),isComplete = currItem and currItem.IsKill()}}
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
    if curData then
        if curData:IsPass() then
            LanguageMgr:ShowTips(80003)
            return
        end
        local cfg = Cfgs.MainLine:GetByID(curData:GetDungeonId())
        local cost = DungeonUtil.GetCost(cfg)
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
    if curData then
        local _data = curData
        CSAPI.OpenView("VirtualCataclysmTeam",{isDirll = isDirll,dungeonId = _data:GetDungeonId(),nodeId = _data:GetID()})
    end
end

function OnClickMask()
    ShowInfo()
end
---------------------------------------------anim---------------------------------------------
function PlayAnim(delay)
    CSAPI.SetGOActive(animMask,true)
    FuncUtil:Call(function ()
        CSAPI.SetGOActive(animMask,false)
    end,this,delay)
end
