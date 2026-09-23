local timer = nil

function OnOpen()
    timer = Time.time + 2
    local cur = data[1].score or 0
    CSAPI.SetText(txtScore, cur .. "")
    -- 
    local maxScore = MerryChristmasMgr:GetMaxScore() or 0
    CSAPI.SetGOActive(new, cur > maxScore)
end

function OnClickMask()
    if (Time.time < timer) then
        return
    end
    OperateActiveProto:GetChristmasGiftReward(data[1], function()
        view:Close()
        data[2]()
    end)
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    OnClickMask()
end
