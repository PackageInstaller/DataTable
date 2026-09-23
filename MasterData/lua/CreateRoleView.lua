-- 抽卡结果
local timer = 0

function Awake()
    items = items or {}
    for i = 1, 10 do
        local go = ResUtil:CreateUIGO("CreateShow/CreateRoleItem", grid.transform)
        local lua = ComUtil.GetLuaTable(go)
        lua.SetIndex(i)
        table.insert(items, lua)
    end

    timer = Time.time + 1.5

    ResUtil:CreateEffect("OpenBox/BGLineLoop", 0, 0, 0, bg)

    -- SettingMgr:SetMusic(false)
    bgm = CSAPI.StopBGM()

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.Role_FirstCreate_End, FirstEnd)
    eventMgr:AddListener(EventType.CreateRoleView_ShareBtn_SH, OpenShareBtn)

    CSAPI.AddEventListener(EventType.ShareView_NoticeTheNextFrameScreenshot,ShareView_NoticeTheNextFrameScreenshot)
    CSAPI.AddEventListener(EventType.ShareView_NoticeScreenshotCompleted,ShareView_NoticeScreenshotCompleted)
end

function OnDestroy()
    CSAPI.RemoveEventListener(EventType.ShareView_NoticeTheNextFrameScreenshot,ShareView_NoticeTheNextFrameScreenshot)
    CSAPI.RemoveEventListener(EventType.ShareView_NoticeScreenshotCompleted,ShareView_NoticeScreenshotCompleted)
    if CSAPI.IsADV() then AdvGuiDeScore.GameAdvGuiDeScore() end
    eventMgr:ClearListener()
    -- SettingMgr:SetMusic(true)
    --EventMgr.Dispatch(EventType.Replay_BGM)
    CSAPI.ReplayBGM(bgm)
end

function OnViewOpened(viewKey)
    if (viewKey == "CreateShowView") then
        view:Close()
    end
end

---判断是否可以打开  分享按钮
function OpenShareBtn(_b)
    local b = _b==nil and true or _b
    local rewards = data[1]
    local quality = GetMaxQuality(rewards)
    if quality>=6 and  CSAPI.IsMobileplatform then
        if b and (CSAPI.IsSharePicture()) then
            CSAPI.SetGOActive(ShareBtn, true);
        else
            CSAPI.SetGOActive(ShareBtn, false);
        end
    else
        CSAPI.SetGOActive(ShareBtn, false)
    end
end
-- {rewards, isFirst10, poolId}
function OnOpen()
    local rewards = data[1]
    -- local goodsDatas = data[4] or {}
    local quality = GetMaxQuality(rewards)
    OpenShareBtn();
    for i, v in ipairs(items) do
        -- v.Refresh(rewards[i], goodsDatas[rewards[i].id])
        v.Refresh(rewards[i], rewards[i].goodsData)
        -- 动画
        local index = i % 5 == 0 and 5 or i % 5
        local delay = (index - 1) * 100
        local timer = 1000 - delay
        local y1 = i > 5 and -430 or 430

        UIUtil:SetPObjMove(v.moveNode, 0, 0, y1, 0, 0, 0, function()
            v.SetEffect()
            if (i == 1) then
                CSAPI.PlayUICardSound("ui_card_draw_summary_end")
                if (quality >= 5) then
                    CSAPI.PlayUICardSound("ui_card_draw_summary_golden")
                elseif (quality >= 4) then
                    CSAPI.PlayUICardSound("ui_card_draw_summary_purple")
                else
                    CSAPI.PlayUICardSound("ui_card_draw_summary_bule")
                end
            end
        end, timer, delay)

        UIUtil:SetObjFade(v.moveNode, 0, 1, nil, timer, delay)

        v.SetImg67Anim(timer, delay)
    end

    CSAPI.PlayUICardSound("ui_card_draw_summary_start")
    if CSAPI.IsADV() then
        JudgNewPlayer(data)
    end
end
---判断新玩家
function JudgNewPlayer(data)
    if(1003==data[3]) then
        local curData = CreateMgr:GetData(1003)
        if(curData and curData:GetCount()<=1 ) then
            BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_RESTRUCTURE_FIRST)
        end
    end
end
function GetMaxQuality(rewards)
    local quality = 3
    for i, v in ipairs(rewards) do
        local cfg = Cfgs.CardData:GetByID(v.id)
        if (cfg.quality > quality) then
            quality = cfg.quality
        end
    end
    return quality
end

-- function SetItems()
-- 	ItemUtil.AddItems("RoleCard/CreateRoleItem", items, data[1], grid)
-- end
-- 重复10连界面
function OpenCreateCachePanel()
    if (createCachePanel == nil) then
        local go = ResUtil:CreateUIGO("Create/CreateCachePanel", transform)
        createCachePanel = ComUtil.GetLuaTable(go)
        -- createCachePanel.SetSureCB(function()
        --     view:Close()
        -- end)
    end
    createCachePanel.Refresh(data)
end

function OnClickMask()
    if (Time.time < timer) then
        return
    end

    if (data[2]) then
        OpenCreateCachePanel()
        EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "CloseBuild") 
    else
        view:Close()
        PopupPackMgr:CheckByCondition({3})
        PhysicalRewardMgr:CheckShowReward()
    end
end
function OnClickShareBtn()
    CSAPI.OpenView("ShareView",{LocationSource=1})
end
---截图前一帧通知
function ShareView_NoticeTheNextFrameScreenshot(Data)
    CSAPI.SetGOActive(itemParent, false);
end

---截图完成通知
function ShareView_NoticeScreenshotCompleted(Data)
    OpenShareBtn();
end
function FirstEnd()
    view:Close()
    PopupPackMgr:CheckByCondition({3})
    PhysicalRewardMgr:CheckShowReward()
end