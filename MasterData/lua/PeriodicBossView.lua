local sectionData = nil
local datas1, datas2 = nil, nil
local curIndex = 0
local curItem = nil
local isHide = true
local items1 = nil
local curData = nil
local itemInfo = nil
local bgEffects = {}
-- bottom
local layout = nil
local rewardItems = nil
-- refresh
local refreshTime, time, timer = 0, 0, 0

function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/PeriodicBoss/PeriodicBossItem2", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.PeriodicBoss_Panel_Update, OnPanelRefresh)
    eventMgr:AddListener(EventType.Bag_Update, OnBagUpdate)

    CSAPI.SetGOActive(rewardMask, false)

    InitAnim()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = datas2[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB2)
        lua.Refresh(_data, curData and curData:GetRewardIndex())
    end
end

function OnItemClickCB2(item)
    ShowRewards(true, item.index)
end

-- function OnPanelRefresh()
--     SetLeftPanel()
-- end

function OnBagUpdate()
    if itemInfo and curData then
        local cur, max = curData:GetChangeNum()
        itemInfo.CallFunc("Button", "SetNum", cur, max)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("PeriodicBossView", topParent, OnClickBack);
end

function Update()
    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = refreshTime - TimeUtil:GetTime()
        if time <= 0 then
            curItem = nil
            PeriodicBossMgr:UpdateDatasTime()
            SetTime()
            SetLeftPanel()
        end
    end
end

function OnOpen()
    FightProto:GetPeriodicBossInfo()
end

function OnPanelRefresh()
    if isOpen then
        curItem = nil
        SetLeftPanel()
        return
    end
    isOpen = true
    sectionData = DungeonMgr:GetSectionData(data and data.id)
    PeriodicBossMgr:UpdateDatasTime()
    RedPointMgr:ApplyRefresh()
    InitPanel()
end

function InitPanel()
    UIUtil:SetObjFade(blackMask, 1, 0, function()
        CSAPI.SetGOActive(blackMask, false)
    end, 300)
    SetTime()
    SetLDatas()
    SetJumpState()
    SetLItems()
    SetHide()
end

function SetJumpState()
    curIndex = 1
    if data.itemId and #datas1 > 0 then
        for i, v in ipairs(datas1) do
            if v:GetDungeonId() == data.itemId then
                curIndex = i
                break
            end
        end
    end
end

function SetTime()
    refreshTime = PeriodicBossMgr:GetRefreshTime()
    time = refreshTime - TimeUtil:GetTime()
end

function RefreshPanel()
    if curData then
        SetBG()
        -- SetBGEffect()
        SetBottomPanel()
        SetRightPanel()
    end
end

function SetBG()
    local iconName = curData:GetBGName()
    if iconName then
        ResUtil.PeriodicBossImg:Load(bg, iconName,OnBGLoadSuccess,false)
    end
end

function OnBGLoadSuccess()
    CSAPI.SetGOAlpha(bg,1)
end

function SetBGEffect()
    for i, v in pairs(bgEffects) do
        CSAPI.SetGOActive(v.gameObject, false)
    end

    if bgEffects[curData:GetID()] then
        CSAPI.SetGOActive(bgEffects[curData:GetID()].gameObject, true)
    elseif curData:GetBGEffect() then
        ResUtil.CreateBGEffect(curData:GetBGEffect(), effectMask, function(go)
            bgEffects[curData:GetID()] = go
        end)
    end
end

function OnClickBack()
    view:Close()
end
---------------------------------------------left---------------------------------------------
function SetLeftPanel()
    SetLDatas()
    SetLItems()
    SetHide()
end

function SetLDatas()
    datas1 = PeriodicBossMgr:GetArr()
end

function SetLItems()
    items1 = items1 or {}
    ItemUtil.AddItems("PeriodicBoss/PeriodicBossItem1", items1, datas1, itemParent1, OnItemClickCB, 1, nil,
        OnItemLoadSuccess)
end

function OnItemClickCB(item)
    if curItem and curItem.index == item.index then
        return
    end
    if curItem then
        curItem.ShowSelAnim(false)
    end
    curItem = item
    curItem.ShowSelAnim(true)
    curIndex = item.index
    curData = item.GetData()
    RefreshPanel()
end

function OnItemLoadSuccess()
    if items1[curIndex] then
        items1[curIndex].OnClick()
    end
end

