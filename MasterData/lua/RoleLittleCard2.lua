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

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_cardData, _selectID, _curID)
    cardData = _cardData
    selectID = _selectID
    curID = _curID
    SetBGIcon(cardData:GetQuality())
    SetIcon(cardData:GetSmallImg())
    SetLv(cardData:GetLv())
    SetName(cardData:GetName())
    Select(selectID and selectID == cardData:GetID())
    SetCur(curID == cardData:GetID())
end

function SetBGIcon(_quality)
    local name = "btn_b_1_01";
    if _quality then
        name = "btn_b_1_0" .. tostring(_quality);
    end
    ResUtil.CardBorder:Load(bgIcon, name);
    -- color 
    local name = "btn_1_0" .. _quality
    ResUtil.CardBorder:Load(color, name);
end

function SetIcon(_iconName)
    if (_iconName) then
        CSAPI.SetGOActive(icon, true)
        ResUtil.Card:Load(icon, _iconName)
    else
        CSAPI.SetGOActive(icon, false)
    end
end

function SetLv(_lv)
    CSAPI.SetText(txtLv2, _lv .. "")
end

function SetName(str)
    needToCheckMove = false
    CSAPI.SetText(txtName, str)
    needToCheckMove = true
end

function Select(b)
    CSAPI.SetGOActive(select, b)
end

function SetCur(b)
    CSAPI.SetGOActive(objCur, b)
end

function OnClick()
    -- anim
    if (selectID ~= cardData:GetID()) then
        CSAPI.SetGOActive(select, true)
        UIUtil:SetObjFade(select, 0, 1, nil, 300)
    end
    --
    if (cb) then
        cb(index)
    end
end
