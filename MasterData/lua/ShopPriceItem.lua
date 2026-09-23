local SDKdisplayPrice = nil;
-- 直接通过商品进行赋值 realPrice不为空时使用该值显示,有特殊判定时使用该方法
function Refresh(comm, realPrice,_elseData)
    if comm ~= nil then
        local rmbIcon = comm:GetCurrencySymbols();
        SDKdisplayPrice = comm:GetSDKdisplayPrice();
        CSAPI.SetText(pnIcon1, rmbIcon);
        CSAPI.SetText(pnIcon2, rmbIcon);
        CSAPI.SetSwapleftandright(pnIcon1,1)
        CSAPI.SetSwapleftandright(pnIcon2,1)
        local costs = realPrice
        if costs == nil then
            if comm:HasOtherPrice(ShopPriceKey.jCosts1) then
                costs = {comm:GetRealPrice()[1], comm:GetRealPrice(ShopPriceKey.jCosts1)[1]};
            elseif comm:GetType() == CommodityItemType.THEME or comm:GetType() == CommodityItemType.FORNITURE then
                costs = {comm:GetRealPrice()[1], comm:GetRealPrice(ShopPriceKey.jCosts1)[1]};
            else
                costs = comm:GetRealPrice();
            end
        end
        local freeID = 18032
        local isOver = false;
        if comm:GetType() == CommodityItemType.MonthCard and comm:GetSubType() == CommodityItemSubType.MonthCard2 and
            comm:IsOver() then
            isOver = true;
            freeID = 18134
        elseif comm:IsOver() then
            isOver = true;
            freeID = 18012
        end
        if _elseData then
      
        end
        CSAPI.SetTextColorByCode(pnIcon1, (_elseData and _elseData.m1Color) and _elseData.m1Color or "ffffff")
        CSAPI.SetTextColorByCode(dMIcon1, (_elseData and _elseData.m1Color) and _elseData.m1Color or "ffffff")
        CSAPI.SetTextColorByCode(txt_dPrice1, (_elseData and _elseData.m1Color) and _elseData.m1Color or "ffffff")
        CSAPI.SetTextColorByCode(txt_dPrice2, (_elseData and _elseData.m2Color) and _elseData.m2Color or "ffffff")
        CSAPI.SetTextColorByCode(pnIcon2, (_elseData and _elseData.m2Color) and _elseData.m2Color or "ffffff")
        CSAPI.SetTextColorByCode(dMIcon2, (_elseData and _elseData.m2Color) and _elseData.m2Color or "ffffff")
        CSAPI.SetTextColorByCode(txt_free, (_elseData and _elseData.m3Color) and _elseData.m3Color or "ffffff")
        if costs == nil or (#costs == 1 and costs[1].num <= 0) or isOver then
            CSAPI.SetGOActive(p1, false);
            CSAPI.SetGOActive(p2, false);
            CSAPI.SetGOActive(txt_free, true);
            CSAPI.SetText(txt_free, LanguageMgr:GetByID(freeID));
        else
            CSAPI.SetGOActive(p1, true);
            CSAPI.SetGOActive(p2, #costs > 1);
            CSAPI.SetGOActive(txt_free, false);
            local isRmb1 = costs[1].id == -1;
            CSAPI.SetGOActive(dMNode1, not isRmb1)
            CSAPI.SetGOActive(pnIcon1, isRmb1)
            if not isRmb1 then
                ShopCommFunc.SetPriceIcon(dMIcon1, costs[1]);
                CSAPI.SetText(txt_dPrice1, tostring(costs[1].num));
            else
                if CSAPI.IsADV() then
                    CSAPI.SetText(txt_dPrice1, tostring(SDKdisplayPrice or costs[1].num));
                else
                    CSAPI.SetText(txt_dPrice1, tostring(costs[1].num));
                end
            end
            if #costs > 1 then
                local isRmb2 = costs[2].id == -1
                CSAPI.SetGOActive(dMNode2, not isRmb2)
                CSAPI.SetGOActive(pnIcon2, isRmb2)
                if not isRmb2 then
                    ShopCommFunc.SetPriceIcon(dMIcon2, costs[2]);
                    CSAPI.SetText(txt_dPrice2, tostring(costs[2].num));
                else
                    if CSAPI.IsADV() then
                        CSAPI.SetText(txt_dPrice2, tostring(SDKdisplayPrice or costs[1].num));
                    else
                        CSAPI.SetText(txt_dPrice2, tostring(costs[1].num));
                    end
                end
            end
        end
    end
end

