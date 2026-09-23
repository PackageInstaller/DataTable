local data = nil
local isLeft= false
local time = 0
local showTime = 0
local showTimer = 0
local textTimeSpeed= 0.2
local textAnimTime = 0.2
local dotStr = {".","..","..."}
local dotIndex = 1
local isStopShow =false

function Awake()
    eventMgr = ViewEvent.New()
end

function SetFinishCB(_cb)
    cb = _cb
end

function OnEnable()
    -- isStopShow = false
end

function OnDisable()
    isStopShow = true
end

function Update()
    if isStopShow then
        return
    end
    if showTime > 0  then
        textAnimTime = textAnimTime - Time.deltaTime
        if textAnimTime <= 0 then
            textAnimTime = textTimeSpeed
            CSAPI.SetText(txtDesc1,dotStr[dotIndex])
            dotIndex = dotIndex == #dotStr and 1 or dotIndex + 1
        end
        if showTimer <= Time.time then
            showTimer = Time.time + 1
            showTime = time - TimeUtil:GetTime()
            if showTime <= 0 then
                data:SetIsShow(true)
                CSAPI.SetText(txtDesc1,data:GetDesc())
                ShowFinish()
            end
        end
    end
end

function Refresh(_data)
    data = _data
    if data then
        isLeft = data:GetIcon() ~= ""
        SetDesc()
    end
end

function SetDesc()
    CSAPI.SetGOActive(left, isLeft)
    CSAPI.SetGOActive(right, not isLeft)
    if isLeft then --左边
        if data:IsShow() then
            CSAPI.SetText(txtDesc1,data:GetDesc())
        else
            CSAPI.SetText(txtDesc1,"")
        end
    else --右边
        CSAPI.SetText(txtDesc2, data:GetDesc())
    end
end

function ShowChat()
    if isLeft and not data:IsShow() then
        time = TimeUtil:GetTime() + data:GetTalkTime()
        showTime = time - TimeUtil:GetTime()
        textAnimTime = textTimeSpeed
    else
        ShowFinish()
    end
    isStopShow = false
end

function ShowFinish()
    if cb then
        cb()
    end
end
