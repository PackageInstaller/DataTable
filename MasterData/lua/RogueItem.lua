local isFirst = false
local isLeft = true -- 左边的按钮

function Awake()
    imgFill_fill = ComUtil.GetCom(imgFill, "Image")
    -- clickNode_image = ComUtil.GetCom(clickNode, "Image")
    go_cg = ComUtil.GetCom(gameObject, "CanvasGroup")
end

function Init(lineDetail)
    CSAPI.SetGOActive(line1, true)
    CSAPI.SetRectAngle(line1, 0, 0, lineDetail[2])
    CSAPI.SetAnchor(line1, lineDetail[1], 0, 0)
    CSAPI.SetRectAngle(linePoint, 0, 0, lineDetail[3])

    isLeft = lineDetail[2] == 0
end

function SetClickCB(_cb)
    cb = _cb
end

function InAnim()
    UIUtil:SetPObjMove(lineAnim, isLeft and 100 or -100, 0, 0, 0, 0, 0, nil, 400, 1)
    UIUtil:SetPObjMove(clickNode, isLeft and 100 or -100, 0, 0, 0, 0, 0, nil, 400, 100)
    UIUtil:SetObjFade(clickNode, 0, 1, nil, 300, 100, 0)
end

function Refresh(_data, _selectID, _inAnim)
    if (_inAnim) then
        InAnim()
    end

    data = _data
    selectID = _selectID or -1

    isLock = data:IsLock()
    local isChallenge = data:IsChallenge()
    isSelect = selectID == data:GetID()
    local isSuccess = data:IsSuccess()
    local cur, max = data:GetNum(), data:GetLimitRound()
    -- open lock 
    CSAPI.SetGOActive(open, not isLock)
    CSAPI.SetGOActive(lock, isLock)
    CSAPI.SetGOActive(go, isChallenge)
    go_cg.alpha = isLock and 0.5 or 1
    if (open.activeInHierarchy) then
        local num = cur / max
        imgFill_fill.fillAmount = num
        CSAPI.SetGOActive(imgLight, cur ~= 0)
        if (cur ~= 0) then
            CSAPI.SetRectAngle(imgLight, 0, 0, num * 360)
        end
    end
    -- img1 2 imgNum
    local img1_name = "img9_01_03"
    local imgNum_name = "img_03_03"
    local imgFill_name = "bar_01_01"
    local lineNameNum = 7
    if (not isLock) then
        if (isSelect) then
            img1_name = data:GetCfg().nType == 1 and "img9_01_02" or "img9_01_04"
            imgNum_name = data:GetCfg().nType == 1 and "img_03_02" or "img_03_04"
            imgFill_name = data:GetCfg().nType == 1 and "bar_01_03" or "bar_01_04"
            lineNameNum = data:GetCfg().nType == 1 and 4 or 10
        else
            img1_name = "img9_01_01"
            imgNum_name = "img_03_01"
            imgFill_name = "bar_01_02"
            lineNameNum = 1
        end
    end
    CSAPI.LoadImg(img1, "UIs/Rogue/" .. img1_name .. ".png", true, nil, true)
    CSAPI.LoadImg(imgNum, "UIs/Rogue/" .. imgNum_name .. ".png", true, nil, true)
    CSAPI.LoadImg(imgFill, "UIs/Rogue/" .. imgFill_name .. ".png", true, nil, true)
    -- num  success 
    if (isChallenge) then
        CSAPI.SetGOActive(nums, true)
        CSAPI.SetGOActive(success, false)
    else
        CSAPI.SetGOActive(nums, not isSuccess)
        CSAPI.SetGOActive(success, isSuccess)
    end
    if (nums.activeInHierarchy) then
        local code1, code2 = "000000", "9F9F9F"
        if (not isLock) then
            if (data:GetCfg().nType == 1) then
                code1 = isSelect and "000000" or "ffffff"
                code2 = isSelect and "ffffff" or "9F9F9F"
            else
                code1 = isSelect and "ffffff" or "000000"
                code2 = isSelect and "e718e" or "9F9F9F"
            end
        end
        CSAPI.SetText(txtNum1, cur .. "")
        CSAPI.SetText(txtNum2, max .. "")
        CSAPI.SetTextColorByCode(txtNum1, code1)
        CSAPI.SetTextColorByCode(txtNum2, code2)
    end
    -- icon 
    ResUtil.RogueIcon:Load(icon, data:GetIcon(isSelect))
    -- name 
    local code1, code2 = "ffffff", "9F9F9F"
    if (not isLock) then
        if (data:GetCfg().nType == 1) then
            code1 = isSelect and "000000" or "ffffff"
            code2 = isSelect and "000000" or "9F9F9F"
        else
            code1 = "ffffff"
            code2 = isSelect and "ffffff" or "9F9F9F"
        end
    end
    CSAPI.SetText(txtName1, data:GetCfg().name)
    CSAPI.SetText(txtName2, data:GetCfg().enName)
    CSAPI.SetTextColorByCode(txtName1, code1)
    CSAPI.SetTextColorByCode(txtName2, code2)
    -- line 
    local str = lineNameNum >= 10 and "img_07_" or "img_07_0"
    CSAPI.LoadImg(line1, "UIs/Rogue/" .. str .. lineNameNum .. ".png", false, nil, true)
    CSAPI.LoadImg(line2, "UIs/Rogue/" .. str .. (lineNameNum + 1) .. ".png", false, nil, true)
    CSAPI.LoadImg(line3, "UIs/Rogue/" .. str .. (lineNameNum + 2) .. ".png", false, nil, true)
    -- btn 
    -- clickNode_image.enabled = not isLock
    --
    local numsName = isSelect and "img_04_02" or "img_04_01"
    CSAPI.LoadImg(nums, "UIs/Rogue/" .. numsName .. ".png", true, nil, true)
    -- go 
    if (go.activeInHierarchy) then
        local imgGoName1, imgGoName2 = "img_05_01", "img_06_01"
        if (isSelect) then
            imgGoName1 = data:GetCfg().nType == 1 and "img_05_02" or "img_05_03"
            imgGoName2 = data:GetCfg().nType == 1 and "img_06_02" or "img_06_03"
        end
        CSAPI.LoadImg(imgGo1, "UIs/Rogue/" .. imgGoName1 .. ".png", true, nil, true)
        CSAPI.LoadImg(imgGo2, "UIs/Rogue/" .. imgGoName2 .. ".png", true, nil, true)
    end
    -- success 
    if (success.activeInHierarchy) then
        local code1, code2 = "a4a0ff", "ffffff"
        if (isSelect) then
            code1 = data:GetCfg().nType == 1 and "151631" or "e9718e"
            code2 = data:GetCfg().nType == 1 and "151631" or "ffffff"
        end
        CSAPI.SetTextColorByCode(txtSuccess1, code1)
        CSAPI.SetTextColorByCode(txtSuccess2, code2)
    end
    -- anims 
    if (not isFirst and go.activeInHierarchy) then
        CSAPI.SetGOActive(imgGo1Anim, true)
    end
    isFirst = true
end

function Select(b)
    local id = b and data:GetID() or nil
    Refresh(data, id)

    if (b and isSelect) then
        UIUtil:SetObjFade2(img1, 0, 1, nil, 300, 1)
    end
end

function CheckIsLeft()
    return isLeft
end

function OnClick()
    if (isLock) then
        if (data:GetCfg().perLevel) then
            local cfg = Cfgs.DungeonGroup:GetByID(data:GetCfg().perLevel)
            LanguageMgr:ShowTips(39002, cfg.name)
        end
    else
        cb(this)
    end
end
