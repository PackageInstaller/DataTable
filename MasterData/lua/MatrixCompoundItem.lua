-- MatrixCompoundData
local isOpen = false

function Awake()
    -- cg_go = ComUtil.GetCom(gameObject, "CanvasGroup")
    cg_noOpen = ComUtil.GetCom(noOpen, "CanvasGroup")
end

function SetIndex(_index)
    index = _index
end

function Refresh(_data, _heightIndex)
    data = _data
    heightIndex = _heightIndex

    RefreshPanel()
end

function RefreshPanel()
    SetTop()
    SetGetItems()
    SetPayItems()
    SetIsOpen()
    SetHeight()
    SetBg()
end

function SetBg()
    -- bg
    local iconName = "img9_05_02.png"
    if (isEnough1 and isEnough2) then
        iconName = "img9_05_01.png"
    end
    CSAPI.LoadImg(clickNode, "UIs/Compound/" .. iconName, false, nil, true)
end

function SetTop()
    isEnough2 = true
    CSAPI.SetText(txtName, data:GetName())
    -- 1 
    ResUtil.Face:Load(imgIcon1, "face1")
    CSAPI.SetText(txtNum1, math.abs(data:GetCfg().tiredVal) .. "")
    -- 2 
    local id = data:GetCfg().cost[1][1]
    local _cfg = Cfgs.ItemInfo:GetByID(id)
    ResUtil.IconGoods:Load(imgIcon2, _cfg.icon .. "_1")

    local need = data:GetPriceNum()
    local max = BagMgr:GetCount(id)
    local str = need > max and StringUtil:SetByColor(need, "ff6565") or need
    CSAPI.SetText(txtNum2, str .. "")
    if (need > max) then
        isEnough2 = false
    end
end

function SetGetItems()
    getItems = getItems or {}
    local _reward = data:GetCfg().rewards[1]
    local reward = {_reward[1], _reward[2]} -- BagMgr:GetCount(_reward[1])}
    ResUtil:CreateCfgRewardGrid(getItems, reward, item0, ItemClick)
end

function ItemClick()
    if (not isOpen) then
        return
    end

    -- if (not isEnough1 or not isEnough2) then
    --     LanguageMgr:ShowTips(2307)
    -- else
    CSAPI.OpenView("MatrixCompoundDetail", data)
    -- end
end

function SetPayItems()
    isEnough1 = true
    payItems = payItems or {}
    ResUtil:CreateCfgRewardGrids(payItems, data:GetMat3(), grids, nil, function()
        for k, v in ipairs(payItems) do
            v.SetCount(0)
        end
    end)

    -- down 
    local materials = data:GetCfg().materials or {}
    for i = 1, 3 do
        local str = ""
        local mat = materials[i]
        if (mat) then
            local need = mat[2] or 0
            local max = BagMgr:GetCount(mat[1])
            str = UIUtil:GetDownStr(max, need)
            if (need > max) then
                isEnough1 = false
            end
        end
        CSAPI.SetGOActive(this["txtDownCount" .. i], str ~= "")
        if (str ~= "") then
            CSAPI.SetText(this["txtDownCount" .. i], str)
        end
    end
end

function SetIsOpen()
    local _isOpen, str = data:CheckIsOpen()
    CSAPI.SetGOActive(noOpen, not _isOpen)
    if (not _isOpen) then
        CSAPI.SetText(txtOpen, str)
    end
    -- cg_go.alpha = _isOpen and 1 or 0.3

    isOpen = _isOpen
end

-- 高亮
function SetHeight()
    CSAPI.SetGOActive(height, index == heightIndex)
end

function SetNoOpenAlpha(b)
    cg_noOpen.ignoreParentGroups = b
end
