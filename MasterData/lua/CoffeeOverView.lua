function OnOpen()
    LanguageMgr:SetText(txtScore, 78005, data[1].score)
end

function OnClickMask()
    OperateActiveProto:GetMaidCoffeeReward(data[3], data[1])
    view:Close()
    data[2]()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    OnClickMask()
end
