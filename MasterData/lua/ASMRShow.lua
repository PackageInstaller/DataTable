local isPlay = true
local voiceTimer = nil
local words = {}
local oldStr = ""
local cur = 0
local max = 0
local graphic = nil
local l2d = nil
local topLua
local timer = nil
local time = nil
local isPress = false
local pType = 0
local isDestory = false
local needReplayBGM = false

function Awake()
    topLua = UIUtil:AddTop2("ASMRShow", gameObject, function()
        voiceTimer = nil
        ASMRMgr:StopBGM()
        view:Close()
    end, nil, {})
    CSAPI.SetGOActive(topLua.gameObject, false)

    slider_sd = ComUtil.GetCom(sd, "Slider")

    -- 立绘
    cardIconItem = RoleTool.AddRole(iconParent, nil, nil, false)
    -- 多人插图 
    mulIconItem = RoleTool.AddMulRole(iconParent, nil, nil, false)

    pType = ASMRMgr:GetASMRMusicPType()
end

function OnDestroy()
    isDestory = true
    ASMRMgr:RemoveCueSheet(curData:GetCfg().id, 2)
    SetMusic(false)

    if (needReplayBGM) then
        ASMRMgr:ReplayBGM() -- 恢复
    end
end

function OnOpen()
    SetMusic(true)
    RefreshPanel()

    needReplayBGM = not CSAPI.IsViewOpen("ASMRView")
    -- 反和谐判断
    local b = CSAPI.CheckFHX()
    if (b ~= nil) then
        CSAPI.SetGOActive(maskHX, not b)
    else
        CSAPI.SetGOActive(maskHX, false)
    end
end

function RefreshPanel()
    curData = ASMRMgr:GetData(data)
    FuncUtil:Call(SetRole, nil, 100)
end

function SetRole()
    local l2dName = curData:GetCfg().l2d
    if (l2dName) then
        SetL2d(l2dName)
    else
        SetModel()
    end
end

