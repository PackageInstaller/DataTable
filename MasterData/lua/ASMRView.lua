local curIndex = 1
local curData
local isBuy
local isDownload
local musicScale = 100 -- 声音大小
local curMusicScale = 100 -- 当前声音大小
local dragX, dragY = 0, 0
local isDrag = false
local speed = 0.001
local oldCurMusicID = nil
local timer = nil
local cur = 0
local isClick = false

local Input = CS.UnityEngine.Input
local GetMouseButton = CS.UnityEngine.Input.GetMouseButton
local deviceType = CSAPI.GetDeviceType()
local isDestory = false
function Awake()
    UIUtil:AddTop2("ASMRView", gameObject, function()
        view:Close()
    end, nil, {})

    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/ASMR/ASMRItem", LayoutCallBack, true)
    layout:AddOnValueChangeFunc(OnValueChange)
    layout:AddToCenterFunc(ToCenterCB)
    svUtil = SVCenterDrag.New()

    fill_imgL = ComUtil.GetCom(imgL, "Image")

    musicScale = SettingMgr:GetValue(s_audio_scale.music)
    curMusicScale = ASMRMgr:GetASMRMusicScale()
    SettingMgr:SetAudioScale(s_audio_scale.music, curMusicScale)

    anim_sound = ComUtil.GetCom(effect_sound, "Animator")
    CSAPI.SetGOActive(effect_sound, false)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Shop_RecordInfos_Refresh, RefreshPanel)
    eventMgr:AddListener(EventType.Shop_Buy_Ret, RefreshPanel)
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end

function OnDestroy()
    isDestory = true
    eventMgr:ClearListener()
    if (oldCurMusicID) then
        ASMRMgr:RemoveCueSheet(oldCurMusicID, 1)
        ASMRMgr:StopBGM()
    end
    ASMRMgr:ReplayBGM() -- 恢复
    SettingMgr:SetAudioScale(s_audio_scale.music, musicScale)
    ASMRMgr:SetASMRMusicScale(curMusicScale)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnClickItem)
        lua.Refresh(_data, isFirst1)
    end
end
function OnClickItem(index)
    if (oldIndex and oldIndex == index) then
        OnClickR2()
        return
    end
    --
    if (isClick) then
        return
    end
    isClick = true
    --
    if (oldIndex and oldIndex ~= index) then
        local item = layout:GetItemLua(oldIndex)
        item.SelectAnim(false)
    end
    if (oldIndex == nil or oldIndex ~= index) then
        local item = layout:GetItemLua(index)
        item.SelectAnim(true)
    end
    -- oldIndex = index
    --
    layout:MoveToCenter(index)
end
function OnValueChange()
    svUtil:Update()
    if (not isBeginDrag) then
        isBeginDrag = true
    end
