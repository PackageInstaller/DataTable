local data = nil
local buffs = nil
local mistInfo = nil
local items = nil
local currItem = nil
local isCanSelect = true
local selectIndex = 1
local newCfg = nil
local curSelType = 0 --1.空 2.同类型

function Refresh(_data)
    data = _data
    mistInfo = data and data.info
    newCfg = Cfgs.BufferConfig:GetByID(mistInfo and mistInfo.buffId or 0)
    if not newCfg then
        LogError("未找到对应buffId配置！！！" .. (mistInfo and mistInfo.buffId or ""))
        return
    end
    SetData()
    CheckBuffs()
    SetItems()  
    SetNewObj()
    SetButtonState()
end

function SetData()
    buffs = {}
    if data and data.buffs then
        for i, v in ipairs(data.buffs) do
            buffs[v.index] = v
        end
    end
end

function CheckBuffs()
    local curType = newCfg.type
    local cfg = nil
    for _, v in pairs(buffs) do
        cfg = Cfgs.BufferConfig:GetByID(v.id)
        if cfg and cfg.type == curType then
            selectIndex = v.index
            isCanSelect = false
            curSelType = 2
            break
        end
    end
    if curSelType == 0 then
        for i = 1, 3 do
            if buffs[i] == nil then
                selectIndex = i
                isCanSelect = false
                curSelType = 1  
                break
            end
        end
    end
end

function SetItems()
    items = items or {}
    for i = 1, 3 do
        if items[i] then
            items[i].Refresh(buffs[i],isCanSelect)
            if currItem == nil and i == selectIndex then
                currItem = items[i]
                currItem.SetSelect(true)
            end
        else
            ResUtil:CreateUIGOAsync("RogueMapBattle/RogueMapBuffTipsItem",itemParent,function (go)
                items[i] = ComUtil.GetLuaTable(go)
                items[i].SetIndex(i)
                items[i].SetClickCB(OnItemClickCB)
                items[i].Refresh(buffs[i],isCanSelect)
                if currItem == nil and i == selectIndex then
                    currItem = items[i]
                    currItem.SetSelect(true)
                end
            end)
        end
    end
end

function OnItemClickCB(item)
    if not isCanSelect then
        return
    end
    if currItem and currItem.index == item.index then
        return
    end
    if currItem then
        currItem.SetSelect(false)
        currItem = nil
    end

    currItem = item
    currItem.SetSelect(true)
end

function SetNewObj()
    if newCfg then
        if newCfg.icon then
            ResUtil.RogueMapBuff:Load(icon,newCfg.icon)
        end
        if newCfg.icon_Type then
            ResUtil.RogueBuff:Load(iconBg,newCfg.icon_Type)
        end
        CSAPI.SetText(txtName,newCfg.name)
        CSAPI.SetText(txtDesc,newCfg.desc)
        CSAPI.SetText(txtRound,mistInfo.buffRound  .. "")
    end
    if curSelType == 2 then
        LanguageMgr:SetText(txtState,76060,newCfg.name)
    else
        LanguageMgr:SetText(txtState,curSelType == 1 and 76061 or 76059)
    end
end

function SetButtonState()
    CSAPI.SetGOActive(btnAdd,curSelType == 2)
    LanguageMgr:SetText(txtSure,curSelType == 1 and 1001 or 76062)
end

function OnClickAdd()
    FightProto:RogueMapSelectBuff(currItem.index,2,OnAddBack)
end

function OnClickSure()
    FightProto:RogueMapSelectBuff(currItem.index,1,OnSureBack)
end

function OnSureBack()
    LanguageMgr:ShowTips(50013)
    Close()
end

function OnAddBack()
    LanguageMgr:ShowTips(50014,newCfg and newCfg.name or "")
    Close()
end

function OnClickClose()
    FightProto:RogueMapSelectBuff(0,3,Close)
end

function Close()
    selectIndex = 1
    isCanSelect = true
    curSelType = 0
    if currItem then
        currItem.SetSelect(false)
        currItem = nil
    end
    if this.OnViewClose then
        this.OnViewClose(this)
    end
end