function Next()
    local curDatas = ASMRMgr:GetDatas()
    if (#curDatas > 1) then
        for k, v in ipairs(curDatas) do
            if (v:GetCfg().id == data) then
                data = nil
                local index, len = k, #curDatas
                while data == nil do
                    index = index >= len and 1 or (index + 1)
                    if (curDatas[index]:IsBuy()) then
                        data = curDatas[index]:GetCfg().id
                    end
                end
                break
            end
        end
    end
    RefreshPanel()
end

function SetModel()
    local model = curData:GetCfg().model
    CSAPI.SetGOActive(cardIconItem.gameObject, model >= 10000)
    CSAPI.SetGOActive(mulIconItem.gameObject, model < 10000)
    local item = model >= 10000 and cardIconItem or mulIconItem
    item.Refresh(model, LoadImgType.Main, nil, false)
    Play()
end

function Play()
    words = {}
    local voiceCfg = Cfgs.CfgAsmrVoice:GetByID(curData:GetCfg().voice)
    for k, v in pairs(voiceCfg.arr) do
        words[v.time] = v.word
    end
    ASMRMgr:StopBGM()
    if tonumber(CS.CSAPI.APKVersion()) > 6 then
        source = ASMRMgr:PlayBGM_CB(curData:GetCfg().id, 2, 0, function()
            if (isDestory) then
                return
            end
            max = source:GetMaxTime()
            voiceTimer = Time.time
            CSAPI.SetGOActive(mask, false)
        end)
    else
        source = ASMRMgr:PlayBGM(curData:GetCfg().id, 2)
        max = source:GetMaxTime()
        voiceTimer = Time.time
        CSAPI.SetGOActive(mask, false)
    end
end

function Update()
    if (voiceTimer ~= nil and Time.time >= voiceTimer) then
        voiceTimer = Time.time + 1
        cur = source:GetCurTime()
        --
        oldStr = words[math.floor(cur)] or oldStr
        CSAPI.SetText(txtVoice, oldStr)
        --
        if (cur >= (max - 1)) then
            voiceTimer = nil
            if (pType == 0) then
                source:Pause(true)
                view:Close()
            elseif (pType == 1) then
                RefreshPanel()
            else
                Next()
            end
        end
    end
end

function OnClickBG()
    isPlay = not isPlay
    CSAPI.SetGOActive(topLua.gameObject, not isPlay)
    CSAPI.SetGOActive(stop, not isPlay)
    CSAPI.SetGOActive(pro, not isPlay)
    SetPTypeImg()
    source:Pause(not isPlay)
    if (isPlay) then
        -- 拉了进度条
        if (isPress) then
            voiceTimer = nil
            ASMRMgr:StopBGM()
            source = ASMRMgr:PlayBGM(curData:GetCfg().id, 2, cur * 1000)
        end
        isPress = false
    else
        -- 暂停
        SetPro()
    end

    voiceTimer = isPlay and Time.time + 0.1 or nil
    if (l2d) then
        local te0 = l2d.animationState:GetCurrent(0)
        te0.TimeScale = isPlay and 1 or 0
        local te = l2d.animationState:GetCurrent(1)
        if (te) then
            if (isPlay) then
                te.TrackTime = te.Animation.Duration * (cur / slider_sd.maxValue)
            end
            te.TimeScale = isPlay and 1 or 0
        end
    end
    --
    CSAPI.SetAnchor(txtVoice, 0, isPlay and 83 or 170, 0)
end

function SetL2d(l2dName)
    if (l2d) then
        CSAPI.RemoveGO(l2d.gameObject)
    end
    l2d = nil
    ResUtil:CreateSpine(l2dName .. "/" .. l2dName, 0, 0, 0, bg, function(go)
        l2d = ComUtil.GetCom(go, "CSpine")
        l2d.animationState:SetAnimation(1, curData:GetCfg().e_anim, false)
        FuncUtil:Call(Play, nil, 100)
    end)
end

function SetMusic(isOpen)
    if (not CSAPI.IsViewOpen("ASMRView")) then
        local musicScale = SettingMgr:GetValue(s_audio_scale.music)
        local curMusicScale = ASMRMgr:GetASMRMusicScale()
        local scale = isOpen and curMusicScale or musicScale
        SettingMgr:SetAudioScale(s_audio_scale.music, scale)
    end
end

----------------------------------------------------------------------------------------

function SetPro()
    if (not isPlay) then
        local _cur = source:GetCurTime()
        local _max = source:GetMaxTime()
        slider_sd.minValue = 0
        slider_sd.maxValue = _max
        slider_sd.value = _cur
        CSAPI.SetText(txtSlider1, TimeUtil:GetTimeStr9(_cur))
        CSAPI.SetText(txtSlider2, TimeUtil:GetTimeStr9(_max))
    end
end

-- function OnPressDown() -- OnPointerDown()
--     if (source ~= nil) then
--         timer = nil
--         source:FadeStop()
--         source = nil
--     end
-- end

function OnPressUp() -- OnPointerUp()
    local value = slider_sd.value
    if (math.floor(value + 0.5) > value) then
        value = math.floor(value + 0.5)
        value = value > slider_sd.maxValue and slider_sd.maxValue or value
    else
        value = math.floor(slider_sd.value)
    end
    slider_sd.value = value
    -- 刷新台词
    cur = value
    oldStr = GetPerVoice()
    CSAPI.SetText(txtVoice, oldStr)
    CSAPI.SetText(txtSlider1, TimeUtil:GetTimeStr9(cur))
    isPress = true
    --
    if (l2d) then
        local te0 = l2d.animationState:GetCurrent(0)
        te0.TimeScale = isPlay and 1 or 0
        local te = l2d.animationState:GetCurrent(1)
        if (te) then
            te.TimeScale = isPlay and 1 or 0
            te.TrackTime = te.Animation.Duration * (cur / slider_sd.maxValue)
        end
    end
end

function GetPerVoice()
    local _cur = math.floor(cur)
    for k = _cur, 1, -1 do
        if (words[math.floor(k)]) then
            return words[math.floor(k)]
        end
    end
    return oldStr
end

function SetPTypeImg()
    local imgName = "btn_05_03.png"
    if (pType > 0) then
        imgName = pType == 1 and "btn_05_01.png" or "btn_05_02.png"
    end
    CSAPI.LoadImg(imgPro, "UIs/ASMR/" .. imgName, true, nil, true);
end

-- 切换循环模式  0:单次  1：循环  2：下一首
function OnClickPro()
    pType = (pType + 1) > 2 and 0 or (pType + 1)
    ASMRMgr:SetASMRMusicPType(pType)
    SetPTypeImg()
    --
    local lanID = 46006
    if (pType == 1) then
        lanID = 46004
    elseif (pType == 2) then
        lanID = 46005
    end
    LanguageMgr:ShowTips(lanID)
end
