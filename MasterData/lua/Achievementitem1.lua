local cfg = nil

function Refresh()
    SetCfg()
    if cfg then
        SetIcon()
        SetName()    
    end
end

function SetCfg()
    local cur = AchievementMgr:GetCount()
    local cfgs = Cfgs.CfgAchieveCollect:GetAll()
    if cfgs and #cfgs>0 then
        for k, v in ipairs(cfgs) do
            if cur >= v.num  then
                cfg = v
            end
        end
    end
end

function SetIcon()
    local iconName = cfg.icon
    if iconName~=nil and iconName~="" then
        ResUtil.Achievement:Load(icon, iconName)
    end
end

function SetName()
    CSAPI.SetText(txtName,cfg.name)
end

function OnClickQuestion()
    
end