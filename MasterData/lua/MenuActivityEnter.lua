local activeEnter_tab = {} -- {cfg:CfgActiveEntry,刷新时间,是否开启}
local timer = 0
local curTime = nil

-- 登录到主界面、场景切换后返回主界面、关卡更新、红点更新时都刷新一次
function Refresh()
    InitActivityEnter()
    SetActivityEnter()
end

function Update()
    if (Time.time < timer) then
        return
    end
    timer = Time.time + 1
    curTime = TimeUtil:GetTime()
    -- 活动入口
    if (activeEnter_tab[2] ~= nil and curTime >= activeEnter_tab[2]) then
        Refresh()
    end
end

function InitActivityEnter()
    activeEnter_tab = {}
    local ativeEnter = {}
    local curTime = TimeUtil:GetTime()
    local cfgs = Cfgs.CfgActiveEntry:GetAll()
    for k, v in pairs(cfgs) do
        if (v.sort and v.sort > 0) then
            if (curTime < TimeUtil:GetTimeStampBySplit(v.endTime)) then
                table.insert(ativeEnter, v)
            end
        end
    end
    if (#ativeEnter > 0) then
        if (#ativeEnter > 1) then
            table.sort(ativeEnter, function(a, b)
                return a.sort < b.sort
            end)
        end
        local index = 1
        for k, v in ipairs(ativeEnter) do
            local begTime = TimeUtil:GetTimeStampBySplit(v.begTime)
            if (curTime >= begTime) then
                index = k
                break
            end
        end
        local cfg = ativeEnter[index]
        activeEnter_tab = {cfg}
        local begTime = TimeUtil:GetTimeStampBySplit(cfg.begTime)
        local endTime = TimeUtil:GetTimeStampBySplit(cfg.endTime)
        --
        local isOpen = curTime >= TimeUtil:GetTimeStampBySplit(cfg.begTime)
        activeEnter_tab[3] = isOpen
        --
        activeEnter_tab[2] = isOpen and endTime or begTime
        --
        local isLock = false
        if (cfg.unlockID) then
            isLock = not DungeonMgr:CheckDungeonPass(cfg.unlockID)
        elseif (cfg.nConfigID) then
            isLock = true
            local _cfg = Cfgs[cfg.config]:GetByID(cfg.nConfigID)
            if (_cfg) then
                local sid = 0
                if _cfg.sectionID then
                    sid = _cfg.sectionID
                elseif _cfg.infos and _cfg.infos[1] and _cfg.infos[1].sectionID then
                    sid = _cfg.infos[1].sectionID
                end
                local sectionData = DungeonMgr:GetSectionData(sid)
                if (sectionData ~= nil) then
                    isLock = not sectionData:GetOpen()
                end
            end
        end
        activeEnter_tab[4] = isLock
    end
end

function SetActivityEnter()
    SetBase()
    -- 
    CSAPI.SetGOActive(node62, false)
    if (activeEnter_tab[1] and activeEnter_tab[1].id == 62) then
        SetNode62()
    end
end

-- icon,lock,红点
function SetBase()
    CSAPI.SetGOActive(node, activeEnter_tab[3])
    local isRed = false
    local isLock = false
    if (activeEnter_tab[3]) then
        local imgName = activeEnter_tab[1].mainBtn
        ResUtil.MenuEnter:Load(icon, imgName)
        isLock = activeEnter_tab[4]
        if (not isLock) then
            local redData = nil
            local key = "ActiveEntry" .. activeEnter_tab[1].id
            if (key == "ActiveEntry26") then
                redData = ColosseumMgr:IsRed()
            elseif (key == "ActiveEntry41") then
                redData = RedPointMgr:GetData(RedPointType.Anniversary)
            elseif (key == "ActiveEntry62") then
                redData = RogueMapMgr:CheckRollCountRed()
            elseif  (key == "ActiveEntry67") then
                redData = MissionMgr:CheckRed({eTaskType.StoryCollectionAct,eTaskType.StoryCollection}) and 1 or 0
            elseif (key == "ActiveEntry71") then
                redData = VirCatMgr:CheckRed() and 1 or 0
            else
                redData = RedPointMgr:GetData(key)
            end
            if (redData and redData ~= 0) then
                isRed = true
            end
        end
    end
    CSAPI.SetGOAlpha(node, not isLock and 1 or 0.5)
    UIUtil:SetLockPoint(gameObject, isLock, 0, 0) 
    UIUtil:SetRedPoint(gameObject, isRed, 112, 60)
end

--特殊处理的活动
function SetNode62()
    CSAPI.SetGOActive(node62, true)
    -- todo
    CSAPI.SetGOActive(rogueMapAssist,RogueMapMgr:IsAssistNew() and not RogueMapMgr:IsRewardRed())
    CSAPI.SetGOActive(rogueMapReward,RogueMapMgr:IsRewardRed())
end

function OnClickNode()
    if (not activeEnter_tab[4]) then
        if (activeEnter_tab[1].JumpID) then
            JumpMgr:Jump(activeEnter_tab[1].JumpID)
        end
    else
        Tips.ShowTips(activeEnter_tab[1].desc) -- 未开启
    end
end
