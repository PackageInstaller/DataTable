local SDKdisplayPrice = nil;
-- 直接通过商品进行赋值 realPrice不为空时使用该值显示,有特殊判定时使用该方法
function Refresh(priceInfo,sdkPInfo)
    if priceInfo ~= nil then
        local rmbIcon=LanguageMgr:GetByID(18013);
        if (sdkPInfo) then
            rmbIcon=sdkPInfo.symbols;
        end
        CSAPI.SetText(pnIcon1, rmbIcon);
        local costs = priceInfo
        local isOver = false;
        if costs == nil or (#costs == 1 and costs[1].num <= 0) or isOver then
            CSAPI.SetGOActive(p1, false);
            CSAPI.SetGOActive(txt_free, true);
        else
            CSAPI.SetGOActive(p1, true);
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
        end
    end
end

