local Screen = UnityEngine.Screen
function Awake()
    adjustSlider = ComUtil.GetCom(slider, "Slider")
    adjustSlider.minValue = g_CardLookScale[1]
    adjustSlider.maxValue = g_CardLookScale[2]

    cardIconItem = RoleTool.AddRole(iconParent)
    -- CSAPI.AddSliderCallBack(slider, SliderCB)

    CSAPI.IsCheckRate(false)
end

function OnDestroy()
    CSAPI.IsCheckRate(true)
    if (data[5]) then
        FanZhuan(false)
    end
    CSAPI.RemoveSliderCallBack(slider, SliderCB)
end

function OnOpen()
    if (not isSet) then
        isSet = 1
        CSAPI.AddSliderCallBack(slider, SliderCB)
    end

    -- local cardData = data[1]
    -- curCRoleId =data[1]--cardData:GetRoleID()
    curModeId = data[1] -- cardData:GetSkinID()
    local isLive2D = data[2] or false
    local isShopImg = data[3] or false
    if isShopImg then
        isLive2D = false;
    end
    -- local desc = data[4] or false;
    -- if desc ~= nil then
    --     CSAPI.SetText(txtInfo, desc);
    -- end
    CSAPI.SetGOActive(infoObj, false)--desc ~= nil)
    pos = openSetting ~= nil and openSetting or LoadImgType.RoleInfo

    cardIconItem.Refresh(curModeId, pos, nil, isLive2D, isShopImg)

    SetSliderValue()
    SetAmplification()

    if (data[5]) then
        FanZhuan(true)
        --CSAPI.SetGOActive(sliderNode, false)
    else 
        --CSAPI.SetGOActive(sliderNode, true)
    end
end
-- function SetAnjustSlider()
-- 	SetSliderValue()
-- end
-- C#调整图片大小回调，这里设置滑动条位置
function SetSliderValue()
    local scale = CSAPI.GetScale(iconParent)
    -- local imgScale = cardIconItem.GetCfgScale()
    -- local value = imgScale * scale
    -- if(not adjustSlider) then
    -- 	adjustSlider = ComUtil.GetCom(slider, "Slider")
    -- end
    adjustSlider.value = scale -- (value - g_CardLookScale[1]) /(g_CardLookScale[2] - g_CardLookScale[1])
end
-- 滑动回调，调整图片大小
function SliderCB(num)
    -- local imgScale = cardIconItem.GetCfgScale()
    -- local value = num *(g_CardLookScale[2] - g_CardLookScale[1]) + g_CardLookScale[1]
    -- CSAPI.SetScale(iconParent, value / imgScale, value / imgScale, 1)

    CSAPI.SetScale(iconParent, num, num, 1)
end

-- 设置放大 
function SetAmplification(_show)
    local imgScale = 1 -- cardIconItem.GetCfgScale()
    cardIconItem.SetClickActive(false)
    if (not uiHandle) then
        uiHandle = ComUtil.GetCom(showBg, "UIHandle")
        uiHandle.isMoveLimit = false
    end

    -- 移动限制
    local modelCfg = Cfgs.character:GetByID(curModeId)
    local isZoomSwitch = not modelCfg.zoomSwitch

    uiHandle:InitParm(1, 1, g_CardLookScale[1] / imgScale, g_CardLookScale[2] / imgScale) -- 对应的是父类不是role
    uiHandle:Init(iconParent, function()
        view:Close()
    end, isZoomSwitch, isZoomSwitch)
    uiHandle:SetSliderCB(SetSliderValue)
end

function FanZhuan(b)
    Screen.autorotateToPortrait = b
    Screen.autorotateToPortraitUpsideDown = b
    Screen.autorotateToLandscapeLeft = true
    Screen.autorotateToLandscapeRight = true
    if (b) then
        Screen.orientation = UnityEngine.ScreenOrientation.AutoRotation
    else
        Screen.orientation = UnityEngine.ScreenOrientation.LandscapeLeft
        Screen.orientation = UnityEngine.ScreenOrientation.AutoRotation
    end
end
