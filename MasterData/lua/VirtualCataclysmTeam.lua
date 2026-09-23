local isReady = false
local teamItems = nil
local optionDatas = nil
local downListView = nil
local dungeonCfg = nil
local teamlist = nil
local currCostInfo = nil
local currCostHot = nil
local showTeamInfos = nil
local selectIndex = nil

function Awake()
    UIUtil:AddTop2("VirtualCataclysmTeam", gameObject, function()
        view:Close()
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Team_Data_Update, RefreshPanel)
    eventMgr:AddListener(EventType.Team_Confirm_ItemDisable, OnOptionChange)
end

function OnOptionChange(eventData)
    if optionDatas==nil then
        do return end
    end
    for k,v in ipairs(optionDatas) do
        if v.itemID==eventData then
            v.itemID=nil;
            v.isSelect=false;
            break;
        end
    end
end

function OnDestroy()
    TeamMgr:DelEditTeam()
    eventMgr:ClearListener()
end

function OnOpen()
    if data then
        dungeonCfg = Cfgs.MainLine:GetByID(data.dungeonId)
        currCostInfo=DungeonUtil.GetCost(dungeonCfg);
        currCostHot=DungeonUtil.GetHot(dungeonCfg);
        InitTeamDatas()
        InitHotItem()
        InitEnterCost()
        RefreshPanel()
        -- 触发虚数天灾编队引导
        FuncUtil:Call(function()
            EventMgr.Dispatch(
                EventType.Guide_Trigger_Flag,
                "VirtualCataclysmTeam"
            )
        end, this, 100)
    end
end

function InitHotItem()
    if currCostInfo then
         --读取消耗信息
         local type = currCostInfo[3] or 2
         -- local type=2;
         local num=currCostInfo[2];
         local cid=currCostInfo[1];
         if type == RandRewardType.ITEM then
             local data = GoodsData()
             data:InitCfg(cid)
             local hasCount=BagMgr:GetCount(cid);
             ResUtil.IconGoods:Load(moneyIcon3,data:GetIcon().."_1");
             CSAPI.SetText(txt_hot,tostring(hasCount));
             CSAPI.SetGOActive(moneyAdd,data:GetMoneyJumpID()~=nil);
         else
             LogError("配置表错误！道具类型错误！");
             LogError(currCostInfo);
         end
    else
        local maxHot=PlayerClient:MaxHot();
        local currHot=PlayerClient:Hot();
        ResUtil.IconGoods:Load(moneyIcon3, "10035_1")
        CSAPI.SetText(txt_hot,string.format("%s/%s",currHot,maxHot));
        CSAPI.SetGOActive(moneyAdd,true);
        -- slider:SetProgress(currHot/maxHot);
    end
end

function InitEnterCost()
    if currCostInfo~=nil then
        --读取消耗信息
        local type = currCostInfo[3]
        -- local type=2;
        local num=currCostInfo[2];
        if data and data.isDirll then
            num=0;
        end
        local cid=currCostInfo[1];
        if type == RandRewardType.ITEM then
            local d = GoodsData()
            d:InitCfg(cid)
            local hasCount=BagMgr:GetCount(cid);
            ResUtil.IconGoods:Load(costIcon,d:GetIcon().."_3");
            local costHot=hasCount>=num and string.format("<color='#000000'>%s</color>",num) or string.format("<color='#cd333e'>%s</color>",num);
            CSAPI.SetText(txt_cost,d:GetName().."-"..costHot);
        else
            LogError("配置表错误！道具类型错误！");
            LogError(currCostInfo);
        end
    else
        local currHot=PlayerClient:Hot();
        local cHot=math.abs(currCostHot)
        local costHot=currHot>=cHot and string.format("<color='#000000'>%s</color>",currCostHot) or string.format("<color='#cd333e'>%s</color>",currCostHot);
        CSAPI.LoadImg(costIcon,"UIs/TeamConfirm/btn_8_07.png",true,nil,true);
        CSAPI.SetText(txt_cost,LanguageMgr:GetByID(26041,costHot));
    end
end

function InitTeamDatas()
    local cfgEnum = TeamMgr:GetIndexRangeInfo(eTeamType.CrossBoss)
    if cfgEnum then --清理已战斗卡牌
        local len = cfgEnum.endIdx - cfgEnum.id
        local teamData = nil
        local removeIDs = nil
        for i = 1, len do
            teamData = TeamMgr:GetTeamData(cfgEnum.id + (i - 1))
            if teamData then
                removeIDs = {}
                for k, v in ipairs(teamData.data) do
                    if not VirCatMgr:IsCardShow(v.cid) then
                        table.insert(removeIDs,v.cid)
                    end
                end
                if #removeIDs > 0 then
                    for _,v in ipairs(removeIDs) do
                        teamData:RemoveCard(v)
                    end
                end
            end
        end
    end
