-- 催眠游戏界面
local favour_first_open_key = "_favour_first_open"
local speeds = {}
local timer1 = 0
local timer2 = 0
local isDowmTime = false
local isStop = false
local stage = 1 -- 初始，（提示）倒计时，playing（暂停），结果,内心独白
local comboNum = 0
local sCur, sMax = 0, 0
local circleScale = 12 -- 圆大小 12度
local bgLimitTime = 0
local num = 1 -- 记录音效播放

function Awake()
    cardImgLua = RoleTool.AddRole(iconParent)

    UIUtil:AddTop2("FavourHypnosisView", top, function()
        if (stage == 3) then
            -- 暂停 
            OnClickStop()
        else
            view:Close()
        end
    end, ni, {})

    m_timeFill = ComUtil.GetCom(timeFill, "Image")
    m_watchAnim = ComUtil.GetCom(watchAnim, "ActionBase")
    m_slider = ComUtil.GetCom(slider, "Slider")

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Favour_CM_Success, OpenSuccesPanel)

    OpenFirstTips()
end
function OnDestroy()
    eventMgr:ClearListener()
end

-- 提示界面
function OpenFirstTips()
    local value = PlayerPrefs.GetInt(favour_first_open_key)
    if (value ~= 1) then
        PlayerPrefs.SetInt(favour_first_open_key, 1)
        ResUtil:LoadBigImg(imgTips, "UIs/Favour/tipsBg", true)
    end
    CSAPI.SetGOActive(tipsMask, value ~= 1)
end

function Update()
    if (not isDowmTime) then
        return
    end
    if (stage == 2) then
        if (timer1 > 0) then
            timer1 = timer1 - Time.deltaTime
            timer1 = timer1 <= 0 and 0 or timer1
            local num = timer1 / 3
            m_timeFill.fillAmount = num
            SetTimeimg1(timer1)
            if (timer1 == 0) then
                SetStateImg("img_17_01")
            end
        elseif (timer2 > 0) then
            timer2 = timer2 - Time.deltaTime
            if (timer2 <= 0) then
                ChangeStage(3)
            end
        end
    elseif (stage == 3) then
        if (timer1 > 0) then
            timer1 = timer1 - Time.deltaTime
            timer1 = timer1 <= 0 and 0 or timer1
            SetTimeimg2(timer1)
            if (timer1 == 0) then
                m_watchAnim:SetRun(false)
                ChangeStage(4)
            end
            -- 叮叮音效
            local curAngleZ = CSAPI.csGetAngle(watchAnim)[2]
            if (num == 1 and curAngleZ < 1) then
                num = 2
                CSAPI.PlayCounselingRoomSound("MetronomeLeft")
            elseif (num == 2 and curAngleZ > 119) then
                num = 1
                CSAPI.PlayCounselingRoomSound("MetronomeRight")
            end
        end
    elseif (stage == 4) then
        timer1 = timer1 - Time.deltaTime
        if (timer1 < 0) then
            ChangeStage(5)
        end
    end
end

function OnOpen()
    -- role 
    SetRole()

    ChangeStage(1)
end

function SetRole()
    CSAPI.SetScale(iconParent, 0, 0, 0)
    cardImgLua.Refresh(data:GetFirstSkinId(), LoadImgType.Main, function()
        CSAPI.SetScale(iconParent, 1, 1, 1)
    end, false)
end

function SetTalk()
    local cfgFavour = Cfgs.CfgCardRoleFavour:GetByID(data:GetID())
    local str = cfgFavour.favourScript2
    CSAPI.SetGOActive(txtTalkBg, str ~= nil)
    if (str ~= nil) then
        CSAPI.SetText(txtTalk, str)
    end
end

function ChangeStage(num)
    stage = num
    RefreshPanel()
end

