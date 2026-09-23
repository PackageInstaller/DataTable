-- 钻石-微晶 
-- 微晶-抽卡卷
function OnOpen()
    poolId = data[1] -- 卡池id
    cnt = data[2] -- 构建次数
    cfgID = data[3] --
    -- if (cfgID == 1003) then
    --     if (BagMgr:GetCount(10040) <= 0) then
    --         cfgID = 1001
    --     end
    -- end
    RefreshPanel()
end

function RefreshPanel()
    cfg = Cfgs.CfgCardPool:GetByID(poolId)
    local id = cnt == 1 and cfg.jCost[1][1] or cfg.multiCost[1][1] -- 抽卡劵id  --g_CreateSpendID
    cur1 = BagMgr:GetCount(id)
    needNum = cnt - cur1 -- 还需要的抽卡卷的数量
    local eCfg = Cfgs.CfgItemExchange:GetByID(cfgID)
    cost = eCfg.costs[1] -- 兑换物
    get = eCfg.gets[1]

    if (cfgID == 1003) then
        SetExchange1()
    elseif (cfgID == 1001) then
        SetExchange3()
    else
        SetExchange2()
    end
end

-- 钻石-微晶 
function SetExchange1()
    -- 微晶
    local _eCfg = Cfgs.CfgItemExchange:GetByID(1002)
    -- local max = cnt * _eCfg.costs[1][2] -- 最大需要的微晶数
    local max = needNum * _eCfg.costs[1][2]
    needNum = needNum * _eCfg.costs[1][2] - BagMgr:GetCount(_eCfg.costs[1][1]) -- 实际需要的微晶数量
    needNum = needNum < 0 and 0 or needNum
    if (not item1) then
        local go, _item = ResUtil:CreateGridItem(itemPoint1.transform)
        item1 = _item
        num = BagMgr:GetCount(cost[1])
        local fodderData = BagMgr:GetFakeData(cost[1], num)
        item1.Refresh(fodderData)
        item1.SetClickCB(GridClickFunc.OpenInfo)
        needCostNum = cost[2] * needNum
        local str = needCostNum > num and StringUtil:SetByColor(num, "FF381E") or StringUtil:SetByColor(num, "65ffb1")
        item1.SetDownCount(str .. "/" .. needCostNum)
    end

    if (not item2) then
        local go, _item = ResUtil:CreateGridItem(itemPoint2.transform)
        item2 = _item
        local had = BagMgr:GetCount(_eCfg.costs[1][1])
        local fodderData = BagMgr:GetFakeData(get[1], had)
        item2.Refresh(fodderData)
        item2.SetClickCB(GridClickFunc.OpenInfo)
        local str1 = StringUtil:SetByColor(had, "FF381E")
        local str2 = needCostNum > num and StringUtil:SetByColor("+" .. needNum, "FF381E") or
                         StringUtil:SetByColor("+" .. needNum, "65ffb1")

        item2.SetDownCount(str1 .. str2 .. "/" .. max)
    end
    LanguageMgr:SetText(txtTips, 17060, Cfgs.ItemInfo:GetByID(get[1]).name, needCostNum,
        Cfgs.ItemInfo:GetByID(cost[1]).name, needNum, Cfgs.ItemInfo:GetByID(get[1]).name)
end

