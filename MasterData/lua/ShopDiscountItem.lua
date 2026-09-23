-- 降价物体
function Refresh(comm)
    if comm == nil or (comm and comm:IsOver()) then
        CSAPI.SetGOActive(root, false);
        do
            return
        end
    end
    CSAPI.SetSwapleftandright(pnIcon1,1)
    local orgCosts = comm:GetOrgCosts();
    local orgNum = orgCosts ~= nil and #orgCosts or 0;
    CSAPI.SetGOActive(root,orgNum>0);
    if orgNum<=0 then
        do return end
    end
    CSAPI.SetGOActive(node1, orgNum > 0);
    CSAPI.SetGOActive(node2, orgNum > 1);
    if comm:HasOtherPrice(ShopPriceKey.jCosts1) ~= nil and orgCosts ~= nil then
        CSAPI.SetGOActive(discountInfo, orgNum > 0);
        local timeTips = comm:GetOrgEndBuyTips()
        CSAPI.SetGOActive(limitTime, timeTips ~= nil)
        if timeTips then
            CSAPI.SetText(txtTime, timeTips);
        end
        for i, v in ipairs(orgCosts) do
            CSAPI.SetText(this["txt_dPrice" .. i], tostring(v[2]));
            if v[1] ~= -1 then
                CSAPI.SetGOActive(this["dMNode" .. i], true);
                CSAPI.SetGOActive(this["pnIcon" .. i], false);
                local cfg = Cfgs.ItemInfo:GetByID(v[1], true);
                if cfg and cfg.icon then
                    ResUtil.IconGoods:Load(this["dMIcon" .. i], cfg.icon .. "_1");
                else
                    LogError("道具商店：读取物品的价格Icon出错！Cfg:" .. tostring(cfg));
                end
            else
                CSAPI.SetText(this["pnIcon" .. i], comm:GetCurrencySymbols(true));
                CSAPI.SetGOActive(this["dMNode" .. i], false);
                CSAPI.SetGOActive(this["pnIcon" .. i], true);
            end
        end
    else
        -- CSAPI.SetGOActive(root, orgNum > 0);
        -- CSAPI.SetGOActive(txt_dPrice1, orgNum > 0);
        if orgCosts ~= nil then
            CSAPI.SetText(txt_dPrice1, tostring(orgCosts[1][2]));
            if orgCosts[1][1] ~= -1 then
                CSAPI.SetGOActive(dMNode1, true);
                CSAPI.SetGOActive(pnIcon1, false);
                local cfg = Cfgs.ItemInfo:GetByID(orgCosts[1][1], true);
                if cfg and cfg.icon then
                    ResUtil.IconGoods:Load(dMIcon1, cfg.icon .. "_1");
                else
                    LogError("道具商店：读取物品的价格Icon出错！Cfg:" .. tostring(cfg));
                end
            else
                CSAPI.SetGOActive(dMIcon1, false);
                CSAPI.SetText(pnIcon1, comm:GetCurrencySymbols(true));
                CSAPI.SetGOActive(pnIcon1, true);
            end
        end
    end
end
