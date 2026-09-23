PlayerProto = {
    teamSaveCallBack = nil,
    teamListSaveCall = nil,
    setNameCallBack = nil,
    useItemCallBack = nil,
    GetLifeCall = nil,
    isOpenReward = false,
    getCardCntCall = nil,
    combineCallBack = nil,
    convertedCallBack=nil,
    useItemListCallBack=nil,
};

-- 背包信息
function PlayerProto:ItemBag(proto)
    -- LogError("物品背包===========================")
    -- LogTable(proto)
    BagMgr:SetData(proto);
    -- data = {{id=1001,row=1, col=1},{id=1002,row=1, col=3},{id=2001,row=2, col=2},{id=2002,row=3, col=1},{id=3001,row=1, col=2}}
    -- local proto = {"FightProtocol:StartMainLineFight",{groupID = 100001, data = data}};
    -- NetMgr.net:Send(proto);
end

-- 物品达到上限
function PlayerProto:ItemFull(proto)
    --	LogError("物品上限===========================")
    --	LogTable(proto)
end

-- 物品更新
function PlayerProto:ItemUpdate(proto)
    --	LogError("物品更新===========================")
    --	LogTable(proto)
    BagMgr:UpdateData(proto);

    -- 刷新数数缓存
    ThinkingAnalyticsMgr:RefreshDatas()
end

-- 使用背包中的物品
function PlayerProto:UseItem(item, isOpenReward, func)
    self.isOpenReward = isOpenReward;
    self.useItemCallBack = func;
    if item then
        local proto = {"PlayerProto:UseItem", {
            info = item
        }}
        NetMgr.net:Send(proto);
    else
        LogError("传入的参数ItemList:" .. tostring(item));
    end
end

-- 使用背包中的物品的回调
function PlayerProto:UseItemRet(proto)
    if proto and proto.info and self.isOpenReward and proto.info.gets ~= nil and #proto.info.gets > 0 then
        UIUtil:OpenReward({proto.info.gets}, {
            isNoShrink = not proto.isMerge
        });
    end
    if self.useItemCallBack then
        self.useItemCallBack(proto);
        self.useItemCallBack = nil;
    end

    -- 使用体能道具
    if (proto and proto.info and (proto.info.id == 10036 or proto.info.id == 10037)) then
        local cfg = Cfgs.ItemInfo:GetByID(proto.info.id)
        local per = PlayerClient:Hot() - cfg.dy_value2 * proto.info.cnt
        EventMgr.Dispatch(EventType.Player_HotChange)
        CSAPI.OpenView("HotTipsPanel", {per})
    end
end

------------------------------------------------------------------------
-- 队伍编成数据
function PlayerProto:TeamData(proto)
    LogDebug("队伍编成数据===========================")
    TeamMgr:SetData(proto);
end

function PlayerProto:SaveTeam(teamData, callBack)
    if teamData == nil then
        LogError("要保存的队伍数据不能为nil！！");
        return;
    end
    if callBack then
        self.teamSaveCallBack = callBack;
    end
    -- local sendData = {index = teamData.index, leader = teamData.leader, name = teamData.teamName, skill_group_id = teamData.skillGroupID,bIsReserveSP=teamData.bIsReserveSP,nReserveNP=teamData.nReserveNP,preformance=teamData.preformance};
    -- sendData.data = {};
    for k, v in ipairs(teamData.data) do
        if v.cid == 0 or v.cid == nil then
            LogError("错误！队伍中存在卡牌id为0的数据！");
            LogError(teamData);
            return
        end
        -- table.insert(sendData.data, v:GetFormatData());
    end
    local sendData = teamData:GetSaveData();
    Log(sendData);
    local proto = {"PlayerProto:SetTeamData", {
        info = sendData
    }}
    NetMgr.net:Send(proto);
end

-- 保存队伍编成回调
function PlayerProto:SetTeamResult(proto)
    LogDebug("保存编成数据回调===========================")
    EventMgr.Dispatch(EventType.Team_Data_Update);
    if proto and proto.info ~= nil then -- 还原变更
        TeamMgr:UpdateDataByIndex(proto.info.index, proto.info);
    end
    if self.teamSaveCallBack then
        self.teamSaveCallBack();
        self.teamSaveCallBack = nil;
    end
end

-- 保存多个队伍
function PlayerProto:SaveTeamList(teamDatas, callBack)
    if teamDatas == nil then
        LogError("要保存的队伍数据不能为nil！！");
        return;
    end
    if callBack then
        self.teamListSaveCall = callBack;
    end
    local sendDatas = {};
    for k, v in ipairs(teamDatas) do
        -- local sendData = {index = v.index, leader = v.leader, name = v.teamName, skill_group_id = v.skillGroupID,bIsReserveSP=v.bIsReserveSP,nReserveNP=v.nReserveNP,preformance=v.preformance};
        -- sendData.data = {};
        for key, val in ipairs(v.data) do
            if val.cid == 0 or val.cid == nil then
                LogError("错误！批量队伍保存中存在卡牌id为0的数据！");
                LogError(v);
                return
            end
            -- table.insert(sendData.data, val:GetFormatData());
        end
        local sendData = v:GetSaveData();
        table.insert(sendDatas, sendData);
    end
    local proto = {"PlayerProto:MultSetTeamData", {
        infos = sendDatas
    }}
    NetMgr.net:Send(proto);
end

function PlayerProto:MultSetTeamResult(proto)
    LogDebug("批量保存编成数据回调===========================")
    EventMgr.Dispatch(EventType.Team_Data_Update);
    if proto and proto.infos ~= nil then -- 还原变更
        for k, v in ipairs(proto.infos) do
            TeamMgr:UpdateDataByIndex(v.index, v);
        end
    end
    if self.teamListSaveCall then
        self.teamListSaveCall(proto);
        self.teamListSaveCall = nil;
    end
end

-- 开启预设数量
function PlayerProto:BuyTeam()
    local proto = {"PlayerProto:BuyTeam", {
        count = 1
    }}
    NetMgr.net:Send(proto);
end

-- 开启预设回调
function PlayerProto:BuyTeamResult(proto)
    if proto.ret then
        -- 购买成功
        TeamMgr.presetNum = proto.count;
    end
    EventMgr.Dispatch(EventType.Team_Preset_Buy)
end

-- 主线数据
function PlayerProto:DuplicateData(proto)
    -- LogDebug("主线数据===========================")
    -- LogTable(proto)
    DungeonMgr:Set(proto);
end

----------------------------------卡牌系统--------------------------------------
-- 卡牌数据
function PlayerProto:CardsDataRet(proto)
    RoleMgr:SetDatas(proto)
end

-- 卡牌改名返回
function PlayerProto:CardRenameRet(proto)
    RoleMgr:CardRenameRet(proto)
end

-- 上锁返回
function PlayerProto:CardLockRet(proto)
    RoleMgr:CardLockRet(proto)
end

-- 角色升级返回
function PlayerProto:CardUpgradeRet(proto)
    RoleMgr:CardUpgradeRet(proto)

    -- rui数数 角色升级
    local cardData = RoleMgr:GetData(proto.card.cid)
    if (cardData) then
        local _datas = {}
        _datas.hero_id = cardData:GetID()
        _datas.hero_name = cardData:GetName()
        _datas.hero_level = cardData:GetLv()
        if CSAPI.IsADV()==false then
            BuryingPointMgr:TrackEvents("roleUpgrade", _datas)
        end
    end
end

-- --角色强化
-- function PlayerProto:CardIntensifyRet(proto)
-- 	RoleMgr:CardIntensifyRet(proto)
-- end

-- 角色跃升
function PlayerProto:CardBreakRet(proto)
    RoleMgr:CardBreakRet(proto)

    -- CRoleMgr:CheckNewSkin() --新皮肤红点检查

    -- rui数数 角色跃升
    local cardData = RoleMgr:GetData(proto.card.cid)
    if (cardData) then
        local _datas = {}
        _datas.hero_id = cardData:GetID()
        _datas.hero_name = cardData:GetName()
        _datas.hero_yuesheng = cardData:GetBreakLevel()
        if CSAPI.IsADV()==false then
            BuryingPointMgr:TrackEvents("RoleLeap", _datas)
        end
    end
