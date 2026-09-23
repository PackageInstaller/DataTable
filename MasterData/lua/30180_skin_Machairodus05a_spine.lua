local isOver = false
local score = 0 -- 当前得分
local bullet = 12 -- 上限装弹
local baseBullet = 12 -- 基础子弹数
local changeNum = 4 -- 自动换弹条件1：子弹小于等于该值
local cool = nil
local baseCool = 3 -- 自动换弹条件2：不动多长时间
local scores = {500, 1000}
local backUI
local endIndexs = {14, 15, 16}
local len = nil
local quanTime = 1
local quanTimer = nil
local anim_quam
local oldLen = nil
local isClickEnd = false

function Awake()
    anim_quam = ComUtil.GetCom(quan, "Image")
end

function OnDestroy()
    SetCenterPos2()
    if (backUI and backUI.gameObject) then
        CSAPI.RemoveGO(backUI.gameObject)
    end
end

function Update()
    if (isOver == nil) then
        return
    end
    if (isOver) then
        isOver = nil
        local index = 63
        if (not isClickEnd) then
            local _index = 3
            for k, v in ipairs(scores) do
                if (score <= v) then
                    _index = k
                    break
                end
            end
            index = endIndexs[_index]
        end
        roleSpineItem2.PlayByIndex(index, nil, nil, true)
        CSAPI.SetGOActive(objBullets, false)
        CSAPI.SetGOActive(quan, false)
        CSAPI.PlayTempSound("Machairodus_Effects_06")
        return
    end
    if (len) then
        len = len - Time.deltaTime
        len = len <= 0 and 0 or len
        SetTime()
        if (len <= 0) then
            len = nil
            isOver = true
            if (backUI) then
                backUI.SetOver()
            end
        end
    end
    -- 装弹时间
    if (quanTimer) then
        quanTimer = quanTimer - Time.deltaTime
        quanTimer = quanTimer <= 0 and 0 or quanTimer
        anim_quam.fillAmount = quanTimer / quanTime
        if (quanTimer <= 0) then
            quanTimer = nil
            CSAPI.SetGOActive(quan, false)
            CSAPI.SetGOActive(objBullets, true)
            bullet = baseBullet
            SetBullets()
        end
    end
    -- 换弹
    if (cool) then
        cool = cool - Time.deltaTime
        if (cool <= 0) then
            cool = 1.5 + baseCool --   1.4动作时间 3：不操作时间 
            if (bullet <= changeNum) then
                roleSpineItem2.PlayByIndex(11, nil, nil, true)
                quanTimer = 1
                CSAPI.SetGOActive(quan, true)
                CSAPI.SetGOActive(objBullets, false)
                CSAPI.PlayTempSound("Machairodus_Effects_02")
            end
        end
    end
end

function Refresh(_roleSpineItem2)
    roleSpineItem2 = _roleSpineItem2
    AddBackUI()
    CSAPI.SetText(txtTarget, scores[2].."")
    len = 15
end

function AddBackUI()
    if (backUI) then
        return
    end
    local UI_Layer_Common = CSAPI.GetGlobalGO("UI_Layer_Common")
    ResUtil:CreateUIGOAsync("Spine/30180_skin_Machairodus05a_spine/30180_BackUI", roleSpineItem2.prefabObj, function(go)
        backUI = ComUtil.GetLuaTable(go)
        backUI.Refresh(this, roleSpineItem2, SetScore)
        -- 
        CSAPI.SetAnchor(go, -333, -221, 0)
        CSAPI.SetScale(go, 0.64, 0.64, 1)
        -- 
        go.transform:SetAsLastSibling()
        roleSpineItem2.l2dGo.transform:SetAsLastSibling()
        CSAPI.SetGOActive(mask, false)
        -- 
        SetCenterPosLast()
    end)
end

function SetScore(_score)
    if (isOver == nil) then
        return
    end
    if(_score>0)then 
        CSAPI.PlayTempSound("Machairodus_Effects_03")
    end 
    score = score + _score
    local nums = StringUtil:SplitNumber(score)
    for k = 1, 5 do
        local num = nums[k]
        CSAPI.SetGOActive(this["s" .. k], num ~= nil)
        if (num) then
            local str = "UIs/Spine/30180_skin_Machairodus05a_spine/img_02_0" .. num .. ".png"
            CSAPI.LoadImg(this["s" .. k], str, true, nil, true)
        end
    end
    --
    bullet = bullet - 1
    SetBullets()
    if (bullet <= 0) then
        cool = 0.5 -- 射击时间
    else
        cool = baseCool
    end
    -- 
    local img = "img_06_03.png"
    if (score >= scores[2]) then
        img = "img_06_01.png"
    elseif (score >= scores[1]) then
        img = "img_06_02.png"
    end
    if (oldImg and oldImg ~= img) then
        local str = "UIs/Spine/30180_skin_Machairodus05a_spine/" .. img
        CSAPI.LoadImg(scoreImg, str, true, nil, true)
        CSAPI.SetGOActive(rankObj, false)
        CSAPI.SetGOActive(rankObj, true)
        CSAPI.PlayTempSound("Machairodus_Effects_05")
    end
    oldImg = img
end

function SetBullets()
    for k = 1, baseBullet do
        CSAPI.SetGOActive(this["objBullet" .. k], k <= bullet)
    end
end

function SetTime()
    if (oldLen and oldLen == math.ceil(len)) then
        return
    end
    oldLen = math.ceil(len)
    local num1 = math.floor(oldLen / 10)
    local num2 = oldLen % 10
    local str1 = "UIs/Spine/30180_skin_Machairodus05a_spine/img_03_0" .. num1 .. ".png"
    CSAPI.LoadImg(t1, str1, true, nil, true)
    local str2 = "UIs/Spine/30180_skin_Machairodus05a_spine/img_03_0" .. num2 .. ".png"
    CSAPI.LoadImg(t2, str2, true, nil, true)
    if (oldLen == 5) then
        CSAPI.PlayTempSound("Machairodus_Effects_07")
    end
end

-- 能否射击
function CanShoot()
    if (bullet <= 0) then
        return false
    end
    return true
end

function Shoot()
    if (quanTimer) then
        -- 打断换弹
        quanTimer = nil
        CSAPI.SetGOActive(quan, false)
        CSAPI.SetGOActive(objBullets, true)
    end
    roleSpineItem2.PlayByIndex(10, nil, nil, true)
    CSAPI.PlayTempSound("Machairodus_Effects_01")
end

-- 设置center位置 0开始
function SetCenterPos2()
    local go = CSAPI.GetView("Menu")
    if (go) then
        local lua = ComUtil.GetLuaTable(go)
        lua.center.transform:SetSiblingIndex(1)
    end
end
function SetCenterPosLast()
    local go = CSAPI.GetView("Menu")
    if (go) then
        local lua = ComUtil.GetLuaTable(go)
        lua.center.transform:SetAsLastSibling()
    end
end

function OnClickBack()
    if (isOver == nil) then
        return
    end
    if (not isOver) then
        isClickEnd = true
        isOver = true
    end
end

