function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end

local needToCheckMove = false
function Awake()
    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txtName)
end

function Update()
    if (needToCheckMove) then
        luaTextMove:CheckMove(txtName)
        needToCheckMove = false
    end
end

-- _data:卡牌信息  toSelect：选卡界面
function Refresh(_data, elseData)
    poolID = elseData[1]
    toSelect = elseData[2]
    isSelect = elseData[3]
    data = _data
    CSAPI.SetGOActive(entity, data.data ~= nil)
    CSAPI.SetGOActive(empty, not data.data)
    --
    local isFirstS = data.data ~= nil and CreateMgr:CheckISSelectCard(poolID, data:GetCfgID()) or false
    local b = false
    if (toSelect) then
        if (isFirstS or (not isSelect and index == 1)) then
            b = true
        end
    end
    CSAPI.SetGOActive(select, b)
    CSAPI.SetGOActive(goods, isFirstS)
    --
    if (not data.data) then
        return
    end
    SetBgIcon(data:GetQuality())
    SetIcon(data:Card_head())
    ResUtil.RoleCard_BG:Load(imgStar, "img_01_0" .. data:GetQuality())
    needToCheckMove = false
    CSAPI.SetText(txtName, data:GetName())
    needToCheckMove = true
end

-- icon
function SetIcon(_iconName)
    if (_iconName) then
        ResUtil.CardIcon:Load(icon, _iconName)
    end
end

function SetBgIcon(_quality)
    local colorName = "btn_1_0" .. _quality
    ResUtil.RoleCard_BG:Load(iconBg, colorName)
end

function OnClick()
    if (toSelect) then
        cb(index)
    else
        local cardData = RoleMgr:GetMaxFakeData(data:GetCfgID())
        CSAPI.OpenView("RoleInfo", cardData)
    end
end