end

-- 卡牌删除
function PlayerProto:CardDelete(proto)
    RoleMgr:CardDelete(proto)
end

-- 卡牌添加
function PlayerProto:CardAdd(proto)
    RoleMgr:CardAdd(proto)
end

-- 卡牌格子扩容
function PlayerProto:CardGirdAddRet(proto)
    RoleMgr:CardGirdAddRet(proto)
end

-- 卡牌更新
function PlayerProto:CardUpdate(proto)
    RoleMgr:CardUpdate(proto)
end

-- 卡牌分解
function PlayerProto:CardDisintegrateRet(proto)
    RoleMgr:CardDisintegrateRet(proto)
end

-- 获取卡牌获得的次数
function PlayerProto:GetCardGetCnt(cfgId, callBack)
    self.getCardCntCall = callBack;
    local proto = {"PlayerProto:GetCardGetCnt", {
        cfgid = cfgId
    }}
    NetMgr.net:Send(proto);
end

-- 获取卡牌获得次数的返回
function PlayerProto:GetCardGetCntRet(proto)
    if self.getCardCntCall then
        self.getCardCntCall(proto.cnt);
        self.getCardCntCall = nil;
    end
end

----------------------------------卡牌系统技能--------------------------------------
-- 卡牌技能格子扩容
function PlayerProto:CardSkillGirdAddRet(proto)
    RoleSkillMgr:CardSkillGirdAddRet(proto)
end

-- 卡牌技能升级列表返回
function PlayerProto:CardSkillUpgradelistRet(proto)
    RoleSkillMgr:CardSkillUpgradelistRet(proto)
end