function RefreshPanel()
    isDowmTime = false
    CSAPI.SetGOActive(talkBg, false)
    CSAPI.SetGOActive(btnStart, false)
    CSAPI.SetGOActive(playing, false)
    CSAPI.SetGOActive(timeMask, false)
    CSAPI.SetGOActive(timeObj, false)
    CSAPI.SetGOActive(imgState, false)

    if (stage == 1) then
        SetStart()
    elseif (stage == 2) then
        SetDowmTime()
    elseif (stage == 3) then
        SetPlaying()
    elseif (stage == 4) then
        SetResult()
    else
        SetHeartTalk()
    end
end

function SetStart()
    CSAPI.SetGOActive(talkBg, true)
    CSAPI.SetGOActive(btnStart, true)

    SetTalk()
end

function SetDowmTime()
    CSAPI.SetGOActive(timeMask, true)
    CSAPI.SetGOActive(timeObj, true)
    timer1 = 3
    timer2 = 1
    isDowmTime = true
    CSAPI.PlayCounselingRoomSound("Countdown_All")
end

function SetPlaying()
    CSAPI.PlayBGM(MatrixBGM.FavourGame)

    CSAPI.SetGOActive(playing, true)
    CSAPI.SetGOActive(iconL2, false)
    CSAPI.SetGOActive(iconR2, false)
    -- cfg 
    cfg = nil
    local lv = data:GetLv()
    local cfgs = Cfgs.CfgHypnosis:GetAll()
    for k, v in ipairs(cfgs) do
        if (lv >= v.lvRange[1] and lv < v.lvRange[2]) then
            cfg = v
            break
        end
    end
    -- watch
    CSAPI.SetAngle(watchRot, 0, 0, -60)
    m_watchAnim.time = cfg.rollSpeed
    m_watchAnim:ToPlay()
    -- combo 
    comboNum = 0
    CSAPI.SetText(txtCombo, comboNum .. "")
    -- bottom 
    sCur = 0
    sMax = cfg.processScore
    m_slider.value = sCur / sMax
    -- time
    timer1 = cfg.timeLen
    SetTimeimg2(timer1)
    isDowmTime = true
end

-- 结束方式：时间到；满分
function SetResult()
    CSAPI.PlayBGM(MatrixBGM.PhyRoom)

    isSuccess = sCur >= sMax
    SetStateImg(isSuccess and "img_17_02" or "img_17_03")

    timer1 = 2
    isDowmTime = true
end

-- 内心独白
function SetHeartTalk()
    CSAPI.SetGOActive(top, false)

    -- talk 
    -- 356  528
    CSAPI.SetAnchor(txtTalkBg, 0, -528, 0)
    local cfgFavour = Cfgs.CfgCardRoleFavour:GetByID(data:GetID())
    local str = cfgFavour.favourScript3
    if (isSuccess) then
        local curIndex, openIndex = data:GetHeartIndex() -- 当前已播放内心独白的最高阶段
        if (curIndex < openIndex) then
            curIndex = curIndex + 1
            str = cfgFavour["heartScripts" .. curIndex]
        else
            str = cfgFavour.favourScript4
        end
        sleep_ix = curIndex
    end
    CSAPI.SetText(txtTalk, str)
    CSAPI.SetGOActive(talkBg, true)
    bgLimitTime = Time.time + 2
end

-- state的图片
function SetStateImg(imgName)
    CSAPI.SetGOActive(timeMask, true)
    CSAPI.SetGOActive(timeObj, false)
    CSAPI.SetGOActive(imgState, true)
    CSAPI.LoadImg(imgState, "UIs/Favour/" .. imgName .. ".png", true, nil, true)
end

-- 开始倒计时（向上取整）
function SetTimeimg1(_num)
    local num = math.ceil(_num)
    num = num > 3 and 3 or num
    num = num < 1 and 1 or num
    CSAPI.LoadImg(imgTime1, "UIs/Favour/img_16_0" .. (4 - num) .. ".png", true, nil, true)
end