end

function RefreshPanel()
    SetOptions()
    -- items
    SetItems()
    --
    CheckReady()
    -- btns 
    CSAPI.SetGOAlpha(btnBattle2, isReady and 1 or 0.3)
end

function SetOptions()
    optionDatas = {}
    showTeamInfos = VirCatMgr:GetShowTeamInfos()
    if data and data.isDirll then --模拟默认第一队
       showTeamInfos = {{id = eTeamType.CrossBoss,index = 1}}
    end
    local option = nil
    for i, v in ipairs(showTeamInfos) do
        option = {}
        option.desc = v.index < 10 and "0" .. v.index or v.index
        option.name = LanguageMgr:GetByID(380061, v.index)
        option.id = v.id
        if not selectIndex then
            option.itemID = 1
            option.isSelect = true
            selectIndex = v.id
        elseif v.id == selectIndex then
            option.itemID = 1
            option.isSelect = true
        else
            option.itemID = nil
            option.isSelect = false
        end
        table.insert(optionDatas, option)
    end
end

function SetItems()
        local _data = {
        id = 1,
        num = 1,
        options = optionDatas,
        state = TeamConfirmItemState.UnAssist,
        ShowDownList = ShowDownList,
        openSetting = TeamConfirmOpenType.VirCat,
        dungeonCfg = dungeonCfg,
        isDirll = data.isDirll,
        dungeonId = data.dungeonId,
    }
    teamItems = teamItems or {}
    ItemUtil.AddItems("TeamConfirm/TeamListItem", teamItems, {_data}, itemNode, nil, 1, nil)
end

-- 刷新下拉面板
function ShowDownList(pos, itemID, func, func2)
    if downListView == nil then
        local go = ResUtil:CreateUIGO("TeamConfirm/TeamDownListView", gameObject.transform);
        downListView = ComUtil.GetLuaTable(go);
    end
    -- 将pos转为本地坐标
    -- pos=transform:InverseTransformPoint(pos);
    -- pos.x=pos.x+150
    downListView.Show(pos, optionDatas, itemID);
    downListView.AddOnValueChange(OnDownValChange);
    downListView.AddOnClose(func2);
end

function OnDownValChange(options)
    for k,v in pairs(options) do
        teamItems[1].OnDropValChange(v);
        if v.isSelect then
            selectIndex = v.id
        end
    end
    CheckReady()
    CSAPI.SetGOAlpha(btnBattle2, isReady and 1 or 0.3)
end

-- 队伍是否都已经选好
function CheckReady()
    isReady = true
    teamlist = {}
    for i, v in ipairs(teamItems) do
        local teamData = TeamMgr:GetEditTeam(v.GetTeamIndex())
        if teamData:GetRealCount() <= 0 then
            isReady = false
            break
        else
            local duplicateTeam=v.GetDuplicateTeamData();
            table.insert(teamlist, duplicateTeam)
        end
    end
    
end

-- 开始战斗
function OnClickBattle()
    local virCatData = VirCatMgr:GetData(data.nodeId)
    if virCatData and virCatData:IsPass() then
        LanguageMgr:ShowTips(80003)
        return
    end
    CheckReady()
    if (isReady) then
        DungeonMgr:SetCurrId(dungeonCfg.id)
        DungeonMgr:SetFightTeamId(teamItems[1].GetTeamIndex())
        CrossBossProto:EnterCrossBossFight({actId = VirCatMgr:GetActiveId(),nodeId = data.nodeId,list = teamlist,isSimulated = data.isDirll})
    end
end

function OnClickHot()
    if currCostInfo then
        --读取消耗信息
        local type = currCostInfo[3]
        -- local type=2;
        local num=currCostInfo[2];
        local cid=currCostInfo[1];
        if type == RandRewardType.ITEM then
            local data = GoodsData()
            data:InitCfg(cid)
            local jumpId=data:GetMoneyJumpID();
           if jumpId then
                JumpMgr:Jump(jumpId);
           end
        else
            LogError("配置表错误！道具类型错误！");
            LogError(currCostInfo);
        end
    else
        CSAPI.OpenView("HotPanel");
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
