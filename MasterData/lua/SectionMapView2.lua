-- 背景界面
local maxScale = 0
local minScale = 0
local scaleTime = 0.2
local sectionData = nil
local isBlur = false -- 模糊
local blurMask = nil
local blurEffect = nil
local dungeonView = nil
local btnCB = nil
-- 背景切换
local bgItems = {}
local bgInfo = nil
local currBgIndex = 1
local lastBgIndex = 1
local contentPosX = 0
local changeMax = 0

function Awake()
    -- 底图
    local goRT = CSAPI.GetGlobalGO("CommonRT")
    CSAPI.SetRenderTexture(goModelRaw, goRT);
    CSAPI.SetCameraRenderTarget(modelRoot, goRT);

    -- 模糊
    blurMask = ComUtil.GetCom(ModelCamera, "BlurMask")
    blurEffect = ComUtil.GetCom(ModelCamera, "RadialBlurEffect3")

    table.insert(bgItems, bgModel.gameObject)
end

function Init(_data, min, max)
    sectionData = _data
    InitScale(1, 1)
    InitPanel()
    if sectionData then
        currIdx = 1 -- 当前界面状态 1：1级界面 2：2级界面 3：3级界面
        -- 背景
        local posZ = -sectionData:GetBGPosZ()
        local scale = CSAPI.GetSizeOffset()
        CSAPI.SetLocalPos(ModelCamera, 0, 0, posZ * (1 / scale))
        SetBgModels()

        CSAPI.SetGOActive(goModelRaw, true)
    end
end

function InitScale(min, max)
    maxScale = g_LineGroup_MaxScale or 3.5
    minScale = g_LineGroup_MinScale > 2 and g_LineGroup_MinScale or 2

    maxScale = max or maxScale
    minScale = min or minScale
end

function InitEffect(go, scale)
    if go == nil then
        return
    end
    scale = scale or 1
    CSAPI.SetParent(go, effectNode)
    CSAPI.SetScale(go, scale, scale, scale)
end

-- 设置背景切割图片
function SetBgModels()
    local bgs = sectionData:GetBGs()
    if bgs then
        for i, v in ipairs(bgs) do
            if bgItems[i] ~= nil then
                ResUtil:LoadBigSR2(bgItems[i], "UIs/SectionImg/" .. v .. "/bg")
            else
                local go = CSAPI.CloneGO(bgItems[1], modelNode.transform)
                ResUtil:LoadBigSR2(go, "UIs/SectionImg/" .. v .. "/bg")
                CSAPI.SetGOActive(go, false)
                bgItems[i] = go
            end
        end
    end
end

function Update()
    SetBlurEffect()

    -- 阻挡操作
    CSAPI.SetGOActive(clickMask, isMove)
end

-----------------------------------------战场-----------------------------------------

function SetClickBtnCB(_cb)
    btnCB = _cb
end

function OnClickBtn()
    if btnCB then
        btnCB()
    end
end

-----------------------------------------初始化-----------------------------------------
function InitPanel()
    -- state
    InitState()

    -- blur
    InitBlur()

    -- bg
    InitBG()
    
    --fit
    InitFit()

    -- voice
    FuncUtil:Call(function()
        CSAPI.PlayUISound("ui_page_battle_start");
    end, nil, 200)
end

-- 初始化状态
function InitState()
    isMove = false
    isBlur = false
end

-- 初始化模糊状态
function InitBlur()
    SetBlurMask(true, false, 1, -3)
    blurEffect.enabled = true
end

-- 初始化背景
function InitBG()
    curScale = 1
    rootScale = 1
    -- local arr = CSAPI.GetScreenSize()
    bgInfo = sectionData:GetBGInfo()
    if not bgInfo then
        LogError("未填背景信息！！！章节ID：" .. sectionData:GetID())
        return
    end

    local mainSize = CSAPI.GetMainCanvasSize()
    local offset = mainSize[0] - 1920
    local size = CSAPI.GetRTSize(svContent)
    CSAPI.SetRTSize(svContent, bgInfo.width + offset, size[1])

    changeMax = 0
    for i = 1, 99 do
        if bgInfo["point" .. i] then
            changeMax = changeMax + 1
        end
    end
