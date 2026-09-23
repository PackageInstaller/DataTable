local cfg = nil
local data = nil
local sectionData = nil
local timer = 0
local time1,refreshTime1 =0,0
local time2,refreshTime2 =0,0

function Update()
    if timer < Time.time then
        timer = Time.time + 1
        SetTimeText()
    end
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetName()
    end
end

function SetName()
    CSAPI.SetText(txtName,cfg.name)
end

--结算时间、开启时间
function SetTime(_refreshTime1,_refreshTime2)    
    time1,time2= 0,0
    if _refreshTime2 and _refreshTime2 > TimeUtil:GetTime() then
        refreshTime2 = _refreshTime2
        time2 = refreshTime2 - TimeUtil:GetTime()
    elseif _refreshTime1 and _refreshTime1 > TimeUtil:GetTime() then
        refreshTime1 = _refreshTime1
        time1 = refreshTime1 - TimeUtil:GetTime()
    else
        LanguageMgr:SetText(txtTime,76215)
    end
    SetTimeText()
end

function SetTimeText()
    if time1 > 0 then
        time1 = refreshTime1 - TimeUtil:GetTime()
        local tab = TimeUtil:GetTimeTab(time1)
        LanguageMgr:SetText(txtTime,55002,tab[1],tab[2],tab[3])
    elseif time2 > 0 then
        time2 = refreshTime2 - TimeUtil:GetTime()
        LanguageMgr:SetText(txtTime,76211,TimeUtil:GetTimeStr10(time2))  
    end
end

function OnClickBoss()
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