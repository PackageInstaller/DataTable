local cfg = nil
local num = 0
local items = nil
local isGet = false
local isFinish = false
local isLock = false

function SetIndex(idx)
    index = idx
end

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    cfg = _data
    if cfg then
        local curPro = VirCatMgr:GetStagePro()
        isFinish = curPro >= cfg.rate
        isGet = VirCatMgr:IsRewardGet(cfg.index)
        isLock = not isFinish and not isGet
        SetItems()
        SetState()
    end
end

function SetItems()
    items = items or {}
    GridAddRewards(items, cfg.rateReward, itemParent, 0.5, 1)
end

function SetState()
    CSAPI.SetGOActive(get, isGet)
    CSAPI.SetGOActive(finish, isFinish and not isGet)
    CSAPI.SetGOActive(lock, isLock)
end

function OnClick()
    if cb then
        cb(this)
    end
end
