local info = nil
local isCanUp = false
local isRight = false
local isShowSkill = false
local currGrid = nil
local tipsInfo = nil
local fade = nil

function Awake()
    fade = ComUtil.GetCom(node, "ActionFade")
end

function OnEnable()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Player_AbilityInfo_ViewActive, OnNodeActive)
    eventMgr:AddListener(EventType.Player_AbilityInfo_ViewPos, OnPanelPos)
    eventMgr:AddListener(EventType.Player_AbilityInfo_Refresh, RefreshPanel)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClose)
    eventMgr:AddListener(EventType.Player_Ability_Refresh, OnTipsShow)
end

function OnDisable()
    eventMgr:ClearListener();
end

function OnOpen()
    fade:SetAlpha(0)
    CSAPI.SetGOActive(node, false)
    CSAPI.SetGOActive(skillMask, false)
end

function OnNodeActive(isOpen)
    if isOpen then
        CSAPI.SetGOActive(action,false)
        CSAPI.SetGOActive(action,true)
    end
    local from = isOpen and 0 or 1
    local to = isOpen and 1 or 0
    CSAPI.SetGOActive(node, true)
    fade:Play(from, to, 150, 0, function()
        CSAPI.SetGOActive(node, isOpen)
    end)
end

function OnPanelPos(_data)
    local parentX = CSAPI.GetAnchor(_data.Contentm)
    local itemX = CSAPI.GetAnchor(_data.item.gameObject)
    local x = itemX - math.abs(parentX)
    local arr = CSAPI.GetMainCanvasSize()
    local rect = ComUtil.GetCom(node, "RectTransform")

    if (x > arr[0] / 2) then
        rect.anchorMax = UnityEngine.Vector2(0, 0.5)
        rect.anchorMin = UnityEngine.Vector2(0, 0.5)
        CSAPI.SetAnchor(node, 800, 0, 0)
        isRight = false
    else
        rect.anchorMax = UnityEngine.Vector2(1, 0.5)
        rect.anchorMin = UnityEngine.Vector2(1, 0.5)
        CSAPI.SetAnchor(node, 0, 0, 0)
        isRight = true
    end

end

function RefreshPanel(_data)
    info = _data
    if (info) then
        local isSkill = info:GetCfg().type == AbilityType.SkillGroup
        CSAPI.SetGOActive(skillObj, isSkill)
        local count = PlayerClient:GetCoin(g_AbilityCoinId)
        local needCount = 0
        LanguageMgr:SetText(txtUp1, info:GetIsLock() and 9009 or 9003)
        LanguageMgr:SetEnText(txtUp2, info:GetIsLock() and 9009 or 9003)
        if (isSkill) then
            CSAPI.SetGOActive(lvObj, true)
            CSAPI.SetText(txtName, info:GetCfg().name)
            local cfg =Cfgs.CfgPlrSkillGroupUpgrade:GetByID(info:GetCfg().active_id)
            local idx = info:GetLv() or 1
            -- LogError(cfg.infos[idx].desc)
            CSAPI.SetText(txtDesc, info:GetDesc())
            -- skills
            local skills, isMax, curLv, maxLv = info:GetSkills()
            grids = grids or {};
            for k, v in ipairs(skills) do
                local item = nil;
                if k <= #grids then
                    item = grids[k];
                    item.Refresh(v, {
                        isRight = isRight
                    })
                    item.SetClickCB(OnSkillClick)
                else
                    ResUtil:CreateUIGOAsync("PlayerAbility/AbilityGrid", layout, function(go)
                        local tab = ComUtil.GetLuaTable(go);
                        table.insert(grids, tab);
                        item = tab;
                        item.Refresh(v, {
                            isRight = isRight
                        })
                        item.SetClickCB(OnSkillClick)
                    end)
                end
            end
            -- lv
            curLv = info:GetIsLock() and 0 or curLv
            CSAPI.SetText(txtLv1, curLv .. "")
            maxLv = maxLv or ""
            CSAPI.SetText(txtLv2, maxLv .. "")
            -- btn
            if (isMax) then
                CSAPI.SetGOActive(btnUp, false)
            elseif (info:CanOpen()) then
                CSAPI.SetGOActive(btnUp, true)
                needCount = info:GetIsLock() and info:GetCfg().cost_num or info:GetCost()
                CSAPI.SetText(txtNum2, needCount .. "")
            else
                CSAPI.SetGOActive(btnUp, false)
            end
        else
            CSAPI.SetGOActive(lvObj, false)
            CSAPI.SetText(txtName, info:GetCfg().name)
            CSAPI.SetText(txtDesc, info:GetDesc())
            -- btn
            if (info:GetIsLock() and info:CanOpen()) then
                needCount = info:GetCfg().cost_num
                CSAPI.SetGOActive(btnUp, true)
                CSAPI.SetText(txtNum2, needCount .. "")
            else
                CSAPI.SetGOActive(btnUp, false)
            end
        end
        if (needCount > count) then
            isCanUp = false
            CSAPI.SetTextColor(txtNum2, 255, 0, 0, 255)
            CSAPI.SetBtnState(btnUp.gameObject,false)
        else
            isCanUp = true
            CSAPI.SetTextColor(txtNum2, 255, 255, 255, 255)
            CSAPI.SetBtnState(btnUp.gameObject,true)
        end
        
        --前置说明
        CSAPI.SetGOActive(txtLock, not info:CanOpen())
        if not info:CanOpen() and info:GetCfg().prev_id then 
            local str = ""
            for k, v in ipairs(info:GetCfg().prev_id) do
                if k ~= 1 then
                    str = str .. "、"
                end
                local preInfo = PlayerAbilityMgr:GetData(v)
                if preInfo then
                    str = str .. StringUtil:SetByColor(preInfo:GetCfg().name,"ffc146")
                end
            end
            LanguageMgr:SetText(txtLock,9012,str)
        end
    end
