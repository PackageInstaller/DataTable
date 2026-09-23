local fightSlider = nil
local data = nil
local ids = {}

function Awake()
    fightSlider = ComUtil.GetCom(slider, "Slider")
    PlayAnims()
end

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    if data then
        SetIcon()
        SetState()
        SetPos(data:GetPos())
        SetSlider()
    end
end

function SetIcon()
    CSAPI.LoadImg(icon, "UIs/BattleField/icon1_" .. index .. ".png", true, nil, true)
end

-- 当前状态 1.全面压制 2.战况压制 3.阵线维持 4.战况紧张 5.全面溃败
function SetState()
    local curState = data:GetState()
    if curState then
        CSAPI.SetGOActive(bgAction, curState ~= 3)
        CSAPI.SetGOActive(effect1, curState > 1 and curState < 4)
        CSAPI.SetGOActive(effect2, curState == 4)

        local isFight = curState > 1 and curState < 5
        CSAPI.SetGOActive(fight, isFight)
        local alpha1 = isFight and 100 or 30
        local alpha2 = isFight and 100 or 70
        CSAPI.SetImgColor(bg, 255, 255, 255, math.floor(255 * (alpha1 / 100)))
        CSAPI.SetImgColor(icon, 255, 255, 255, math.floor(255 * (alpha2 / 100)))
        CSAPI.SetTextColor(txt_title, 255, 255, 255, math.floor(255 * (alpha2 / 100)))

        local imgName = "btn_01_02"
        if curState < 3 then
            imgName = "btn_01_01"
        elseif curState > 3 then
            imgName = "btn_01_03"
        end
        CSAPI.LoadImg(bg, "UIs/BattleField/" .. imgName .. ".png", false, nil, true)
        local str, txtColor = BattleFieldUtil.GetTextColor(curState)
        if BattleFieldMgr:IsAllPass() then
            str = LanguageMgr:GetByID(37025)
            txtColor = {0,255,191,255}
        end
        CSAPI.SetText(txtState, str)
        CSAPI.SetTextColor(txtState, txtColor[1], txtColor[2], txtColor[3], txtColor[4])
    end
end

function SetSlider()
    local pecent = 1 - (data:GetCurrEnemy() / data:GetInit()) / 2
    fightSlider.value = pecent
end

function SetPos(p)
    if p then
        CSAPI.SetAnchor(gameObject, p[1], p[2])
    end
end

function GetType()
    return data and data:GetEnemyDesc()
end

function GetOffsetPos()
    return {0, 0}
end

function GetState()
    return data and data:GetState()
end

function GetData()
    return data
end

function OnClick()
    if cb then
        cb(this)
    end
end

function PlayAnims()
    local anims = ComUtil.GetComsInChildren(action, "ActionBase")
    for i = 0, anims.Length - 1 do
        anims[i]:Play()
    end
end
