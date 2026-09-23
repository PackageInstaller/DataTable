-- 跃升成功界面
local showIndex = 1

function Awake()
    fade = ComUtil.GetCom(gameObject, "ActionFade")
    fade1 = ComUtil.GetCom(goShaderRaw, "ActionFade")
    UIMaskGo = CSAPI.GetGlobalGO("UIClickMask")
end

function OnOpen()
    -- music
    CSAPI.PlayUISound("ui_getitems")

    -- fade
    fade1:Play(0, 1, 167, 600, function()
        CSAPI.SetGOActive(bg1, false)
        CSAPI.SetGOActive(black, false)
        CSAPI.SetGOActive(shaderObj, true)
        isCanBack = true
    end)

    SetPanel()

    if (newData:GetBreakLevel() == 5) then
        RoleAudioPlayMgr:PlayByType(newData:GetSkinID(), RoleAudioType.maxBreak)
    else
        RoleAudioPlayMgr:PlayByType(newData:GetSkinID(), RoleAudioType.perBreak)
    end
end

function SetPanel()
    CSAPI.PlayUISound("ui_core_upgrade")

    oldData = data[1]
    newData = data[2]
    oldTotalResult = oldData:GetTotalProperty()
    newTotalResult = newData:GetTotalProperty()

    -- title 
    if (newData:GetBreakLevel() >= 6) then
        LanguageMgr:SetText(txtTitle1, 4089)
    else
        LanguageMgr:SetText(txtTitle1, 4019, newData:GetBreakLevel())
    end

    -- lv 
    local curLv = oldData:GetLv()
    local maxLv1 = oldData:GetMaxLv()
    local maxLv2 = newData:GetMaxLv()
    CSAPI.SetText(txtLv1, string.format("%s<color=#929296>/%s</color>", curLv, maxLv1))
    CSAPI.SetText(txtLv2, string.format("%s<color=#ffc146>/%s</color>", curLv, maxLv2))

    -- 属性
    statusItems = statusItems or {}
    statusDatas = {}
    for i, v in ipairs(g_RoleAttributeListT) do
        local cfg = Cfgs.CfgCardPropertyEnum:GetByID(v)
        local _data = {}
        _data.nobg = true
        _data.id = v
        _data.val1 = GetBaseValue(cfg.sFieldName)
        local val2 = GetAddValue(cfg.sFieldName)
        if (val2 == nil) then
            -- _data.val2 = _data.val1
            -- _data.val2Color = "ffffff"
        else
            _data.val2 = GetNewValue(cfg.sFieldName)
            _data.val2Color = "00FFBF"
            table.insert(statusDatas, _data)
        end
    end
    ItemUtil.AddItems("AttributeNew2/AttributeItem7", statusItems, statusDatas, statusGrids)
end

function SetNode2()
    CSAPI.SetGOActive(node1, false)
    CSAPI.SetGOActive(node2, true)
    CSAPI.SetGOActive(txtTitle1, false)
    CSAPI.SetGOActive(txtTitle2, false)

    -- 动态效果开启提示(只提示一次)
    local breakLv = newData:GetBreakLevel()
    CSAPI.SetGOActive(objTips1, breakLv == 3)
    local x = breakLv == 3 and 140.7 or -133.3
    CSAPI.SetAnchor(objTips2, x, 192, 0)

    -- card
    if (breakLv == 3) then
        -- item 
        if (not cardItem) then
            ResUtil:CreateUIGOAsync("RoleCard/RoleCard", cardPoint, function(go)
                cardItem = ComUtil.GetLuaTable(go)
                cardItem.Refresh(newData, {
                    isAnimEnd = true,
                    noCheckRed = true
                })
            end)
        else
            cardItem.Refresh(newData, {
                isAnimEnd = true,
                noCheckRed = true
            })
        end
        -- 皮肤开启提示
        local cRoleData = CRoleMgr:GetData(newData:GetRoleID())
        local oldLv = cRoleData:GetOldBreakLevel()
        if (breakLv > oldLv) then
            cRoleData:GetOldBreakLevel(breakLv)
            LanguageMgr:ShowTips(3009, cRoleData:GetAlias())
        end
    end
    -- talent 
    local taletnID = newData:GetTalentIDByBreakLV()
    local cfg = Cfgs.CfgSubTalentSkill:GetByID(taletnID)
    if (not talentItem) then
        ResUtil:CreateUIGOAsync("Role/RoleInfoTalentItem2", talentPoint, function(go)
            talentItem = ComUtil.GetLuaTable(go)
            talentItem.Refresh2(cfg)
        end)
    else
        talentItem.Refresh2(cfg)
    end
    CSAPI.SetText(txtTalent, cfg.name)
    -- txt
    LanguageMgr:SetText(txtBreak1, 4201, breakLv - 2)
    LanguageMgr:SetText(txtBreak2, 4201, breakLv - 1)
end

-- 旧属性 str 
function GetBaseValue(_key)
    local num = oldTotalResult[_key]
    if (num) then
        return RoleTool.GetStatusValueStr(_key, num)
    end
    return 0
end

-- 新属性 str 
function GetNewValue(_key)
    local num = newTotalResult[_key]
    if (num) then
        return RoleTool.GetStatusValueStr(_key, num)
    end
    return 0
end

-- 升级加的
function GetAddValue(_key)
    local num1 = newTotalResult[_key]
    local num2 = oldTotalResult[_key]
    if (num1 and num2 and num1 - num2 > 0) then
        return RoleTool.GetStatusValueStr(_key, num1 - num2)
    end
    return nil
end

function OnClickMask()
    if not isCanBack then
        return
    end
    if (showIndex == 1 and newData:GetBreakLevel() < 5) then
        showIndex = 2
        SetNode2()
        CSAPI.SetGOActive(anim, true)
        return
    end

    fade:Play(1, 0, 167, 0, function()
        view:Close()
    end)
end
function AnimStart()
    CSAPI.SetGOActive(UIMaskGo, true)
end

function AnimEnd()
    CSAPI.SetGOActive(UIMaskGo, false)
end