end

function OnSkillClick(_item)
    if (currGrid ~= _item) then
        CSAPI.SetParent(skillMask.gameObject, entity.gameObject, false)
        skillMask.transform:SetSiblingIndex(5)
        CSAPI.SetGOActive(skillMask, true)
        if currGrid then
            currGrid.SetSelect(false)
        end
        currGrid = _item
    end
end

function OnTipsShow()
    if tipsInfo then
        Tips.ShowTips(LanguageMgr:GetByID(tipsInfo.id))
    end
    tipsInfo = nil
end

function OnViewClose(key)
    if (key == "PlayerAbility") then
        Close()
    end
end

-- 升级
function OnClickUp()
    if (info and info:GetIsLock()) or not isCanUp then
        PlayerAbilityMgr:ShowTips(info)
        tipsInfo = {
            id = 9010
        }
        return 
    end
    if (isCanUp) then
        local isSkill = info:GetCfg().type == AbilityType.SkillGroup
        if (isSkill) then
            local skills, isMax = info:GetSkills()
            if (not isMax) then
                local group = TacticsMgr:GetDataByID(info:GetCfg().active_id)
                AbilityProto:SkillGroupUpgrade(group:GetCfgID())
                tipsInfo = {
                    id = 9011
                }
            end
        end
    end
end

function OnClick()
    CloseGrid()
end

function CloseGrid()
    if (currGrid) then
        CSAPI.SetGOActive(skillMask, false)
        CSAPI.SetParent(skillMask.gameObject, gameObject, false)
        skillMask.transform:SetSiblingIndex(0)
        currGrid.SetSelect(false)
        currGrid = nil
    end
end

function IsGrid()
    return currGrid ~= nil
end

function SetIsRight(b)
    isRight = b
end

function Close()
    view:Close()
end

--TacticsData
function ShowInfo(_data)
    fade:SetAlpha(1)
    CSAPI.SetGOActive(node, true)
    CSAPI.SetGOActive(skillMask, true)
    CSAPI.SetGOActive(btnUp,false)
    CSAPI.SetGOActive(lvObj, true)
    CSAPI.SetAnchor(node,-408,0)
    CSAPI.SetGOActive(txtLock,false)
    if _data then
        CSAPI.SetText(txtName, _data:GetName())
        local cfg =Cfgs.CfgPlrSkillGroupUpgrade:GetByID(_data:GetCfgID())
        local idx = _data:GetLv() or 1
        CSAPI.SetText(txtDesc, _data:GetDesc())
        -- skills
        local skills =_data:GetSkills()
        local isMax,maxLv = _data:IsMaxLv()
        local curLv = _data:GetLv()
        grids = grids or {};
        for k, v in ipairs(skills) do
            local item = nil;
            if k <= #grids then
                item = grids[k];
                item.Refresh(v, {
                    isRight = isRight
                })
                item.SetClickCB(OnSkillClick)
            else
                ResUtil:CreateUIGOAsync("PlayerAbility/AbilityGrid", layout, function(go)
                    local tab = ComUtil.GetLuaTable(go);
                    table.insert(grids, tab);
                    item = tab;
                    item.Refresh(v, {
                        isRight = isRight
                    })
                    item.SetClickCB(OnSkillClick)
                end)
            end
        end
        -- lv
        CSAPI.SetText(txtLv1, curLv .. "")
        maxLv = maxLv or ""
        CSAPI.SetText(txtLv2, maxLv .. "")
    end
end