local cfg =nil
local iconItem

function Refresh(_data)
    cfg = Cfgs.cfgGlobalBossBuffBattle:GetByID(_data)
    if cfg then
        SetIcon()
        SetName()
        SetDesc()
    end
end

function SetIcon()
    if iconItem == nil then
        ResUtil:CreateUIGOAsync("GlobalBoss/GlobalBossBuffItem2",iconParent,function (go)
            iconItem = ComUtil.GetLuaTable(go)
            iconItem.Refresh(cfg.id)
        end)
    else
        iconItem.Refresh(cfg.id)
    end
end

function SetName()
    CSAPI.SetText(txtName,cfg.name or "")
end

function SetDesc()
    CSAPI.SetText(txtDesc,cfg.desc or "")
end