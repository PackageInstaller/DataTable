require "RoleCommon" -- 角色常量定义
require "RoleSortUtil" -- 排序工具
require "RoleTool" -- 角色工具
require "RoleUniteUtil" -- 角色同调工具

local this = MgrRegister("RoleMgr")

function this:Init()
    self:Clear()
    -- self:SetSortTab()
    self:CardsData()
    -- EventMgr.AddListener(EventType.Bag_Update, this.OnBagUpdate)
    -- 特效技能红点查看记录
    self.passiveRedIsLookDatas = {}
    PlayerProto:GetClientData("passiveRed_isLook")
end

function this:Clear()
    self.datas = {}
    self.cards = {}
    self.scaleTypes = {} -- 大小图
    self.sortTypes = {} -- 排序
    self.orderTypes = {} -- 升降
    -- EventMgr.RemoveListener(EventType.Bag_Update, this.OnBagUpdate)
end

-- 材料更新,跃升突破检查(延迟调用，优化物品大量刷新的情况)
function this.OnBagUpdate(isLogin)
    if (this.applyRefresh) then
        return
    end
    this.isLogin = isLogin
    this.applyRefresh = 1
    FuncUtil:Call(this.OnBagUpdate2, nil, 100)
end
function this.OnBagUpdate2(num)
    this.applyRefresh = num
    if (this.cards) then
        for k, v in pairs(this.cards) do
            v:CheckPassiveUp0(this.isLogin)
            v:GoodsUpdate()
        end
        RoleMgr:CheckRed()
    end
end

-- 检查升级突破的红点
function this:CheckRed()
    local num = nil
    local cards = RoleMgr:GetDatas()
    for i, v in pairs(self.cards) do
        if (v:IsPassiveRed()) then -- 特性技能可升级 
            num = 1
            break
        end
        if (v:IsRed()) then
            num = 1
            break
        end
    end
    RedPointMgr:UpdateData(RedPointType.RoleList, num)
end

-- 设置卡牌数据
function this:SetDatas(proto)
    self.datas = proto
    if (proto.cards) then
        for index, crad in ipairs(proto.cards) do
            self:UpdateCardsData(crad)
        end
    end
end

-- 更新卡牌数据
function this:UpdateData(newData)
    if (newData) then
        for i, v in ipairs(newData) do
            self:UpdateCardsData(v)
        end
    end
end

function this:UpdateCardsData(v)
    self.cards = self.cards or {}
    local cardData = self:GetData(v.cid)
    if (cardData) then
        cardData:Init(v)
    else
        local _card = CharacterCardsData(v, true) -- 真实获得的卡牌
        self.cards[v.cid] = _card
    end
end

-- 更新热值
function this:FlushAutoAddHotCardRet(cards)
    if (cards) then
        for i, v in ipairs(cards) do
            local cardData = self:GetData(v.cid)
            if (cardData) then
                local _data = cardData:GetData()
                for k, m in pairs(v) do
                    _data[k] = m
                end
            end
        end
    end
end

----------------------------------////set/get
-- 获取卡牌数据,字典型
function this:GetDatas()
    return self.cards
end

-- 获取卡牌数据，数组型
function this:GetArr()
    local arr = {}
    if (self.cards) then
        for _, data in pairs(self.cards) do
            if (data) then
                table.insert(arr, data)
            end
        end
    end
    return arr
end

-- 获取单个数据
function this:GetData(cid)
    if (cid == nil) then
        LogError("获取数据失败！！id无效")
        return nil
    end
    if (self.cards) then
        return self.cards[cid]
    end
    return nil
end

