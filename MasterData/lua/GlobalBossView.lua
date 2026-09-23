local itemInfo = nil
local bossData = nil
local curType = nil
local cfgModel = nil

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    eventMgr:AddListener(EventType.GlobalBoss_Data_Update, OnDataUpdate)
    eventMgr:AddListener(EventType.Mission_List, SetRed)

    CSAPI.SetGOActive(killObj, false)
end

function OnViewOpened(viewKey)
    if (viewKey == "RankList" or viewKey == "FightEnemyInfo" or viewKey == "TeamConfirm") then -- 排除自身
        FightProto:GetGlobalBossData()
    end
end

function OnViewClosed(viewKey)
    if (viewKey == "RankList" or viewKey == "FightEnemyInfo" or viewKey == "TeamConfirm") then -- 排除自身
        FightProto:GetGlobalBossData()
    end
end

function OnDataUpdate(isOffset)
    if isOffset then
        local dialogData = {}
        dialogData.content = LanguageMgr:GetTips(47003)
        dialogData.okCallBack = function()
            UIUtil:ToHome()
        end
        CSAPI.OpenView("Prompt", dialogData)
        return
    end
    bossData = GlobalBossMgr:GetData()
    RefreshPanel()
end

function OnTimeEnd()
    LanguageMgr:ShowTips(24001)
    UIUtil:ToHome()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("GlobalBossView", topParent, OnClickReturn);
end

function OnOpen()
    InitData()
    if bossData then
        cfgModel = Cfgs.GlobalBossModel:GetByID(bossData:GetModelId())
        InitPanel()
    end

    DungeonMgr:CheckRedPointData()
end

function InitData()
    bossData = GlobalBossMgr:GetData()
end

function InitPanel()
    InitEffect()
    FightProto:GetGlobalBossData()
end

function InitEffect()
    if bossData:GetEffectName() then
        ResUtil:CreateBGEffect(bossData:GetEffectName(), 0, 0, 0, effectParent, function(go)
            SetEffectScale()
        end)
    end
end

function SetEffectScale()
    local size = CSAPI.GetMainCanvasSize()
    local offset1, offset2 = size[0] / 1920, size[1] / 1080
    local offset = offset1 > offset2 and offset1 or offset2
    CSAPI.SetScale(effectParent, offset, offset, offset)

    -- if offset1>offset2 then
    --     CSAPI.SetRTSize(bg,size[0],1080*offset)
    -- elseif offset1<offset2 then
    --     CSAPI.SetRTSize(bg,1920*offset,size[1])
    -- end
end

function RefreshPanel()
    ShowKill()
    ShowInfo()
    SetRed()
end

function ShowKill()
    CSAPI.SetGOActive(killObj, GlobalBossMgr:IsKill())
end

function ShowInfo()
    local cfg = bossData:GetDungeonCfg()
    local cfgGlobalBoss = bossData:GetCfg()
    curType = GlobalBossMgr:GetBuffIds() and DungeonInfoType.GlobalBossBuff or DungeonInfoType.GlobalBoss
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("GlobalBoss/GlobalBossInfo", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            CSAPI.SetGOActive(itemInfo.gameObject, true)
            itemInfo.SetPos(true)
            itemInfo.Refresh(cfg, curType, OnItemLoadSuccess)
        end)
    else
        itemInfo.Refresh(cfg, curType)
    end
end

function GetType()
    return DungeonInfoType.GlobalBoss
end

function OnItemLoadSuccess()
    if itemInfo then
        if curType == DungeonInfoType.GlobalBossBuff then
            itemInfo.SetPanelPos("BossTitle", 18.5, 430)
            itemInfo.SetPanelPos("BossLevel", 18.5, 280)
            itemInfo.SetPanelPos("BossState", 18.5, 219)
            itemInfo.SetPanelPos("BossTime", 18.5, 156)
            itemInfo.SetPanelPos("BossButton1", 18.5, 66)
            itemInfo.SetPanelPos("BossDetails", 18.5, -47)
            itemInfo.SetPanelPos("BossBuff", 18.5, -170)
        else
            itemInfo.SetPanelPos("BossTitle", 18.5, 440)
            itemInfo.SetPanelPos("BossLevel", 18.5, 301)
            itemInfo.SetPanelPos("BossState", 18.5, 215)
            itemInfo.SetPanelPos("BossTime", 18.5, 115)
            itemInfo.SetPanelPos("BossButton1", 18.5, 0)
            itemInfo.SetPanelPos("BossDetails", 18.5, -155)
        end
        itemInfo.SetPanelPos("BossButton2", 18.5, -303)
        OnImgReplace()
    end
end

function OnImgReplace()
    if cfgModel and not isFirstReplace then
        isFirstReplace = true
        for k, v in pairs(cfgModel) do
            if not (tostring(k) == "id" or tostring(k) == "key") then
                if itemInfo[k] and not IsNil(itemInfo[k].gameObject) then
                    ResUtil.GlobalBossInfo:Load(itemInfo[k].gameObject,tostring(cfgModel.id) .. "/" .. v,false)
                    CSAPI.SetImgColor(itemInfo[k].gameObject,255,255,255,255)
                end
                itemInfo.ReplacePanelImgs(tostring(k),"GlobalBossInfo",tostring(cfgModel.id) .. "/" .. v)
            end
        end
    end
end

function SetRed()
    UIUtil:SetRedPoint(btnMission, GlobalBossMgr:IsMissionRed(), 107, 34)
end

function OnClickMission()
    CSAPI.OpenView("MissionGlobalBoss", {
        group = bossData:GetSectionID()
    })
end

function OnClickReturn()
    view:Close()
end
