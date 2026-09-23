local item = nil
local reward = nil
local frames = GridFrame

function Refresh(_rewards, _isGet)
    CSAPI.SetGOActive(getObj, _isGet)
    local reward = {
        type = _rewards[3] or 2,
        num = _rewards[2],
        id = _rewards[1]
    }
    if reward then
        if (not item) then
            local go = ResUtil:CreateUIGO("Grid/GridSignInContinueItem", itemParent.transform)
            item = ComUtil.GetLuaTable(go)
        end
        local itemData = GridUtil.RandRewardConvertToGridObjectData(reward)
        CSAPI.SetText(txtCount, reward.num .. "" or "0")
        item.Refresh(itemData)
        item.SetClickCB(GridClickFunc.OpenInfoSmiple)
        ResUtil.IconGoods:Load(icon, GridFrame[itemData:GetQuality()])
    end
end