-- 通过模型表id,获取角色穿戴的皮肤（如果该角色设置了看板，则返回看板的）
function this:GetSkinIDByRoleID(roleID)
    local modelId = nil
    local b = false -- 是否已设置看板 
    -- if (PlayerClient:KBIsRole()) then
    --     local cfg = Cfgs.character:GetByID(PlayerClient:GetIconId())
    --     if (cfg and cfg.role_id and cfg.role_id == roleID) then
    --         modelId = PlayerClient:GetIconId()
    --     end
    -- end
    if (not modelId) then
        local cRoleInfo = CRoleMgr:GetData(roleID)
        local cfgID = cRoleInfo:GetFirstCardId()
        for i, v in pairs(self.cards) do
            if (v:GetID() == cfgID) then
                return v:GetSkinID()
            end
        end
        modelId = cRoleInfo:GetFirstSkinId()
    end
    return modelId
end

-- 表id是否存在
function this:CheckCfgIdExist(cfgId)
    for i, v in pairs(self.cards) do
        if (v:GetCfgID() == cfgId) then
            return true,v
        end
    end
    return false
end

---- 根据cfgId集合获取卡牌集合
function this:GetCardsByCfgIDs(cfgIds, curId)
    local selectCards = {}
    local cards = RoleMgr:GetDatas()
    for i, v in pairs(self.cards) do
        if (v:GetID() ~= curId) then
            for k = 1, #cfgIds do
                if (v:GetCfgID() == cfgIds[k]) then
                    table.insert(selectCards, v)
                end
            end
        end
    end
    return selectCards
end

-- 根据cfgId获取卡牌集合
function this:GetCardsByCfgID(cfgId, curID)
    local selectCards = nil
    for i, v in pairs(self.cards) do
        if (v:GetCfgID() == cfgId) then
            if (curID == nil or curID ~= v:GetID()) then
                selectCards = selectCards or {}
                table.insert(selectCards, v)
            end
        end
    end
    return selectCards
end

--适配新版（一个id只有一个卡牌）
function this:GetDataByCfgID(cfgId)
    for i, v in pairs(self.cards) do
        if (v:GetCfgID() == cfgId) then
            return v
        end
    end
    return nil
end

-- 根据角色标签返回卡牌集合
function this:GetCardsByRoleTag(roleTag)
    local cards = nil
    for i, v in pairs(self.cards) do
        if (v:GetRoleTag() == roleTag) then
            cards = cards or {}
            table.insert(cards, v)
        end
    end
    return cards
end

-- 返回剔除过cfgIds的卡牌集合
function this:GetCardsByExcludeIds(excludsIds)
    local cards = nil
    for _, v in pairs(self.cards) do
        if excludsIds ~= nil then
            local hasId = false;
            for key, val in ipairs(excludsIds) do
                local cfg = Cfgs.CardData:GetByID(val);
                if (v:GetCfgID() == val or (cfg and v:GetRoleTag() == cfg.role_tag)) then
                    hasId = true;
                    break
                end
            end
            if hasId == false then
                cards = cards or {}
                table.insert(cards, v);
            end
        else
            cards = cards or {}
            table.insert(cards, v)
        end
    end
    return cards
end

function this:GetCurSize()
    return self.datas.cur_size or 0
end

function this:GetMaxSize()
    return self.datas.max_size or 0
end

function this:GetStoreExp()
    return self.datas.store_exp or 0
end

-- 刷新存储的经验
function this:UpdateStoreExp(exp)
    self.datas.store_exp = exp
end

-- 改名冷却列表
function this:GetRenameList()
    return self.rename_records
end

-- 根据品质获取卡牌
function this:GetDataByQuality(_quality)
    local newDatas = {}
    local datas = self:GetDatas()
    for i, v in pairs(datas) do
        if (v:GetQuality() == _quality) then
            table.insert(newDatas, v)
        end
    end
    return newDatas
end

-- 移除数据
function this:RemoveData(cid)
    if (cid == nil) then
        LogError("移除数据失败！！id无效")
        return nil
    end
    if (self.cards) then
        self.cards[cid] = nil
    end
end