-- 玩过程倒计时（向下取整）
function SetTimeimg2(_num)
    local num = math.ceil(_num)
    num = num < 0 and 0 or num
    -- 十位数
    local num1 = math.floor(num / 10)
    CSAPI.SetGOActive(imgTime2, num1 ~= 0)
    if (num1 ~= 0) then
        CSAPI.LoadImg(imgTime2, "UIs/Favour/img_23_0" .. num1 .. ".png", true, nil, true)
    end
    -- 个位数
    local num2 = math.floor(num - num1 * 10)
    CSAPI.LoadImg(imgTime3, "UIs/Favour/img_23_0" .. num2 .. ".png", true, nil, true)
end

-- 好感度提升
function OpenSuccesPanel(proto)
    if (proto.id == data:GetID() and (data:GetLv() ~= oldLv or data:GetExp() ~= oldExp)) then
        CSAPI.OpenView(DormGift2, {data, oldLv, oldExp})
    end
end
----------------------------------------------------------------------------------------------

function OnClickStart()
    ChangeStage(2)
end

function OnClickTipsMask()
    CSAPI.SetGOActive(tipsMask, false)
end

-- 点击
function OnClickPlayMask()
    if (stage == 3 and isDowmTime) then
        local curAngleZ = CSAPI.csGetAngle(watchAnim)[2]
        local isL = true
        if (curAngleZ > 60) then
            isL = false
        end
        local difValue = 0
        if (isL) then
            difValue = math.abs(curAngleZ - 15)
        else
            difValue = math.abs(curAngleZ - 105)
        end
        difValue = difValue > circleScale and circleScale or difValue
        -- 分数
        local socre, index = 0, 0
        local contactRatio = difValue / circleScale -- 重合度(0:百分百重合  1：完全不重合)
        if (contactRatio < 0.05) then
            socre = cfg.perfectScore
            index = 1
            CSAPI.PlayCounselingRoomSound("Perfect")
        elseif (contactRatio < 0.4) then
            socre = cfg.greatScore
            index = 2
            CSAPI.PlayCounselingRoomSound("Great")
        elseif (contactRatio < 0.7) then
            socre = cfg.goodScore
            index = 3
            CSAPI.PlayCounselingRoomSound("Good")
        else
            socre = cfg.missScore
            index = 4
            CSAPI.PlayCounselingRoomSound("Miss")
        end
        sCur = sCur + socre
        m_slider.value = sCur <= 0 and 0 or sCur / sMax
        -- combo 
        if (socre > 0) then
            comboNum = comboNum + 1
        else
            comboNum = 0
        end
        CSAPI.SetText(txtCombo, comboNum .. "")
        -- img
        local imgGo = iconR2
        if (isL) then
            imgGo = iconL2
        end
        CSAPI.SetGOActive(imgGo, false)
        CSAPI.LoadImg(imgGo, "UIs/Favour/img_27_0" .. index .. ".png", true, nil, true)
        CSAPI.SetGOActive(imgGo, true)
        if (sCur >= sMax) then
            m_watchAnim:SetRun(false)
            ChangeStage(4)
        end
    end
end

-- 停止摆动
function OnClickStop()
    if (stage == 3) then
        m_watchAnim:SetRun(false)
        SetStateImg("img_18_01")
        isDowmTime = false
    end
end

--
function OnClickTimeMask()
    -- 恢复摆动
    if (stage == 3) then
        m_watchAnim:SetRun(true)
        CSAPI.SetGOActive(timeMask, false)
        isDowmTime = true
    end
end

function OnClickBg()
    if (stage == 5) then
        -- 成功
        if (isSuccess) then
            local oldSleep_ix = data:GetHeartIndex()
            if (not data:IsMax() or oldSleep_ix ~= sleep_ix) then
                oldLv = data:GetData()
                oldExp = data:GetExp()
                BuildingProto:PhySleep(data:GetID(), sleep_ix)
            end
        end
        CSAPI.SetGOActive(top, true)
        CSAPI.SetAnchor(txtTalkBg, 0, -356, 0)
        ChangeStage(1)
    end
end
