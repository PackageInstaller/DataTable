-- local isHold = false
local holdDownTime1 = 0
local isPress1 = false
local timer1 = 0
local holdDownTime2 = 0
local isPress2 = false
local timer2 = 0

function SetIndex(_index)
    index = _index
end

function Update()
    if (isPress1 and Time.time > holdDownTime1 and Time.time > timer1) then
        timer1 = Time.time + 0.1
        OnClick()
    end
    if (isPress2 and Time.time > holdDownTime2 and Time.time > timer2) then
        timer2 = Time.time + 0.1
        OnClickRemove()
    end
end

function Refresh(_data, _giftData, _isMax)
    data = _data
    giftData = _giftData -- 选中的后数据
    isMax = _isMax
    if (isMax) then
        isPress1 = false
    end
    if (giftData.num <= 0) then
        isPress2 = false
    end
    -- bg
    LoadFrame(data:GetQuality())
    -- icon
    LoadIcon(data:GetIcon())
    -- count
    CSAPI.SetText(txt_count, data:GetCount() .. "")
    -- exp
    local color = 929296
    if (data:GetCount() > 0) then
        color = (giftData.percent > 0) and "00ffbf" or "ffffff"
    end
    StringUtil:SetColorByName(txtExp2, "EXP", color)
    StringUtil:SetColorByName(txtExp2, giftData.totalVal, color)
    -- select,sel
    CSAPI.SetGOActive(selectObj, giftData.num > 0)
    if (giftData.num > 0) then
        CSAPI.SetText(txtSel, giftData.num .. "")
    end
    -- percent
    local str = ""
    if (giftData.percent > 0) then
        str = "+" .. giftData.percent
    end
    CSAPI.SetText(txtPercent, str)
    -- mask 
    CSAPI.SetGOActive(mask, data:GetCount() <= 0)
    CSAPI.SetGOAlpha(clickNode, data:GetCount() > 0 and 1 or 0.4)
end

-- 加载框
function LoadFrame(lvQuality)
    if lvQuality then
        local frame = GridFrame[lvQuality];
        ResUtil.IconGoods:Load(bg, frame);
    else
        ResUtil.IconGoods:Load(bg, GridFrame[1]);
    end
end

-- 加载图标
function LoadIcon(iconName)
    CSAPI.SetGOActive(icon, iconName ~= nil);
    if (iconName) then
        ResUtil.IconGoods:Load(icon, iconName .. "")
    end
end

function OnClick()
    if (data:GetCount() <= 0) then
        return
    end
    giftData.slectFunc(this)

    if (giftData.had <= 0) then
        LanguageMgr:ShowTips(21022)
    end
end

function OnClickRemove()
    giftData.removeFunc(this)
end

function OnPressDown1(isDrag, clickTime)
    holdDownTime1 = Time.time + 0.3
    timer1 = Time.time
    isPress1 = true
end

function OnPressUp1(isDrag, clickTime)
    if not isDrag then
        if Time.time < holdDownTime1 then
            OnClick()
        end
    end
    isPress1 = false
end

function OnPressDown2(isDrag, clickTime)
    holdDownTime2 = Time.time + 0.3
    timer2 = Time.time
    isPress2 = true
end

function OnPressUp2(isDrag, clickTime)
    if not isDrag then
        if Time.time < holdDownTime2 then
            OnClickRemove()
        end
    end
    isPress2 = false
end