-- 卡牌升级完成返回
function PlayerProto:CardSkillUpgradeFinishRet(proto)
    RoleSkillMgr:CardSkillUpgradeFinishRet(proto)

    -- rui数数 技能升级
    local infos = proto.infos
    for i, v in pairs(infos) do
        if (#v.ids == 2) then
            local cardData = RoleMgr:GetData(v.cid)
            local skillCfg = Cfgs.skill:GetByID(v.ids[2])
            local _datas = {}
            _datas.reason = "技能升级"
            _datas.hero_id = cardData:GetID()
            _datas.hero_name = cardData:GetName()
            _datas.skill_oldid = v.ids[1]
            _datas.skill_newid = v.ids[2]
            _datas.skill_level = skillCfg.lv
            if CSAPI.IsADV()==false then
                BuryingPointMgr:TrackEvents("SkillUpgrading", _datas)
            end
        end
    end
end

function PlayerProto:CardSkillUpgradeRet(proto)
    RoleSkillMgr:CardSkillUpgradeRet(proto)
end

----------------------------------卡牌系统热值--------------------------------------
-- --卡牌冷却信息列表
-- function PlayerProto:CardCoolBoxInfoRet(proto)
-- 	CoolMgr:CardCoolBoxInfoRet(proto)
-- end
-- --卡牌冷却
-- function PlayerProto:CardCoolRet(proto)
-- 	CoolMgr:CardCoolRet(proto)
-- end
-- --服务器通知冷却完成
-- function PlayerProto:CardCoolFinishNotice(proto)
-- 	CoolMgr:CardCoolFinishNotice(proto)
-- end
-- --卡牌冷却格子扩容
-- function PlayerProto:CardCoolGirdAddRet(proto)
-- 	CoolMgr:CardCoolGirdAddRet(proto)
-- end

-- --中止冷却
-- function PlayerProto:CardCoolFinish(_index, _isPause)
-- 	local proto = {"PlayerProto:CardCoolFinish", {index = _index, isPause = _isPause}}
-- 	NetMgr.net:Send(proto)
-- end

----------------------------------卡牌建造--------------------------------------
-- 卡牌厂区信息
function PlayerProto:CardFactoryInfoRet(proto)
    CreateMgr:CardFactoryInfoRet(proto)
end
-- 获取首次抽卡logs
function PlayerProto:FirstCardCreateLogsRet(proto)
    CreateMgr:FirstCardCreateLogsRet(proto)
end
-- 卡牌建造完成(先返回CardFactoryInfoRet)
function PlayerProto:CardCreateFinishRet(proto)
    CreateMgr:CardCreateFinishRet(proto)
end
-- 卡牌建造首次10连
function PlayerProto:FirstCardCreateRet(proto)
    CreateMgr:FirstCardCreateRet(proto)
end
function PlayerProto:FirstCardCreateAffirmRet(proto)
    CreateMgr:FirstCardCreateAffirmRet(proto)
end

function PlayerProto:SetCardPoolSelCard(_card_pool_id, _cid)
    local proto = {"PlayerProto:SetCardPoolSelCard", {
        card_pool_id = _card_pool_id,
        cid = _cid
    }}
    NetMgr.net:Send(proto)
end
function PlayerProto:SetCardPoolSelCardRet(proto)
    CreateMgr:SetCardPoolSelCardRet(proto)
end

--------------------------------人物相关
function PlayerProto:SetPlrName(data, callBack)
    self.setNameCallBack = callBack;
    local proto = {"PlayerProto:SetPlrName", data}
    NetMgr.net:Send(proto);
end

function PlayerProto:SetPlrNameRet(proto)
    --PlayerClient:SetPanelId(proto.panel_id)
    PlayerClient:SetIconId(proto.icon_id)
    --PlayerClient:SetLastRoleID(proto.role_panel_id)
    PlayerClient:SetModifyName(false);
    if self.setNameCallBack then
        self.setNameCallBack(proto);
        self.setNameCallBack = nil
    end

    -- 重新请求演习数据
    -- ExerciseMgr:GetPracticeInfo(true, false)
end

-- 检测重名
function PlayerProto:PlrNameCheckUse(data, callBack)
    self.checkNameCallBack = callBack;
    local proto = {"PlayerProto:PlrNameCheckUse", data}
    NetMgr.net:Send(proto);
end

function PlayerProto:PlrNameCheckUseRet(proto)
    if self.checkNameCallBack then
        self.checkNameCallBack(proto);
        self.checkNameCallBack = nil
    end
end

--------------------------------每日副本
function PlayerProto:DailyData(proto)
    DebugLog("每日副本================");
    DebugLog(proto);
    if proto and proto.data then
        DungeonMgr:SetDailyData(proto.data);

        -- 催眠次数
        -- FavourMgr:DailyData(proto.data)

    end

    -- 每日刷新 --放到SystemProto:ActiveZeroNotice
    -- EventMgr.Dispatch(EventType.Update_Everyday)
end
function PlayerProto:UpdateDailyData(proto)
    DebugLog("更新每日副本================");
    DebugLog(proto);
    if proto and proto.data then
        DungeonMgr:UpdateDailyData(proto.data);

        -- 催眠次数 
        -- FavourMgr:UpdateDailyData(proto.data)
    end
end

-- 副本多倍加成使用信息，id为空时获取全部
function PlayerProto:SectionMultiInfo(id)
    local proto = {"PlayerProto:SectionMultiInfo", {
        id = id
    }}
    NetMgr.net:Send(proto);
end

function PlayerProto:SectionMultiInfoRet(proto)
    DungeonMgr:UpdateSectionMultiInfo(proto);
end

function PlayerProto:NotifyDupDrop(proto)
    EventMgr.Dispatch(EventType.Dungeon_Double_Update)
end

--------------------------------玩家
-- 玩家信息
function PlayerProto:PlrPaneInfoRet(proto)
    PlayerMgr:PlrPaneInfoRet(proto)
end

-- 获取头像框列表
function PlayerProto:PlrIconGridRet(proto)
    PlayerMgr:PlrIconGridRet(proto)
end

-- 获取背景列表
function PlayerProto:PlrPaneBgRet(proto)
    PlayerMgr:PlrPaneBgRet(proto)
end

-- 修改签名
function PlayerProto:SignRet(proto)
    PlayerMgr:SignRet(proto)
end

-- 修改模型
function PlayerProto:ChangeIconRet(proto)
    PlayerMgr:ChangeIconRet(proto)
end

-- 请求返回生活BUFF
function PlayerProto:GetLifeBuff(func)
    self.GetLifeCall = func;
    local proto = {"PlayerProto:GetLifeBuff", {}}
    NetMgr.net:Send(proto);
end

-- 获取生活BUFF回调
function PlayerProto:GetLifeBuffRet(proto)
    PlayerClient:SetLifeBuff(proto.buffs);
    if self.GetLifeCall then
        self.GetLifeCall();
        self.GetLifeCall = nil;
    end
end

-- 更新生活BUFF
function PlayerProto:UpdateLifeBuff(proto)
    if proto and proto.buffs then
        PlayerClient:UpdateLifeBuff(proto.buffs);
    end
end

-- 删除buff列表
function PlayerProto:RemoveLifeBuff(proto)
    if proto and proto.ids then
        PlayerClient:RemoveLifeBuff(proto.ids);
    end
end

-------------------------------------------------
-- 设置客户端自定义数据
-- key 为字符串,  val 可以是常规类型也可以是table
-- 当val为table时注意, 不要用数字做key 
-- 比如{1000000 = true},  转成json会{null....null(1000000个null),true}非常大的字符串, 程序可能会蹦
-- 建议转换一下格式代替, 比如这样{{1000000,true}}, 拿到数据重新转换一下
-- val == nil 删除数据
function PlayerProto:SetClientData(key, val)

    local data = {
        key = key
    }

    if type(val) == "number" then
        data.data = tostring(val)
        data.type = 1
    elseif type(val) == "string" then
        data.data = val
        data.type = 2
    elseif type(val) == "table" then
        data.data = Json.Encode(val)
        data.type = 3
    elseif val == nil then
        data.type = 4
        -- val == nil 删除数据
    else
        ASSERT("类型不对")
    end

    local proto = {"PlayerProto:SetClientData", data}
    NetMgr.net:Send(proto);
end

-- -- 设置客户端自定义数据结果
-- function PlayerProto:SetClientDataRet(proto)
-- 	print(proto.ret)
-- end
-- 获取客户端自定义数据
function PlayerProto:GetClientData(key)
    local proto = {"PlayerProto:GetClientData", {
        key = key
    }}
    NetMgr.net:Send(proto);
end

-- 获取客户端自定义数据结果
function PlayerProto:GetClientDataRet(proto)
    local key = proto.key
    local data = proto.data
    local typ = proto.type

    if typ == 1 then
        data = tonumber(data)
        -- print(key,data)
    elseif typ == 3 then
        data = Json.Decode(data)
        -- LogTable(data)
    elseif typ == 4 then
        -- print(proto.key.." = nil")
    end

    if (key == PlotMgr.plotDataKey) then
        -- 剧情数据
        PlotMgr:SetData(data);
        EventMgr.Dispatch(EventType.Init_Plot_Data);
    elseif (key == FightActionDataMgr.fight_data_list_key) then
        FightActionDataMgr:SetListData(data);
    elseif (key == GuideMgr:GetGuideKey()) then
        GuideMgr:ReceData(data);

    elseif (key == PlayerClient:GetNewPlayerFightStateKey()) then
        if (data and data > PlayerClient:GetNewPlayerFightCount()) then -- 新手固定特殊战斗
            PlayerClient:EnterMajor();
            PlayerClient:SetLocalNewPlayerFightState(data);
        else
            if(not FightClient:IsFightting())then
                PlayerClient:NewPlayerFight(data);
            end
        end

    elseif (string.find(key, FightActionDataMgr.fight_data_key)) then
        LogError("获取战斗数据结果===============");
        LogError(data);
        -- elseif(key == RoleSkillMgr.idDatasKey) then
        -- 	RoleSkillMgr:GetSuccessDatasRet(data)
    elseif (key=="passiveRed_isLook") then
        RoleMgr:PassiveRedIsLook(data)
    end
end

-------------------------------------皮肤
-- 获取皮肤回调+主动推送
function PlayerProto:GetSkinsRet(proto)
    RoleSkinMgr:GetSkinsRet(proto)
end

------------------------------------合成
-- 合成
function PlayerProto:StartCombine(cfgId, num, callBack)
    self.combineCallBack = callBack;
    local proto = {"PlayerProto:StartCombine", {
        cfgid = cfgId,
        cnt = num
    }}
    NetMgr.net:Send(proto);
end

-- 合成回调
function PlayerProto:StartCombineRet(proto)
    if self.combineCallBack then
        self.combineCallBack(proto);
    end
end

-------------------------------------天赋
-- 主天赋升级
function PlayerProto:MainTalentUpgrade(_cid, _skill_id, _uf)
    local proto = {"PlayerProto:MainTalentUpgrade", {
        cid = _cid,
        skill_id = _skill_id,
        uf = _uf
    }}
    NetMgr.net:Send(proto)
end

function PlayerProto:MainTalentUpgradeRet(proto)
    RoleSkillMgr:MainTalentUpgradeRet(proto)

    -- rui数数 天赋升级
    local cardData = RoleMgr:GetData(proto.cid)
    local skillCfg = Cfgs.skill:GetByID(proto.new_skill_id)
    local _datas = {}
    _datas.reason = "天赋升级"
    _datas.hero_id = cardData:GetID()
    _datas.hero_name = cardData:GetName()
    _datas.skill_oldid = proto.skill_id
    _datas.skill_newid = proto.new_skill_id
    _datas.skill_level = skillCfg.lv
    if CSAPI.IsADV()==false then
        BuryingPointMgr:TrackEvents("SkillUpgrading", _datas)
    end
end

-- 随机副天赋(学习)
function PlayerProto:RandSubTalent(_cid, _item_id)
    local proto = {"PlayerProto:RandSubTalent", {
        cid = _cid,
        item_id = _item_id
    }}
    NetMgr.net:Send(proto)
end

function PlayerProto:RandSubTalentRet(proto)
    EventMgr.Dispatch(EventType.Talent_Study, proto)
end

-- 设置副天赋(返回卡牌更新)
function PlayerProto:SetUseSubTalent(_cid, _types)
    local proto = {"PlayerProto:SetUseSubTalent", {
        cid = _cid,
        infos = _types
    }}
    NetMgr.net:Send(proto)
end

-- 替换副天赋(返回卡牌更新)
function PlayerProto:SetReplaceSubTalent(_cid, _is_replace, _type)
    local proto = {"PlayerProto:SetReplaceSubTalent", {
        cid = _cid,
        is_replace = _is_replace,
        type = _type
    }}
    NetMgr.net:Send(proto)
end

function PlayerProto:SetReplaceSubTalentRet(proto)
    EventMgr.Dispatch(EventType.Talent_Replace, proto)
end

-- 副天赋格子开启
function PlayerProto:OpenSubTalentSlot(_cid, _index)
    local proto = {"PlayerProto:OpenSubTalentSlot", {
        cid = _cid,
        index = _index
    }}
    NetMgr.net:Send(proto)
end

-- 副天赋格子开启返回
function PlayerProto:OpenSubTalentSlotRet(proto)
    -- print("由角色更新协议进行更新")
end

-------------------------------------卡牌角色
-- 获取角色
function PlayerProto:GetCardRole()
    local proto = {"PlayerProto:GetCardRole"}
    NetMgr.net:Send(proto)
end

-- 角色添加
function PlayerProto:AddCardRole(proto)
    CRoleMgr:AddCardRole(proto.roles)
end

-- 角色更新
function PlayerProto:UpdateCardRole(proto)
    CRoleMgr:UpdateCardRole(proto)
end

-- 通过角色剧情
function PlayerProto:PassCardRoleStory(_id, _index)
    local proto = {"PlayerProto:PassCardRoleStory", {
        id = _id,
        index = _index
    }}
    NetMgr.net:Send(proto)
end

-- 通过角色剧情
function PlayerProto:PassCardRoleStoryRet(proto)
    local data = CRoleMgr:GetData(proto.id)
    data:SetStoryIds(proto.index)
    EventMgr.Dispatch(EventType.CRole_PlayJQ, proto)
end

-- 请求刷新角色
function PlayerProto:GetCardRoleUpdate()
    local proto = {"PlayerProto:GetCardRoleUpdate"}
    NetMgr.net:Send(proto)
end

-- 标签
function PlayerProto:SetCardTag(_cid, _tag)
    local proto = {"PlayerProto:SetCardTag", {
        cid = _cid,
        tag = _tag
    }}
    NetMgr.net:Send(proto)
end
function PlayerProto:SetCardTagRet(proto)
    local data = RoleMgr:GetData(proto.cid)
    if (data) then
        data:GetData().tag = proto.tag
    end
    EventMgr.Dispatch(EventType.Role_Tag_Update)
end

-- 副天赋升级(返回卡牌更新)
function PlayerProto:UpgradeSubTalent(_cid, _index)
    local proto = {"PlayerProto:UpgradeSubTalent", {
        cid = _cid,
        index = _index
    }}
    NetMgr.net:Send(proto)
end

-- 副天赋升级
function PlayerProto:UpgradeSubTalentRet(proto)
    -- rui数数 被动技能升级
    local cardData = RoleMgr:GetData(proto.cid)
    local subTfSkills = cardData:GetCfg().subTfSkills
    local id = subTfSkills and subTfSkills[1] or nil
    local ids = Cfgs.CfgSubTalentSkillPool:GetByID(id).ids
    local _datas = {}
    _datas.hero_id = cardData:GetID()
    _datas.hero_name = cardData:GetName()
    _datas.skill_id = ids[proto.index]
    _datas.skill_level = proto.index

    if CSAPI.IsADV()==false then
        BuryingPointMgr:TrackEvents("PassiveSkill", _datas)
    end
    LanguageMgr:ShowTips(3012)
end
-- 副天赋设置(返回卡牌更新)
function PlayerProto:SetUseSubTalent(_cid, _indexs)
    local proto = {"PlayerProto:SetUseSubTalent", {
        cid = _cid,
        indexs = _indexs
    }}
    NetMgr.net:Send(proto)
end

-- 记录播放过的音效
function PlayerProto:AddRoleAudio(_id, _au_id)
    local proto = {"PlayerProto:AddRoleAudio", {
        id = _id,
        au_id = _au_id
    }}
    NetMgr.net:Send(proto)
end

-- 获取卡牌自动恢复热值更新(弃用，现在由服务器统一发送)
-- 需要自动更新的位置  1：主界面  2：角色详情  3：冷却列表  4：编队  5：战斗队伍选择
function PlayerProto:FlushAutoAddHotCard()
    local proto = {"PlayerProto:FlushAutoAddHotCard", {}}
    NetMgr.net:Send(proto)
end

-- 获取卡牌自动恢复热值更新返回
function PlayerProto:FlushAutoAddHotCardRet(proto)
    RoleMgr:FlushAutoAddHotCardRet(proto.cards)
    EventMgr.Dispatch(EventType.CardCool_Update)
end

-- 累计抽卡
function PlayerProto:CardPoolOpen(proto)
    CreateMgr:CardPoolOpen(proto.sum_pool_cnts)
end

-- 获取自动战斗的数据
function PlayerProto:GetAIStrategy(cids)
    local proto = {"PlayerProto:GetAIStrategy", {
        cid = cids
    }}
    NetMgr.net:Send(proto)
end

-- 返回自动战斗的数据
function PlayerProto:GetAIStrategyRet(proto)
    if proto and proto.data then
        for k, v in ipairs(proto.data) do
            if v.tStrategyData then
                for key, val in pairs(v.tStrategyData) do
                    AIStrategyMgr:AddData(v.cid, key, val);
                end
            end
        end
    end
    EventMgr.Dispatch(EventType.AIPreset_Update);
    -- LogTable(proto)
end

--- -- 设置自动战斗的数据
---@param list sSetAIStrategyData数组
function PlayerProto:SetAIStrategy(list)
    local proto = {"PlayerProto:SetAIStrategy", {
        data = list
    }}
    NetMgr.net:Send(proto)
end

function PlayerProto:SetAIStrategyRes(proto)
    -- LogTable(proto)
    EventMgr.Dispatch(EventType.AIPreset_SetRet, proto);
end

-- 切换自动战斗方案
function PlayerProto:SwitchAIStrategy(nTeamIndex, nCardIndex, nStrategyIndex)
    local proto = {"PlayerProto:SwitchAIStrategy", {
        nTeamIndex = nTeamIndex,
        nCardIndex = nCardIndex,
        nStrategyIndex = nStrategyIndex
    }}
    NetMgr.net:Send(proto)
end

-- 战斗中修改ai预设会走这条协议返回
function PlayerProto:SwitchAIStrategyRes(proto)
    -- LogTable(proto)
    EventMgr.Dispatch(EventType.AIPreset_Switch, proto);
end

-- 获取抽卡日志
function PlayerProto:GetCreateCardLogs(_card_pool_id, _skip, _GetCreateCardLogsCB)
    if (self.GetCreateCardLogsCB ~= nil) then
        return
    end
    self.GetCreateCardLogsCB = _GetCreateCardLogsCB
    local proto = {"PlayerProto:GetCreateCardLogs", {
        card_pool_id = _card_pool_id,
        skip = _skip
    }}
    NetMgr.net:Send(proto)
end

-- 获取抽卡建造日志返回
function PlayerProto:GetCreateCardLogsRet(proto)
    if (self.GetCreateCardLogsCB) then
        self.GetCreateCardLogsCB(proto)
    end
    self.GetCreateCardLogsCB = nil
end

function PlayerProto:CardCoreLv(_cid, _uf, _CardCoreLvCB)
    local proto = {"PlayerProto:CardCoreLv", {
        cid = _cid,
        uf = _uf
    }}
    NetMgr.net:Send(proto)
end
function PlayerProto:CardCoreLvRet(proto)
    RoleMgr:CardCoreLvRet(proto)

    -- rui数数 角色突破
    local cardData = RoleMgr:GetData(proto.cid)
    if (cardData) then
        local _datas = {}
        _datas.hero_id = cardData:GetID()
        _datas.hero_name = cardData:GetName()
        _datas.hero_level_max = cardData:GetMaxLv()
        if CSAPI.IsADV()==false then
            BuryingPointMgr:TrackEvents("RoleBreak", _datas)
        end
    end
end

-- 设置卡牌new
function PlayerProto:SetCardInfo(_cid, _is_new, _cb)
    self.SetCardInfoCB = _cb
    local proto = {"PlayerProto:SetCardInfo", {
        cid = _cid,
        is_new = _is_new
    }}
    NetMgr.net:Send(proto)
end
function PlayerProto:SetCardInfoRet(proto)
    RoleMgr:SetCardInfoRet(proto)
    if (self.SetCardInfoCB) then
        self.SetCardInfoCB()
    end
    self.SetCardInfoCB = nil
end

-- 设置角色new
function PlayerProto:LookRole(_role_id)
    local proto = {"PlayerProto:LookRole", {
        role_id = _role_id
    }}
    NetMgr.net:Send(proto)

    -- 设置已查看
    local cRole = CRoleMgr:GetData(_role_id)
    if (cRole) then
        cRole:SetIsNew(false)
    end
end

-- 兑换体能
function PlayerProto:ChangePlrHot()
    self.hot = PlayerClient:Hot()
    local proto = {"PlayerProto:ChangePlrHot", {}}
    NetMgr.net:Send(proto)
end

-- 兑换体能回调
function PlayerProto:ChangePlrHotRet(proto)
    PlayerClient:HotBuyCnt(proto.hot_buy_cnt)
    PlayerClient:Hot(proto.hot)

    EventMgr.Dispatch(EventType.Player_HotChange)
    CSAPI.OpenView("HotTipsPanel", {self.hot})
end

-- 获取爬塔数据
function PlayerProto:GetTowerData()
    local proto = {"PlayerProto:GetTowerData"}
    NetMgr.net:Send(proto)
end

-- 爬塔数据返回
function PlayerProto:TowerData(proto)
    -- Log("PlayerProto:TowerData")
    -- Log(proto)

    TowerMgr:UpdateTowerData(proto)
    if self.getSessionTaskReward then
        self.getSessionTaskReward()
        self.getSessionTaskReward = nil
    end
end

--获取章节任务完成奖励
function PlayerProto:GetSectionTaskReward(ids,callBack)
    self.getSessionTaskReward = callBack
    local proto = {"PlayerProto:GetSectionTaskReward",{ids = ids}}
    NetMgr.net:Send(proto)
end

-- 获取战场数据
function PlayerProto:GetBattleFieldData()
    local proto = {"PlayerProto:GetBattleFieldData"}
    NetMgr.net:Send(proto)
end

-- 战场数据返回
function PlayerProto:BattleFieldData(proto)
    Log("PlayerProto:BattleFieldData")
    Log(proto)
    BattleFieldMgr:SetDatas(proto)
end

-- 获取战场boss数据
function PlayerProto:GetBattleBossData()
    local proto = {"PlayerProto:GetBattleBossData"}
    NetMgr.net:Send(proto)
end

-- 战场boss数据返回
function PlayerProto:BattleBossData(proto)
    Log("PlayerProto:BattleBossData")
    Log(proto)
    BattleFieldMgr:SetBossData(proto)
end

function PlayerProto:GetBattleBossRank(page)
    local proto = {"PlayerProto:GetBattleBossRank", {
        nPage = page
    }}
    NetMgr.net:Send(proto)
end

function PlayerProto:GetBattleBossRankRet(proto)
    Log("PlayerProto:GetBattleBossRankRet")
    Log(proto)
    BattleFieldMgr:GetBossRankRet(proto)
end

function PlayerProto:DuplicateModUpData(_id)
    local data = _id and {
        id = _id
    } or {}
    local proto = {"PlayerProto:DuplicateModUpData", data}
    NetMgr.net:Send(proto)
end

function PlayerProto:DuplicateModUpDataRet(proto)
    Log("PlayerProto:DuplicateModUpDataRet")
    Log(proto)
    SweepMgr:SetDatas(proto)
end

-- 检查支付发货情况
function PlayerProto:PayReward(_id, _payType)
    local data = {
        id = _id,
        pay_type = _payType
    }
    local proto = {"PlayerProto:PayReward", data}
    NetMgr.net:Send(proto)
end

function PlayerProto:PayRewardRet(proto)
    SDKPayMgr:SetPayReward(proto);
end

function PlayerProto:GetNoticeMsg()
    EventMgr.Dispatch(EventType.SDK_QRPay_Over, true)
    SDKPayMgr:SearchPayReward();
end

-- -- 设置是否新皮肤
-- function PlayerProto:LookSkin(_id, _skin)
--     NetMgr.net:Send({"PlayerProto:LookSkin", {
--         id = _id,
--         skin = _skin
--     }})
-- end
-- function PlayerProto:LookSkinRet(proto)
--     RoleSkinMgr:LookSkinRet(proto)
-- end

-- 角色累计充值金额
function PlayerProto:PayRecharge()
    local proto = {"PlayerProto:PayRecharge"}
    NetMgr.net:Send(proto)
end
function PlayerProto:PayRechargeRet(proto)
    PlayerClient:PayRechargeRet(proto)
end

function PlayerProto:GetTaoFaCount(callBack)
    local proto = {"PlayerProto:GetTaoFaCount"}
    NetMgr.net:Send(proto)
end

function PlayerProto:GetTaoFaCountRet(proto)
    EventMgr.Dispatch(EventType.TaoFa_Count_Refresh, proto)
end

function PlayerProto:BuyTaoFaCount(data)
    local proto = {"PlayerProto:BuyTaoFaCount", data}
    NetMgr.net:Send(proto)
end

function PlayerProto:BuyTaoFaCountRet(proto)
    EventMgr.Dispatch(EventType.TaoFa_Count_BuyRefresh, proto)
end

-- 更改角色(返回角色更新)
function PlayerProto:ChangeCardCfgId(_cid, _cfgid)
    local proto = {"PlayerProto:ChangeCardCfgId", {
        cid = _cid,
        cfgid = _cfgid
    }}
    NetMgr.net:Send(proto)
end
function PlayerProto:ChangeCardCfgIdRet(proto)
    LanguageMgr:ShowTips(3014)
end

-- 切换卡牌形态
function PlayerProto:ChangeCardTcSkill(_cid, _oldSkillId, _useSkillId)
    local proto = {"PlayerProto:ChangeCardTcSkill", {
        cid = _cid,
        oldSkillId = _oldSkillId,
        useSkillId = _useSkillId
    }}
    NetMgr.net:Send(proto)
end
function PlayerProto:ChangeCardTcSkillRet(proto)
    LanguageMgr:ShowTips(3014)
end

-- 更换头像框
function PlayerProto:SetIconFrame(_icon_frame)
    local proto = {"PlayerProto:SetIconFrame", {
        icon_frame = _icon_frame
    }}
    NetMgr.net:Send(proto)
end
function PlayerProto:SetIconFrameRet(proto)
    PlayerClient:SetHeadFrame(proto.icon_frame)
    EventMgr.Dispatch(EventType.Head_Frame_Change, proto)
end

-- 解禁通知
function PlayerProto:CardChangeOpenNotice(proto)
    RoleMgr:AddJieJinDatas(proto)
end

-- 活动入场卷购买
function PlayerProto:BuyArachnidCount(_buy_cnt,_sectionId,callBack)
    self.buyArachnidCount = callBack
    local proto = {"PlayerProto:BuyArachnidCount", {
        buy_cnt = _buy_cnt,
        sectionId = _sectionId
    }}
    NetMgr.net:Send(proto)
end

-- 活动入场卷购买返回
function PlayerProto:BuyArachnidCountRet(proto)
    DungeonMgr:SetArachnidCount(proto)
    if self.buyArachnidCount then
        self.buyArachnidCount(proto)
        self.buyArachnidCount = nil
    end
end

-- 设置头像框
function PlayerProto:SetIcon(_icon_id)
    local proto = {"PlayerProto:SetIcon", {
        icon_id = _icon_id
    }}
    NetMgr.net:Send(proto)
end
function PlayerProto:SetIconRet(proto)
    PlayerClient:SetIconId(proto.icon_id)
    EventMgr.Dispatch(EventType.Head_Icon_Change, proto)
end

-- 异构空间获取角色hp和sp
function PlayerProto:GetNewTowerCardInfo()
    local proto = {"PlayerProto:GetNewTowerCardInfo"}
    NetMgr.net:Send(proto)
end

-- 异构空间获取角色hp和sp返回
function PlayerProto:GetNewTowerCardInfoRet(proto)
    Log("PlayerProto:GetNewTowerCardInfoRet")
    TowerMgr:SetCardInfos(proto)
end

-- 重置异构空间角色hp和sp
function PlayerProto:ResetNewTowerCardInfo(sid, cb)
    self.ResetCardInfoCallBack = cb
    local proto = {"PlayerProto:ResetNewTowerCardInfo", {
        sid = sid
    }}
    NetMgr.net:Send(proto)
end

-- 异构空间助战卡牌返回
function PlayerProto:NewTowerAssitCardRet(proto)
    TowerMgr:SetAssistCardInfos(proto)
end

-- 获取异构空间今天的剩余重置次数
function PlayerProto:GetNewTowerResetCnt()
    local proto = {"PlayerProto:GetNewTowerResetCnt"}
    NetMgr.net:Send(proto)
end

-- 获取异构空间今天的剩余重置次数返回
function PlayerProto:GetNewTowerResetCntRet(proto)
    Log("PlayerProto:GetNewTowerResetCntRet")
    Log(proto)
    TowerMgr:SetResetCnt(proto)
    if self.ResetCardInfoCallBack then
        self.ResetCardInfoCallBack()
        self.ResetCardInfoCallBack = nil
    end
end

-- 获取副本的怪物hp和sp
function PlayerProto:GetDupMonsterHpInfo(dungeonId)
    local proto = {"PlayerProto:GetDupMonsterHpInfo", {
        id = dungeonId
    }}
    NetMgr.net:Send(proto)
end

-- 获取副本的怪物hp和sp返回
function PlayerProto:GetDupMonsterHpInfoRet(proto)
    Log("PlayerProto:GetDupMonsterHpInfoRet")
    Log(proto)
    TowerMgr:SetDatas(proto)
end

-- 修改主角返回
function PlayerProto:ChangePlrShpaeRet(proto)
    --PlayerClient:SetPanelId(proto.panel_id)
    PlayerClient:SetIconId(proto.icon_id)
    --PlayerClient:SetLastRoleID(proto.role_panel_id)
    if self.changePlrShpaeCallBack then
        self.changePlrShpaeCallBack(proto);
        self.changePlrShpaeCallBack = nil
    end
    --更换队长（角色、看板）
    CRoleMgr:ChangeLeader(proto.ocfgid or {})
    --CRoleDisplayMgr:ChangeLeader(proto.ocfgid)
end

-- 回归玩家判断(服务器推送)
function PlayerProto:CheckReturningPlr(proto)
    RegressionMgr:CheckReturningPlr(proto)
    EventMgr.Dispatch(EventType.HuiGui_Check)
end

function PlayerProto:ClickBoard()
    local proto = {"PlayerProto:ClickBoard"}
    NetMgr.net:Send(proto)
end

-- 修改角色名
function PlayerProto:ChangePlrName(_name, _item_id)
    local proto = {"PlayerProto:ChangePlrName", {
        name = _name,
        item_id = _item_id
    }}
    NetMgr.net:Send(proto)
end

function PlayerProto:ChangePlrNameRet()
    -- self.changePlrShpaeCallBack = nil
    EventMgr.Dispatch(EventType.Player_EditName)
end

-- 获取特殊掉落数量
function PlayerProto:GetSpecialDropsInfo()
    local proto = {"PlayerProto:GetSpecialDropsInfo"}
    NetMgr.net:Send(proto)
end

function PlayerProto:GetSpecialDropsInfoRet(proto)
    PlayerMgr:UpdateSpecialDrops(proto)
end

-- -- 修改背景 
-- function PlayerProto:SetBackground(id, cb)
--     self.SetBackgroundCB = cb
--     local proto = {"PlayerProto:SetBackground", {
--         background_id = id
--     }}
--     NetMgr.net:Send(proto)
-- end
-- function PlayerProto:SetBackgroundRet(proto)
--     PlayerClient:SetBG(proto.background_id)
--     EventMgr.Dispatch(EventType.Player_Select_BG)
--     if (self.SetBackgroundCB) then
--         self.SetBackgroundCB(proto.background_id)
--     end
--     self.SetBackgroundCB = nil
-- end

--十二宫获取挑战开启信息
function PlayerProto:GetStarPalaceInfo()
    local proto = {"PlayerProto:GetStarPalaceInfo", {}}
    NetMgr.net:Send(proto)
end

--十二宫获取挑战开启信息返回
function PlayerProto:GetStarPalaceInfoRet(proto)
    TotalBattleMgr:SetInfo(proto)
end

--十二宫不可使用的卡牌
function PlayerProto:DeathCardInfos(proto)
    TotalBattleMgr:CardCacheAdd(proto)
end

--放弃获开启挑战
function PlayerProto:GiveUpStarPalaceChallenge()
    local proto = {"PlayerProto:GiveUpStarPalaceChallenge", {}}
    NetMgr.net:Send(proto)
end

--十二星宫排行榜
function PlayerProto:GetStarRank(page,sid)
    local proto = {"PlayerProto:GetStarRank", {nPage=page,rank_type=sid}}
    NetMgr.net:Send(proto)
end

--十二星宫排行榜返回
function PlayerProto:GetStarRankRet(proto)
    RankMgr:GetRankRet(proto)
end

--获取累充的领取状态
function PlayerProto:GetColletData()
    local proto = {"PlayerProto:GetColletData"}
    NetMgr.net:Send(proto)
end
function PlayerProto:GetColletDataRet(proto)
    AccuChargeMgr:GetColletDataRet(proto)
end
function PlayerProto:TakeColletReward(_id,_cb)
    self.TakeColletRewardCB = _cb 
    local proto = {"PlayerProto:TakeColletReward",{id = _id}}
    NetMgr.net:Send(proto)
end
function PlayerProto:TakeColletRewardRet(proto)
    if(self.TakeColletRewardCB) then 
        self.TakeColletRewardCB(proto.id)
    end
    self.TakeColletRewardCB = nil 
end

--改性
function PlayerProto:ChangePlrShpae(data, callBack)
    local proto = {"PlayerProto:ChangePlrShpae",data}
    NetMgr.net:Send(proto)
    self.changePlrShpaeCallBack = callBack
end

--双人看板
function PlayerProto:GetNewPanel(b)
    self.GetNewPanel_Loging = b 
    local proto = {"PlayerProto:GetNewPanel"}
    NetMgr.net:Send(proto)
end
function PlayerProto:SetNewPanel(_panels,_setting,_random,_using,_cb)
    self.SetNewPanelCB = _cb 
    local proto = {"PlayerProto:SetNewPanel",{panels = _panels,	setting=_setting,random=_random,using = _using}}
    NetMgr.net:Send(proto)
end
function PlayerProto:GetNewPanelRet(proto)
    local old_curData = CRoleDisplayMgr:GetCopyCurData()
    CRoleDisplayMgr:GetNewPanelRet(proto,self.GetNewPanel_Loging)
    if(self.GetNewPanel_Loging) then
        CRoleDisplayMgr:LoginCheck()
    else 
        CRoleDisplayMgr:NormalCheck1(old_curData)
        if(self.SetNewPanelCB) then 
            self.SetNewPanelCB(old_curData)
        end
        self.SetNewPanelCB = nil 
    end 
    self.GetNewPanel_Loging = nil 
    EventMgr.Dispatch(EventType.CRoleDisplayMain_Change)
end
function PlayerProto:GetRandomPanelRet(proto)
    CRoleDisplayMgr:GetRandomPanelRet(proto)
end

function PlayerProto:SetNewPanelUsing(_using,_noIn)
    self.SetNewPanelUsing_noIn = _noIn
    local proto = {"PlayerProto:SetNewPanelUsing",{using = _using}}
    NetMgr.net:Send(proto)
end
function PlayerProto:SetNewPanelUsingRet(proto)
    CRoleDisplayMgr:SetNewPanelUsingRet(proto,self.SetNewPanelUsing_noIn)
    self.SetNewPanelUsing_noIn = nil
end

--活动排行榜
function PlayerProto:GetRank(page,sid)
    local proto = {"PlayerProto:GetRank", {nPage=page,rank_type=sid}}
    NetMgr.net:Send(proto)
end

--活动排行榜返回
function PlayerProto:GetRankRet(proto)
    RankMgr:GetRankRet(proto)
end

function PlayerProto:GetMineRankInfo(type)
    local proto = {"PlayerProto:GetMineRankInfo", {rank_type = type}}
    NetMgr.net:Send(proto)
end

function PlayerProto:GetMineRankInfoRet(proto)
    EventMgr.Dispatch(EventType.Dungeon_Activity_RankInfo,proto)
end

--请求查看排行榜阵容
function PlayerProto:GetRankTeamInfo(type,index,cb)
    self.RankTeamInfoCallBack = cb
    local proto = {"PlayerProto:GetRankTeamInfo", {rankType=type,rankIdx=index}}
    NetMgr.net:Send(proto)
end

--请求查看排行榜阵容返回
function PlayerProto:GetRankTeamInfoRet(proto)
    if self.RankTeamInfoCallBack then
        self.RankTeamInfoCallBack(proto)
        self.RankTeamInfoCallBack = nil
    end
    if self.CopyRankTeamCallBack then
        self.CopyRankTeamCallBack(proto)
        self.CopyRankTeamCallBack = nil
    end
end

--请求替换排行榜阵容
function PlayerProto:CopyRankTeam(type,index,cb)
    self.CopyRankTeamCallBack = cb
    local proto = {"PlayerProto:CopyRankTeam", {rankType=type,rankIdx=index}}
    NetMgr.net:Send(proto)
end

--请求替换排行榜阵容
function PlayerProto:ClearRank(proto)
    RankMgr:ClearRank(proto)
end

function PlayerProto:GetOpenConditionTime()
    local proto = {"PlayerProto:GetOpenConditionTime", {}}
    NetMgr.net:Send(proto)
end

function PlayerProto:GetOpenConditionTimeRet(proto)
    PlayerMgr:SetOpenTimes(proto)
end

--获取已拥有的音乐
function PlayerProto:GetAllMusic()
    local proto = {"PlayerProto:GetAllMusic"}
    NetMgr.net:Send(proto)
end
function PlayerProto:GetAllMusicRet(proto)
    
end

---支付完成订单通知	游戏订单id	中台订单id
------3639
function PlayerProto:PayFinishOrderId(proto)
    if proto then
        if CSAPI.IsADV() then
            SDKPayMgr:SearchPayRewardAtOne();
            SDKPayMgr:StopSearchPayReward();
        else
            if CSAPI.IsDomestic() then
                if proto.gameOrderId then
                    ShiryuSDK.ClosePurchasePage(proto.gameOrderId)
                else
                    LogError(" PlayerProto:PayFinishOrderId:"..tostring(proto,true))
                end
            end
        end
    end
end


--设置 isEquip:R5上锁状态
function PlayerProto:Setting(isEquip,callback)
    self.SettingCallBack = callback
    local proto = {"PlayerProto:Setting",{equip_state = isEquip}}
    NetMgr.net:Send(proto)
end

--设置返回
function PlayerProto:SettingRet(proto)
    if self.SettingCallBack then
        self.SettingCallBack(proto and proto.res or false)
        self.SettingCallBack = nil
    end
end

--称号
function PlayerProto:SetIconTitle(_icon_title)
    local proto = {"PlayerProto:SetIconTitle",{icon_title = _icon_title}}
    NetMgr.net:Send(proto)
end
function PlayerProto:SetIconTitleRet(proto)
    PlayerClient:SetIconTitle(proto.icon_title)
    EventMgr.Dispatch(EventType.Head_Title_Change, proto)
end

--清除关卡数据
function PlayerProto:ClearDuplicateRet(proto)
    DungeonMgr:ClearDungeonData(proto.dupIds)
end
--------------------------------------------------------------------------------------------------------
--设置随机看板(新增或者修改)
function PlayerProto:SetRandomPanel(_random_panel)
    local proto = {"PlayerProto:SetRandomPanel",{random_panel = _random_panel}}
    NetMgr.net:Send(proto)
end
function PlayerProto:SetRandomPanelRet(proto)
    CRoleDisplayMgr:SetRandomPanelRet(proto)
    EventMgr.Dispatch(EventType.CRoleDisplayS_Change)
end

--获取随机看板详细
function PlayerProto:GetRandomPanelDetail(_idx,cb)
    self.GetRandomPanelDetailCB = cb
    local proto = {"PlayerProto:GetRandomPanelDetail",{idx = _idx}}
    NetMgr.net:Send(proto)
end
function PlayerProto:GetRandomPanelDetailRet(proto)
    CRoleDisplayMgr:GetRandomPanelDetailRet(proto)
    if(self.GetRandomPanelDetailCB) then 
        self.GetRandomPanelDetailCB(proto)
    end 
    self.GetRandomPanelDetailCB = nil
end

--移除随机看板
function PlayerProto:RemoveRandomPanel(_idx)
    local proto = {"PlayerProto:RemoveRandomPanel",{idx = _idx}}
    NetMgr.net:Send(proto)
end
function PlayerProto:RemoveRandomPanelRet(proto)
    CRoleDisplayMgr:RemoveRandomPanelRet(proto.idx)
    EventMgr.Dispatch(EventType.CRoleDisplayS_Change)
end

--设置当前看板随机类型
function PlayerProto:SetPanelRandomType(_using_type,cb)
    self.SetPanelRandomTypeCB = cb
    local proto = {"PlayerProto:SetPanelRandomType",{random_type = _using_type}}
    NetMgr.net:Send(proto)
end
function PlayerProto:SetPanelRandomTypeRet(proto)
    CRoleDisplayMgr:SetPanelRandomTypeRet(proto.random_type)
    if(self.SetPanelRandomTypeCB) then 
        self.SetPanelRandomTypeCB()
    end     
    self.SetPanelRandomTypeCB = nil
end

--获取累充的领取状态
function PlayerProto:GetColletDataByType(_type)
    local proto = {"PlayerProto:GetColletDataByType",{type = _type}}
    NetMgr.net:Send(proto)
end
function PlayerProto:GetColletDataByTypeRet(proto)
    if(proto.type==eCollectType.Recharge1)then 
        AccuChargeMgr:GetColletDataByTypeRet(proto)
    elseif(proto.type==eCollectType.Recharge2)then 
        AccuChargeMgr:GetColletDataByTypeRet3(proto)
    end 
end

--领取奖励(会先返回GetColletDataByTypeRet)
function PlayerProto:TakeColletRewardByType(_type,_id,_cb)
    self.TakeColletRewardByTypeCB = _cb
    local proto = {"PlayerProto:TakeColletRewardByType",{type = _type,id = _id}}
    NetMgr.net:Send(proto)
end
function PlayerProto:TakeColletRewardByTypeRet(proto)
    if(self.TakeColletRewardByTypeCB) then 
        self.TakeColletRewardByTypeCB(proto.id)
    end 
    self.TakeColletRewardByTypeCB = nil
    EventMgr.Dispatch(EventType.Activity_List_Panel_Refresh)
end

--手动转换物品
function PlayerProto:ConverItem(_id,_ix,_cnt)
    if _id and _ix and _cnt then
        local proto = {"PlayerProto:ConverItem",{id = _id,ix = _ix,cnt=_cnt}}
        NetMgr.net:Send(proto)
    end
end

function PlayerProto:ConverItemRet(proto)
    -- if proto then--更新背包数据
        
    -- end
    EventMgr.Dispatch(EventType.Goods_Converted_Success,proto)
end

--通知服务端有皮肤到期
function PlayerProto:SkinExpired()
    local proto = {"PlayerProto:SkinExpired"}
    NetMgr.net:Send(proto)
end
function PlayerProto:SkinExpiredRet(proto)
    LanguageMgr:ShowTips(1054)
    RoleSkinMgr:SkinExpiredRet(proto.ids)
end

--设置PVP表情
function PlayerProto:SetIconEmote(_icon_emotes,_cb)
    self.SetIconEmoteCB = _cb
    local proto = {"PlayerProto:SetIconEmote",{icon_emotes=_icon_emotes}}
    NetMgr.net:Send(proto)
end
function PlayerProto:SetIconEmoteRet(proto)
    --LanguageMgr:ShowTips(49001)
    PlayerClient:SetEmotes(proto.icon_emotes)
    EventMgr.Dispatch(EventType.Head_Face_Change)
    if(self.SetIconEmoteCB)then 
        self.SetIconEmoteCB()
    end 
    self.SetIconEmoteCB = nil
end

function PlayerProto:SetSelfChoiceCardPoolCard(_id,_cids)
    local proto = {"PlayerProto:SetSelfChoiceCardPoolCard",{id=_id,cids=_cids}}
    NetMgr.net:Send(proto)
end
function PlayerProto:SetSelfChoiceCardPoolCardRet(proto)
    CreateMgr:SetSelfChoiceCardPoolCardRet(proto)
end

--获取积分战斗的分数
function PlayerProto:GetBuffBattleInfo(sid ,callBack)
    self.buffBattleInfoCallBack = callBack
    local proto = {"PlayerProto:GetBuffBattleInfo",{sid = sid}}
    NetMgr.net:Send(proto)
end

--获取积分战斗的分数返回
function PlayerProto:GetBuffBattleInfoRet(proto)
    if self.buffBattleInfoCallBack then
        self.buffBattleInfoCallBack(proto)
        self.buffBattleInfoCallBack = nil
    end
end

--修改角色名与性别
function PlayerProto:ChangePlrNameAndSex(data,callBack)
    self.changePlrNameAndSexCallBack = callBack
    local proto = {"PlayerProto:ChangePlrNameAndSex",data}
    NetMgr.net:Send(proto)
end

function PlayerProto:ChangePlrNameAndSexRet(proto)
    if self.changePlrNameAndSexCallBack then
        self.changePlrNameAndSexCallBack(proto)
        self.changePlrNameAndSexCallBack = nil
    end
end

--批量使用物品
function PlayerProto:UseItemList(infos,isOpenReward,callBack)
    self.isOpenReward = isOpenReward;
    self.useItemListCallBack=callBack
    local proto = {"PlayerProto:UseItemList",{infos=infos}}
    NetMgr.net:Send(proto)
end

-- 使用背包中的物品的回调
function PlayerProto:UseItemListRet(proto)
    if proto and proto.infos and self.isOpenReward and proto.gets ~= nil and #proto.gets > 0 then
        UIUtil:OpenReward({proto.gets}, {
            isNoShrink = not proto.isMerge
        });
    end
    if self.useItemListCallBack then
        self.useItemListCallBack(proto);
        self.useItemListCallBack = nil;
    end

    -- 使用体能道具
    if proto and proto.infos then
        local total=0;
        for k, v in ipairs(proto.infos ) do
            if (v.id == 10036 or v.id == 10037) then
                local cfg = Cfgs.ItemInfo:GetByID(v.id)
                total=total+ cfg.dy_value2 * v.cnt
            end
        end
        if total>0 then
            local per = PlayerClient:Hot()-total;
            EventMgr.Dispatch(EventType.Player_HotChange)
            CSAPI.OpenView("HotTipsPanel", {per})
        end
    end
end


--永域战境 队员恢复
function PlayerProto:ResetEternalBattleCardInfo(sid)
    local proto = {"PlayerProto:ResetEternalBattleCardInfo",{sid=sid}}
    NetMgr.net:Send(proto)
end

function PlayerProto:GetEternalBattleCardInfo()
    local proto = {"PlayerProto:GetEternalBattleCardInfo"}
    NetMgr.net:Send(proto)
end

function PlayerProto:GetEternalBattleInfoRet(proto)
    TowerMgr:SetCardInfos2(proto)
end

function PlayerProto:EternalBattleAssitCardRet(proto)
    TowerMgr:SetAssistCardInfos(proto)
end

--皮肤通行证 获取数据
function PlayerProto:GetSkinPassData()
    local proto = {"PlayerProto:GetSkinPassData"}
    NetMgr.net:Send(proto)
end

--皮肤通行证 获取数据返回
function PlayerProto:GetSkinPassDataRet(proto)
    OperationActivityMgr:SetSkinPassDatas(proto)
end

--皮肤通行证 领取奖励
function PlayerProto:SkinPassGetReward(id,index)
    local proto = {"PlayerProto:SkinPassGetReward",{id = id,idx = index}}
    NetMgr.net:Send(proto)
end

--皮肤通行证 领取奖励返回
function PlayerProto:SkinPassGetRewardRet(proto)
    OperationActivityMgr:UpdateSkinPassReward(proto)
end

--皮肤通行证 进入挑战战斗
function PlayerProto:EnterSkinPassFight(id,index,dungeonId)
    local proto = {"PlayerProto:EnterSkinPassFight",{id = id,idx = index,dupId = dungeonId}}
    NetMgr.net:Send(proto)
end

function PlayerProto:SkinPassUpgrade(id,level)
     local proto = {"PlayerProto:SkinPassUpgrade",{id = id,lv = level}}
    NetMgr.net:Send(proto)
end

function PlayerProto:SkinPassUpgradeRet(proto)
    OperationActivityMgr:UpdateSkinPassLevel(proto)
end


--一键添加所有皮肤
function PlayerProto:AddRandomSkinsAll(_ids,_random_type)
    local proto = {"PlayerProto:AddRandomSkinsAll",{ids=_ids,random_type =_random_type}}
    NetMgr.net:Send(proto)
end
function PlayerProto:AddRandomSkinsAllRet(proto)
    CRoleDisplayMgr:AddRandomSkinsAllRet(proto)
    if(proto.finish)then 
        EventMgr.Dispatch(EventType.CRoleDisplayS_Change)
    end 
end

--预设名称
function PlayerProto:SetRandomPanelName(_random_type,_name,_cb)
    self.SetRandomPanelNameCB = _cb
    local proto = {"PlayerProto:SetRandomPanelName",{random_type=_random_type,name =_name}}
    NetMgr.net:Send(proto)
end
function PlayerProto:SetRandomPanelNameRet(proto)
   CRoleDisplayMgr:SetRandomPanelNameRet(proto)
   if(self.SetRandomPanelNameCB)then 
        self.SetRandomPanelNameCB()
   end
   self.SetRandomPanelNameCB = nil
end

--清空
function PlayerProto:RandomPanelClean(_random_type,_idx)
    local proto = {"PlayerProto:RandomPanelClean",{random_type=_random_type,idx = _idx}}
    NetMgr.net:Send(proto)
end
function PlayerProto:RandomPanelCleanRet(proto)
   CRoleDisplayMgr:RandomPanelCleanRet(proto)
   EventMgr.Dispatch(EventType.CRoleDisplayS_Change)
end

--专武升级
function PlayerProto:UpgradeWeaponLv(_cid)
    local proto = {"PlayerProto:UpgradeWeaponLv",{cid = _cid}}
    NetMgr.net:Send(proto)
end
function PlayerProto:UpgradeWeaponLvRet(proto)
    local cardData = RoleMgr:GetData(proto.cid)
    if cardData then
        cardData:SetWeaponLv(proto.weaponLv)
    end
    CSAPI.OpenView("RoleWeaponUpSuccess", proto)
    RoleMgr:UpdateCardEvent(CardUpdateType.Weapon, proto.cid)
end

--更换主题
function PlayerProto:MainUIChangeTheme(_themeId,_cb)
    self.MainUIChangeThemeCB = _cb
    local proto = {"PlayerProto:MainUIChangeTheme",{themeId = _themeId}}
    NetMgr.net:Send(proto)
end

--更换返回+登录返回
function PlayerProto:MainUIThemeDataRet(proto)
    MenuThemeMgr:SetMenuThemeID(proto.curThemeId)
    if(self.MainUIChangeThemeCB)then 
        self.MainUIChangeThemeCB()
    end
    self.MainUIChangeThemeCB = nil
end

function PlayerProto:OneKeyMainTalentUpgrade(_infoArr)
    local proto = {"PlayerProto:OneKeyMainTalentUpgrade",{infoArr = _infoArr}}
    NetMgr.net:Send(proto)
end
function PlayerProto:OneKeyMainTalentUpgradeRet(proto)
    RoleMgr.OnBagUpdate2(1)
    EventMgr.Dispatch(EventType.MainTalent_Upgrade)
end