end

function InitPivot(x, y)
    local x1, y1 = CSAPI.GetAnchor(itemNode.gameObject)
    local size = CSAPI.GetRTSize(itemNode.gameObject)
    if not rect then
        rect = ComUtil.GetCom(itemNode, "RectTransform")
    end
    rect.pivot = UnityEngine.Vector2(x, y)
    if x == 0 or x == 1 then
        x1 = x > 0.5 and (x + size[0] / 2) or -(x + size[0] / 2)
    end
    if y == 0 or y == 1 then
        y1 = y > 0.5 and (y + size[01] / 2) or -(y + size[1] / 2)
    end

    local fit1 =CSAPI.UIFitoffsetTop() and -CSAPI.UIFitoffsetTop() or 0
    local fit2 = CSAPI.UIFoffsetBottom() and -CSAPI.UIFoffsetBottom() or 0

    CSAPI.SetAnchor(itemNode.gameObject,x1 + fit1 + fit2, y1)
end

function InitFit()
    local x1, y1 = CSAPI.GetAnchor(itemNode.gameObject)
    local fit1 = CSAPI.UIFitoffsetTop() or 0
    local fit2 = CSAPI.UIFoffsetBottom() or 0
    CSAPI.SetAnchor(itemNode.gameObject,x1 + ((fit1 + fit2) / 2), y1)
end

---------------------------------------------模糊---------------------------------------------------
-- 模糊
-- 跟随背景
function SetBlurMask(_isBlur, _isCenter, _StepA, _StepB)
    blurMask.enabled = _isBlur
    blurMask.SmoothStepA = _StepA or 1
    blurMask.SmoothStepB = _StepB or -0.15

    if _isBlur then
        SetBlurCenter(_isCenter)
    end
end

-- 跟随相机 1.2-0.3 2-0.15
function SetBlurEffect()
    -- blurEffect.blurFactor = isBlur and 0.435 * curScale or 0.5 * curScale
    -- blurEffect.lerpFactor = isBlur and 1.5 * curScale or 1 * curScale
    -- blurEffect.DistanceFactor = isBlur and -0.05 * curScale or -(-0.1875 * curScale + 0.525)
    -- local x, y = CSAPI.GetLocalPos(svContent.gameObject)
    -- local blurX = (960 * curScale - x) / (1920 * curScale)
    -- local blurY = (540 * curScale - y) / (1080 * curScale)
    -- blurEffect.blurCenter = UnityEngine.Vector2(blurX, blurY)
end

-- 设置模糊中心点
function SetBlurCenter(isCenter, item)
    if isCenter and item then
        local x, y = CSAPI.GetLocalPos(item.gameObject)
        local blurX = (960 + x) / 1920
        local blurY = (540 + y) / 1080
        blurMask.Center = UnityEngine.Vector2(blurX, blurY)
    else
        blurMask.Center = UnityEngine.Vector2(0.5, 0.5)
    end
end
-------------------------------------------场景移动-------------------------------------------------
-- 返回回到中心
function ResetPos()
    CSAPI.SetLocalPos(svContent.gameObject, 0, 0, 0)
end
-- 移动到目标位置
function MoveToTarget(_item, _scale, _scaleTime, _callBack)
    local x, y = FindTargetPos(_item, _scale)
    -- LogError("x:" .. x.."|y:" .. y)
    if currIdx == 2 then
        ScaleTo(_scale, _scaleTime)
        MoveTo(-x, y, _scaleTime, _callBack)
    else
        CSAPI.SetLocalPos(svContent.gameObject, -x, -y, 0)
    end
end

