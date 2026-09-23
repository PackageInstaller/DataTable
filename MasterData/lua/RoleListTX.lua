local selectDic = {} -- 当前选择字典（默认全选） 选：空或者1   0：未选
local isToPlay = false

function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/RoleList/RoleListTXItem", LayoutCallBack, true)
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.MainTalent_Upgrade, function()
        isToPlay = true
        CSAPI.SetGOActive(mask2, true)
        OnOpen()
        FuncUtil:Call(HideMask2, nil, 1200, false)
    end)
end

function HideMask2()
    isToPlay = false
    CSAPI.SetGOActive(mask2, false)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = data[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB)
        lua.Refresh(_data, {selectDic[index], isToPlay})
    end
end

function ItemClickCB(index)
    if (not selectDic[index]) then
        selectDic[index] = 0
    else
        selectDic[index] = selectDic[index] == 1 and 0 or 1
    end
end

-- data -> arr
function OnOpen()
    layout:IEShowList(#data, nil, 1)
    -- 
    RefreshPanel()
end

function RefreshPanel()
    -- 
    LanguageMgr:SetText(txtTitle, isSuccess and 361004 or 361001)
    LanguageMgr:SetText(txtS1, isSuccess and 50025 or 361002)
    -- 
    if (isSuccess) then
        local anim = ComUtil.GetCom(bg, "Animator")
        if (anim) then
            anim:Play("Upgrade2")
        end
    end
end

function OnClickC()
    if (isSuccess) then
        return
    end
    view:Close()
end

-- 一键升级
function OnClickS()
    if (isSuccess) then
        view:Close()
        return
    end
    local _datas = {}
    local _infoArr = {}
    for k, v in ipairs(data) do
        if (not selectDic[k] or selectDic[k] == 1) then
            local _data = {}
            _data.cid = v:GetID()
            _data.skill_id = v:GetPassiveID()
            table.insert(_infoArr, _data)
            table.insert(_datas, v)
        end
    end
    if (#_infoArr > 0) then
        data = _datas
        selectDic = {}
        isSuccess = true
        PlayerProto:OneKeyMainTalentUpgrade(_infoArr)
    end
end

function OnClickMask()
    view:Close()
end

function OnClickVirtualkeysClose()
    view:Close()
end
