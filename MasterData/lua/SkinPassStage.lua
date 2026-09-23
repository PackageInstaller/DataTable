local curData = nil
local curDatas = nil
local btns = {};
local upLv = nil;
local nextLv = nil;
local maxLv = nil;
local curLv = nil;
local layout = nil
local costID = 0
local currPrice = 0

function Awake()
    layout = ComUtil.GetCom(hsv, "UISV");
    layout:Init("UIs/DungeonDetail/DungeonGoodsItem", LayoutCallBack, true, 0.8)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.SkinPass_Update,OnPanelRefresh)
end

function LayoutCallBack(index)
    local item = layout:GetItemLua(index);
    if item then
        item.SetIndex(index)
        item.Refresh(curDatas[index].data,curDatas[index].elseData)
    end
end

function OnPanelRefresh()
    curData = OperationActivityMgr:GetSkinPassData(data.id)
    RefreshPanel()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    -- 初始化等级
    if data and data.id then
        curData = OperationActivityMgr:GetSkinPassData(data.id)
        RefreshPanel()
    end
end

function RefreshPanel()
    curLv = curData:GetLv()
    maxLv = #curData:GetRewardInfos()
    upLv = 1;
    CSAPI.SetText(txt_stage1,curLv .. "");
    CSAPI.SetText(txt_num, upLv .. "");
    RefreshNextStage();
    -- 刷新奖励列表
    RefreshRewards();
    RefreshPrice();
    RefreshBtnState()
end

function RefreshNextStage()
    CSAPI.SetText(txt_stage2, (curLv + upLv) .. "");
    CSAPI.SetText(txt_tips, LanguageMgr:GetByID(320026, curLv + upLv));
end

