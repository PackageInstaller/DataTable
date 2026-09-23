local num, min, max = 1, 1, 1

function OnInit()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Exercise_End, function()
        view:Close()
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    -- 已购买次数 
    buyCount, buyMax = ExerciseMgr:GetCanBuy()
    -- 当前次数
    cnt, maxCnt = ExerciseMgr:GetJoinCnt()
    -- 当前可最大购买次数： 不能超过购买上限，不能超过当前上限
    local _num1 = buyMax - buyCount
    local _num2 = maxCnt - cnt
    max = _num1 > _num2 and _num2 or _num1
    -- 可购买下限 
    min = buyCount >= buyMax and 0 or 1
    num = min

    RefreshPanel()
end

function RefreshPanel()
    need = g_ArmyAttactBuyCost[2] * num
    -- 持有
    local id = g_ArmyAttactBuyCost[1]
    count = BagMgr:GetCount(id)
    CSAPI.SetText(txt_hasNum, count .. "")
    ResUtil.IconGoods:Load(coinIcon, id .. "_1")
    -- 可购买次数 
    local str1 = LanguageMgr:GetByID(33040)
    local had = buyMax - buyCount
    local colorName0 = had <= 0 and "ff7781" or "ffffff"
    local str2 = string.format("<color=#%s>%s</color>/%s", colorName0, had, buyMax)
    CSAPI.SetText(txt_tips, str1 .. "  " .. str2)
    -- 当前 
    CSAPI.SetText(txt_stage1, cnt .. "")
    -- 购买后次数
    CSAPI.SetText(txt_stage2, cnt + num .. "")
    -- 数量
    CSAPI.SetText(txt_num, num .. "")
    -- btn 
    ResUtil.IconGoods:Load(moneyIcon, id .. "_1")
    local colorName1 = count >= need and "000000" or "ff7781"
    StringUtil:SetColorByName(txt_price, need, colorName1)
end

function OnClickMin()
    local _num = 1
    if (buyCount >= buyMax) then
        _num = 0
    end
    if (_num ~= num) then
        num = _num
        RefreshPanel()
    end
end

function OnClickMax()
    if (num == max) then
        LanguageMgr:ShowTips(33006)
        return
    end
    num = max
    RefreshPanel()
end

function OnClickAdd()
    if (num >= max) then
        LanguageMgr:ShowTips(33006)
        return
    end
    num = num + 1
    RefreshPanel()
end

function OnClickRemove()
    if (num <= min) then
        return
    end
    num = num - 1
    RefreshPanel()
end

function OnClickPay()
    if (need <= count) then
        ArmyProto:BuyAttackCnt(num)
        view:Close()
    end
end

function OnClickMask()
    view:Close()
end
