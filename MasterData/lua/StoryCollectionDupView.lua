local groupData = nil
local itemInfo = nil
local cfg = nil

function OnInit()
    UIUtil:AddTop2("StoryCollectionDup", topParent, OnClickBack)
end

function OnOpen()
    if data and data.id then
        groupData = DungeonMgr:GetDungeonGroupData(data.id)
        SetLeft()
        SetRight()
    end
end

function SetLeft()
    SetIcon()
    SetName()
end

function SetIcon()
    local iconName = groupData:GetIcon()
    if iconName and iconName ~= "" then
        ResUtil.StoryCollectionImg:Load(icon,groupData:GetGroup() .. "/" .. iconName)
    end
end

function SetName()
    CSAPI.SetText(txtName,groupData:GetName())
end

function SetRight()
    cfg = groupData:GetFirstDungeonCfg()
    ShowInfo()
end

function ShowInfo()
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo", InfoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            CSAPI.SetGOActive(itemInfo.gameObject, true)
            itemInfo.SetPos(true)
            itemInfo.Refresh(cfg)
        end)
    else
        itemInfo.Refresh(cfg)
    end
end

function OnClickBack()
    view:Close()
end