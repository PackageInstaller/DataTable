local timer = nil
function Awake()
    anim_go = ComUtil.GetCom(gameObject, "Animator")
end

function Update()
    if (timer and Time.time >= timer) then
        timer = nil
        CSAPI.SetScale(gameObject, 1, 1, 1)
        CSAPI.SetGOActive(gameObject, false)
        CSAPI.SetGOActive(gameObject, true)
        anim_go:Play("RogueTEnemySelectItem_In")
    end
end

function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end
function Refresh(_cfg, _curIndex)
    cfg = _cfg
    curIndex = _curIndex or 100
    isCur = index == curIndex
    CSAPI.SetText(txtName, cfg.name)
    CSAPI.SetGOAlpha(clickNode, index >= curIndex and 1 or 0.5)
    --
    local bgName = isCur and "img_07_02.png" or "img_07_03.png"
    CSAPI.LoadImg(clickNode, "UIs/RogueT/" .. bgName, true, nil, true)
    --
    if (isCur) then
        local ones = index % 10 -- 个位数
        local tens = math.floor(index / 10) -- 十位数
        CSAPI.SetText(txtNum, "<color=#ffc146>" .. tens .. "</color>" .. "<color=#ffffff>" .. ones .. "</color>")
        CSAPI.SetImgColorByCode(numBg, "ffc146")
        CSAPI.SetTextColorByCode(txtNum, "ffffff")
    else
        CSAPI.SetText(txtNum, index < 10 and "0" .. index or index .. "")
        CSAPI.SetImgColorByCode(numBg, "7b7b7a")
        CSAPI.SetTextColorByCode(txtNum, "7b7b7a")
    end
    --
    local code = isCur and "ffc146" or "ffffff"
    CSAPI.SetImgColorByCode(imgDown, code)
    --
    CSAPI.SetGOActive(select, index == curIndex)
    CSAPI.SetGOActive(success, index < curIndex)
    CSAPI.SetGOActive(lock, index > curIndex)
    --
    CSAPI.SetAnchor(node, 0, index % 2 == 0 and 0 or -158, 0)
    --
    CSAPI.SetText(txtJF, cfg.coin and cfg.coin .. "" or "0")
end

function PlayIn(i)
    CSAPI.SetScale(gameObject, 0, 0, 0)
    timer = Time.time + i * 80 / 1000
end

function OnClick()
    if (cb and curIndex == index) then
        cb()
    end
end
