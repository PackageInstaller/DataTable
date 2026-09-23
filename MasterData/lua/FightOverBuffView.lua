
local buffs = nil
local items= nil
local cfgDungeon = nil

-- type: 1.结算 2.扫荡  id：关卡id
function OnOpen()
    if data then
        cfgDungeon = Cfgs.MainLine:GetByID(data.id)
        if data.type == 1 then
            CSAPI.SetAnchor(pos,535,0)
        elseif data.type == 2 then
            CSAPI.SetAnchor(pos,133,316)
        end
    end
    InitBuffData()
    RefreshItems()
end

function InitBuffData()
    buffs = {}
    local lifeBuffs = PlayerClient:GetLifeBuff()
    if lifeBuffs then
        for i, v in ipairs(lifeBuffs) do
            if v.id == 4 or v.id == 9 or v.id == 14 then
                local cfg = Cfgs.CfgLifeBuffer:GetByID(v.id)
                local title = cfg and cfg.name or ""
                table.insert(buffs,{title = title,data = {v}})
            end
        end
    end
    local abilityBuffs = PlayerAbilityMgr:GetFightOverBuff()
    if abilityBuffs then
        local title = LanguageMgr:GetByID(20023)
        local dungeonType = cfgDungeon and cfgDungeon.type or 0
        local aBuffs = {}
        for i, v in ipairs(abilityBuffs) do
            if dungeonType == eDuplicateType.Exp and v.id == 29 then
                table.insert(aBuffs,v)
            elseif dungeonType == eDuplicateType.Gold and v.id == 30 then
                table.insert(aBuffs,v)
            end
        end
        if #aBuffs > 0 then
            table.insert(buffs,{title = title,data = aBuffs})
        end
    end
end

function RefreshItems()
    items = items or {}

    ItemUtil.AddItems("FightOver/FightOverBuffItem", items, buffs, itemParent)
end

function OnClickClose()
    view:Close()
end