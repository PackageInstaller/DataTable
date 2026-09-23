local bossData = nil
local hpSlider = nil
local isEnd = false
local cfg = nil

function Awake()
    hpSlider = ComUtil.GetCom(slider, "Slider")

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Dungeon_DailyData_Update, OnChangeUpdate)
end

function OnChangeUpdate()
    SetChange(true)
end

function OnInit()
    UIUtil:AddTop2("BattleFieldBoss", topObj, OnClickReturn, nil, {});
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    local curTime = TimeUtil.GetTime()
    if bossData and bossData.nEndTime then
        -- isEnd = curTime >= bossData.nEndTime
        SetTime(bossData.nEndTime)
    end
end

function SetTime(target)
    if TimeUtil:GetTime() >= target then
        LanguageMgr:SetText(txtTime, 39002)
    else
        local timeTab = TimeUtil:GetDiffHMS(target, TimeUtil:GetTime())
        local day = timeTab.day > 0 and timeTab.day or 0
        local hour = timeTab.hour > 0 and timeTab.hour or 0
        local minute = timeTab.minute > 0 and timeTab.minute or 0
        LanguageMgr:SetText(txtTime, 1042, day, hour, minute)
    end
end

function OnOpen()
    bossData = BattleFieldMgr:GetBossData()
    if bossData then
        SetHp()
        SetChange()
        local cfgDungeon = Cfgs.MainLine:GetByID(bossData.nBossID)
        if cfgDungeon then
            SetIcon(cfgDungeon.bossIcon)
            if cfgDungeon.enemyPreview then
                local cfgModel = Cfgs.CardData:GetByID(cfgDungeon.enemyPreview[1])
                if cfgModel then
                    SetName(cfgModel.name)
                    SetDesc(cfgModel.m_Desc)
                end
            end
        end
    end
end

function SetHp()
    local cur = bossData.bossHp or 0
    local max = bossData.bossMaxHp or 0
    CSAPI.SetText(txtCurHp, cur .. "")
    CSAPI.SetText(txtMaxHp, "/" .. max)
    hpSlider.value = cur / max
end

function SetChange(isRefresh)
    local cur, max = BattleFieldMgr:GetBossChangeCount(isRefresh)
    cur = StringUtil:SetByColor(cur, "FFC146")
    CSAPI.SetText(txtChange, cur .. "/" .. max)
end

function SetIcon(iconName)
    if iconName and iconName ~= "" then
        ResUtil:LoadBigImg(icon, "UIs/DungeonActivity/BattleField/" .. iconName .. "/bg")
    end
end

function SetName(str)
    CSAPI.SetText(txtTitle, str)
end

function SetDesc(str)
    CSAPI.SetText(txtDesc, str)
end

function OnClickExplain()
    CSAPI.OpenView("BattleFieldExplain", 1)
end

function OnClickReward()
    CSAPI.OpenView("MissionActivity", {
        type = eTaskType.DupFight,
        title = LanguageMgr:GetByID(6020)
    })
end

function OnClickBuff()
    CSAPI.OpenView("BattleFieldExplain", 2)
end

function OnClickRank()
    -- CSAPI.OpenView("BattleFieldRank")
end

function OnClickShop()
    CSAPI.OpenView("ShopView", 903)
end

function OnClickEnemy()
    if bossData then
        local cfgDungeon = Cfgs.MainLine:GetByID(bossData.nBossID)
        local list = {};
        if cfgDungeon and cfgDungeon.enemyPreview then
            for k, v in ipairs(cfgDungeon.enemyPreview) do
                local cfg = Cfgs.CardData:GetByID(v);
                table.insert(list, {
                    id = v,
                    -- level = cfgDungeon.previewLv,
                    isBoss = k == 1
                });
            end
            CSAPI.OpenView("FightEnemyInfo", list);
        end
    end
end

function OnClickEnter()
    if isEnd then
        LanguageMgr:ShowTips(24001)
        return
    end
    if bossData then
        local cfg = Cfgs.MainLine:GetByID(bossData.nBossID)
        if cfg then
            CSAPI.OpenView("TeamConfirm", { -- 正常上阵
                dungeonId = cfg.id,
                teamNum = cfg.teamNum,
                isNotAssist = true
            }, TeamConfirmOpenType.FieldBoss)
        end
    end
end

function OnClickReturn()
    view:Close()
end