-- 寻找目标位置（随缩放大小变化）
function FindTargetPos(_item, _scale)
    _scale = _scale or maxScale
    if _item then
        -- local x, y = CSAPI.GetLocalPos(_item.gameObject)
        local x, y = CSAPI.GetAnchor(_item.gameObject)
        local offsetPos = _item.GetOffsetPos()
        x = (x + offsetPos[1] / minScale) * _scale
        y = (y + offsetPos[2] / minScale) * _scale

        -- x, y = GetMoveLimit(x, y)
        return x, y
    end
end

-- 限制背景的移动范围
function GetMoveLimit(starX, starY)
    local arr = CS.UIUtil.mainCanvasRectTransform.sizeDelta
    local endX = starX
    local endY = starY

    local xlen = (curScale - 1) * 960
    local xLimit = xlen - (arr[0] / curScale - xlen)
    if starX >= xLimit or starX <= -xLimit then
        xLimit = starX > 0 and xLimit or -xLimit
        endX = xLimit
    end

    local ylen = (curScale - 1) * 540
    local yLimit = ylen - (arr[1] / curScale - ylen)
    if starY >= yLimit or starY <= -yLimit then
        yLimit = starY > 0 and yLimit or -yLimit
        endY = yLimit
    end

    return endX, endY
end

-- 移动到目标位置
function MoveTo(_x, _y, _scaleTime, _callBack)
    CSAPI.MoveTo(svContent.gameObject, "UI_Local_Move", _x, _y, 0, _callBack, _scaleTime)
end

-- 缩放
function ScaleTo(_scale, _scaleTime)
    CSAPI.SetUIScaleTo(svContent.gameObject, nil, _scale, _scale, _scale, nil, _scaleTime)
end

function Enter(item, startCB, finshCB)
    if not isMove and item then
        isBlur = true
        isMove = true
        curScale = maxScale
        currIdx = 2

        -- 模糊
        SetBlurMask(true, false, 2)

        if startCB then
            startCB()
        end
        MoveToTarget(item, curScale, scaleTime, function()
            isMove = false
            -- blur
            SetBlurMask(true, true, 1, nil)
            UpdateChangeBg()

            if finshCB then
                finshCB()
            end
        end)
    end
end

function Back(item, startCB, finshCB)
    if not isMove and item then
        isBlur = false
        isMove = true
        curScale = minScale

        -- 模糊
        SetBlurMask(true, false, 2)

        if startCB then
            startCB()
        end
        MoveToTarget(item, curScale, scaleTime, function()
            currIdx = 1
            isMove = false
            -- blur
            SetBlurMask(false, false, 1, -3)
            UpdateChangeBg()

            if finshCB then
                finshCB()
            end
        end)
    end
end

function Switch(item, startCB, finshCB)
    if not isMove and item then
        isMove = true

        -- 模糊
        SetBlurMask(true, false, 2)

        if startCB then
            startCB()
        end
        MoveToTarget(item, curScale, scaleTime, function()
            isMove = false
            -- blur
            SetBlurMask(true, true, 1, nil)
            UpdateChangeBg()

            if finshCB then
                finshCB()
            end
        end)
    end
end

function OnDrop()
    UpdateChangeBg()
end

function UpdateChangeBg()
    currBgIndex = CheckBgChange()
    if currBgIndex ~= lastBgIndex then
        lastBgIndex = currBgIndex
        ChangeBg()
    end
end

-- 检测在哪个位置
function CheckBgChange()
    contentPosX = CSAPI.GetAnchor(svContent)
    currBgIndex = 1
    for i = 1, changeMax do
        if contentPosX <= -bgInfo["point" .. i] then
            currBgIndex = i + 1
        end
    end
    return currBgIndex
end

-- 改变背景
function ChangeBg()
    if isChange then
        return
    end
    isChange = true
    UIUtil:SetObjFade(black, 0, 1, nil, 200)
    FuncUtil:Call(function()
        for i, v in ipairs(bgItems) do
            CSAPI.SetGOActive(v, false)
        end
        CSAPI.SetGOActive(bgItems[currBgIndex], true)
        UIUtil:SetObjFade(black, 1, 0, nil, 200)
        isChange = false
    end, this, 200)
end
