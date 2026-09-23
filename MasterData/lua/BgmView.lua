local curIndex = nil
local curMusicID = nil
local BgmData = require "BgmData"
local isPlay = true
local source
local timer = nil
local svUtil = nil
local time = nil
local isBeginDrag = false
local isDestory = false
function Awake()
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/Bgm/BgmItem1", LayoutCallBack, true)
    layout:AddOnValueChangeFunc(OnValueChange)
    layout:AddToCenterFunc(ToCenterCB)
    svUtil = SVCenterDrag.New()

    cg_btmCZ = ComUtil.GetCom(btnCZ, "CanvasGroup")
    cg_btn1 = ComUtil.GetCom(btn1, "CanvasGroup")
    cg_btn3 = ComUtil.GetCom(btn3, "CanvasGroup")
    cg_btnSet1 = ComUtil.GetCom(btnSet1, "CanvasGroup")
    cg_btnSet2 = ComUtil.GetCom(btnSet2, "CanvasGroup")

    slider_sd = ComUtil.GetCom(sd, "Slider")

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.BGM_Select, function(id)
        SelectMusice(id)
        layout:UpdateList()
    end)

    UIUtil:AddTop2("RoleListNormal", gameObject, function()
        view:Close()
    end, nil, {})
end

function OnDestroy()
    isDestory = true
    timer = nil
    eventMgr:ClearListener()
    if (oldCurMusicID) then
        BGMMgr:RemoveCueSheet(oldCurMusicID)
        BGMMgr:ReplayBGM()
    else
        if (not isPlay) then
            local _sound = CSAPI.GetSound()
            _sound:Pause(false)
        end
    end
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    local _data = curDatas[index]
    lua.SetIndex(index)
    lua.SetClickCB(OnClickItem)
    lua.Refresh(_data, curMusicID)
    -- lua.SetSelect(curIndex == index)
end
function OnClickItem(index)
    layout:MoveToCenter(index)
end
function OnValueChange()
    -- local index = layout:GetCurIndex()
    -- if index + 1 ~= curIndex then
    --     local item = layout:GetItemLua(curIndex)
    --     if item then
    --         item.SetSelect(false)
    --     end
    --     curIndex = index + 1
    --     local item = layout:GetItemLua(curIndex)
    --     if (item) then
    --         item.SetSelect(true)
    --     end
    -- end
    svUtil:Update()
    if (not isBeginDrag) then
        isBeginDrag = true
        -- 推开恢复，展开恢复
        SelectOrNot(false)
    end
end

function ToCenterCB(index)
    local oldIndex = curIndex
    CSAPI.SetGOActive(mask, true)
    isBeginDrag = false
    curIndex = index == nil and curIndex or (index + 1)
    -- 两边的推开，选中的展开
    SelectOrNot(true)
    -- 背景颜色
    SetBgClor(oldIndex, curIndex)
    -- 延迟关闭mask
    FuncUtil:Call(function()
        CSAPI.SetGOActive(mask, false)
    end, nil, 801)
end

function SelectOrNot(b)
    local indexs = layout:GetIndexs()
    local len = indexs.Length
    for i = 0, len - 1 do
        local index = indexs[i]
        local item = layout:GetItemLua(index)
        if (index == curIndex) then
            item.SetSelect(b)
        else
            item.SetPush(b, curIndex)
        end
    end
end

