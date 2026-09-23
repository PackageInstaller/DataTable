local cfg = nil
local data = nil
local sectionData = nil

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetName()
        SetHard()
        SetTime()
    end
end

function SetName()
    local str = cfg.name:gsub("-","\u{3000}")
    CSAPI.SetText(txtName,str)
    CSAPI.SetText(txtName2,str)
    CSAPI.SetText(txtStage,cfg.chapterID and cfg.chapterID .. "" or "")
    CSAPI.SetGOActive(txtStage,cfg.type ~= eDuplicateType.Tower and cfg.type ~= eDuplicateType.TaoFa)
    CSAPI.SetGOActive(txt_stage,cfg.type ~= eDuplicateType.Tower and cfg.type ~= eDuplicateType.TaoFa)
end

function SetHard()
    CSAPI.SetGOActive(hardObj, cfg.type == eDuplicateType.MainElite)
end

function SetTime()
    CSAPI.SetGOActive(txtTime, cfg.nEndTime ~= nil)
    if (cfg.nEndTime) then
        local _endTime = TimeUtil:GetTimeStampBySplit(cfg.nEndTime)
        local surplusTime = TimeUtil:GetTimeTab(_endTime - TimeUtil:GetTime())
        if surplusTime[1] > 0 then
            LanguageMgr:SetText(txtTime, 36008, surplusTime[1] .. "")
        else
            CSAPI.SetText(txtTime, "")
            LogError("该限时副本已结束!" .. cfg.id)
        end
    end
end
