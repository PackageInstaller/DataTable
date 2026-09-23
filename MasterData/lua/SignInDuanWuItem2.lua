local data = nil
local items = {}

function Refresh(_data)
    data = _data
    if data then
        SetDay()
        SetRewards()
    end
end

function SetDay()
    CSAPI.SetText(txtDay,data:GetIndex() .. "")
end

function SetRewards()
    local rewards = data:GetRewards()   
    items = items or {}
	ItemUtil.AddItems("SignInContinue13/SignInDuanWuItem",items,rewards,grid,nil,1,{isGet = data:CheckIsDone()})
end