function RefreshRewards()
    local infos = curData:GetRewardInfos()
    local rewards = {};
    local rewards2 = {}
    local rewards3 = {}
    local cfgDungeon= nil
    for i, v in ipairs(infos) do
        if v.level and v.level > curLv and v.level <= (curLv + upLv) then
            if v.reward then
                for k, m in ipairs(v.reward) do
                    if rewards[m[1]] then
                        rewards[m[1]].num = rewards[m[1]].num + m[2]
                    else
                        rewards[m[1]] = {
                            id = m[1],
                            num = m[2],
                            type = m[3]
                        }
                    end
                end
                if curData:IsBuy() and v.fullReward then
                    for k, m in ipairs(v.fullReward) do
                        if rewards[m[1]] then
                            rewards[m[1]].num = rewards[m[1]].num + m[2]
                        else
                            rewards[m[1]] = {
                                id = m[1],
                                num = m[2],
                                type = m[3]
                            }
                        end
                    end
                end
            elseif v.group then
                cfgDungeon = Cfgs.MainLine:GetByID(v.group[1])
                if cfgDungeon and cfgDungeon.fisrtPassReward then
                    for k, m in ipairs(cfgDungeon.fisrtPassReward) do
                        if rewards2[m[1]] then
                            rewards2[m[1]].num = rewards2[m[1]].num + m[2]
                        else
                            rewards2[m[1]] = {
                                id = m[1],
                                num = m[2],
                                type = m[3]
                            }
                        end
                    end
                end
                if curData:IsBuy() and v.fullReward then
                    for k, m in ipairs(v.fullReward) do
                        if rewards3[m[1]] then
                            rewards3[m[1]].num = rewards[m[1]].num + m[2]
                        else
                            rewards3[m[1]] = {
                                id = m[1],
                                num = m[2],
                                type = m[3]
                            }
                        end
                    end
                end
            end
        end
    end
    curDatas = {};
    for k, v in pairs(rewards) do
        local gData = GridFakeData(v);
        table.insert(curDatas, {data = gData});
    end
    for k, v in pairs(rewards2) do
        local gData = GridFakeData(v);
        table.insert(curDatas, {data = gData,elseData = {tag = ITEM_TAG.FirstPass}});
    end
    for k, v in pairs(rewards3) do
        local gData = GridFakeData(v);
        table.insert(curDatas, {data = gData,elseData = {tag = ITEM_TAG.Other}});
    end
    layout:IEShowList(#curDatas);
end

function RefreshPrice()
    local infos = curData:GetRewardInfos()
    local id, num = 0, 0
    for i, v in ipairs(infos) do
        if v.cost and v.level and v.level > curLv and v.level <= (curLv + upLv) then
            for k, m in ipairs(v.cost) do
                if id <= 0 then
                    id = m[1]
                end
                num = num + m[2]
            end
        end
    end
    costID = id
    currPrice = num
    SetPrice(id, num);
end

function SetPrice(id, num)
    if id == ITEM_ID.GOLD then -- 钻石
        ResUtil.IconGoods:Load(moneyIcon, tostring(ITEM_ID.GOLD) .. "_1");
        ResUtil.IconGoods:Load(coinIcon, tostring(ITEM_ID.GOLD) .. "_1");
    elseif id == ITEM_ID.DIAMOND then -- 金币
        ResUtil.IconGoods:Load(moneyIcon, tostring(ITEM_ID.DIAMOND) .. "_1");
        ResUtil.IconGoods:Load(coinIcon, tostring(ITEM_ID.DIAMOND) .. "_1");
    else
        local cfg = Cfgs.ItemInfo:GetByID(id);
        if cfg and cfg.icon then
            ResUtil.IconGoods:Load(moneyIcon, cfg.icon .. "_1");
        end
    end
    CSAPI.SetText(txt_price, tostring(math.floor(num + 0.5)));
    -- 设置货币持有数
    CSAPI.SetScale(coinIcon, 1, 1, 1);
    local num = BagMgr:GetCount(id);
    if (num >= 100000) then
        CSAPI.SetText(txt_hasNum, math.floor(num / 10000) .. "W")
    else
        CSAPI.SetText(txt_hasNum, tostring(num))
    end
end

function RefreshBtnState()
    SetBtnState(btn_remove, removeImg, upLv > 1);
    SetBtnState(btn_add, addImg, curLv + upLv < maxLv);
    SetBtnState(btn_max, maxImg, curLv + upLv < maxLv);
    SetBtnState(btn_min, minImg, upLv > 1);
end

function SetBtnState(btn, img, enable)
    if btn then
        CSAPI.SetGOAlpha(btn, enable and 1 or 0.5);
        local com = nil;
        if btns and btns[btn.name] ~= nil then
            com = btns[btn.name]
        else
            btns = btns or {}
            com = ComUtil.GetCom(btn, "Image");
            btns[btn.name] = com;
        end
        if com then
            if enable then
                com.raycastTarget = enable;
            else
                com.raycastTarget = false;
            end
        end
    end
end

function OnClickAdd()
    if upLv < maxLv then
        upLv = upLv + 1;
        CSAPI.SetText(txt_num, upLv .. "");
    end
    RefreshBtnState()
    RefreshPrice();
    RefreshRewards();
    RefreshNextStage()
end

function OnClickRemove()
    if upLv > 1 then
        upLv = upLv - 1;
        CSAPI.SetText(txt_num, upLv .. "");
    end
    RefreshBtnState()
    RefreshPrice();
    RefreshRewards();
    RefreshNextStage()
end

function OnClickMax()
    upLv = maxLv - curLv;
    CSAPI.SetText(txt_num, upLv .. "");
    RefreshBtnState()
    RefreshPrice();
    RefreshRewards();
    RefreshNextStage()
end

function OnClickMin()
    upLv = 1;
    CSAPI.SetText(txt_num, upLv .. "");
    RefreshBtnState()
    RefreshPrice();
    RefreshRewards();
    RefreshNextStage()
end

function OnClickPay()
    -- 发送购买协议
    local canPay = false;
    if costID == ITEM_ID.GOLD or costID == ITEM_ID.DIAMOND or costID == g_AbilityCoinId or costID == g_ArmyCoinId then
        canPay = PlayerClient:GetCoin(costID) >= currPrice;
    elseif costID == -1 then
        canPay = true;
        -- 进入SDK支付流程
        return;
    else
        local count = BagMgr:GetCount(costID);
        canPay = count >= currPrice;
    end
    if canPay then
        -- 提示是否购买
        local dialogdata = {
            content = LanguageMgr:GetByID(320025, currPrice),
            okCallBack = function()
                if CSAPI.IsADVRegional(3) and costID == ITEM_ID.DIAMOND then
                    CSAPI.ADVJPTitle(currPrice, function()
                        PlayerProto:SkinPassUpgrade(data.id,curLv + math.floor(upLv))
                        -- ExplorationProto:Upgrade(data:GetCfgID(), curLv + math.floor(upLv));
                        OnClickMask()
                    end)
                else
                    PlayerProto:SkinPassUpgrade(data.id,curLv + math.floor(upLv))
                    -- ExplorationProto:Upgrade(data:GetCfgID(), curLv + math.floor(upLv));
                    OnClickMask()
                end
            end
        }
        CSAPI.OpenView("Dialog", dialogdata);
    else
        local goods = GoodsData();
        goods:InitCfg(costID);
        Tips.ShowTips(string.format(LanguageMgr:GetTips(15000), goods:GetName()));
    end
end

function OnClickMask()
    view:Close();
end
