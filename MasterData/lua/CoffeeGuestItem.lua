local faces = {"img_10_01", "img_10_02", "img_10_03"}

local isStop = true -- 暂停
local changeTime = nil -- 客人更换间隔
local guestCfg = nil -- 当前客人
local waitTime = nil
local successDic = {}
local isSuccess = false
local faceTime = nil
local isOver = false

function SetClickCB(_cb)
    cb = _cb
end

function Awake()
    image_fillBg = ComUtil.GetCom(fillBg, "Image")
    image_fillBg.fillAmount = 1

    -- 一开始隐藏
    CSAPI.SetGOActive(iconMask, false)
    CSAPI.SetGOActive(top, false)
end

function Refresh(_data, _mainCfg)
    index = _data
    mainCfg = _mainCfg -- 主表
    --
    changeTime = mainCfg.changeTime
end

function Update()
    if (isStop) then
        return
    end
    if (isOver) then
        return
    end
    if (faceTime) then
        faceTime = faceTime - Time.deltaTime
        if (faceTime <= 0) then
            faceTime = nil
            CSAPI.SetGOActive(face_scale, false)
        end
    end
    if (changeTime) then
        changeTime = changeTime - Time.deltaTime
        if (changeTime <= 0) then
            -- 客人来了
            changeTime = nil
            SetGuest()
            CSAPI.SetGOActive(iconMask, true)
            FuncUtil:Call(function()
                CSAPI.SetGOActive(top, true)
            end, nil, 400)
        end
    elseif (waitTime ~= nil and not isSuccess) then
        waitTime = waitTime - Time.deltaTime
        local oldFillAmount = image_fillBg.fillAmount
        image_fillBg.fillAmount = waitTime / guestCfg.waitTime
        if (oldFillAmount >= 0.75 and image_fillBg.fillAmount <= 0.75) then
            SetFace(2)
        elseif (oldFillAmount >= 0.25 and image_fillBg.fillAmount <= 0.25) then
            SetFace(3)
        end
        -- 透明度
        SetAlpha()
        --
        if (waitTime <= 0) then
            -- 耐心归0
            ToOver()
        end
    end
end

function SetAlpha()
    local a1 = (image_fillBg.fillAmount - 0.75) <= 0 and 0 or (image_fillBg.fillAmount - 0.75)
    CSAPI.SetGOAlpha(fill3, a1 / 0.25)
    --
    local a2 = 1
    if (image_fillBg.fillAmount < 0.25) then
        a2 = 0
    elseif (image_fillBg.fillAmount < 0.75) then
        a2 = (image_fillBg.fillAmount - 0.25) <= 0 and 0 or (image_fillBg.fillAmount - 0.25)
    end
    CSAPI.SetGOAlpha(fill2, a2 / 0.5)
    --
    -- local a3 = 1
    -- if (image_fillBg.fillAmount < 0.25) then
    --     a3 = image_fillBg.fillAmount
    -- end
    -- CSAPI.SetGOAlpha(fill1, a3 / 0.25)
end

-- 初始化客人
function SetGuest()
    if (changeTime == nil and not guestCfg) then
        local cfgs = Cfgs.CfgGuest:GetAll()
        local index = CSAPI.RandomInt(1, #cfgs)
        guestCfg = cfgs[index]
        --
        -- local imgScoreN = "img_13_02"
        -- if (guestCfg.score == 100) then
        --     imgScoreN = "img_13_01"
        -- end
        -- icon 
        ResUtil.Coffee:Load(icon, guestCfg.icon, true, nil, true)
        -- score 
        CSAPI.SetGOActive(imgScore, false)
        -- CSAPI.LoadImg(imgScore, "UIs/Coffee/" .. imgScoreN .. ".png", true, nil, true)
        -- 需要的食物
        SetFoodItems()
        -- 表情
        SetFace(1)
        -- 进度条
        image_fillBg.fillAmount = 1
        SetAlpha()
        -- 开始等待
        waitTime = guestCfg.waitTime
    end
end

function SetScore(isSuccess)
    local imgScoreN = nil
    if (isSuccess) then
        imgScoreN = guestCfg.score == 100 and "img_13_01" or "img_13_02"
    else
        imgScoreN = CoffeeMgr:GetMissPoints() == 100 and "img_13_03" or "img_13_04"
        if (cb) then
            cb()
        end
    end
    CSAPI.LoadImg(imgScore, "UIs/Coffee/" .. imgScoreN .. ".png", true, nil, true)
    CSAPI.SetGOActive(imgScore, false)
    CSAPI.SetGOActive(imgScore, true)
end

function SetFoodItems()
    foodItems = foodItems or {}
    ItemUtil.AddItems("Coffee/CoffeeFoodItem2", foodItems, guestCfg.foods, foodParent, nil, 1, successDic)
end

function SetFace(type)
    if (faceTime == nil or type == 3) then
        CSAPI.LoadImg(face, "UIs/Coffee/" .. faces[type] .. ".png", true, nil, true)
        CSAPI.SetGOActive(face_scale, true)
        faceTime = 2
    end
end

function SetStop(b)
    isStop = b
end

function ToStart()
    isStop = false
end

function GetScore()
    if (guestCfg) then
        return guestCfg.score
    end
    return 0
end

function CheckSuccess()
    for k, v in pairs(guestCfg.foods) do
        if (not successDic[v]) then
            return false
        end
    end
    return true
end

-- 吃
function Eat(id)
    local isEat = false
    for k, v in ipairs(guestCfg.foods) do
        if (v == id and not successDic[v]) then
            -- 成功
            successDic[id] = 1
            SetFoodItems()
            isEat = true
        end
    end
    isSuccess = CheckSuccess()
    if (isSuccess) then
        faceTime = nil
        SetFace(1) -- 强制笑
        ToOver()
    elseif (not isEat) then
        waitTime = waitTime - guestCfg.waitTime * (mainCfg.deducPatience / 100)
        SetFace(3)
        -- 
        for k, v in pairs(foodItems) do
            v.SetDD()
        end
    end
    return isEat
end

-- 能否吃（无论成功失败）
function CheckCanEat()
    if (not isOver and waitTime ~= nil and not CheckSuccess()) then
        return true
    end
    return false
end

function ToOver()
    isOver = true
    if (isSuccess) then
        SetFace(1)
    else
        SetFace(3)
    end
    -- 
    SetScore(isSuccess)
    -- 退场
    UIUtil:SetObjFade(node, 1, 0, function()
        if (gameObject == nil) then
            return
        end
        --
        changeTime = nil -- 客人更换间隔
        guestCfg = nil -- 当前客人
        waitTime = nil
        successDic = {}
        isSuccess = false
        faceTime = nil
        isOver = false
        --
        CSAPI.SetGOAlpha(node, 1)
        CSAPI.SetGOActive(iconMask, false)
        CSAPI.SetGOActive(top, false)
        changeTime = mainCfg.changeTime
    end, 900, 2000, 1)
end
