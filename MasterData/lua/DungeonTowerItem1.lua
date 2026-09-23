local cfg = nil
local index = 0
local cb = nil
local isNotOpenTime = false -- 开放时间
local max = 0
local cur = 0
local canvasGroup = nil
local isSelect = false
local isFinish = false
local isGet = false

--anim
local fade = nil
local move = nil

function Awake()
    canvasGroup = ComUtil.GetCom(node,"CanvasGroup")
    fade = ComUtil.GetCom(action,"ActionFade")
    move = ComUtil.GetCom(action,"ActionMoveByCurve")

    CSAPI.SetGOActive(selectObj, false)
    CSAPI.SetGOActive(unSelObj, true)
    CSAPI.SetGOActive(finishObj,false)
end

function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    data = _data
    if data then
        isNotOpenTime = false
        cur,max = TowerMgr:GetTowerMissionNum(data:GetID())
        isFinish = cur >= max
        isGet = TowerMgr:IsTowerGet(data:GetID())
        SetBG()
        SetIcon()
        SetTitle()
        SetDesc()
        SetLock()
        SetNum()
        SetFinish()
        SetRed()
    end
end

-- 背景
function SetBG()
    local cfg = data:GetCfg()
    if cfg.bg then
        ResUtil:LoadBigImg(bg, "UIs/SectionImg/tBg/" .. cfg.bg)
    end
end

function SetIcon()
    CSAPI.LoadImg(icon, "UIs/DungeonTower/icon" .. index .. ".png", true, nil, true)
end

-- 上标题
function SetTitle()
    CSAPI.SetText(txtTitle1, data:GetName() or "")
    -- CSAPI.SetText(txtTitle2, data:GetEName() or "")
end

-- 中间标题
function SetDesc()
    local cfgTower = data:GetDungeonCfgs()
    local isTime = false
    local offsetTime = 0
    if cfgTower then
        for k, v in pairs(cfgTower) do
            if v.nStartTime or v.nEndTime then
                isTime = true
                local sTime = GCalHelp:GetTimeStampBySplit(v.nStartTime)
                local eTime = GCalHelp:GetTimeStampBySplit(v.nEndTime)
                if TimeUtil:GetTime() >= sTime and TimeUtil:GetTime() < eTime then
                    offsetTime = (offsetTime == 0 or offsetTime > eTime - TimeUtil:GetTime()) and eTime - TimeUtil:GetTime() or offsetTime
                end
            end
        end
    end
    CSAPI.SetGOActive(timeImg, isTime and offsetTime > 0)
    if isTime then
        if offsetTime > 0 then
            local timeStr = TimeUtil:GetTimeTab(offsetTime)
            LanguageMgr:SetText(txtDesc, 32069, timeStr[1])
        else
            isNotOpenTime = true
            CSAPI.SetText(txtDesc, "")
        end
    else
        LanguageMgr:SetText(txtDesc, 39004)
    end

    local color = isTime and {255, 193, 70, 255} or {195, 195, 200, 255}
    CSAPI.SetTextColor(txtDesc, color[1], color[2], color[3], color[4])
end

-- 锁状态
function SetLock()
    local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.section, data:GetID())
    local isLock = not isOpen
    CSAPI.SetGOActive(lockObj, isLock or isNotOpenTime)
    if isLock or isNotOpenTime then
        canvasGroup.alpha = 0.3
        CSAPI.SetGOActive(lock1, isLock)
        CSAPI.SetGOActive(lock2, isNotOpenTime)
        CSAPI.SetGOActive(txtLock2, isLock)
        if isLock then
            local cfg = data:GetCfg()
            str = cfg.lock_desc or ""
            LanguageMgr:SetText(txtLock1, 15080)
            CSAPI.SetText(txtLock2, str)
        elseif isNotOpenTime then
            LanguageMgr:SetText(txtLock1, 36011)
        end
    else
        canvasGroup.alpha = 1
    end
end

function SetNum()
    CSAPI.SetText(txtCur,cur.."")
    CSAPI.SetText(txtMax,"/" .. max)
end

function SetFinish()
    CSAPI.SetGOActive(finishObj,isFinish)
    CSAPI.SetGOActive(btnGet,isFinish and not isGet)
end

function SetRed()
    local isRed = false
    local cfgs = Cfgs.MainLine:GetGroup(data:GetID())
    if cfgs then
        for _, cfg in pairs(cfgs) do
            local missionDatas = MissionMgr:GetActivityDatas(eTaskType.TmpDupTower, cfg.missionID)
            if missionDatas then
                for _, missData in ipairs(missionDatas) do
                    if missData:IsFinish() and not missData:IsGet() then
                        isRed = true
                        break
                    end
                end
            end
        end
    end
    UIUtil:SetRedPoint(redParent,isRed and not isSelect)
end

-- 选中
function SetSelect(_isSelect)
    isSelect = _isSelect
    CSAPI.SetGOActive(selectObj, isSelect)
    CSAPI.SetGOActive(unSelObj,not isSelect)
    SetRed()
end

function GetIndex()
    return index
end

function GetCfgDungeons()
    return Cfgs.MainLine:GetGroup(data:GetID())
end

function OnClick()   
    local isLock = not (data and data:GetOpen()) or false
    if (isLock or isNotOpenTime) then
        return
    end
    if (cb) then
        cb(this)
    end
end

function OnClickGet()
    PlayerProto:GetSectionTaskReward({data:GetID()},OnRedCheckCallBack)
end

function OnRedCheckCallBack()
    DungeonMgr:CheckRedPointData()
end

function PlayAnim()
    fade:Play(0,1,500,(index - 1) * 100)
    move.delay = (index - 1) * 100
    move:Play()
end

function PlayFade(isFade)
    if isFade then
        fade:Play(1,0,200,0)
    else
        fade:Play(0,1,200,0)
    end
end