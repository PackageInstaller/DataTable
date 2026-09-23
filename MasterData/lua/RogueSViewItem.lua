local effects = {}
local curType = nil
local curEffect = nil

function Awake()
    anim_stars = ComUtil.GetCom(stars, "ActionBase")
end

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _curID)
    data = _data
    curID = _curID

    isSelect = false
    if (curID and curID == data:GetID()) then
        isSelect = true
    end
    isLock = data:IsLock()
    CSAPI.SetGOActive(clickNode, not isLock)
    CSAPI.SetGOActive(lock, isLock)
    if (not islock) then
        SetEntity()
    end
end

function SetEntity()
    -- star 
    CSAPI.SetGOActive(stars, data:IsPass())
    if (data:IsPass()) then
        local cur, max = data:GetStars()
        for k = 1, 3 do
            local imgName = cur >= k and "img_47_01.png" or "img_47_02.png"
            CSAPI.LoadImg(this["star" .. k], "UIs/RogueS/" .. imgName, true, nil, true)
        end
    end
    -- effect
    local nType = data:GetCfg().nType
    if (curType and curType ~= nType and curEffect) then
        CSAPI.SetGOActive(curEffect.gameObject, false)
    end
    curType = nType
    local effectName = nType == 1 and "level_easy" or "level_hard"
    if (not effects[effectName]) then
        CSAPI.CreateGOAsync("UIs/RogueS/" .. effectName, 0, 0, 0, clickNode, function(go)
            curEffect = ComUtil.GetLuaTable(go)
            curEffect.SetState(data, isSelect, index)
            effects[effectName] = curEffect
        end)
    else
        curEffect = effects[effectName]
        curEffect.SetState(data, isSelect, index)
        CSAPI.SetGOActive(curEffect.gameObject, true)
    end
    -- 
    local iconName = "img_" .. index
    ResUtil.RogueSNum:Load(imgNum3, iconName, true)
end

function FirstTween()
    if (anim_stars) then
        anim_stars:ToPlay()
    end
end

function OnClick()
    if (not isLock) then
        cb(this)
    end
end

function OnClickLock()
    if (isLock) then
        LanguageMgr:ShowTips(44001)
    end
end

function CheckUnLock()
    if (curEffect) then
        curEffect.CheckUnLock()
    end
end
