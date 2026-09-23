-- local targetPos = {{-243.9, 491.3}, {-81.4, 491.3}, {81.3, 491.3}, {243.5, 491.3}}
local lookBreakLv -- 预览等级

function Awake()
    cg_btnBreak = ComUtil.GetCom(btnBreak, "CanvasGroup")
end

function SetOldData(_oldData)

end

function OnDisable()
    RoleAudioPlayMgr:StopSound()
end

function Refresh(_cardData, _elseData)
    _lookBreakLv = _elseData and _elseData[1] or nil -- 查看突破等级返回
    _target = _elseData and _elseData[2] or nil
    InitData(_cardData)
    SetLv()
    SetStatus()
    SetTalent()
    SetMaterials()
    SetBtn()
    SetIconAnim()
    -- 
    local lv = _lookBreakLv
    if (not lv) then
        lv = cardData:GetBreakLevel()
    end
    LanguageMgr:SetText(txtBreak, lv > 5 and 4091 or 4213)
end

-- 选中
function SetIconAnim()
    if (_lookBreakLv) then
        local x1, y1, z1 = CSAPI.GetPos(_target)
        CSAPI.SetPos(imgBreak, x1, y1, z1)
        local x2, y2 = CSAPI.GetAnchor(imgBreak)
        CSAPI.SetGOIgnoreAlpha(imgBreak, true)
        UIUtil:SetPObjMove(imgBreak, x2, -162.7, y2, 503.6, 0, 0, nil, 300, 1)
        UIUtil:SetObjScale(imgBreak, 1, 0.6, 1, 0.6, 1, 1, function()
            CSAPI.SetGOIgnoreAlpha(imgBreak, false)
        end, 300, 0)
    end
end

function InitData(_cardData)
    -- if (cardData and cardData:GetID() ~= _cardData:GetID()) then
    --     curBreakLv = nil
    -- end

    cardData = _cardData or cardData
    totalResult = cardData:GetTotalProperty()

    SetNextData()

    -- 满级音效
    -- if (curBreakLv and cardData:GetBreakLevel() > curBreakLv) then
    --     if (cardData:GetBreakLevel() == 5) then
    --         RoleAudioPlayMgr:PlayByType(cardData:GetSkinID(), RoleAudioType.maxBreak)
    --     else
    --         RoleAudioPlayMgr:PlayByType(cardData:GetSkinID(), RoleAudioType.perBreak)
    --     end
    -- end
    -- curBreakLv = cardData:GetBreakLevel()
end

function SetNextData()
    lookBreakLv = _lookBreakLv ~= nil and _lookBreakLv or (cardData:GetBreakLevel() + 1)
    local _data = {}
    table.copy(cardData:GetData(), _data)
    _data.break_level = lookBreakLv
    nextData = CharacterCardsData(_data)
    newTotalResult = nextData:GetTotalProperty()
end

function SetLv()
    --
    CSAPI.SetGOActive(imgEX, lookBreakLv > 5)
    ResUtil.RoleCard_BG:Load(imgBreak, "img_2_0" .. (lookBreakLv - 1))
    -- 
    local curLv, maxLv = cardData:GetLv(), cardData:GetMaxLv()
    CSAPI.SetText(txtLv1, string.format("%s<color=#929296>/%s</color>", curLv, maxLv))
    --
    local cfg = Cfgs.CfgCardBreakLimitLv:GetByID(lookBreakLv - 1)
    CSAPI.SetText(txtLv2, string.format("%s<color=#ffc146>/%s</color>", curLv, cfg.MaxLv))
end

function SetStatus()
    statusItems = statusItems or {}
    statusDatas = {}
    for i, v in ipairs(g_RoleAttributeListT) do
        local cfg = Cfgs.CfgCardPropertyEnum:GetByID(v)
        local _data = {}
        _data.id = v
        _data.val1 = GetBaseValue(cfg.sFieldName)
        _data.val2 = GetAddValue(cfg.sFieldName)
        _data.nobg = true
        if (_data.val2 ~= nil) then
            table.insert(statusDatas, _data)
        end
    end
    ItemUtil.AddItems("AttributeNew2/AttributeItem6", statusItems, statusDatas, statusGrids)
end

-- 基础属性
function GetBaseValue(_key)
    local num = totalResult[_key]
    if (num) then
        return RoleTool.GetStatusValueStr(_key, num)
    end
    return 0
end

-- 升级加的
function GetAddValue(_key)
    if (nextData) then
        local num1 = totalResult[_key]
        local num2 = newTotalResult[_key]
        if (num1 and num2 and num2 - num1 > 0) then
            return "+" .. RoleTool.GetStatusValueStr(_key, num2 - num1)
        end
    end
    return nil
end