end
function ToCenterCB(index)
    CSAPI.SetGOActive(mask, true)
    isBeginDrag = false
    curIndex = index == nil and curIndex or (index + 1)
    -- 两边的推开，选中的展开
    if (not isClick) then
        SelectOrNot()
    end
    --
    RefreshPanel()
    -- 延迟关闭mask
    FuncUtil:Call(function()
        CSAPI.SetGOActive(mask, false)
    end, nil, 801)
    --
    CSAPI.SetGOAlpha(btnR1, curIndex <= 1 and 0.5 or 1)
    CSAPI.SetGOAlpha(btnR3, curIndex >= #curDatas and 0.5 or 1)
    --
    isClick = false
    oldIndex = curIndex
end

function SelectOrNot()
    local indexs = layout:GetIndexs()
    local len = indexs.Length
    for i = 0, len - 1 do
        local index = indexs[i]
        local item = layout:GetItemLua(index)
        item.SetSelect(index == curIndex)
        -- if (index == curIndex) then
        --     item.SetSelect(b)
        -- else
        -- item.SetPush(b, curIndex)
        -- end
    end
end

function Update()
    if (source ~= nil and timer ~= nil and Time.time >= timer) then
        timer = Time.time + 1
        local time = source:GetCurTime()
        if (time >= cur) then
            cur = time -- 播放中
        else
            -- 返回开头了 
            RemoveCur()
            ASMRMgr:StopBGM()
            anim_sound:Play("Sound_quit")
        end
    end
end

function OnOpen()
    curDatas = ASMRMgr:GetDatas()
    svUtil:Init(layout, #curDatas, {830, 577}, 5, 0.1, 0.8)
    -- middle
    layout:IEShowList(#curDatas, FirstCB, curIndex)
    RefreshPanel()
    -- 反和谐判断
    local b = CSAPI.CheckFHX()
    if (b ~= nil) then
        CSAPI.SetGOAlpha(movePoint, b and 0.2 or 0)
    else
        CSAPI.SetGOAlpha(movePoint, 0)
    end
end
function FirstCB()
    if (not isFirst1) then
        isFirst1 = true
        --
        svUtil:Update()
        --
        -- ToCenterCB()
        OnClickItem(curIndex)
    end
end

function RefreshPanel()
    curData = curDatas[curIndex]
    ASMRMgr:SetRed(curData:GetCfg().item)
    Play()
    SetL()
    SetR()
    SetModel()
    CSAPI.SetText(txtDesc, curData:GetCfg().des)
end

function SetModel()
    if (curImgIndex ~= nil) then
        UIUtil:SetObjFade(this["bg" .. curImgIndex], 1, 0, nil, 520, 1, 1)
    end
    local elseImg = bg1
    if (curImgIndex) then
        elseImg = curImgIndex == 1 and bg2 or bg1
    end
    UIUtil:SetObjFade(elseImg, 0, 1, nil, 520, 1, 0)
    curImgIndex = curImgIndex == 1 and 2 or 1
    local model = curData:GetCfg().model
    if (model >= 10000) then
        RoleTool.LoadImg(elseImg, model, LoadImgType.Main)
    else
        RoleTool.LoadMulImg(elseImg, model, LoadImgType.Main)
    end
end

-- 试听
function Play()
    if (oldCurMusicID and oldCurMusicID == curData:GetCfg().id) then
        return
    end
    timer = nil
    ASMRMgr:StopBGM()
    ------------------------------
    if tonumber(CS.CSAPI.APKVersion()) > 6 then
        source = ASMRMgr:PlayBGM_CB(curData:GetCfg().id, 1, 0, function()
            if (isDestory) then
                return
            end
            if (source:GetMaxTime() > 0) then
                cur = 0
                timer = Time.time
                CSAPI.SetGOActive(effect_sound, true)
                anim_sound:Play("Sound_entry")
            end
        end)
    else
        source = ASMRMgr:PlayBGM(curData:GetCfg().id, 1)
        if (source:GetMaxTime() > 0) then
            cur = 0
            timer = Time.time
            CSAPI.SetGOActive(effect_sound, true)
            anim_sound:Play("Sound_entry")
        end
    end
    ----------------------------
    if (oldCurMusicID) then
        ASMRMgr:RemoveCueSheet(oldCurMusicID, 1)
    end
    oldCurMusicID = curData:GetCfg().id
end

function SetL()
    CSAPI.SetText(txtL, curMusicScale .. "%")
    local rotaZ = (100 - curMusicScale) / 100 * 255
    CSAPI.SetAngle(imgProg, 0, 0, rotaZ)
    fill_imgL.fillAmount = 0.11 + 0.78 * (curMusicScale / 100)
end

function SetR()
    local imgName, scaleStr = "btn_03_01.png", ""
    isBuy = curData:IsBuy()
    if (isBuy) then
        isDownload = curData:IsDownload()
        imgName = isDownload and "btn_03_03.png" or "btn_03_02.png"
        scaleStr = isDownload and "" or LanguageMgr:GetByID(69001, curData:GetCfg().scale)
    end
    CSAPI.LoadImg(imgR2, "UIs/ASMR/" .. imgName, true, nil, true)
    CSAPI.SetText(txtR2, scaleStr)
    -- red
    local isRedL, isRedR = ASMRMgr:CheckRedLR(curIndex)
    UIUtil:SetRedPoint(btnR1, isRedL, -25.5, 21.5, 0)
    UIUtil:SetRedPoint(btnR3, isRedR, 30.7, 21.5, 0)
end

function OnClickR1()
    if (curIndex > 1) then
        curIndex = curIndex - 1
        OnClickItem(curIndex)
    end
end

function OnClickR2()
    if (isBuy) then
        if (isDownload) then
            RemoveCur()
            CSAPI.OpenView("ASMRShow", curData:GetCfg().id)
        else
            CSAPI.SetGOActive(mask, true)
            ASMRMgr.DownloadCV(curData:GetCfg().cue_sheet2, function()
                CSAPI.SetGOActive(mask, false)
                SetR()
            end)
        end
    else
        if (curData:GetCfg().jump) then
            RemoveCur()
            JumpMgr:Jump(curData:GetCfg().jump)
        end
    end
end

function OnClickR3()
    if (curIndex < #curDatas) then
        curIndex = curIndex + 1
        OnClickItem(curIndex)
    end
end

function OnBeginDrag()
    isDrag = true
end

-- 滑动范围0-255
function OnDrag()
    if (not isDrag) then
        return
    end
    SetLContentPos()
    local angle = calculate_angle(dragX, dragY) -- [218,322] [255,360]

    angle = (angle >= 255 and angle < 307) and 255 or angle
    angle = (angle >= 307 and angle <= 360) and 0 or angle
    if (oldAngle and math.abs(angle - oldAngle) > 30) then
        return
    end
    oldAngle = angle

    CSAPI.SetAngle(imgProg, 0, 0, angle)
    curMusicScale = math.floor((255 - angle) / 255 * 100)
    SettingMgr:SetAudioScale(s_audio_scale.music, curMusicScale)
    -- CSAPI.SetGOAlpha(imgL, 0.11 + curMusicScale / 100 * 0.89)
    fill_imgL.fillAmount = 0.11 + 0.78 * (curMusicScale / 100)
    SetL()
end

function OnEndDrag()
    isDrag = false
end

-- 定义一个函数来计算角度
function calculate_angle(x, y)
    local angle_in_radians
    if x == 0 and y == 0 then
        -- 如果 x 和 y 都为 0，返回 0 度（无方向）
        angle_in_radians = 0
    elseif x == 0 then
        -- 如果 x 为 0，直接判断 y 的符号
        angle_in_radians = (y > 0) and (math.pi / 2) or (-math.pi / 2)
    else
        -- 计算弧度
        angle_in_radians = math.atan(y / x)

        -- 根据 x 和 y 的符号调整角度
        if x < 0 then
            -- 第二或第三象限
            if y >= 0 then
                -- 第二象限
                angle_in_radians = angle_in_radians + math.pi
            else
                -- 第三象限
                angle_in_radians = angle_in_radians - math.pi
            end
        end
    end

    -- 将弧度转换为度数
    local angle_in_degrees = angle_in_radians * (180 / math.pi)
    angle_in_degrees = angle_in_degrees + 37
    -- -- 确保角度在 0 到 360 度之间  0-254
    -- if angle_in_degrees < 0 then
    --     angle_in_degrees = angle_in_degrees + 360
    -- end
    -- angle_in_degrees = angle_in_degrees < 0 and 0 or angle_in_degrees
    -- angle_in_degrees = angle_in_degrees > 254 and 254 or angle_in_degrees

    -- 确保角度在 0 到 360 度之间
    if angle_in_degrees < 0 then
        angle_in_degrees = angle_in_degrees + 360
    end

    return angle_in_degrees
end

function SetLContentPos()
    local screenClickPos = GetCurPos()
    CSAPI.SetToMousePosition(pointSV.transform, point.transform, screenClickPos.x, screenClickPos.y, screenClickPos.z)
    dragX, dragY = CSAPI.GetAnchor(point)
end

function GetCurPos()
    local vec3 = UnityEngine.Vector3(0, 0, 0)
    if (deviceType == 3) then
        -- 电脑
        if (GetMouseButton(0)) then
            vec3 = Input.mousePosition
        end
    else
        if (Input.touchCount == 1) then
            vec3 = Input.GetTouch(0).position
        end
    end
    return vec3
end

function OnViewOpened(viewKey)
    --RemoveCur()
    if (viewKey == "ShopView") then
        SettingMgr:SetAudioScale(s_audio_scale.music, musicScale)
    end
end

-- 其它界面关闭
function OnViewClosed(viewKey)
    if (viewKey == "ShopView") then
        SettingMgr:SetAudioScale(s_audio_scale.music, curMusicScale)
    end
end

-- 移除bgm只有一个接口，那么打开界面时都移除当前试听
function RemoveCur()
    if (source) then
        timer = nil
        source = nil
        ASMRMgr:RemoveCueSheet(oldCurMusicID, 1)
        oldCurMusicID = nil
    end
end