function OnOpen()
    curMusicID = BGMMgr:GetViewMusicID()
    curIndex = Cfgs.CfgMusic:GetByID(curMusicID).group
    --
    curDatas = Cfgs.CfgAlbum:GetAll()
    -- items 
    svUtil:Init(layout, #curDatas, {575, 575}, 5, 0.1, 0.8)
    layout:IEShowList(#curDatas, FirstCB, curIndex)
    -- btn
    CSAPI.SetGOActive(sd, false)
    CSAPI.SetGOActive(Effect_music, true)
    -- name 
    SetBaseName()
    -- 
    SetBtnCZ()

    SelectMusice0()
end

function SetBtnCZ()
    isCanCZ = BGMMgr:GetViewMusicID() ~= BGMMgr:GetIDByInitialType(1)
    CSAPI.SetGOAlpha(btnCZ, isCanCZ and 1 or 0.3)
end

function SetBaseName()
    local cfg = Cfgs.CfgMusic:GetByID(BGMMgr:GetViewMusicID())
    CSAPI.SetText(txtName2, cfg.sName)
end

function FirstCB()
    if (not isFirst1) then
        isFirst1 = true
        --
        svUtil:Update()
        --
        ToCenterCB()
    end
end

function Update()
    if (timer ~= nil and Time.time >= timer) then
        timer = Time.time + 0.1
        time = source:GetCurTime()
        CSAPI.SetText(txtSlider1, TimeUtil:GetTimeStr9(time))
    end
    if (timer ~= nil and time ~= nil) then
        slider_sd.value = slider_sd.value + Time.deltaTime
        if (slider_sd.value > time) then
            slider_sd.value = time
        end
    end
end

function SelectMusice0()
    -- paly
    -- SetPlay(0)
    ---data 
    SetBgmData(curMusicID)
    CSAPI.SetText(txtName, bgmData:GetCfg().sName)
    -- btns
    CSAPI.SetGOAlpha(btn1, bgmData.isCanL and 1 or 0.3)
    CSAPI.SetGOAlpha(btn3, bgmData.isCanR and 1 or 0.3)
    SetBtnSet2()
    SetBtnPlay()
    -- CSAPI.SetGOActive(sd, true)
    -- if (oldCurMusicID and oldCurMusicID ~= curMusicID) then
    --     BGMMgr:RemoveCueSheet(oldCurMusicID)
    -- end
end

function SelectMusice(id)
    isPlay = true
    oldCurMusicID = curMusicID
    curMusicID = id
    -- paly
    SetPlay(0)
    ---data 
    SetBgmData(id)
    CSAPI.SetText(txtName, bgmData:GetCfg().sName)
    -- btns
    CSAPI.SetGOAlpha(btn1, bgmData.isCanL and 1 or 0.3)
    CSAPI.SetGOAlpha(btn3, bgmData.isCanR and 1 or 0.3)
    SetBtnSet2()
    SetBtnPlay()
    CSAPI.SetGOActive(sd, true)
    CSAPI.SetGOActive(Effect_music, false)
    BGMMgr:RemoveCueSheet(oldCurMusicID)
    --
    CSAPI.SetGOActive(icon_cone1, false)
    CSAPI.SetGOActive(icon_cone1, true)

    oldCurMusicID = curMusicID
end

function SetBgmData(id)
    if (not bgmData) then
        bgmData = BgmData.New()
    end
    bgmData:Init(id)
end

function SetPlay(startTime)
    timer = nil
    BGMMgr:StopBGM2()
    if tonumber(CS.CSAPI.APKVersion()) > 6 then
        source = BGMMgr:PlayBGM2_CB(curMusicID, startTime * 1000, function()
            if(isDestory or source == nil or source.cueSheet == "")then 
                return
            end
            local max = source:GetMaxTime()
            slider_sd.minValue = 0
            slider_sd.maxValue = max
            slider_sd.value = startTime
            CSAPI.SetText(txtSlider1, TimeUtil:GetTimeStr9(startTime))
            CSAPI.SetText(txtSlider2, TimeUtil:GetTimeStr9(max))
            time = nil
            timer = Time.time + 0.1
        end)
    else
        source = BGMMgr:PlayBGM2(curMusicID, startTime * 1000)
        local max = source:GetMaxTime()
        slider_sd.minValue = 0
        slider_sd.maxValue = max
        slider_sd.value = startTime
        CSAPI.SetText(txtSlider1, TimeUtil:GetTimeStr9(startTime))
        CSAPI.SetText(txtSlider2, TimeUtil:GetTimeStr9(max))
        time = nil
        timer = Time.time + 0.1
    end
end

function SetBtnPlay()
    local imgName = isPlay and "img_08_02.png" or "img_08_01.png"
    CSAPI.LoadImg(btn2, "UIs/Bgm/" .. imgName, true, nil, true)
end

function SetBtnSet2()
    CSAPI.SetGOActive(btnSet2, not bgmData.isSetViewBgm)
    CSAPI.SetGOActive(btnSuccess2, bgmData.isSetViewBgm)
    if (not bgmData.isSetViewBgm) then
        CSAPI.SetGOAlpha(btnSet2, bgmData.isCanSetViewBgm and 1 or 0.3)
    end
end

function SetBgClor(oldIndex, newIndex)
    --
    if (oldIndex) then
        local _cfg = curDatas[oldIndex]
        CSAPI.SetGOActive(bgColor1, _cfg.background_colour ~= nil)
        if (_cfg.background_colour) then
            CSAPI.SetImgColorByCode(bgColor1, _cfg.background_colour)
            UIUtil:SetObjFade(bgColor1, 0.2, 0, nil, 200, 1, 0.2)
        end
    end
    if (newIndex) then
        local _cfg = curDatas[newIndex]
        CSAPI.SetGOActive(bgColor2, _cfg.background_colour ~= nil)
        if (_cfg.background_colour) then
            CSAPI.SetImgColorByCode(bgColor2, _cfg.background_colour)
            UIUtil:SetObjFade(bgColor2, 0, 0.2, nil, 200, 1, 0)
        end
    end
end

-- 重置BGM
function OnClickCZ()
    if (isCanCZ) then
        local cfg = Cfgs.CfgMusic:GetByID(BGMMgr:GetIDByInitialType(1))
        local str = LanguageMgr:GetTips(43002, cfg.sName)
        UIUtil:OpenDialog(str, function()
            BGMMgr:SetViewMusicID(BGMMgr:GetIDByInitialType(1))
            SelectMusice(BGMMgr:GetViewMusicID())
            SetBaseName()
            SetBtnSet2()
            layout:UpdateList()
            LanguageMgr:ShowTips(43005)
        end)
    end
end

-- 设为战斗BGM
function OnClickSet1()
    if (bgmData.isCanSetFightBgm) then
        local str = LanguageMgr:GetTips(43001)
        UIUtil:OpenDialog(str, function()
            BGMMgr:SetFightMusicID(BGMMgr:GetViewMusicID())
            bgmData.isCanSetFightBgm = false
            CSAPI.SetGOAlpha(btnSet1, bgmData.isCanSetFightBgm and 1 or 0.3)
            LanguageMgr:ShowTips(43004)
        end)
    end
end

-- 设为主界面BGM
function OnClickSet2()
    if (bgmData.isCanSetViewBgm) then
        local str = LanguageMgr:GetTips(43001)
        UIUtil:OpenDialog(str, function()
            BGMMgr:SetViewMusicID(curMusicID)
            SetBtnCZ()
            SetBaseName()
            bgmData.isSetViewBgm = true
            SetBtnSet2()
            LanguageMgr:ShowTips(43004)
        end)
    else
        LanguageMgr:ShowTips(43003)
    end
end

-- 上一首
function OnClick1()
    if (bgmData.isCanL) then
        local id = bgmData:GetPer()
        SelectMusice(id)
        layout:UpdateList()
    end
end

-- 播放/暂停
function OnClick2()
    if (not oldCurMusicID) then
        local _sound = CSAPI.GetSound()
        isPlay = not isPlay
        -- timer = isPlay and Time.time or nil
        _sound:Pause(not isPlay)
        SetBtnPlay()
    else
        isPlay = not isPlay
        timer = isPlay and Time.time or nil
        source:Pause(not isPlay)
        SetBtnPlay()
    end
end

-- 下一首
function OnClick3()
    if (bgmData.isCanR) then
        local id = bgmData:GetNext()
        SelectMusice(id)
        layout:UpdateList()
    end
end

function OnPressDown() -- OnPointerDown()
    if (source ~= nil) then
        timer = nil
        source:FadeStop()
        source = nil
    end
end

function OnPressUp() -- OnPointerUp()
    local value = slider_sd.value
    if (math.floor(value + 0.5) > value) then
        value = math.floor(value + 0.5)
        value = value > slider_sd.maxValue and slider_sd.maxValue or value
    else
        value = math.floor(slider_sd.value)
    end
    SetPlay(value)
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