function SetHide()
    -- CSAPI.SetScale(hideImg, isHide and -1 or 1, 1, 1)
    local height = 36
    if isHide then
        height = height + 91
    elseif datas1 then
        height = height + #datas1 * 91 + (#datas1 - 1) * 18
    end
    CSAPI.SetRTSize(leftLayout, 431, height)
end

function OnClickHide()
    isHide = not isHide
    ShowHideBtnAnim(not isHide)
    ShowHideAnim(not isHide)
    SetHide()
end

function OnClickRankReward()
    UIUtil:OpenRankView(sectionData:GetRankView(), GetRankInfos(), 3, {
        damage = curData and curData:GetRealDamage()
    })
end

function OnRankClick()
    UIUtil:OpenRankView(sectionData:GetRankView(), GetRankInfos(), 1, {
        damage = curData and curData:GetRealDamage()
    })
end

function GetRankInfos()
    if curData then
        return {{
            id = curData:GetRankId(),
            title = LanguageMgr:GetByID(70005),
            desc1 = LanguageMgr:GetByID(76221)
        }, {
            id = curData:GetRankRewardID(),
            title = LanguageMgr:GetByID(70006)
        }, {
            id = curData:GetRewardID(),
            title = LanguageMgr:GetByID(70007)
        }}
    end
end

function OnClickShop()
    local shopId = sectionData and sectionData:GetInfoContent("shopId")
    if shopId then
        CSAPI.OpenView("ShopView", shopId)
    end
end

---------------------------------------------bottom---------------------------------------------
function SetBottomPanel()
    SetDamage()
    SetBDatas()
    SetItems2()
end

function SetDamage()
    if curData:IsOpen() then
        local damage, isReduce = curData:GetDamage()
        CSAPI.SetText(txtDamage, (damage > 0 and damage .. "" or ""))
        CSAPI.SetGOActive(txtDamage, true)
        CSAPI.SetGOActive(txt_damage, isReduce or damage <= 0)
        LanguageMgr:SetText(txt_damage,damage > 0 and 76214 or 76209)
    else
        LanguageMgr:SetText(txt_damage, 76209)
        CSAPI.SetGOActive(txtDamage, false)
        CSAPI.SetGOActive(txt_damage, true)
    end
end

function SetBDatas()
    local cfgReward = Cfgs.CfgPeriodicBossBattleReward:GetByID(curData:GetRewardID())
    if cfgReward and cfgReward.infos then
        datas2 = {}
        for i, v in ipairs(cfgReward.infos) do
            table.insert(datas2, v)
        end
    end
end

