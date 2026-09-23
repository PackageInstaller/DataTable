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
local items = nil

function Awake()
    -- 底图
    local goRT = CSAPI.GetGlobalGO("CommonRT")
    CSAPI.SetRenderTexture(goModelRaw, goRT);
    CSAPI.SetCameraRenderTarget(modelRoot, goRT);

    -- 模糊
    blurMask = ComUtil.GetCom(ModelCamera, "BlurMask")
    blurEffect = ComUtil.GetCom(ModelCamera, "RadialBlurEffect3")
end

function OnDestroy()
    ReleaseCSComRefs()
end

function Init(_data, min, max)
    sectionData = _data
    InitScale(min, max)
    InitPanel()
    if sectionData then
        currIdx = 1 -- 当前界面状态 1：1级界面 2：2级界面 3：3级界面
        local isMainLine = sectionData:GetSectionType() == SectionType.MainLine
        -- 背景
        local bgRes = sectionData:GetBG();
        local posZ = -sectionData:GetBGPosZ()
        local scale = CSAPI.GetSizeOffset()
        SetBgModel(bgRes, posZ * (1 / scale))

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
function SetBgModel(bgName, z)
    ResUtil:LoadBigSR2(bgModel, "UIs/SectionImg/" .. bgName .. "/bg")
    CSAPI.SetLocalPos(ModelCamera, 0, 0, z)
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
    curScale = minScale
    rootScale = 1 / curScale * 2
    -- local arr = CSAPI.GetScreenSize()
    local arr = CS.UIUtil.mainCanvasRectTransform.sizeDelta
    CSAPI.SetRTSize(goModelRaw, arr[0], arr[1])
    CSAPI.SetRTSize(svContent, arr[0], arr[1])
    CSAPI.SetScale(svContent, curScale, curScale, curScale)
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
        y1 = y > 0.5 and (y + size[1] / 2) or -(y + size[1] / 2)
    end
    local fit1 =CSAPI.UIFitoffsetTop() and -CSAPI.UIFitoffsetTop() or 0
    local fit2 = CSAPI.UIFoffsetBottom() and -CSAPI.UIFoffsetBottom() or 0

    CSAPI.SetAnchor(itemNode.gameObject,x1 + fit1 + fit2, y1)
end

function InitFit()
    local fit1 = CSAPI.UIFitoffsetTop() or 0
    local fit2 = CSAPI.UIFoffsetBottom() or 0
    local x1, y1 = CSAPI.GetAnchor(itemNode.gameObject)
    CSAPI.SetAnchor(itemNode.gameObject,x1 + ((fit1 - fit2) / 2), y1)
    local x2,y2 =  CSAPI.GetAnchor(boxObj.gameObject)
    CSAPI.SetAnchor(boxObj.gameObject,x2  - fit2, y2)
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
    blurEffect.blurFactor = isBlur and 0.435 * curScale or 0.5 * curScale
    blurEffect.lerpFactor = isBlur and 1.5 * curScale or 1 * curScale
    blurEffect.DistanceFactor = isBlur and -0.05 * curScale or -(-0.1875 * curScale + 0.525)
    local x, y = CSAPI.GetLocalPos(svContent.gameObject)
    local blurX = (960 * curScale - x) / (1920 * curScale)
    local blurY = (540 * curScale - y) / (1080 * curScale)
    blurEffect.blurCenter = UnityEngine.Vector2(blurX, blurY)
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
    if currIdx == 2 then
        ScaleTo(_scale, _scaleTime)
        MoveTo(-x, -y, _scaleTime, _callBack)
    else
        CSAPI.SetLocalPos(svContent.gameObject, -x, -y, 0)
    end
end

-- 寻找目标位置（随缩放大小变化）
function FindTargetPos(_item, _scale)
    _scale = _scale or maxScale
    if _item then
        local x, y = CSAPI.GetLocalPos(_item.gameObject)
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
        rootScale = 1 / curScale * 2
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
        rootScale = 1 / curScale * 2

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

            if finshCB then
                finshCB()
            end
        end)
    end
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    bg = nil;
    svContent = nil;
    goModelRaw = nil;
    lineNode = nil;
    listNode = nil;
    txtDay = nil;
    txtPower = nil;
    fillPower = nil;
    modelRoot = nil;
    ModelCamera = nil;
    modelNode = nil;
    bgModel = nil;
    effectNode = nil;
    btnMask = nil;
    btnRoot = nil;
    nextImage = nil;
    btnNext = nil;
    lastImg = nil;
    btnLast = nil;
    normal = nil;
    numObj = nil;
    leftTimes = nil;
    leftTimesVal = nil;
    txt_exNum = nil;
    hardObj = nil;
    btnSelEasy = nil;
    txt_easy = nil;
    btnSelHard = nil;
    txt_hard = nil;
    txt_lockHard = nil;
    boxObj = nil;
    txtStage = nil;
    txt_stage = nil;
    txt_maxStage = nil;
    txtStar = nil;
    slider = nil;
    txt_star = nil;
    txt_maxStar = nil;
    img_tip = nil;
    btnReward = nil;
    txt_Reward = nil;
    infoMask = nil;
    itemNode = nil;
    txtItemTitle = nil;
    itemSv = nil;
    itemParent = nil;
    boxNode = nil;
    txtboxStar = nil;
    txt2 = nil;
    txt_boxStar = nil;
    txt_boxMaxStar = nil;
    boxContent = nil;
    btnAllGet = nil;
    txt_GetAll = nil;
    Text = nil;
    info = nil;
    childNode = nil;
    selDungeonNum = nil;
    selDungeonName = nil;
    txttopTips = nil;
    txt_topTips = nil;
    txt_goal = nil;
    detailsObj = nil;
    enemyObj = nil;
    enemyImg = nil;
    txt_enemy = nil;
    mapObj = nil;
    mapImg = nil;
    txt_map = nil;
    outputObj = nil;
    txt_output = nil;
    goodsNode = nil;
    txt_cost = nil;
    cost = nil;
    txt_enter = nil;
    txt_enter2 = nil;
    aiMoveObj = nil;
    txt_aiMove = nil;
    btnAI = nil;
    aiImg = nil;
    goalTitle = nil;
    section = nil;
    chapterNum = nil;
    chapterName = nil;
    clickMask = nil;
    topObj = nil;
    passObj = nil;
    txt_passTitle = nil;
    txt_passTips = nil;
    effectFront = nil;
    view = nil;
end
----#End#----
