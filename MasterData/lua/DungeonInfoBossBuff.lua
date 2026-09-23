local cfg = nil
local data = nil
local sectionData = nil

local items= nil

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetItems()
    end
end

function SetItems()
    if GlobalBossMgr:GetBuffIds() then
        items = items or {}
        ItemUtil.AddItems("GlobalBoss/GlobalBossBuffItem2",items,GlobalBossMgr:GetBuffIds(),itemParent)
    end
end

function OnClick()
    if GlobalBossMgr:GetBuffIds() then
        CSAPI.OpenView("GlobalBossBuff", GlobalBossMgr:GetBuffIds())
    end
end