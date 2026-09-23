-- 皮肤商品子物体
local skinInfo = nil;
local countTime = 0;
local changeInfo = nil;
local needToCheckMove = false
function Awake()
    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txt_name)
end

function Refresh(_data, _elseData)
    this.data = _data;
    this.elseData = _elseData;
    skinInfo = ShopCommFunc.GetSkinInfo(this.data);
    if skinInfo then
        changeInfo = skinInfo:GetChangeInfo();
        local hasMore = changeInfo ~= nil and true or false;
        local showBg1 = true;
        if hasMore ~= true then
            ResUtil.CardIcon:Load(icon, skinInfo:GetCardHead(), true);
        else
            if changeInfo[1].cfg.skinType ~= 5 then -- 形切或者同调
                ResUtil.CardIcon:Load(icon1, skinInfo:GetCardHead(),true);
                ResUtil.CardIcon:Load(icon2, changeInfo[1].cfg.Card_head,true);
                ResUtil.CardIcon:Load(icon3, changeInfo[1].cfg.Card_head,true);
                showBg1 = false
            else
                ResUtil.CardIcon:Load(icon, skinInfo:GetCardHead(), true);
                -- 加载机神icon
                showBg1 = true
            end
        end
        CSAPI.SetGOActive(icon, showBg1);
        CSAPI.SetGOActive(iconObj2, not showBg1);
        SetName(skinInfo:GetRoleName());
        -- 特殊标签
        -- local icons = skinInfo:GetTagIcons() or {};
        -- if icons ~= nil then
        --     for i, v in ipairs(icons) do
        --         CSAPI.SetGOActive(this[("tag" .. i)], true)
        --         ResUtil.Tag:Load(this[("tagIcon" .. i)], v);
        --     end
        -- end
        -- if icons == nil or #icons < 3 then
        --     local index = icons ~= nil and #icons + 1 or 1;
        --     for i = index, 3 do
        --         CSAPI.SetGOActive(this[("tag" .. i)], false)
        --     end
        -- end
        local cfg = skinInfo:GetSetCfg();
        SetTag(skinInfo:GetSkinName());
        SetSIcon(cfg.icon);
    else
        LogError("未找到对应的模型Id:"..tostring(this.data:GetID()));
    end
end

function SetOrgPrice()
    if this.data ~= nil then
        if this.data:IsOver() then
            CSAPI.SetGOActive(discountInfo, false);
            do
                return
            end
        end
        local orgCosts=this.data:GetOrgCostsByCostKey();
        CSAPI.SetGOActive(discountInfo, orgCosts ~= nil);
        if orgCosts ~= nil then
            CSAPI.SetText(txt_discount2, tostring(orgCosts[2]));
            -- 计算倒计时
            local timeTips = this.data:GetOrgEndBuyTips()
            CSAPI.SetGOActive(dsInfo2, timeTips ~= nil)
            if timeTips then
                CSAPI.SetText(txtDSTime, timeTips);
            end
            if orgCosts[1] ~= -1 then
                CSAPI.SetGOActive(dsMoneyIcon, true);
                CSAPI.SetGOActive(txt_dsRmb, false);
                local cfg = Cfgs.ItemInfo:GetByID(orgCosts[1], true);
                if cfg and cfg.icon then
                    ResUtil.IconGoods:Load(dsMoneyIcon, cfg.icon .. "_1");
                else
                    LogError("道具商店：读取物品的价格Icon出错！Cfg:" .. tostring(cfg));
                end
            else
                CSAPI.SetText(txt_dsRmb, this.data:GetCurrencySymbols(true));
                CSAPI.SetGOActive(dsMoneyIcon, false);
                CSAPI.SetGOActive(txt_dsRmb, true);
            end
            -- CSAPI.SetTextColorByCode(txt_price,"FFC146");
            -- CSAPI.SetTextColorByCode(txt_rmb,"FFC146");
            -- CSAPI.SetTextColorByCode(txt_rmbVal,"FFC146");
            -- CSAPI.SetTextColorByCode(txt_price3,"FFC146");
            if #orgCosts == 3 then
                CSAPI.SetTextColorByCode(this["pnIcon" .. orgCosts[3]], "FFC146");
                CSAPI.SetTextColorByCode(this["txt_dPrice" .. orgCosts[3]], "FFC146");
            else
                CSAPI.SetTextColorByCode(pnIcon1, "FFFFFF");
                CSAPI.SetTextColorByCode(pnIcon2, "FFFFFF");
                CSAPI.SetTextColorByCode(txt_dPrice1, "FFFFFF");
                CSAPI.SetTextColorByCode(txt_dPrice2, "FFFFFF");
            end
        else
            CSAPI.SetTextColorByCode(pnIcon1, "FFFFFF");
            CSAPI.SetTextColorByCode(pnIcon2, "FFFFFF");
            CSAPI.SetTextColorByCode(txt_dPrice1, "FFFFFF");
            CSAPI.SetTextColorByCode(txt_dPrice2, "FFFFFF");
        end
    end
end

function SetDiscount(discount)
    CSAPI.SetGOActive(discountObj, discount ~= nil);
    if discount then
        CSAPI.SetText(txt_discount, discount);
    end
    -- local dis=math.floor(discount*10+0.5);
    -- CSAPI.SetGOActive(discountObj,discount~=1);
    -- CSAPI.SetText(txt_discount,string.format(LanguageMgr:GetByID(18074),dis));
end

function Update()
    if (needToCheckMove) then
        luaTextMove:CheckMove(txt_name)
        needToCheckMove = false
    end
end


function SetSIcon(iconName)
    CSAPI.SetGOActive(setIcon, iconName ~= nil);
    if iconName then
        ResUtil.SkinSetIcon:Load(setIcon, iconName .. "_w", true);
    end
end

function SetTag(str)
    CSAPI.SetText(txt_setTag, str or "");
    CSAPI.SetGOActive(txt_setTag, str ~= nil)
end

function SetName(str)
    needToCheckMove = false
    CSAPI.SetText(txt_name, str or "");
    needToCheckMove = true
end

function SetAlpha(val)
    CSAPI.SetGOAlpha(alphaNode, val);
end

function SetClickCB(cb)
    this.cb = cb;
end

function OnClickSelf()
    if this.cb then
        this.cb(this);
    end
end
