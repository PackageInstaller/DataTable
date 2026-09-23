local layout = nil
local layoutTween = nil
local curDatas = nil
local deepDatas = nil
local selIndex = 0
local curIndex = 0
local currItem = nil
local itemInfo = nil
local isActive = false
local openInfo = nil
local sectionData = nil
local lockTime,lockTargetTime,lockTimer = 0,0,0
-- anim
local actionMove = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/TowerDeep/TowerDeepItem", LayoutCallBack)
    -- layoutTween = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.MoveByType2, {"DTU"});

    CSAPI.SetGOActive(animMask, false)

    actionMove = ComUtil.GetCom(svAction, "ActionMoveByCurve")
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index, #curDatas)
        lua.SetClickCB(OnItemClickCB)
        lua.SetSel(index == selIndex)
        lua.Refresh(_data, {
            isPass = TowerMgr:IsDeepPass(_data:GetID()),
            isLock = not TowerMgr:IsDeepOpen(_data:GetID()),
            data = deepDatas and deepDatas[_data:GetID()]
        })
    end
end

function OnItemClickCB(item)
    if selIndex == item.index then
        return
    end

    local lua = layout:GetItemLua(selIndex)
    if lua then
        lua.SetAnimSel(false)
    end

    item.SetAnimSel(true)
    selIndex = item.index
    curIndex = item.index

    ShowInfo(item)
end

function OnInit()
    UIUtil:AddTop2("TowerDeep", topParent, OnClickClose)
end

function Update()
    if itemInfo and isActive then
        if lockTime > 0 and lockTimer < Time.time then
            lockTimer = Time.time + 1
            lockTime = lockTargetTime - TimeUtil:GetTime()
            local tab = TimeUtil:GetTimeTab(lockTime)
            local obj = itemInfo.GetPanelObj("Button", "txtDesc")
            if obj and not IsNil(obj.gameObject) then
                LanguageMgr:SetText(obj.gameObject,130013,tab[1],tab[2],tab[3])
            end
            if lockTime <= 0 then
                SetInfoButtonState(curDatas[selIndex]:GetID())
                layout:UpdateList()
            end
        end
    end
end

function OnOpen()
    if data and data.id then
        sectionData = DungeonMgr:GetSectionData(data.id)
        openInfo = DungeonMgr:GetActiveOpenInfo2(data.id)
        if not openInfo then
            LogError("未找到和章节相关活动入口表数据！！！章节id：" .. data.id)
            return
        end
        SetDatas()
        SetEnterState()
        SetItems()
    else
        LogError("未传入章节id！！！")
    end
end

function SetDatas()
    deepDatas = TowerMgr:GetDeepDatas(openInfo:GetCfgID())
    curDatas = DungeonMgr:GetDungeonGroupDatas(data.id)
    if #curDatas > 0 then -- 倒序
        table.sort(curDatas, function(a, b)
            return a:GetID() > b:GetID()
        end)
    end
end

function SetEnterState()
    curIndex = #curDatas
    selIndex = 0
    if data.itemId then
        for i, v in ipairs(curDatas) do
            if data.itemId == v:GetID() then
                curIndex = i
                break
            end
        end
    end
end

function SetItems()
    if not isFirst then
        AnimStart()
    end
    layout:IEShowList(#curDatas, OnLoadSuccess, curIndex)
end

function OnLoadSuccess()
    if data.itemId then
        local lua = layout:GetItemLua(curIndex)
        if lua then
            lua.OnClick()
        end
    end
    if isFirst then
        return
    end
    isFirst = true
    CSAPI.SetParent(imgLayout, content)
    PlaySvEnterAnim()
end

function ShowInfo(item)
    isActive = item ~= nil;
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo8", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            itemInfo.Show(item and item.GetCfg(), DungeonInfoType.TowerDeep, OnLoadCallBack)
        end)
    else
        itemInfo.Show(item and item.GetCfg(), DungeonInfoType.TowerDeep, OnLoadCallBack)
    end
    SetSvPos()
end

function SetSvPos()
    CSAPI.MoveTo(vsv, "UI_Local_Move", isActive and -247 or 0, 0, 0, nil, 0.15)
end

function OnLoadCallBack()
    local lua = layout:GetItemLua(selIndex)
    if lua then
        itemInfo.CallFunc("Title", "SetName", lua.data:GetName())
        itemInfo.CallFunc("Score", "SetText", lua.GetScore())
        itemInfo.CallFunc("Target", "ShowGoals", lua.GetGoals())
        itemInfo.SetFunc("Output", "GetRewardDatas", OnGetRewardDatas)
        itemInfo.CallFunc("Output", "ShowOutput")
        itemInfo.SetFunc("Output", "OnClickOutput", OnGoodItemClick)
        itemInfo.SetFunc("Details", "OnClickEnemy", OnEnemyClick)
        SetInfoButton(lua)
    end
    SetInfoItemPos()
end

function OnGetRewardDatas()
    local _datas = {}
    local lua = layout:GetItemLua(selIndex)
    if lua then
        local cfg = lua.data:GetCfg()
        if cfg then
            if cfg.rewards then
                for i, v in ipairs(cfg.rewards) do
                    table.insert(_datas, {
                        id = v,
                    })
                end
            end
        end
    end
    return _datas
