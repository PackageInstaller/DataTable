function Awake()
    UIUtil:AddTop2("ColosseumTeam", gameObject, function()
        if (not isMax and data) then
            data.closeCB()
        else
            EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "ColosseumMRandom")
        end
        view:Close()
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Colosseum_SelectCard, SelectCardCB)
end

function SelectCardCB(cardIdx)
    -- 动画
    CSAPI.SetGOActive(mask, true)
    mItems[cardIdx].SetOut()
    FuncUtil:Call(RefreshPanel, nil, 300)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    RefreshPanel()
end

function RefreshPanel()
    local _data = ColosseumMgr:GetRandModData()
    local selectCardData = _data.selectCardData
    -- top
    local cur = ColosseumMgr:GetRoleCur()
    local max = ColosseumMgr:GetRoleMax()
    isMax = cur >= max
    LanguageMgr:SetText(txtRole, 64025, cur, max)
    -- middle
    if(not isMax) then 
        mItems = mItems or {}
        for k, v in pairs(mItems) do
            mItems[k].SetIn()
            CSAPI.SetGOActive(v.gameObject, false)
        end
        ItemUtil.AddItems("Colosseum/ColosseumTeamItem", mItems, selectCardData.waitSelectCards, mGrid, TeamItemClick)
    end 
    -- down
    cardDatas = {}
    local selectCards = selectCardData.selectCards or {}
    for k = 1, max do
        local cardData = {}
        local _selectCard = selectCards[k]
        if (_selectCard) then
            -- local monsterCfg = Cfgs.MonsterData:GetByID(_selectCard.monsterIdx)
            -- cardData = RoleMgr:GetMaxFakeData(_selectCard.cardId, monsterCfg.level)
            cardData = ColosseumMgr:MonsterCardData(_selectCard.monsterIdx)
        end
        table.insert(cardDatas, cardData)
    end
    dItems = dItems or {}
    for k, v in pairs(dItems) do
        CSAPI.SetGOActive(v.gameObject, false)
    end
    ItemUtil.AddItems("RoleLittleCard/RoleSmallCard", dItems, cardDatas, dGrid, DItemClickCB)
    -- maxk 
    CSAPI.SetGOActive(mask, isMax)
    if (isMax) then
        FuncUtil:Call(function()
            --“已使用上次保存路线”
            if(cur==ColosseumMgr:GetBaseRoleMax(2) and ColosseumMgr:IsSaveSelect()) then 
                LanguageMgr:ShowTips(45003)
            end
            --
            view:Close()
            EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "ColosseumMRandom")
        end, nil, 500)
    end
end

function TeamItemClick(index)
    AbattoirProto:SelectCard(index)
end

function DItemClickCB(item)
    if (item.data ~= nil) then
        CSAPI.OpenView("RoleInfo", item.data)
    end
end

function OnClickEdit()
    CSAPI.OpenView("TeamView", {
        currentIndex = eTeamType.Colosseum + 1,
        canEmpty = true,
        is2D = true
    }, TeamOpenSetting.Colosseum)
end