function SetItems2()
    layout:IEShowList(#datas2, OnItemLoadSuccess2, 1)
end

function OnItemLoadSuccess2()
    if not isFirst then
        CSAPI.SetParent(svLine2, itemParent2.gameObject)
        svLine2.transform:SetAsFirstSibling()
        CSAPI.SetParent(svLine1, itemParent2.gameObject)
        svLine1.transform:SetAsFirstSibling()
        ShowEnterAnim()
    end
    isFirst = true
    local left, cell, spacing = 13, 138, 18
    local width = left + #datas2 * cell + (#datas2 - 1) * spacing - cell / 2
    CSAPI.SetRTSize(svLine1, width, 6)
    local curDamage, lastDamage = curData:GetRealDamage(), 0
    local width2, len = 0, 0
    for i, v in ipairs(datas2) do
        len = i == 1 and (left + cell / 2) or cell + spacing
        if curDamage >= v.damage then
            width2 = width2 + len
            lastDamage = v.damage
        else
            width2 = width2 + ((curDamage - lastDamage) / (v.damage - lastDamage)) * len
            break
        end
    end
    CSAPI.SetRTSize(svLine2, width2, 6)
end

function ShowRewards(b, index)
    CSAPI.SetGOActive(rewardMask, b)
    if b and datas2 and index then
        local info = datas2[index]
        if info and info.reward then
            rewardItems = rewardItems or {}
            GridAddRewards(rewardItems, info.reward, rewardParent, 0.5)
        end
        local listX = CSAPI.GetAnchor(itemParent2)
        local x, y = -484, -380
        x = x + (index - 1) * 156 + listX
        CSAPI.SetAnchor(rewardObj, x, y)
    end
end

function OnClickMask()
    ShowRewards(false)
end

---------------------------------------------right---------------------------------------------
function SetRightPanel()
    ShowInfo()
end

function ShowInfo()
    local cfg = curData and curData:GetDungeonCfg()
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("PeriodicBoss/DungeonItemInfo", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            CSAPI.SetGOActive(itemInfo.gameObject, true)
            itemInfo.SetPos(true)
            itemInfo.Refresh(cfg, DungeonInfoType.PeriodicBoss, OnInfoLoadSuccess)
        end)
    else
        itemInfo.Refresh(cfg, DungeonInfoType.PeriodicBoss, OnInfoLoadSuccess)
    end
end

function OnInfoLoadSuccess()
    itemInfo.SetPanelPos("Title", 0, 354)
    itemInfo.SetPanelPos("Buff", 0, 14)
    itemInfo.SetPanelPos("Rank", 0, -284)
    itemInfo.SetPanelPos("Button", 0, -415)
    if curData then
        itemInfo.CallFunc("Title", "SetTime", curData:GetDupOverTime(), curData:GetStartTime())
        itemInfo.CallFunc("Buff", "SetBuff", curData:GetBuffID())
        itemInfo.CallFunc("Rank", "SetRank", curData:GetDamage() > 0 and curData:GetRank() or "")
        itemInfo.CallFunc("Rank", "CloseRank", (not (curData:IsOpen() or curData:IsOver())) or curData:GetDamage() <= 0)
        local cur, max = curData:GetChangeNum()
        itemInfo.CallFunc("Button", "SetNum", cur, max)
        itemInfo.CallFunc("Button", "SetRed", curData:IsOpen() and not curData:IsOver() and curData:GetRealDamage() <= 0)
        itemInfo.CallFunc("Button", "SetAlpha", (curData:IsOpen() and not curData:IsOver()) and 1 or 0.5)
    end

    itemInfo.SetFunc("Button", "OnClickEnter", OnBattleEnter)
    itemInfo.SetFunc("Button", "OnClickDirll", OnDirllEnter)
    itemInfo.SetFunc("Rank", "OnClickRank", OnRankClick)
end

function OnBattleEnter()
    EnterDungeon()
end

function OnDirllEnter()
    EnterDungeon(true)
end

function EnterDungeon(isDirll)
    if curData then
        if not isDirll then
            if not curData:IsOpen() then
                return
            end
            if curData:IsOver() then
                return
            end
            local cur, max = curData:GetChangeNum()
            if cur <= 0 then
                OnBuyFunc()
                return
            end
        end
        local cfg = curData:GetDungeonCfg()
        if cfg then
            CSAPI.OpenView("TeamConfirm", {
                dungeonId = cfg.id,
                teamNum = cfg.teamNum,
                buffId = curData:GetBuffID(),
                bossId = curData:GetID(),
                isDirll = isDirll,
                disChoosie = true,
                showFakeLevel = PeriodicBossMgr:GetFakeLevel(),
                isNotAssist = true
            }, TeamConfirmOpenType.PeriodicBoss)
        end
    end

end

function OnBuyFunc()
    local curCount = DungeonMgr:GetArachnidCount(sectionData:GetID())
    if curCount <= 0 then
        LanguageMgr:ShowTips(54001)
        return
    end
    if sectionData:GetBuyGets() then
        UIUtil:OpenPurchaseView(nil, LanguageMgr:GetByID(76226), curCount, sectionData:GetBuyCount(), sectionData:GetBuyCost(),
            sectionData:GetBuyGets(), OnPayFunc)
    end
end

function OnPayFunc(count)
    PlayerProto:BuyArachnidCount(count, sectionData:GetID(),RefreshPanel)
end

----------------------------------anim----------------------------------
local hideAnim = nil
function InitAnim()
    CSAPI.SetGOActive(animMask, false)

    hideAnim = ComUtil.GetCom(btnHide,"Animator")
end

function PlayAnim(time)
    CSAPI.SetGOActive(animMask, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(animMask, false)
    end, this, time)
end

function ShowEnterAnim()
    if datas2 then
        for i, v in ipairs(datas2) do
            local lua = layout:GetItemLua(i)
            if lua then
                lua.ShowEnterAnim(90 + (i - 1) * 45)
            end
        end
    end
    PlayAnim(1200)
end

function ShowHideBtnAnim(b)
    if not IsNil(hideAnim) then
        hideAnim:Play(b and "btnHide_sel" or "btnHide_Nsel")
    end
end

function ShowHideAnim(b)
    if items1 then
        for i, v in ipairs(items1) do
            if i ~= 1 then
                UIUtil:SetObjFade(v.gameObject,b and 0 or 1,b and 1 or 0,nil,300)
            end
        end
    end
end