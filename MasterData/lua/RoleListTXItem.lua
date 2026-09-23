function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _elseData)
    num = _elseData[1] or 1
    data = _data
    --
    lv1, lv2 = data:PassiveCanUpTo()
    CSAPI.SetGOActive(arrow, lv1 ~= lv2)
    CSAPI.SetGOActive(txtLv2, lv1 ~= lv2)
    if (lv1 ~= lv2) then
        CSAPI.SetText(txtLv2, lv2 .. "")
    end
    local str = LanguageMgr:GetByID(1033)
    CSAPI.SetText(txtLv1, str .. lv1)
    -- 
    if (lv1 == lv2) then
        CSAPI.SetGOActive(tickParent, false)
    else
        CSAPI.SetGOActive(tick, num == 1)
    end
    -- 
    SetItem()
    -- 
    local cfgDesc = Cfgs.CfgSkillDesc:GetByID(data:GetPassiveID())
    ResUtil.IconSkill:Load(imgSkill, cfgDesc.icon)
    -- 
    if (lv1 == lv2 and _elseData[2]) then
        local anim = ComUtil.GetCom(gameObject, "Animator")
        if (anim) then
            anim:Play("Upgrade1")
        end
    end
end

function SetItem()
    if (not item) then
        ResUtil:CreateUIGOAsync("RoleCard/RoleCard", cardParent, function(go)
            item = ComUtil.GetLuaTable(go)
            item.Refresh(data, {
                noCheckRed = 1,
                noCheckNew = 1
            })
        end)
    else
        item.Refresh(data, {
            noCheckRed = 1,
            noCheckNew = 1
        })
    end
end

function OnClick()
    if (lv1 == lv2) then
        return
    end
    num = num == 1 and 0 or 1
    CSAPI.SetGOActive(tick, num == 1)
    cb(index)
end
