local slotNodes = {}
local equipDatas = {}
local grids = {}

function Awake()
    anim_node = ComUtil.GetCom(node, "Animator")
    slotNodes = {tGO, lGO, cGO, rGO, bGO}
end

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    local monsterCfg = Cfgs.MonsterData:GetByID(_data.monsterIdx)
    -- cardData = RoleMgr:GetMaxFakeData(_data.cardId, monsterCfg.level)
    cardData = ColosseumMgr:MonsterCardData(_data.monsterIdx)
    -- cardData.data.equips = _data.equips
    -- icon
    ResUtil.FightCard:Load(icon, cardData:GetModelCfg().Fight_head)
    -- name
    CSAPI.SetText(txtName, cardData:GetName())
    -- lv
    CSAPI.SetText(txtLv, cardData:GetLv() .. "")
    -- grid
    -- if (cardData:GetCfg().gridsIcon) then
    --     ResUtil.RoleSkillGrid:Load(imgGrid, cardData:GetCfg().gridsIcon)
    -- end
    -- equip
    SetEquip()
    -- star
    local roleCfg = Cfgs.CardData:GetByID(monsterCfg.card_id)
    local quality = roleCfg.quality or 6
    local bgName = "img_01_0" .. (9 - quality)
    CSAPI.LoadImg(starBG, "UIs/Colosseum/" .. bgName .. ".png", true, nil, true)
    local starName = "img_01_0" .. quality
    ResUtil.RoleCard_BG:Load(star, starName)
    --
    SetTJObj()
    SetPosVlg()
end

function SetEquip()
    local equipDatas = ColosseumMgr:GetEquipDatas(data.equips)
    if #grids <= 0 then
        for i = 1, 5, 1 do
            ResUtil:CreateUIGOAsync("EquipCore/EquipMiniGrid", slotNodes[i], function(go)
                local lua = ComUtil.GetLuaTable(go)
                lua.SetSlot(i)
                lua.Refresh(GetEquipBySlot(equipDatas, i))
                table.insert(grids, lua)
            end)
        end
    else
        for k, v in ipairs(grids) do
            v.Refresh(GetEquipBySlot(equipDatas, k))
        end
    end
end

function GetEquipBySlot(equipDatas, i)
    for k, v in pairs(equipDatas) do
        if v:GetSlot() == i then
            return v
        end
    end
    return nil
end

-- 选中动画
function SetIn()
    anim_node:Play("ColosseumTeamltem_in")
    CSAPI.SetGOActive(star, true)
    CSAPI.SetGOActive(equipItems, true)
    CSAPI.SetGOAlpha(gameObject, 1)
end

-- 选中动画
function SetOut()
    anim_node:Play("ColosseumTeamltem_end")
    CSAPI.SetGOActive(star, false)
    CSAPI.SetGOActive(equipItems, false)
    UIUtil:SetObjFade(gameObject, 1, 0, nil, 200, 1, 1)
end

-- 看装备
function OnClickItem(go)
    -- local slot = -1
    -- for k, v in ipairs(slotNodes) do
    --     if v == go then
    --         slot = k
    --         break
    --     end
    -- end
    -- if slot ~= -1 then
    --     local equip = cardData:GetEquipBySlot(slot)
    --     if equip then
    --         CSAPI.OpenView("EquipFullInfo", equip, openSetting == 3)
    --     end
    -- end
end

-- 看人
function OnClickLook()
    -- local _data = cardData:GetData()
    -- local data = table.copy(_data)
    -- data.equips = nil
    -- local _cardData = RoleMgr:GetMaxFakeData(data.cfgid, data.level)
    CSAPI.OpenView("RoleInfo", cardData)
end

-- 看装备技能
function OnClickLook2()
    local equip = data.equips[1]
    CSAPI.OpenView("ColosseumEquipPanel", {equip.cfgid, detailTarget})
end

function OnClickS()
    if (cb) then
        cb(index)
    end
end

function SetTJObj()
    local recommend = {}
    local cfg = Cfgs.cfgColosseumEquip:GetByID(data.cardId)
    for k, v in pairs(cfg.infos) do
        if (v.monsterIdx == data.monsterIdx) then
            recommend = v.recommend or {}
            break
        end
    end
    local len = #recommend
    CSAPI.SetGOActive(tjObj, len > 0)
    if (len > 0) then
        -- local tab = {}
        -- for k, v in pairs(recommend) do
        --     tab[v] = 1
        -- end
        -- for k = 1, 3 do
        --     CSAPI.SetGOActive(this["imgTJ" .. k], tab[k] ~= nil)
        -- end
        local childCount = tjObj.transform.childCount - 1
        for i, v in ipairs(recommend) do
            if (i <= childCount) then
                local _tran = tjObj.transform:GetChild(i)
                CSAPI.SetGOActive(_tran.gameObject, true)
                ResUtil.Colosseum:Load(_tran.gameObject, "small"..v)
            else
                local go = CSAPI.CloneGO(imgTJ, tjObj.transform)
                ResUtil.Colosseum:Load(go.gameObject, "small"..v)
            end
        end
        for i = len + 1, childCount do
            CSAPI.SetGOActive(tjObj.transform:GetChild(i).gameObject, false)
        end
    end
end

function SetPosVlg()
    local enums = {}
    local monsterCfg = Cfgs.MonsterData:GetByID(data.monsterIdx)
    local _nums = monsterCfg.pos_enum
    if (_nums) then
        for i, v in ipairs(_nums) do
            local cfg = Cfgs.CfgRolePosEnum:GetByID(v)
            table.insert(enums, cfg)
        end
        local len = #enums
        if (len > 0) then
            local childCount = posVlg.transform.childCount
            local origin = posVlg.transform:GetChild(0).gameObject
            for i, v in ipairs(enums) do
                if (i <= childCount) then
                    local _tran = posVlg.transform:GetChild(i - 1)
                    CSAPI.SetGOActive(_tran.gameObject, true)
                    ResUtil.RolePos:Load(_tran:GetChild(0).gameObject, v.icon)
                else
                    local go = CSAPI.CloneGO(origin, posVlg.transform)
                    ResUtil.RolePos:Load(go.transform:GetChild(0).gameObject, v.icon)
                end
            end
            for i = len + 1, childCount do
                CSAPI.SetGOActive(posVlg.transform:GetChild(i - 1).gameObject, false)
            end
        end
    end
    CSAPI.SetGOActive(posVlg, #enums > 0)
end
