-- 首充的item
function Refresh(_reward)
    reward = _reward

    item = BagMgr:GetFakeData(reward[1], reward[2])
    -- icon 
    ResUtil.IconGoods:Load(icon, item:GetIcon())
    -- desc
    CSAPI.SetText(txtName, reward[4])
end

function OnClick()
    GridRewardGridFunc({
        data = item
    })
end
