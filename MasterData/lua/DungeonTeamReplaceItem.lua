local isCheckCard = false
local teamNum = 1
local curDatas1 = nil
local curDatas2 = nil
local items1 = nil
local items2 = nil
local formationView = nil

function Awake()
    items1 = {}
    items2 = {}
    for i = 1, 6 do
        local go1 = ResUtil:CreateUIGO("DungeonTeamReplace/DungeonTeamReplaceCard", itemParent1.transform)
        items1[i] = ComUtil.GetLuaTable(go1)
        items1[i].SetIndex(i)
        items1[i].SetClickCB(OnItemClickCB)
        if itemParent2 and not IsNil(itemParent2.gameObject) then
            local go2 = ResUtil:CreateUIGO("DungeonTeamReplace/DungeonTeamReplaceCard", itemParent2.transform)
            items2[i] = ComUtil.GetLuaTable(go2)
            items2[i].SetIndex(i)
            items2[i].SetClickCB(OnItemClickCB)
        end
    end
end

function OnItemClickCB(item)
    CSAPI.OpenView("RoleInfo", item.cardData)
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function SetClickCB2(_cb2)
    cb2 = _cb2
end

-- teamDatas
function Refresh(_data, _elseData)
    data = _data
    isCheckCard = _elseData
    if data then
        SetDatas()
        SetItems()
        SetSkill()
        -- SetPos()
    end
end

function SetDatas()
    curDatas1 = data[1] and data[1].data or nil
    curDatas2 = data[2] and data[2].data or nil
end

function SetItems()
    -- Log(string.format("第%s个第一队战力:%s", index, data[1]:GetTeamStrength() + data[1]:GetHaloStrength()))
    AddItems(items1, curDatas1)
    AddItems(items2, curDatas2)
    -- if curDatas2 then
    --     Log(string.format("第%s个第二队战力%s", index, data[2]:GetTeamStrength() + data[2]:GetHaloStrength()))
    -- end
end

function AddItems(items, datas)
    for i = 1, 6 do
        if items[i] then
            items[i].Refresh()
        end
    end
    if datas and #datas > 0 then
        for i, v in ipairs(datas) do
            local index = v:GetIndex()
            if items[index] then
                items[index].Refresh(datas[i], {
                    isCheckCard = isCheckCard
                })
            end
        end
    end
end

function SetSkill()
    SetSkillIcon(1, data[1].skillGroupID)
    if data[2] then
        SetSkillIcon(2, data[2].skillGroupID)
    end
end

function SetSkillIcon(index, cfgId)
    if not this["txtSkill" .. index] or not this["skillIcon" .. index] then
        return
    end
    if cfgId == nil or cfgId == -1 then
        CSAPI.SetText(this["txtSkill" .. index].gameObject, LanguageMgr:GetByID(110012))
        CSAPI.SetGOActive(this["skillIcon" .. index].gameObject, false)
        CSAPI.SetGOActive(this["skillEmpty" .. index].gameObject, true)
        return
    end
    local cfg = Cfgs.CfgPlrSkillGroup:GetByID(cfgId)
    if cfg then
        CSAPI.SetGOActive(this["skillEmpty" .. index].gameObject, false)
        CSAPI.SetGOActive(this["skillIcon" .. index].gameObject, true)
        CSAPI.SetText(this["txtSkill" .. index].gameObject, cfg.sName);
        ResUtil.Ability:Load(this["skillIcon" .. index].gameObject, cfg.sIcon .. "_1");
    end
end

function SetPos()
    if gameObject.name == "DungeonTeamReplaceItem2" then
        local num = data[2] ~= nil and 2 or 1
        CSAPI.SetAnchor(teamObj1, 0, num == 2 and 94 or -30)
        CSAPI.SetGOActive(teamObj2, num > 1)
    end
end

function OnClickShow(go)
    if data == nil then
        return
    end
    local teamData = go.name == "btnShow1" and data[1] or data[2]
    if cb2 then
        cb2(teamData)
    end
end

function OnClickReplace()
    if cb then
        cb(this)
    end
end
