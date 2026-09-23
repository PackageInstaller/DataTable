local isPass = false
local isLock = false
local isSel = false
local dupData = nil
local textIndex = 0
local anim = nil

function Awake()
    SetSel(false)
end

function OnDisable()
    if not IsNil(anim) then
        anim.enabled = false
    end
end

function SetIndex(cur, max)
    index = cur
    textIndex = max - cur + 1
end

function SetClickCB(_cb)
    cb = _cb
end

function SetSel(b)
    isSel = b
    CSAPI.SetGOActive(nolObj, not b)
    CSAPI.SetGOActive(selObj, b)
    local code = b and "0f0f19" or "dadbe1"
    CSAPI.SetTextColorByCode(txtIndex.gameObject, code, true)
    CSAPI.SetImgColor(nolImg, 255, 255, 255, 255)
    CSAPI.SetScale(nolImg, 1, 1, 1)
    SetWidth()
end

function Refresh(_data, _elseData)
    data = _data
    dupData = _elseData and _elseData.data
    isPass = _elseData and _elseData.isPass
    isLock = _elseData and _elseData.isLock
    if textIndex == 1 then
        isLock = false
    end
    if data then
        SetText()
        SetState()
    end
end

function SetText()
    CSAPI.SetText(txtIndex, textIndex < 10 and "0" .. textIndex or textIndex .. "")
end

function SetState()
    local str = LanguageMgr:GetByID(130003)
    local imgName = "img_03_02"
    if isLock then
        str = LanguageMgr:GetByID(130004)
        imgName = "img_03_03"
    elseif isPass then
        str = LanguageMgr:GetByID(130002)
        imgName = "img_03_01"
    end
    CSAPI.SetText(txtState, str)
    CSAPI.LoadImg(stateImg, "UIs/TowerDeep/" .. imgName .. ".png", true, nil, true)
    if data:IsDiff() then
        CSAPI.LoadImg(nolImg, "UIs/TowerDeep/nol_02.png", true, nil, true)
        CSAPI.LoadImg(selImg, "UIs/TowerDeep/sel_02.png", true, nil, true)
        CSAPI.LoadImg(arrow1, "UIs/TowerDeep/arrow_02_01.png", true, nil, true)
        CSAPI.LoadImg(arrow2, "UIs/TowerDeep/arrow_02_02.png", true, nil, true)
    else
        CSAPI.LoadImg(nolImg, "UIs/TowerDeep/nol_01.png", true, nil, true)
        CSAPI.LoadImg(selImg, "UIs/TowerDeep/sel_01.png", true, nil, true)
        CSAPI.LoadImg(arrow1, "UIs/TowerDeep/arrow_01_01.png", true, nil, true)
        CSAPI.LoadImg(arrow2, "UIs/TowerDeep/arrow_01_02.png", true, nil, true)
    end
end

function SetWidth()
    CSAPI.SetAnchor(txtIndex, isSel and -124 or -100, 23)
    CSAPI.SetAnchor(stateImg, isSel and 155 or 146, 19)
end

function GetCfg()
    return index
end

function GetScore()
    local cur, max = 0, 0
    if dupData and dupData.score then
        max = dupData.score
    end
    local cfg = data:GetCfg()
    if cfg and cfg.pointMax then
        cur = cfg.pointMax
    end
    return cur .. "", max .. ""
end

function GetGoals()
    local infos = {}
    local cfg = data:GetCfg()
    if cfg then
        for i = 1, 3 do
            if cfg["star" .. i] then
                table.insert(infos, {
                    isComplete = (dupData and dupData.score >= cfg["star" .. i]) or false,
                    tips = LanguageMgr:GetByID(130008, cfg["star" .. i])
                })
            end
        end
    end
    return infos
end

function IsPass()
    return isPass
end

function OnClick()
    if cb then
        cb(this)
    end
end

---------------------------------------------anim---------------------------------------------
function SetAnimSel(b)
    CSAPI.SetGOActive(nolObj, true)
    CSAPI.SetGOActive(selObj, true)
    if b then
        PlayAnim("stageSel")
    else
        PlayAnim("stageUnsel")
    end
end

function PlayAnim(key)
    if anim == nil then
        anim = ComUtil.GetCom(node, "Animator")
    end
    if not IsNil(anim) and key and key ~= "" then
        anim.enabled = true
        anim:Play(key)
    end
end
