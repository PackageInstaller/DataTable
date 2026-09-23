local cur,max =0,0
local lastLock = false
local isLock = false

function Refresh(_data)
    cur,max = RogueMapMgr:GetFightLv(),RogueMapMgr:GetFightLv()
    lastLock,isLock = RogueMapMgr:IsLockLv(), RogueMapMgr:IsLockLv()
    SetLevel()
    SetLock()
end

function SetLevel()
    CSAPI.SetText(txtLv,cur .. "")
end

function SetLock()
    CSAPI.SetGOActive(open1, isLock)
    CSAPI.SetGOActive(open2,not isLock)
    CSAPI.SetGOActive(lock2, isLock)
    CSAPI.SetGOActive(lock1,not isLock)
end


function OnClickLevel(go)
    if go.name == "btnLv1" then
        cur = cur - 1 < 1 and 1 or cur - 1
    elseif go.name == "btnLv2" then
        cur = cur + 1
        if cur > max then
            cur = max
            LanguageMgr:ShowTips(50012)
        end
    end
    SetLevel()
end

function OnClickLock(go)
    isLock = go.name == "btnLock1"
    SetLock()
end

function OnClickSure()
    local isChange = (cur ~= max) or (isLock ~= lastLock)
    if not isChange then
        OnClickClose()
        return
    end
    if cur ~= max then
        local dialogData = {}
        dialogData.content = LanguageMgr:GetByID(76070,cur)
        dialogData.okCallBack = function()
            FightProto:RogueMapLevelSet(isLock,cur,OnClickClose)
        end
        CSAPI.OpenView("Dialog",dialogData)
    else
        FightProto:RogueMapLevelSet(isLock,cur,OnClickClose)
    end
end

function OnClickClose()
    if this.OnViewClose then
        this.OnViewClose(this)
    end
end