function SetTalent()
    CSAPI.SetGOActive(talent, lookBreakLv <= 5)
    CSAPI.SetGOActive(objMaxTalent, lookBreakLv > 5)
    if (lookBreakLv <= 5) then
        local curTalentID = cardData:GetTalentIDByBreakLV(lookBreakLv)
        if (curTalentID) then
            local cfg = Cfgs.CfgSubTalentSkill:GetByID(curTalentID)
            -- item 
            if (not talentItem) then
                ResUtil:CreateUIGOAsync("Role/RoleInfoTalentItem1", talent, function(go)
                    talentItem = ComUtil.GetLuaTable(go)
                    talentItem.Refresh2(cfg)
                end)
            else
                talentItem.Refresh2(cfg)
            end
            -- name
            CSAPI.SetText(txtTalent1, cfg.name)
            -- desc 
            local _desc = StringUtil:SkillDescFormat(cfg.desc)
            CSAPI.SetText(txtTalent2, _desc or cfg.desc)
        end
    end
end

-- 背包更新
function RefreshGoods()
    SetMaterials()
    SetBtn()
end

function SetMaterials()
    local goodsDatas = {}
    if (lookBreakLv > 5) then
        local matCfg2 = Cfgs.CardBreakMaterial2:GetByID(cardData:GetQuality())
        materialCfg = matCfg2.infos[lookBreakLv - 1]
    else
        local break_id = cardData:GetCfg().break_id
        local useBreakId = GCardCalculator:CalUseBreakId(break_id, lookBreakLv - 1)
        materialCfg = Cfgs.CardBreakMaterial:GetByID(useBreakId)
    end
    local mats = {}
    if (materialCfg) then
        mats = materialCfg.materials
    end
    for i, v in ipairs(mats) do
        local goodsData = BagMgr:GetFakeData(v[1])
        table.insert(goodsDatas, {goodsData, v[2]})
    end
    -- item
    items = items or {}
    ItemUtil.AddItems("Grid/RoleGridItem", items, goodsDatas, materialGrids, GridClickFunc.OpenInfo, 1,
        {nil, #goodsDatas})
end

-- 是否足够
function CheckEnough()
    mat1, mat2 = nil, nil
    if (materialCfg) then
        if (materialCfg.materials) then
            for i, v in ipairs(materialCfg.materials) do
                local goodsData = BagMgr:GetData(v[1])
                local curNum = goodsData and goodsData:GetCount() or 0
                local needNum = v[2]
                if (curNum < needNum) then
                    mat1, mat2 = v[1], needNum - curNum
                    return false
                end
            end
        end
        if (materialCfg.gold and materialCfg.gold > PlayerClient:GetGold()) then
            return false, true
        end
        return true
    end
    return false
end

function SetBtn()
    CSAPI.SetGOActive(imgBreak1, _lookBreakLv == nil)
    CSAPI.SetGOActive(imgBreak2, _lookBreakLv ~= nil)
    if (_lookBreakLv ~= nil) then
        -- 预览 
        cg_btnBreak.alpha = 1
        LanguageMgr:SetText(txtBreak1, 4214)
        -- LanguageMgr:SetEnText(txtBreak2, 4214)
    else
        -- 正常升级 
        isOpen, lockStr = MenuMgr:CheckModelOpen(OpenViewType.special, "special1") -- 是否已解锁
        if (not isOpen) then
            CSAPI.SetGOActive(imgBreak1, true)
            CSAPI.SetGOActive(imgBreak2, false)
            LanguageMgr:SetText(txtBreak1, 4001)
            cg_btnBreak.alpha = 0.3
        else
            enough, isNoGold = CheckEnough()
            cg_btnBreak.alpha = isNoGold and 0.3 or 1
            local landID = 21172
            if (enough) then
                landID = cardData:GetBreakLevel() > 4 and 4090 or 4001
            else
                local _landID = cardData:GetBreakLevel() > 4 and 4090 or 4001
                landID = isNoGold and _landID or 21172
            end
            LanguageMgr:SetText(txtBreak1, landID)
            -- LanguageMgr:SetEnText(txtBreak2, 4001)
            -- 
            CSAPI.SetGOActive(imgBreak1, enough or isNoGold)
            CSAPI.SetGOActive(imgBreak2, not enough and not isNoGold)
        end
        CSAPI.SetText(txtBreakLock,lockStr)
    end
    local money = materialCfg.gold or 0
    CSAPI.SetText(txtCost, PlayerClient:GetGold() >= money and money .. "" or StringUtil:SetByColor(money, "ff8790"))
end

function OnClickBreak()
    if (_lookBreakLv ~= nil) then
        -- 返回升级
        EventMgr.Dispatch(EventType.Role_Jump_Break, {_lookBreakLv, true, imgBreak})
    else
        if(not isOpen)then 
            Tips.ShowTips(lockStr)
        end 
        if (enough) then
            RoleMgr:CardBreak(cardData:GetID())
        else
            if (mat1) then
                local goodsData = BagMgr:GetFakeData(mat1)
                UIUtil:OpenGoodsInfo(goodsData, nil, mat2)
            end
        end
    end
end

