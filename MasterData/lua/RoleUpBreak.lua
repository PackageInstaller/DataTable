local panels = {}

function OnInit()
    UIUtil:AddTop2("RoleUpBreak", gameObject, function()
        view:Close()
    end, nil, {ITEM_ID.DIAMOND, ITEM_ID.GOLD, 10003})

    -- 事件监听
    eventMgr = ViewEvent.New()
    -- 卡牌刷新
    eventMgr:AddListener(EventType.Card_Update, CardUpdate)
    -- 物品更新
    eventMgr:AddListener(EventType.Bag_Update, function(_data)
        if (curPanel and curPanel.RefreshGoods) then
            curPanel.RefreshGoods()
        end
    end)
    eventMgr:AddListener(EventType.Role_Jump_Break, RoleJumpBreak)
end

-- 卡牌刷新
function CardUpdate(_data)
    if (_data.type == CardUpdateType.CardUpgradeRet or _data.type == CardUpdateType.CardBreakRet or _data.type ==
        CardUpdateType.CoreUpgrade) then
        curPanel.SetOldData(_data.other)
    end

    --如果是升级，则滑动条完成再切换界面
    if(_data.type == CardUpdateType.CardUpgradeRet) then 
        curPanel.SetIsUpCB(RefreshPanel)
        ShowPanel("RoleUp")
        return 
    end 

    RefreshPanel()

    -- 会出现界面互换（RoleBreak，RoleTalent），所以要放到这里打开
    if (_data.type == CardUpdateType.CardBreakRet) then
        CSAPI.OpenView("RoleBreakSuccess", {_data.other, cardData})
    end

    -- 突破 
    if (_data.type == CardUpdateType.CoreUpgrade) then
        CSAPI.OpenView("RoleTopuSuccess", cardData)
    end
end

-- 调整到指定突破查看
function RoleJumpBreak(_data)
    local isBack = _data[2]
    if (_data[2]) then
        -- 返回升级
        ShowPanel("RoleUp", {_data[1],_data[3]})
    else
        ShowPanel("RoleBreak", {_data[1],_data[3]})
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    cardData = data
    RefreshPanel()

    if (cardData:IsRed()) then
        cardData:IsLook()
    end
end

function RefreshPanel()

    SetRole()

    local curLv = cardData:GetLv()
    local maxLv = cardData:GetMaxLv()
    local break_limitLv = cardData:GetBreakLimitLv()
    --local core_limitLv = cardData:GetCoreLimitLv()
    local isMax = curLv >= break_limitLv -- core_limitLv 屏蔽

    if (isMax or curLv < maxLv) then
        -- 升级 
        ShowPanel("RoleUp")
    elseif (curLv < break_limitLv) then
        -- 跃升
        ShowPanel("RoleBreak")
        -- elseif (curLv < core_limitLv) then
        --     -- 突破 
        --     ShowPanel("RoleTupo")
    end
end

function SetRole()
    if (not isFirst) then
        CSAPI.SetGOActive(iconParent, false)
        isFirst = true
        RoleTool.LoadImg(img, cardData:GetSkinID(), LoadImgType.RoleInfo, function()
            CSAPI.SetGOActive(iconParent, true)
            local x1 = LoadImgType.RoleInfo[1]
            local x2 = LoadImgType.RoleUpBreak[1]
            UIUtil:SetPObjMove(iconNode, x1, x2, 0, 0, 0, 0, nil, 300, 1)
        end)
    else
        RoleTool.LoadImg(img, cardData:GetSkinID(), LoadImgType.RoleInfo)
    end
end

function ShowPanel(panelName, elseData)
    if (not panels[panelName]) then
        ResUtil:CreateUIGOAsync("Role/" .. panelName, AdaptiveScreen, function(go)
            local _curPanel = ComUtil.GetLuaTable(go)
            panels[panelName] = _curPanel

            if (curPanel and _curPanel ~= curPanel) then
                CSAPI.SetGOActive(curPanel.gameObject, false)
            end

            curPanel = panels[panelName]
            curPanel.Refresh(cardData, elseData)

        end)
    else

        if (curPanel and panels[panelName] ~= curPanel) then
            CSAPI.SetGOActive(curPanel.gameObject, false)
        end

        curPanel = panels[panelName]
        CSAPI.SetGOActive(curPanel.gameObject, true)
        curPanel.Refresh(cardData, elseData)
    end
end
