local data = nil
local pageData = nil
local item = nil
local isFinish = false
local iconItem = nil

function SetIndex(idx)
    index = idx
end

function Refresh(_data, _elseData)
    data = _data
    pageData = _elseData
    if data then
        SetName()
        SetPrice()
        SetIcon()
        SetCount()
        SetLimit()
        SetLock()
        SetFinish()
    end
end

function SetName()
    CSAPI.SetText(txtName, data:GetName())
end

function SetPrice()
    local costs = {};
    if data:HasOtherPrice(ShopPriceKey.jCosts1) then
        if data:GetRealPrice()[1].id == -1 then
            costs = {data:GetRealPrice(ShopPriceKey.jCosts1)[1], data:GetRealPrice()[1]}
        else
            costs = {data:GetRealPrice()[1], data:GetRealPrice(ShopPriceKey.jCosts1)[1]};
        end
    else
        costs = data:GetRealPrice();
    end
    CSAPI.SetGOActive(priceObj1, #costs < 2)
    CSAPI.SetGOActive(priceObj2, #costs > 1)
    ShopCommFunc.InitPriceItem(data,priceNode,priceItem,"ShopComm/ShopPriceItem6",{m1Color = #costs > 1 and "2D8180" or "ffffff"})
    -- if #costs == 1 then
    --     local tips = "";
    --     if costs[1].id == -1 then
    --         tips = data:GetCurrencySymbols();
    --     end
    --     ShopCommFunc.SetPriceIcon(icon2, costs[1]);
    --     CSAPI.SetText(txtPrice, tips .. tostring(costs[1].num));
    -- else
    --     ShopCommFunc.SetPriceIcon(icon3, costs[2]);
    --     CSAPI.SetText(txtPrice1, tostring(costs[1].num));
    --     CSAPI.SetText(txtPrice2, data:GetCurrencySymbols() .. "")
    --     CSAPI.SetText(txtPrice3, tostring(costs[2].num));
    --     local SDKdisplayPrice = data:GetSDKdisplayPrice();
    --     if CSAPI.IsADV() then
    --         if SDKdisplayPrice ~= nil then
    --             CSAPI.SetText(txtPrice3, tostring(SDKdisplayPrice));
    --         end
    --     end
    -- end
end

function SetIcon()
    if iconItem == nil then
        ResUtil:CreateUIGOAsync("ShopComm/CommodityIcon", iconParent1, function(go)
            iconItem = ComUtil.GetLuaTable(go)
            iconItem.Refresh(data, pageData:GetCommodityType())
        end);
    else
        iconItem.Refresh(data, pageData:GetCommodityType())
    end
end

function SetCount()
    local getList = data:GetCommodityList();
    local num = getList and getList[1].num or 0;
    local str = LanguageMgr:GetByID(18008) .. num
    CSAPI.SetText(txtNum, str)
end

function SetLimit()
    local s1, s2, s3 = data:GetResetTips();
    CSAPI.SetText(txtLimit, s2 .. s3);
    if data:GetType() ~= 12 then
        CSAPI.SetGOActive(limitTag, data:IsLimitTime());
    end
    CSAPI.SetText(txtLimitTag, data:GetEndBuyTips() or "");
end

function SetLock()
    isLock = not data:GetBuyLimit();
    CSAPI.SetGOActive(lockObj, isLock)
end

function SetFinish()
    isFinish = not isLock and data:IsOver()
    if not isFinish then
        if #data:GetCommodityList() < 2 then
            local info = data:GetCommodityList()[1]
            if info.data:GetType() == ITEM_TYPE.PANEL_IMG then
                if BagMgr:GetCount(info.cid) > 0 then
                    isFinish = true
                end
            end
        end
        -- local cur,max =0,0
        -- for k, v in ipairs(data:GetCommodityList()) do
        --     max = max + 1
        --     if v.data:GetType() == ITEM_TYPE.PANEL_IMG then
        --         if BagMgr:GetCount(v.cid) > 0 then
        --             cur = cur + 1
        --         end
        --     end
        -- end
        -- if cur >= max then
        --     isFinish = true
        -- end
    end
    CSAPI.SetGOActive(finishObj, isFinish)
end

-- 点击商品
function OnClick()
    if isFinish then
        return
    end
    if isLock then
        Tips.ShowTips(data:GetBuyLimitDesc())
        return
    end
    ShopCommFunc.OpenPayView(data);
end
