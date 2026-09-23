local sectionData = nil
local curDatas = nil
local items = nil
local selIndex = 0
local curIndex = 0
local currItem = nil
local itemInfo = nil
local currLevel = 1
local currDanger = 1

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Dungeon_InfoItem_Update, OnItemInfoUpdate)
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRed)

    CSAPI.SetGOActive(animMask, false)
end

function OnItemInfoUpdate(_data)
    if _data then
        currDanger = _data.danger or currDanger
        -- RefreshInfo(currItem)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("RogueMapList", topParent, OnClickBack);
end

function OnOpen()
    if data and data.group then
        sectionData = DungeonMgr:GetSectionData(data.group)
    end
    if sectionData then
        InitPanel()
    end
end

function InitPanel()
    InitDatas()
    InitJumpState()
    SetLeft()
    SetRed()
end

function InitDatas()
    curDatas = RogueMapMgr:GetArr(sectionData:GetID())
end

function InitJumpState()
    curIndex, currDanger= GetCurIndex(data and data.groupId,
        data and data.itemId or RogueMapMgr:GetFightId())
end

function GetCurIndex(_groupId, _itemId)
    local index, danger = 1, RogueMapMgr:GetLv()
    local dungeonGroups, ids = nil, nil
    if curDatas and #curDatas > 0 then
        for i, v in ipairs(curDatas) do
            if (not _groupId or _groupId == v:GetID()) and v:IsOpen() then
                index = i
                if _itemId then
                    ids = v:GetDungeonGroups()
                    if ids and #ids > 0 then
                        for k, id in ipairs(ids) do
                            if _itemId == id then
                                danger = k
                                return index, danger
                            end
                        end
                    end
                end
            end
        end
    end
    return index, danger
end

function RefreshPanel()
    SetLeft()
end

function SetLeft()
    items = items or {}
    ItemUtil.AddItems("DungeonActivity2/DungeonTaoFaItem",items,curDatas,itemParent,OnItemClickCB,1,nil,OnItemLoadSuccess)
end

function OnItemClickCB(item)
    if item.index == selIndex then
        return
    end

    if not item.isOpen then
        LanguageMgr:ShowTips(44001)
        return
    end

    if currItem then
        currItem.ShowSelAnim(false)
        currItem = nil
    end

    item.ShowSelAnim(true)
    selIndex = item.index
    curIndex = item.index
    currItem = item
    ShowInfo(item)
end

function OnItemLoadSuccess()
    if isFirst then
        return 
    end
    isFirst = true

    items[curIndex].OnClick()
end

function ShowInfo(item)
    local cfg = item and item.GetCfg(currDanger) or nil
    local type = DungeonInfoType.RogueMap
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("RogueMap/RogueMapItemInfo", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            itemInfo.Show(cfg, type, OnLoadCallBack)
        end)
    else
        itemInfo.Show(cfg, type, OnLoadCallBack)
    end
end

function RefreshInfo(item)
    if itemInfo and item then
        local cfg = item and item.GetCfg(currDanger) or nil
        itemInfo.Refresh(cfg, DungeonInfoType.RogueMap, OnLoadCallBack)
    end
end

function OnLoadCallBack()
    itemInfo.SetFunc("Button6", "OnClickEnter", OnBattleEnter)
    itemInfo.CallFunc("Button6", "SetText",
        (RogueMapMgr:GetFightId() and RogueMapMgr:GetFightId() > 0) and LanguageMgr:GetByID(76044) or
            LanguageMgr:GetByID(15003))
    itemInfo.CallFunc("Button6", "HideDirll", true)
    itemInfo.SetFunc("Output4", "GetRewardDatas", OnGetRewardDatas)
    itemInfo.CallFunc("Output4","ShowOutput")
    SetItemInfoDetails()
    SetItemInfoDanger()
    SetInfoItemPos()
end

function OnBattleEnter()
    ApplyShowTeamView()
end

function OnDirllEnter()
    ApplyShowTeamView(true)
end

function ApplyShowTeamView(isDirll)
    if currItem then
        local cfg = currItem.GetCfg(currDanger)
        if cfg then
            if cfg.dLevel and cfg.dLevel > RogueMapMgr:GetLv() then
                LanguageMgr:ShowTips(50008)
                return
            end
            CSAPI.OpenView("TeamConfirm", { -- 正常上阵
                dungeonId = cfg.id,
                teamNum = cfg.teamNum,
                isNotAssist = true,
                isDirll = isDirll
            }, TeamConfirmOpenType.RogueMap)
        end
    end
end

function OnGetRewardDatas()
    local _datas = {}
    local groupData = curDatas[curIndex]
    if groupData then
        local specialRewards = RewardUtil.GetSpecialReward(groupData:GetGroup())
        if (specialRewards and #specialRewards > 0) then
            for i, v in ipairs(specialRewards) do
                local _data = {
                    id = GridUtil.GetGoodsID(v),
                    elseData = {
                        tag = ITEM_TAG.TimeLimit
                    }
                }
                table.insert(_datas, _data)
            end
        end
        local rewards = groupData:GetRewards()
        if rewards and not groupData:IsPass() then
            for i, v in ipairs(rewards) do
                local _data = {
                    id = GridUtil.GetGoodsID(v),
                    elseData = {
                        tag = ITEM_TAG.FirstPass,
                        isPass = false
                    }
                }
                table.insert(_datas, _data)
            end
        end
    end
    return _datas
end

function SetItemInfoDetails()
    itemInfo.SetFunc("Details", "Refresh", OnDetailsRefresh)
    itemInfo.SetGOActive("Details", "mapObj", false)
    itemInfo.SetGOActive("Details", "enemyImg1", false)
    itemInfo.SetGOActive("Details", "enemyImg2", true)
    itemInfo.SetFunc("Details", "OnClickEnemy", OnEnemyEnter)
end

function OnDetailsRefresh(tab)

end

function OnEnemyEnter()
    if currItem then
        local cfg = currItem.GetCfg(currDanger)
        if cfg then
            local list = {};
            if cfg and cfg.enemyPreview then
                for k, v in ipairs(cfg.enemyPreview) do
                    local cfg = Cfgs.CardData:GetByID(v);
                    table.insert(list, {
                        id = v,
                        isBoss = k == 1
                    });
                end
            end
            CSAPI.OpenView("FightEnemyInfo", list);
        end
    end
end

function SetItemInfoDanger()
    if currItem then
        itemInfo.CallFunc("Danger4", "ShowDangeLevel", true, currItem.GetCfgs(), currDanger)
        itemInfo.CallFunc("Danger4", "SetTips", LanguageMgr:GetByID(76085))
        itemInfo.CallFunc("Danger4", "SetClick", RogueMapMgr:GetFightId() ~= nil, LanguageMgr:GetTips(50007),
            LanguageMgr:GetTips(50008))
    end
end

function SetInfoItemPos()
    if itemInfo then
        itemInfo.SetPanelPos("Title2", -16, 385)
        itemInfo.SetPanelPos("Level", -12, 311)
        itemInfo.SetPanelPos("Output4", 11, 170)
        itemInfo.SetPanelPos("Danger4", -13, -97)
        itemInfo.SetPanelPos("Details", -13, -252)
        itemInfo.SetPanelPos("Button6", -14, -427)
    end
end

function SetRed()
    UIUtil:SetRedPoint(redParent,RogueMapMgr:IsRewardRed() or RogueMapMgr:IsAssistNew())
end

function OnClickAssist()
    CSAPI.OpenView("RogueMapAssist",{id = sectionData:GetID()})
end

function OnClickBack()
    view:Close()
end