-- 创建假数据
function this:GetFakeData(cfgId, num)
    local cfgData = Cfgs.CardData:GetByID(cfgId)
    local data = {}
    table.copy(cfgData, data)
    data.cfgid = cfgId
    -- data.name = cfgData.name
    data.num = num or 1
    data.level = 1
    data.break_level = 1
    data.intensify_level = 1
    data.skin = nil -- 与表的冲突
    -- 封装技能天赋
    local skillDatas = {}
    if (cfgData) then
        if (cfgData.jcSkills) then
            for i, v in ipairs(cfgData.jcSkills) do
                local data = {
                    id = v,
                    exp = 0,
                    type = SkillMainType.CardNormal
                }
                table.insert(skillDatas, data)
            end
        end
        if (cfgData.tfSkills) then
            local data = {
                id = cfgData.tfSkills[1],
                exp = 0,
                type = SkillMainType.CardTalent
            }
            table.insert(skillDatas, data)
        end
    end
    data.skills = skillDatas
    data.mix_data = {}
    data.mix_data.cl = RoleTool.GetMaxCoreLv(cfgData.quality)
    local _card = CharacterCardsData(data)
    return _card
end

-- 满级的假数据 
function this:GetMaxFakeData(cfgId, level, break_level)
    local cfgData = Cfgs.CardData:GetByID(cfgId)
    local data = {}
    table.copy(cfgData, data)
    data.cfgid = cfgId
    data.level = level or RoleTool.GetMaxLv()
    data.break_level = break_level or RoleTool.GetMaxBreakLv()
    data.skin = nil -- 与表的冲突
    -- 封装技能天赋
    local skillDatas = {}
    if (cfgData) then
        if (cfgData.jcSkills) then
            for i, v in ipairs(cfgData.jcSkills) do
                local _cfg = Cfgs.skill:GetByID(v)
                local _cfgs = Cfgs.skill:GetGroup(_cfg.group)
                local data = {
                    id = _cfgs[#_cfgs].id,
                    exp = 0,
                    type = SkillMainType.CardNormal
                }
                table.insert(skillDatas, data)
            end
        end
        -- 特性
        if (cfgData.tfSkills) then
            local _cfg = Cfgs.skill:GetByID(cfgData.tfSkills[1])
            local _cfgs = Cfgs.skill:GetGroup(_cfg.group)
            local data = {
                id = _cfgs[#_cfgs].id,
                exp = 0,
                type = SkillMainType.CardTalent
            }
            table.insert(skillDatas, data)
        end
        -- 特殊技能
        if (cfgData.tcSkills) then
            table.insert(skillDatas, {
                id = cfgData.tcSkills[1],
                exp = 0,
                type = SkillMainType.CardSpecial
            })
        end
    end
    data.skills = skillDatas
    -- 满级天赋
    data.sub_talent = {}
    local use = {}
    local subTfSkills = cfgData.subTfSkills
    local id = subTfSkills and subTfSkills[1] or nil
    local allDatas = Cfgs.CfgSubTalentSkillPool:GetByID(id)
    for n, m in ipairs(allDatas.ids) do
        local _cfg = Cfgs.CfgSubTalentSkill:GetByID(m.id)
        local _cfgs = Cfgs.CfgSubTalentSkill:GetGroup(_cfg.group)
        table.insert(use, _cfgs[#_cfgs].id)
    end
    data.sub_talent.use = use
    --
    data.mix_data = {}
    data.mix_data.cl = RoleTool.GetMaxCoreLv(cfgData.quality)
    local _card = CharacterCardsData(data)
    _card:SetMaxFakeCard()
    return _card
end

function this:SetSkills(cfgData)
    local skillDatas = {}
    if (cfgData) then
        if (cfgData.jcSkills) then
            for i, v in ipairs(cfgData.jcSkills) do
                local data = {
                    id = v,
                    exp = 0,
                    type = SkillMainType.CardNormal
                }
                table.insert(skillDatas, data)
            end
        end
        if (cfgData.tfSkills) then
            local data = {
                id = cfgData.tfSkills[1],
                exp = 0,
                type = SkillMainType.CardTalent
            }
            table.insert(skillDatas, data)
        end
    end
    return skillDatas
end

-- 能否分解
function this:CheckCanShell(cardData, showTips)
    local b = false
    local tips = ""
    if (cardData) then
        for i = 1, 1 do
            -- 锁定中
            if (cardData:IsLock()) then
                b = false
                tips = ""
                break
            end
            -- --冷却中
            -- if(CoolMgr:CheckIsIn(cardData:GetID())) then
            -- 	b = false
            -- 	tips = ""
            -- 	break
            -- end
            -- 技能提升中
            if (RoleSkillMgr:CheckIsIn(cardData:GetID())) then
                b = false
                tips = ""
                break
            end
            -- 编队中
            if (TeamMgr:CheckIsInTeam(cardData:GetID())) then
                b = false
                tips = ""
                break
            end
            -- 远征中
            if (cardData:IsInExpedition()) then
                b = false
                tips = ""
                break
            end
            b = true
        end
    end
    if (not b and showTips) then
        Tips.ShowTips(tips)
    end
    return b
end

-- 是否提升过
function this:IsUp(cardData)
    local b = false
    if (cardData:GetLv() > 1 or cardData:GetEXP() > 0 or cardData:GetBreakLevel() > 1) then
        return true
    end
    -- 技能
    local skills = cardData.data.skills
    for i, v in pairs(skills) do
        local cfg = Cfgs.skill:GetByID(v.id)
        if (cfg == nil) then
            LogError("找不到技能：" .. v.id)
        end
        if (cfg and cfg.lv > 1) then
            return true
        end
    end
    -- 主天赋
    local ids = cardData:GetSkills(SkillMainType.CardTalent)
    if (#ids > 0) then
        local id = ids and ids[1].id or nil
        mainTalentData = id and Cfgs.skill:GetByID(id) or nil
        if (mainTalentData and mainTalentData.lv > 1) then
            return true
        end
    end
    return false
end

----------------------------------////协议
-- 请求卡牌数据
function this:CardsData()
    local proto = {"PlayerProto:CardsData"}
    NetMgr.net:Send(proto)
end
-- 卡牌添加
function this:CardAdd(proto)
    self.addCards = self.addCards or {}
    if (proto) then
        self:UpdateData(proto.cards)
        self.datas.cur_size = proto.cur_size
        self.datas.max_size = proto.max_size
        for k, v in ipairs(proto.cards) do
            table.insert(self.addCards, v)
        end
        -- 已发完
        if (proto.finish) then
            local addCards = self.addCards
            self.addCards = nil
            EventMgr.Dispatch(EventType.Role_Card_Add, {
                card = addCards,
                isAdd = true
            })
            self:CheckRed()
        end
    end
end

-- 更新
function this:CardUpdate(proto)
    if (proto) then
        self.datas.store_exp = proto.store_exp
        for i, v in ipairs(proto.cards) do
            local card = self:GetData(v.cid)
            if (card) then
                local cardData = card.data
                for k, m in pairs(v) do
                    cardData[k] = m
                end
                card:Init(cardData)
            end
        end
        -- EventMgr.Dispatch(EventType.Role_Card_Update)
        self:UpdateCardEvent(CardUpdateType.DataUpdate, nil, proto)
    end
end

--卡牌光环升级
function this:CardHaloUpdate(proto)
    if (proto and proto.info) then
        local card = self:GetData(proto.info.cid)
        if card~=nil then
            local cardData = card:GetData();
            cardData.haloInfo=table.copy(proto.info);
            card:Init(cardData)
            self.cards[proto.info.cid]=card;
            self:UpdateCardEvent(CardUpdateType.DataUpdate, card:GetID(), nil)
        end
    end
end

--卡牌光环站位切换
function this:CardHaloSwitch(proto)
    if (proto and proto.cid and proto.hid) then
        local card = self:GetData(proto.cid)
        if card~=nil then
            local cardData = card.data
            cardData.haloInfo.curCoor=proto.hid;
            card:Init(cardData)
            self.cards[proto.cid]=card;
            self:UpdateCardEvent(CardUpdateType.DataUpdate, card:GetID(), nil)
        end
    end
end

-- 卡牌删除
function this:CardDelete(proto)
    if (proto) then
        for i, v in ipairs(proto.card_ids) do
            self:RemoveData(v)
        end
        self.datas.cur_size = proto.cur_size
        self.datas.max_size = proto.max_size
        EventMgr.Dispatch(EventType.Role_Card_Delete)
    end
end

-- 格子扩容
function this:CardGirdAdd(_num)
    local proto = {"PlayerProto:CardGirdAdd", {
        num = _num
    }}
    NetMgr.net:Send(proto)
end
-- 格子扩容
function this:CardGirdAddRet(proto)
    if (proto) then
        self.datas.max_size = proto.max_size
        EventMgr.Dispatch(EventType.Role_Card_GridAdd)
    end
end

-- 卡牌改名
function this:CardRename(_cid, _name)
    local proto = {"PlayerProto:CardRename", {
        cid = _cid,
        name = _name
    }}
    NetMgr.net:Send(proto)
end

-- 改名
function this:CardRenameRet(_proto)
    if (_proto) then
        self:UpdateNameList(_proto)
        local card = RoleMgr:GetData(_proto.cid)
        if (card) then
            card.data.name = _proto.name
        end
        -- EventMgr.Dispatch(EventType.Role_Card_ReName, _proto.name)
        self:UpdateCardEvent(CardUpdateType.CardRenameRet, _proto.cid, _proto)
    end
end

-- 刷新改名列表
function this:UpdateNameList(proto)
    if (self.rename_records == nil) then
        self.rename_records = {}
        self.rename_records[proto.cid] = {
            sid = proto.cid,
            num = proto.rename_time
        }
    else
        local isin = false
        for i, v in pairs(self.rename_records) do
            if (i == proto.cid) then
                v.num = proto.rename_time
                isin = true
            end
        end
        if (not isin) then
            self.rename_records[proto.cid] = {
                sid = proto.cid,
                num = proto.rename_time
            }
        end
    end
end

function this:CardLock(datas)
    local proto = {"PlayerProto:CardLock", {
        ops = datas
    }}
    NetMgr.net:Send(proto)
end

-- 上锁
function this:CardLockRet(_proto)
    local len = #_proto.ops
    for i = 1, len do
        local data = _proto.ops[i]
        local card = self:GetData(data.cid)
        if (card) then
            card:GetData().lock = data.lock
        end
    end
    -- EventMgr.Dispatch(EventType.Role_Card_Lock)
    self:UpdateCardEvent(CardUpdateType.CardLockRet, nil, _proto)
end

-- 升级
function this:CardUpgrade(_cid, _use_store_exp, _material_ids, _card_ids, _CardUpgradeCB)
    self.CardUpgradeCB = _CardUpgradeCB
    local proto = {"PlayerProto:CardUpgrade", {
        cid = _cid,
        use_store_exp = _use_store_exp,
        material_ids = _material_ids,
        card_ids = _card_ids
    }}
    NetMgr.net:Send(proto)
end

-- 升级回调
function this:CardUpgradeRet(proto)
    if (proto) then
        self.datas.store_exp = proto.store_exp
        self:UpSuccessCB(proto, CardUpdateType.CardUpgradeRet) -- RoleUpSuccessType.Up)
    end
    if (self.CardUpgradeCB) then
        self.CardUpgradeCB()
    end
end

-- -- 强化
-- function this:CardIntensify(_cid, _card_ids, _material_ids)
-- 	local proto = {
-- 		"PlayerProto:CardIntensify", {cid = _cid, card_ids = _card_ids, material_ids = _material_ids}
-- 	}
-- 	NetMgr.net:Send(proto)
-- end

-- -- 强化回调
-- function this:CardIntensifyRet(proto)
-- 	if(proto) then
-- 		self:UpSuccessCB(proto, CardUpdateType.CardIntensifyRet)--RoleUpSuccessType.Restructure)
-- 	end
-- end

-- 突破
function this:CardBreak(_cid)
    local proto = {"PlayerProto:CardBreak", {
        cid = _cid
    }}
    NetMgr.net:Send(proto)
end

-- 突破回调
function this:CardBreakRet(proto)
    if (proto) then
        self:UpSuccessCB(proto, CardUpdateType.CardBreakRet) -- RoleUpSuccessType.Break)
    end
end

function this:UpSuccessCB(_proto, _roleUpSuccessType)
    local cardData = self:GetData(_proto.card.cid)
    local _data = cardData:GetData()
    local data = {}
    table.copy(_data, data)
    local _oldData = CharacterCardsData(data)
    self:UpdateData({_proto.card})
    -- EventMgr.Dispatch(EventType.Role_Card_Upgrade, {oldData, _roleUpSuccessType})
    self:UpdateCardEvent(_roleUpSuccessType, _proto.card.cid, _proto, _oldData)
    self:CheckRed()
end

-- 卡牌分解
function this:CardDisintegrate(_card_ids)
    local proto = {"PlayerProto:CardDisintegrate", {
        card_ids = _card_ids
    }}
    NetMgr.net:Send(proto)
end
-- 卡牌分解回调
function this:CardDisintegrateRet(proto)
    if (proto) then
        -- if(proto.rewards and #proto.rewards > 0) then
        -- 	UIUtil:OpenReward( {proto.rewards, proto.equip_ids})
        -- end
        EventMgr.Dispatch(EventType.Role_Create_Disintegrate, proto)

        -- 移除技能升级红点
        -- RoleSkillMgr:RemoveDeleteCard(proto.card_ids)
    end
end

----------------------------------////界面数据推送封装
-- 卡牌更新
function this:UpdateCardEvent(_type, _cid, _proto, _other)
    EventMgr.Dispatch(EventType.Card_Update, {
        type = _type,
        cid = _cid,
        proto = _proto,
        other = _other
    })
end

----------------------------------////排序相关
-- 排序类型
function this:GetSortType(_listType)
    if (not self.sortTypes[_listType]) then
        self.sortTypes[_listType] = self:GetSortTab(_listType)
    end
    return self.sortTypes[_listType]
end
function this:SetSortType(_listType, _data)
    self.sortTypes[_listType] = _data
end

-- 升降类型
function this:GetOrderType(_listType)
    self.orderTypes[_listType] = self.orderTypes[_listType] or self:GetOrder(_listType)
    return self.orderTypes[_listType]
end
function this:SetOrderType(_listType, _data)
    self.orderTypes[_listType] = _data
end

-- 排序  首选排序 稀有度、等级、性能...
-- 筛选  稀有度,核心类型,小队
-- {Sort = {1}, RoleQuality = {0}, RoleType = {0}, RoleTeam = {0}}
-- 设置默认排序及筛选
function this:GetSortTab(_listType)
    local RoleListSortType = {}
    RoleListSortType.Sort = _listType == RoleListType.Cool and {7} or {1}
    RoleListSortType.RoleQuality = {0}
    -- RoleListSortType.RoleType = {0}
    RoleListSortType.RoleTeam = {0}
    RoleListSortType.RolePosEnum = {0}
    return RoleListSortType
end

function this:GetOrder(_listType)
    if (_listType == RoleListType.Resolve) then
        return RoleListOrderType.Up
    else
        return RoleListOrderType.Down
    end
end

-- 队长放第一
function this:SortByLeader()
    self.isSortByLeader = true
end

function this:CheckIsSortByLeader()
    local b = self.isSortByLeader == nil and false or self.isSortByLeader
    self.isSortByLeader = nil
    return b
end

-- 属性复选的下标
function this:GetMultiID(_listType)
    self.mulIDs = self.mulIDs or {}
    return self.mulIDs[_listType]
end
function this:SetMultiID(_listType, _mulID)
    self.mulIDs = self.mulIDs or {}
    self.mulIDs[_listType] = _mulID
end
----------------------------------男主女初始卡相关
-- 根据当前玩家性别返回对应卡牌ID
function this:GetCurrSexCardCfgId()
    return PlayerClient:GetSex() == 1 and g_SexInitCardIds[1] or g_SexInitCardIds[2]
end

-- 判断当前卡牌Id是否是男主卡牌ID
function this:IsSexInitCardIDs(cfgId)
    if cfgId then
        for k, v in ipairs(g_SexInitCardIds) do
            if cfgId == v then
                return true;
            end
        end
    end
    return false;
end

-- 天赋是否已开启
function this:CheckTalentIsOpen(careData)
    local breakLv = careData:GetBreakLevel()
    if (breakLv < 2) then
        local tips = LanguageMgr:GetTips(3005, 2)
        tips = string.format(tips, 2)
        return false, tips
    end
    return true, ""
end

function this:CardCoreLvRet(proto)
    local cardData = self:GetData(proto.cid)
    cardData:SetCoreLv(proto.cl)

    self:UpdateCardEvent(CardUpdateType.CoreUpgrade, proto.cid)
end

function this:SetCardInfoRet(proto)
    local cardData = self:GetData(proto.cid)
    cardData:SetIsNew(proto.is_new)
end

function this:SetRoleListSortData()
    self.roleListData = table.copy(SortMgr:GetData(1))
end
function this:GetRoleListSortData()
    return self.roleListData
end
function this:ClearRoleListSortData()
    self.roleListData = nil
end

-- 解禁数据（用于弹出界面展示）
function this:AddJieJinDatas(proto)
    if (proto == nil) then
        self.jiejinDatas = nil
        return
    end
    if (self.jiejinDatas) then
        if (proto.open_cards) then
            self.jiejinDatas.open_cards = self.jiejinDatas.open_cards or {}
            for k, v in pairs(proto.open_cards) do
                table.insert(self.jiejinDatas.open_cards, v)
            end
        end
        if (proto.open_mechas) then
            self.jiejinDatas.open_mechas = self.jiejinDatas.open_mechas or {}
            for k, v in pairs(proto.open_mechas) do
                table.insert(self.jiejinDatas.open_mechas, v)
            end
        end
    else
        self.jiejinDatas = proto
    end
end
function this:GetJieJinDatas()
    return self.jiejinDatas
end

-- 获取总队长
function this:GetLeader()
    for k, v in ipairs(g_InitRoleId) do
        local data = self:GetData(v)
        if (data) then
            return data
        end
    end
    return nil
end

--当前队长的基础皮肤
function this:GetBaseModelID()
    local data = self:GetLeader()
    local cfg = Cfgs.CardData:GetByID(data:GetCfgID())
    return cfg.model
end

-- 获取总队长
function this:GetLeader2()
    for k, v in ipairs(g_CaptainRoleId) do
        local data = self:GetDataByCfgID(v)
        if (data) then
            return data
        end
    end
    return nil
end

--获取纯白总队长
function this:GetExtraLeader()
    for k, v in ipairs(g_SexExtraCardIds) do
        local data = self:GetDataByCfgID(v[1])
        if (data) then
            return data
        end
    end
end

-- 判断总队长
function this:IsLeader(cfgId)
    for i, v in ipairs(g_CaptainRoleId) do
        if cfgId == v then
            return true
        end
    end
    return false
end

function this:IsExtraLeader(cfgId)
    for i, v in ipairs(g_SexExtraCardIds) do
        if cfgId == v[1] then
            return true
        end
    end
end

-- 特效技能红点查看记录
function this:PassiveRedIsLook(data)
    self.passiveRedIsLookDatas = data or {}
end
function this:CheckPassiveRedIsLook(uidStr)
    if (self.passiveRedIsLookDatas and self.passiveRedIsLookDatas[uidStr] == 1) then
        return true
    end
    return false
end
function this:SetPassiveRedIsLook(uidStr, num)
    self.passiveRedIsLookDatas[uidStr] = num
    PlayerProto:SetClientData("passiveRed_isLook", self.passiveRedIsLookDatas)
end

return this