-- 微晶-抽卡卷
function SetExchange2()
    if (not item1) then
        local go, _item = ResUtil:CreateGridItem(itemPoint1.transform)
        item1 = _item
        num = BagMgr:GetCount(cost[1])
        local fodderData = BagMgr:GetFakeData(cost[1], num)
        item1.Refresh(fodderData)
        item1.SetClickCB(GridClickFunc.OpenInfo)
        needCostNum = cost[2] * needNum
        local str = needCostNum > num and StringUtil:SetByColor(num, "FF381E") or StringUtil:SetByColor(num, "65ffb1")
        item1.SetDownCount(str .. "/" .. needCostNum)
    end

    if (not item2) then
        local go, _item = ResUtil:CreateGridItem(itemPoint2.transform)
        item2 = _item
        local fodderData = BagMgr:GetFakeData(get[1], cur1)
        item2.Refresh(fodderData)
        item2.SetClickCB(GridClickFunc.OpenInfo)
        local str1 = StringUtil:SetByColor(cur1, "FF381E")
        local str2 = needCostNum > num and StringUtil:SetByColor("+" .. needNum, "FF381E") or
                         StringUtil:SetByColor("+" .. needNum, "65ffb1")
        item2.SetDownCount(str1 .. str2 .. "/" .. cnt)
    end
    LanguageMgr:SetText(txtTips, 17016, Cfgs.ItemInfo:GetByID(get[1]).name, needCostNum,
        Cfgs.ItemInfo:GetByID(cost[1]).name, needNum, Cfgs.ItemInfo:GetByID(get[1]).name)
end

-- 钻石-抽卡卷
function SetExchange3()
    if (not item1) then
        local go, _item = ResUtil:CreateGridItem(itemPoint1.transform)
        item1 = _item
        num = BagMgr:GetCount(cost[1])
        local fodderData = BagMgr:GetFakeData(cost[1], num)
        item1.Refresh(fodderData)
        item1.SetClickCB(GridClickFunc.OpenInfo)
        needCostNum = cost[2] * needNum
        local str = needCostNum > num and StringUtil:SetByColor(num, "FF381E") or StringUtil:SetByColor(num, "65ffb1")
        item1.SetDownCount(str .. "/" .. needCostNum)
    end

    if (not item2) then
        local go, _item = ResUtil:CreateGridItem(itemPoint2.transform)
        item2 = _item
        local fodderData = BagMgr:GetFakeData(get[1], cur1)
        item2.Refresh(fodderData)
        item2.SetClickCB(GridClickFunc.OpenInfo)
        local str1 = StringUtil:SetByColor(cur1, "FF381E")
        local str2 = needCostNum > num and StringUtil:SetByColor("+" .. needNum, "FF381E") or
                         StringUtil:SetByColor("+" .. needNum, "65ffb1")
        item2.SetDownCount(str1 .. str2 .. "/" .. cnt)
    end
    LanguageMgr:SetText(txtTips, 17016, Cfgs.ItemInfo:GetByID(get[1]).name, needCostNum,
        Cfgs.ItemInfo:GetByID(cost[1]).name, needNum, Cfgs.ItemInfo:GetByID(get[1]).name)
end

function OnClickL()
    view:Close()
end

function OnClickR()
    if (needCostNum > num) then
        -- 不足兑换
        local str = LanguageMgr:GetTips(10004)
        UIUtil:OpenDialog(str, function()
            JumpMgr:Jump(140001)
            view:Close()
        end)
    else
        local datas = {{
            id = cfgID,
            num = needNum,
            type = RandRewardType.ITEM
        }}
        if CSAPI.IsADVRegional(3) and (cfgID==1003 or cfgID==1001 or cfgID==1006) then
            CSAPI.ADVJPTitle(needCostNum, function()
                ClientProto:ExchangeItem(datas, ChangeCB, poolId)
            end)
        else
            if CSAPI.IsADVRegional(3) then Log("cfgID:"..tostring(cfgID).."poolId"..tostring(poolId)) end
            ClientProto:ExchangeItem(datas, ChangeCB, poolId)
        end
    end
end
function ChangeCB(proto)
    if (cfgID == 1002 or cfgID == 1001) then
        if (proto.rewards and #proto.rewards > 0) then
            CreateMgr:CardCreate(poolId, cnt)
        end
    else
        -- 弹奖励框
        UIUtil:OpenReward({proto.rewards})
    end
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
    bg = nil;
    txtTitle1 = nil;
    txtTitle2 = nil;
    itemPoint1 = nil;
    itemPoint2 = nil;
    txtTips = nil;
    btnCancel = nil;
    txtCancel = nil;
    txtL2 = nil;
    txtOk = nil;
    txtR2 = nil;
    view = nil;
end
----#End#----
