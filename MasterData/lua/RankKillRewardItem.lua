local info = nil
local elseData = nil
local key = nil
local items = {}

function Refresh(_data,_elseData)
    info = _data
    elseData = _elseData
    if info then
        SetTitle()
        SetRewards()
    end
end

function SetTitle()
    local curMonth = TimeUtil:GetTimeHMS(TimeUtil:GetTime(),"%m")
    local startDay = elseData and elseData.startDay or 1
    local closeDay = elseData and elseData.closeDay
    local curDay = startDay + (info.day or 0)
    if closeDay and curDay > closeDay then --超过关闭日
        curDay = closeDay
    end
    LanguageMgr:SetText(txtName,70010,curMonth,curDay)
end

function SetRewards()
    if info.mailId then
        local cfgMail = Cfgs.CfgMail:GetByID(info.mailId)
        if cfgMail and cfgMail.rewards then
            ShowReward(cfgMail.rewards)
        end
    end
end

function ShowReward(rewards)
    local gridDatas = GridUtil.GetGridObjectDatas2(rewards)
    items = items or {}
    ItemUtil.AddItems("Rank/RankRewardGrid", items, gridDatas, grid,
    GridClickFunc.OpenInfoSmiple, 1, IsGet())
end

function IsGet()
    if elseData and elseData.damage and info.damage then
        return elseData.damage >= info.damage
    end
    return false
end