end

function OnGoodItemClick()
    local infos = {}
    local lua = layout:GetItemLua(selIndex)
    if lua then
        local cfg = lua.data:GetCfg()
        if cfg then
            local goals = TowerMgr:GetTowerDeepGoals(lua.data:GetID()) or {}
            -- local goals = lua.GetGoals()
            for i = 1, 3 do
                local info = {}
                if cfg["Reward" .. i] then
                    info.rewards = cfg["Reward" .. i]
                    info.elseData = {isPass = goals[i] and goals[i].isComplete}
                    info.languageText = LanguageMgr:GetByID(130028,i)
                end
                table.insert(infos,info)
            end
        end
    end
    CSAPI.OpenView("DungeonDetail2", infos)
end

function OnEnemyClick()
    local lua = layout:GetItemLua(selIndex)
    if lua then
        local cfg = lua.data:GetCfg()
        if cfg then
            local cfgDungeons = {}
            local cfgs = Cfgs.MainLine:GetGroup(cfg.group)
            for k, _cfg in pairs(cfgs) do
                if _cfg.dungeonGroup == cfg.id then
                    table.insert(cfgDungeons, _cfg)
                end
            end
            if #cfgDungeons > 0 then
                table.sort(cfgDungeons, function(a, b)
                    return a.id < b.id
                end)
            end
            local list = {};
            if #cfgDungeons > 0 then
                local cfgCard = nil
                for _, _cfg in ipairs(cfgDungeons) do
                    if _cfg.enemyPreview then
                        for k, v in ipairs(_cfg.enemyPreview) do
                            table.insert(list, {
                                id = v,
                                isBoss = k == 1
                            });
                        end
                    end
                end
            end
            CSAPI.OpenView("FightEnemyInfo", list);
        end
    end
end

function SetInfoButton(item)
    itemInfo.SetFunc("Button", "OnClickEnter", OnBattleEnter)
    SetInfoButtonState(curDatas[selIndex]:GetID())
end

function SetInfoButtonState(groupId)
    local isOpen,lockStr,time = TowerMgr:IsDeepOpen(groupId)
    lockTime = 0
    itemInfo.SetGOActive("Button", "btnEnter", isOpen)
    if not isOpen then    
        if time > 0 and time > TimeUtil:GetTime() then
            lockTargetTime = time + 1
            lockTime = lockTargetTime - TimeUtil:GetTime()
            local tab = TimeUtil:GetTimeTab(lockTime)
            LanguageMgr:SetText(itemInfo.GetPanelObj("Button", "txtDesc").gameObject,130013,tab[1],tab[2],tab[3])
        else
            CSAPI.SetText(itemInfo.GetPanelObj("Button", "txtDesc").gameObject, lockStr)
        end
    else
        CSAPI.SetText(itemInfo.GetPanelObj("Button", "txtDesc").gameObject, "")
    end
end

function OnBattleEnter()
    if not openInfo or not openInfo:IsOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    local _data = curDatas[selIndex]
    if _data then
        -- if _data:GetID() <= TowerMgr:GetNewPassDeepId() then -- 已通关
        --     return
        -- end
        if not TowerMgr:IsDeepOpen(_data:GetID()) then -- 未解锁
            return
        end
        CSAPI.OpenView("TowerDeepTeam", _data:GetID())
    end
end

function SetInfoItemPos()
    itemInfo.SetPanelPos("Title", 22, 470)
    itemInfo.SetPanelPos("Score", 22, 336)
    itemInfo.SetPanelPos("Target", 22, 235)
    itemInfo.SetPanelPos("Output", 22, -59)
    itemInfo.SetPanelPos("Details", -4, -216)
    itemInfo.SetPanelPos("Button", 22, -397)
end

function OnClickBack()
    if isActive then
        local lua = layout:GetItemLua(selIndex)
        if lua then
            lua.SetAnimSel(false)
        end
        selIndex = 0
        curIndex = 0
        ShowInfo()
    end
end

function OnClickRank()
    if not openInfo or not openInfo:IsOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    UIUtil:OpenRankView(sectionData:GetRankView(),sectionData:GetRankListInfo())
end

function OnClickReward()
    CSAPI.OpenView("TowerDeepReward",sectionData:GetID())
end

function OnClickShop()
    JumpMgr:Jump(openInfo:GetJumpID())
end

function OnClickClose()
    view:Close()
end

---------------------------------------------anim---------------------------------------------

function PlayAnim(time)
    time = time or 0
    CSAPI.SetGOActive(animMask, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(animMask, false)
    end, this, time)
end

function AnimStart()
    CSAPI.SetGOActive(animMask, true)
end

function AnimEnd()
    CSAPI.SetGOActive(animMask, false)
end

function PlaySvEnterAnim()
    UIUtil:SetObjFade(imgLayout, 0, 1, nil, 200)
    if #curDatas > 0 then
        local index = 1
        local lua = nil
        for i = #curDatas, 1,-1 do
            lua = layout:GetItemLua(i)
            if lua then
                UIUtil:SetObjFade(lua.gameObject, 0, 1, nil, 200, index * 50)
                index = index + 1
            end
        end
        FuncUtil:Call(AnimEnd, this, index * 50)
    end
end

