-- 首充的item
function Refresh(_reward)
    reward = _reward

    item = BagMgr:GetFakeData(reward[1], reward[2])
    -- icon 
    ResUtil.IconGoods:Load(icon, item:GetIcon().."_3")
    -- num
    CSAPI.SetText(txtNum, reward[2].."")
    -- name 
    CSAPI.SetText(txtName, item:GetName())
end

function OnClick()
    GridRewardGridFunc({
        data = item
    })
end
