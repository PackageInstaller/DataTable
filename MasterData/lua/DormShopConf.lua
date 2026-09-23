-- 单独购买家具
local count = 1
local max = 1

function Awake()
    m_Slider = ComUtil.GetCom(numSlider, "Slider")
    CSAPI.AddSliderCallBack(numSlider, SliderCB)
end

function SliderCB(_num)
    count = _num
    CSAPI.SetText(txtCount, math.ceil(count) .. "")
    SetSpend()
end

function OnOpen()
    id = data
    cfg = Cfgs.CfgFurniture:GetByID(id)
    -- icon
    SetIcon()
    -- comfort
    CSAPI.SetText(txt_comfort, cfg.comfort .. "")
    -- num
    local cur = DormMgr:GetBuyCount(id)
    CSAPI.SetText(txt_hasNum, string.format("%s/%s", cur, cfg.buyNumLimit))
    -- time/new
    SetNewAndTime()
    -- name
    CSAPI.SetText(txtName, cfg.sName)
    -- desc
    CSAPI.SetText(txtDesc, cfg.desc)
    -- spend
    SetSpend()
    -- grid
    local itemCfg = Cfgs.ItemInfo:GetByID(cfg.itemId)
    CSAPI.SetGOActive(imgScale, itemCfg.seizeIcon ~= nil)
    if (itemCfg.seizeIcon) then
        ResUtil.FurnitureSeize:Load(imgScale, itemCfg.seizeIcon)
    end

    max = cfg.buyNumLimit - cur
    m_Slider.maxValue = max

    -- btn
    -- SetBtns()
    SetCount()
end

function SetIcon()
    local iconName = cfg.icon
    CSAPI.SetGOActive(icon, iconName ~= nil);
    if (iconName) then
        ResUtil.Furniture:Load(icon, iconName .. "")
    end
end

function SetNewAndTime()
    local time = nil
    local isNew = false
    if (cfg.theme) then
        local themeCfg = Cfgs.CfgFurnitureTheme:GetByID(cfg.theme)
        new = cfg.new
        if (themeCfg.sEnd) then
            local endTime = TimeUtil:GetTimeStampBySplit(themeCfg.sEnd)--GCalHelp:GetTimeStampBySplit(themeCfg.sEnd)
            local second = endTime - TimeUtil:GetTime()
            second = second <= 0 and 0 or second
            time = second ~= 0 and math.ceil(second / 3600) or 0
        end
        isNew = themeCfg.new
    end
    CSAPI.SetGOActive(txt_Timer, time ~= nil)
    if (time ~= nil) then
        LanguageMgr:SetText(32030, time)
    end
    -- CSAPI.SetGOActive(txtNew, isNew)
end

function SetSpend()
    -- local ids = DormMgr:GetPrice()
    -- local prices = cfg.price or {}
    SetSpendSrt(btn_pay1, priceIcon1, txt_price1, cfg.price_1[1])
    SetSpendSrt(btn_pay2, priceIcon2, txt_price2, cfg.price_2[1])

    local x = cfg.price_2 ~= nil and -245 or 0
    CSAPI.SetAnchor(btn_pay1, x, -260, 0)
end

function SetSpendSrt(go, icon, txt, price)
    CSAPI.SetGOActive(go, price ~= nil)
    if (price) then
        local cfg = Cfgs.ItemInfo:GetByID(price[1])
        ResUtil.IconGoods:Load(icon, cfg.icon .. "_1")
        local num = price[2] * count
        CSAPI.SetText(txt, math.ceil(num) .. "")
    end
end

function SetCount()
    m_Slider.value = count
    CSAPI.SetText(txtCount, math.ceil(count) .. "")
end

-- function SetBtns()
-- 	--count
-- 	CSAPI.SetText(txtCount, count .. "")
-- 	--l
-- 	if(lgroup == nil) then
-- 		lgroup = ComUtil.GetCom(btnL, "CanvasGroup")
-- 	end
-- 	lgroup.alpha = count <= 1 and 0.5 or 1
-- 	--r
-- 	if(rgroup == nil) then
-- 		rgroup = ComUtil.GetCom(btnR, "CanvasGroup")
-- 	end
-- 	rgroup.alpha = count >= max and 0.5 or 1
-- end
function OnClickRemove()
    count = count - 1 > 0 and count - 1 or count
    SetCount()
    SetSpend()
end

function OnClickAdd()
    count = count + 1 > max and max or count + 1
    SetCount()
    SetSpend()
end

function OnClickMax()
    count = max
    SetCount()
    SetSpend()
end

function OnClickPay1()
    local prices = cfg.price_1 or {}
    if (prices[1]) then
        Buy(prices[1],"price_1")
    end
end
function OnClickPay2()
    local prices = cfg.price_2 or {}
    if (prices[1]) then
        Buy(prices[1],"price_2")
    end
end

function Buy(price,str)
    local num = price[2] * count
    local bagNum = BagMgr:GetCount(price[1])
    if (num > bagNum) then
        LanguageMgr:ShowTips(1004)
    else
        local infos = {{
            ["id"] = id,
            num = count
        }}
        DormProto:BuyFurniture(infos, str)
        view:Close()
    end
end

function OnClickMask()
    view:Close()
end
function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    right = nil;
    txtComfort = nil;
    txtNum = nil;
    txtTime = nil;
    grid = nil;
    txtGrid = nil;
    txtName = nil;
    txtDesc = nil;
    txtCount = nil;
    btnL = nil;
    Text = nil;
    btnR = nil;
    Text = nil;
    btnMax = nil;
    Text = nil;
    btnBuy1 = nil;
    txtBuy1 = nil;
    btnBuy2 = nil;
    txtBuy2 = nil;
    view = nil;
end
----#End#----
