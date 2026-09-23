local baseCfgIDs
local curCfgIDs
local datas -- 选取的

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Update_Everyday, OnClickC)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    curData = CreateMgr:GetData(data)
    baseCfgIDs = curData:GetChoiceCids()
    SetDatas()
    RefreshPanel()
end

function SetDatas()
    datas = {}
    for k = 1, 5 do
        local _data = k <= #baseCfgIDs and RoleMgr:GetFakeData(baseCfgIDs[k]) or {}
        table.insert(datas, _data)
    end
end

function RefreshPanel()
    isSelect = curData:GetFirstCids() ~= nil
    SetItems()
    SetBtns()
    SetText()
end

function SetText()
    str = LanguageMgr:GetByID(17203)
    if (isSelect) then
        local names = {}
        local cids = curData:GetFirstCids()
        for k, v in ipairs(cids) do
            local cfg = Cfgs.CardData:GetByID(v)
            names[k] = cfg.name
        end
        str = LanguageMgr:GetByID(17185, names[1], names[2])
    elseif (isShow) then
        str = LanguageMgr:GetByID(17185, datas[1]:GetName(), datas[3]:GetName())
    end
    CSAPI.SetText(txtSV, str)
end

function SetItems()
    datas1 = {datas[1], datas[2]}
    items1 = items1 or {}
    ItemUtil.AddItems("Create/CreateRoleCard", items1, datas1, hlg1, ItemClickCB1, 1, {data, true, isSelect})

    datas2 = {datas[3], datas[4], datas[5]}
    items2 = items2 or {}
    ItemUtil.AddItems("Create/CreateRoleCard", items2, datas2, hlg2, ItemClickCB2, 1, {data, true, isSelect})
end

function ItemClickCB1(index)
    CSAPI.OpenView("CreateSelectRoleTPanel", {index, datas1, GetPoolCardCfgs(6), data, SelectCB})
end

function ItemClickCB2(index)
    CSAPI.OpenView("CreateSelectRoleTPanel", {index + 2, datas2, GetPoolCardCfgs(5), data, SelectCB})
end

function SelectCB(index, cfgID)
    datas[index] = RoleMgr:GetFakeData(cfgID)
    RefreshPanel()
end

function GetPoolCardCfgs(quality)
    if (not poolCards) then
        poolCards = {}
        local ids = curData:GetCfg().sel_card_ids
        if (#ids > 1) then
            table.sort(ids, function(a, b)
                return a < b
            end)
        end
        for k, v in ipairs(ids) do
            local cfg = Cfgs.CardData:GetByID(v)
            poolCards[cfg.quality] = poolCards[cfg.quality] or {}
            table.insert(poolCards[cfg.quality], cfg)
        end

    end
    return poolCards[quality]
end

function SetBtns()
    -- 不同，并且已满
    isShow = false
    local isAllSelect = true
    curCfgIDs = {}
    for k, v in ipairs(datas) do
        if (v.data == nil) then
            isAllSelect = false
            break
        else
            table.insert(curCfgIDs, v:GetCfgID())
        end
    end
    if (isAllSelect) then
        local isSame = FuncUtil.TableIsSame(curCfgIDs, baseCfgIDs)
        if (isAllSelect and not isSame) then
            isShow = true
        end
    end
    CSAPI.SetGOAlpha(btnS, isShow and 1 or 0.3)
end

function OnClickS()
    if (isShow) then
        if (#baseCfgIDs <= 0) then
            --local str = LanguageMgr:GetByID(17185)
            UIUtil:OpenDialog(str, function()
                PlayerProto:SetSelfChoiceCardPoolCard(curData:GetID(), curCfgIDs)
                view:Close()
            end)
        else
            PlayerProto:SetSelfChoiceCardPoolCard(curData:GetID(), curCfgIDs)
            view:Close()
        end
    end
end

function OnClickC()
    view:Close()
end

function OnClickMask()
    view:Close()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
