local cfg = nil
local num = 0
local items = {}

function Refresh(_cfg, _num)
    cfg = _cfg
    num = _num

    SetDay()
    SetRewards()
end

function SetDay()
    CSAPI.SetText(txtDay, cfg.id .. "")
end

function SetRewards()
    local isGet = num >= cfg.id
    items = items or {}
    ItemUtil.AddItems("Common/SignInNRewardItem2", items, cfg.rewards or {}, grid, nil, 1, isGet)
end
