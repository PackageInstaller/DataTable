-- 光环强化界面
local attrItems = {};
local attrEffItems = {};
local costItems = {};
local eventMgr = nil;
local data = nil;
local curHalo = nil;
local nextHaloInfo = nil;
local bar1 = nil;
local bar2 = nil;
local curAddExp = 0;
local nextLv = 0;
local costPriceInfo = nil;
local curLessExp = 0; -- 当前剩余EXP
local curStuffs = {};
local btnCleanClicker = nil;
local btnOkClicker = nil;

function Awake()
    bar1 = ComUtil.GetCom(slider1, "Slider");
    bar2 = ComUtil.GetCom(slider2, "Slider");
    eventMgr = ViewEvent.New();
end

function OnEnable()
    InitListener();
end

function InitListener()
    eventMgr:AddListener(EventType.Bag_Update,OnBagUpdate)
end

function OnDisable()
    if eventMgr then
        eventMgr:ClearListener();
    end
end

-- _d:cardData
function Show(_d)
    data = _d;
    curHalo = data:GetHaloInfo();
    CleanCache();
    CSAPI.SetGOActive(gameObject, true);
    Refresh(true);
end

function Hide()
    CleanCache();
    CSAPI.SetGOActive(gameObject, false);
end

function CleanCache()
    curAddExp = 0;
    nextHaloInfo = nil;
    nextLv = 0;
    costPriceInfo = nil;
    curLessExp = 0
    curStuffs = {};
end

function OnBagUpdate()
    Refresh();
end

function Refresh(isClean)
    if isClean then
        CleanCache()
    end
    if curHalo then
        local isMaxLv = curHalo:IsMax();
        local lv = curHalo:GetLv();
        -- 刷新升级中的信息
        nextHaloInfo, nextLv = CountNextLv();
        CSAPI.SetGOActive(preObj, not isMaxLv);
        CSAPI.SetGOActive(lvObj, isMaxLv);
        CSAPI.SetGOActive(barNode, not isMaxLv);
        CSAPI.SetGOActive(maxObj, isMaxLv);
        if curHalo:IsMax() then
            CSAPI.SetText(txtLv, tostring(curHalo:GetMaxLv()))
        else
            CSAPI.SetText(txtPreLv1, tostring(lv))
            CSAPI.SetText(txtPreLv2,
                nextHaloInfo:GetLv() > nextLv and tostring(nextHaloInfo:GetLv()) or tostring(nextLv))
            SetCost(isClean);
        end
        local isShowBase=nextHaloInfo:GetUpdateShow();
        -- 默认下一级
        if isShowBase then
            InitAttrs(nextHaloInfo);
        else
            InitEffs(nextHaloInfo);
        end
        CSAPI.SetGOActive(attrParent, isShowBase);
        CSAPI.SetGOActive(attrParent2, not isShowBase);
    end
end

function CountNextLv()
    if curHalo == nil then
        return nil
    end
    local lv = curHalo:GetLv();
    local _nextLv = lv + 1 >= curHalo:GetMaxLv() and curHalo:GetMaxLv() or lv + 1;
    -- 刷新升级中的信息
    local preInfo = HaloData.New();
    local d2 = table.copy(curHalo:GetData());
    d2.level = _nextLv;
    preInfo:SetData(d2);
    return preInfo, _nextLv;
end

function SetCost(isCleanGrid)
    -- 初始化经验物体
    local list = {};
    if curHalo ~= nil then
        list = curHalo:GetLevelUpItems();
        costPriceInfo = curHalo:GetLevelUpCost();
    end
    ItemUtil.AddItems("Grid/HaloSelectItem", costItems, list, costLayout, nil, 1, isCleanGrid)
    if costPriceInfo and next(costPriceInfo) then
        CSAPI.SetGOActive(priceNode, true);
        local v = costPriceInfo[1];
        local goods = BagMgr:GetFakeData(v[1]);
        goods:GetIconLoader():Load(mIcon, goods:GetIcon() .. "_1");
        CSAPI.SetText(txt_price, tostring(v[2]));
        CSAPI.SetTextColorByCode(txt_price, goods:GetCount() >= v[2] and "FFFFFF" or "E38089");
    else
        CSAPI.SetGOActive(priceNode, false);
    end
end

function InitAttrs(haloInfo)
    -- 生成属性
    local attrDatas = HaloUtil.CountHaloAddtion(haloInfo, data, "c3c3c8", "00ffbf", "7f7f84", "7f7f84");
    ItemUtil.AddItems("AttributeNew2/HaloAttributeItem4", attrItems, attrDatas, attrParent)
end

function InitEffs(haloInfo)
    local effect = haloInfo:GetSpecialCfg();
    local cfg = haloInfo:GetCfg().infos[haloInfo:GetLv()];
    local list = {};
    if effect then
        local sDesc = string.format("<color=#ff8746>%s</color>", LanguageMgr:GetByID(100041))
        for k, v in ipairs(effect.use_types) do
            local eCfg = Cfgs.CfgCardPropertyEnum:GetByID(v);
            if eCfg then
                local _num = effect[eCfg.sFieldName] or 0
                table.insert(list, {
                    cfg = eCfg,
                    name = eCfg.sName,
                    val = HaloUtil.GetPropertyValueStr(eCfg.sFieldName, _num),
                    color1 = "7f7f84",
                    addColor = "00ffbf",
                    sDesc = sDesc,
                    color3 = "ff8746"
                });
            end
        end
    end
    if cfg and cfg.coorId and cfg.index > 1 then
        table.insert(list, {
            desc = LanguageMgr:GetByID(100036),
            color2 = "00ffbf"
        });
    end
    ItemUtil.AddItems("Halo/HaloEquipItem2", attrEffItems, list, attrParent2)
end


-- 判断当前是否可以继续升级
function CanStrength(halo)
    if halo then
        local curMaxLv, desc = halo:GetUnlockMaxLv();
        if halo:GetLv() >= curMaxLv then
            if (curMaxLv - nextHaloInfo:GetLv()) >= 1 then -- 当前等级离当前上限等级有多个差距
                return true
            elseif curMaxLv < halo:GetMaxLv() then
                if desc ~= nil then
                    Tips.ShowTips(LanguageMgr:GetByID(100040, desc));
                end
                return false;
            else -- 到达当前上限
                return false;
            end
        end
    end
    return true
end

function OnClickClean()
    Refresh(true)
end

function OnClickStrength()
    if CanStrength(curHalo) ~= true then
        do
            return
        end
    end
    local upItems = curHalo:GetLevelUpItems();
    local goodsName=nil;
    if upItems~=nil then
        for i, v in ipairs(upItems) do
            if v.goods:GetCount()<v.num then
                goodsName=v.goods:GetName();
                Tips.ShowTips(LanguageMgr:GetTips(8014, goodsName));
                do return end;
            end
        end
    end
    if costPriceInfo ~= nil then
        for k, v in ipairs(costPriceInfo) do
            local goods = BagMgr:GetFakeData(v[1]);
            if goods and goods:GetCount() < v[2] then
                Tips.ShowTips(LanguageMgr:GetTips(8014, goods:GetName()));
                do
                    return
                end
            end
        end
    end
    if data and curHalo then
        HaloProto:HaloUp(data:GetID(), curHalo:GetID())
    end
end
