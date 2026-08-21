local M = BaseClass("OtakuRoomDataMgr", require("DataCenter.BaseDataCenter"))
local MessageId = Proto.MessageId
local OtakuRoomType = OtakuType.OtakuRoomType
local tInsert = table.insert
-- 初始化
function M:Init()
    -- 舱室类型
    self.m_OtakuTypes = {
        [OtakuRoomType.EST_Bridge] = require("DataCenter.Otaku.OtakuRoomByBridgeData"),               --建桥
        [OtakuRoomType.EST_Produce] = require("DataCenter.Otaku.OtakuRoomByProduceData"),             --制造舱
        [OtakuRoomType.EST_Communication] = require("DataCenter.Otaku.OtakuRoomByCommunicationData"), --通讯室
        [OtakuRoomType.EST_Dormitory] = require("DataCenter.Otaku.OtakuRoomByDormitoryData"),         --宿舍
        [OtakuRoomType.EST_Canteen] = require("DataCenter.Otaku.OtakuRoomByCanteenData"),             --餐厅
        [OtakuRoomType.EST_Compose] = require("DataCenter.Otaku.OtakuRoomByComposeData"),             --合成舱
        [OtakuRoomType.EST_Survey] = require("DataCenter.Otaku.OtakuRoomBySurveyData"),               --调查舱
        [OtakuRoomType.EST_Kitchen] = require("DataCenter.Otaku.OtakuRoomByKitChenData"),             --厨房
    }

    self.m_houseFieldDic = {
        [OtakuRoomType.EST_Produce] = "make",       --制造舱
        -- [OtakuRoomType.EST_Communication] = "communication", --通讯室
        [OtakuRoomType.EST_Canteen] = "restaurant", --餐厅
        [OtakuRoomType.EST_Compose] = "makeUp",     --合成舱
        [OtakuRoomType.EST_Survey] = "expMission",  --调查舱
        [OtakuRoomType.EST_Kitchen] = "kitchen",    --厨房
    }

    self.m_roomCountByType = {
        -- 表示房间类型在边舱中存在的个数，受预制件OtakuMainUI布局的影响
        [OtakuRoomType.EST_Produce] = 3,
        [OtakuRoomType.EST_Canteen] = 2,
        [OtakuRoomType.EST_Compose] = 1,
        [OtakuRoomType.EST_Survey] = 1,
        [OtakuRoomType.EST_Kitchen] = 1,
    }

    -- 房间Datas
    self.m_RoomDatas = {}
    self:_RegistResponse(MessageId.ResponseBrowseStudio, Bind(self, self.OnResponseBrowseStudio))
    self:_RegistResponse(MessageId.ResponseBuildStudio, Bind(self, self.OnResponseBuildStudio))
    self:_RegistResponse(MessageId.ResponseGarrisonStudio, Bind(self, self.OnResponseGarrisonStudio))
    self:_RegistResponse(MessageId.ResponseCancelGarrisonStudio, Bind(self, self.OnResponseCancelGarrisonStudio))
    self:_RegistResponse(MessageId.ResponseStudioUpgrade, Bind(self, self.OnResponseStudioUpgrade))
    self:_RegistResponse(MessageId.NotifyExpeditionChange, Bind(self, self.OnNotifyExpeditionChange))
    self:_RegistResponse(MessageId.NotifyStudioMakeStateChange, Bind(self, self.OnNotifyStudioMakeStateChange))

    self.m_houseDic = nil     -- house表数据
    self.m_isMakeFast = false -- 正在加速制造中
    self.m_makeItems = {}
    self.m_houseResDic = {}
    self.m_houseLevelDic = {}
    self.m_composeItemDic = {} -- 合成道具字典
    self.m_rsEnterRoomDic = {}
    self.m_upgradeCallback = nil
    self.m_composeCallback = nil
    self.m_makeClaimCallback = nil
    self.m_enterRoomCallbackDic = {}
    self.m_StudioGarrisonCallback = nil
    self.m_surveyLimit = GameHelper.GetParamters(138)
end

-- 注销
function M:OnDispose()
    for _, roomData in pairs(self.m_RoomDatas) do
        roomData:Dispose()
    end
    for messageId, handler in pairs(self.m_rsEnterRoomDic) do
        NetPack:UnRegistResponse(messageId, handler)
    end
    if self.m_rsMakeStart then
        local messageId = MessageId.ResponseStudioProduce
        NetPack:UnRegistResponse(messageId, self.m_rsMakeStart)
        self.m_rsMakeStart = nil
    end
    if self.m_rsMakeFast then
        local messageId = MessageId.ResponseStudioMakerFast
        NetPack:UnRegistResponse(messageId, self.m_rsMakeFast)
        self.m_rsMakeFast = nil
    end
    if self.m_rsMakeAward then
        local messageId = MessageId.ResponseStudioMakerAward
        NetPack:UnRegistResponse(messageId, self.m_rsMakeAward)
        self.m_rsMakeAward = nil
    end
    if self.m_rsComposeItem then
        local messageId = MessageId.ResponseCompoundMakeItem
        NetPack:UnRegistResponse(messageId, self.m_rsComposeItem)
        self.m_rsComposeItem = nil
    end
    if self.m_rsAllMakerAward then
        local messageId = MessageId.ResponseStudioMakerAwardAll
        NetPack:UnRegistResponse(messageId, self.m_rsAllMakerAward)
        self.m_rsAllMakerAward = nil
    end

    self.m_roomFmt = nil
    self.m_levelFmt = nil
    self.m_houseDic = nil
    self.m_RoomDatas = nil
    self.m_makeItems = nil
    self.m_surveyLimit = nil
    self.m_houseResDic = nil
    self.m_houseFieldDic = nil
    self.m_houseLevelDic = nil
    self.m_composeItemDic = nil
    self.m_rsEnterRoomDic = nil
    self.m_composeRequest = nil
    self.m_composeCallback = nil
    self.m_upgradeCallback = nil
    self.m_makeClaimCallback = nil
    self.m_enterRoomCallbackDic = nil
    self.m_StudioGarrisonCallback = nil
end

--IDataGetter start
--用于在登录的时候初始化相关数据
function M:LoadData()
    --判断边舱是否解锁
    if JumpMgr:GetInstance():CheckLockByJumpId(5) == 0 then
        self._isloading = true
        self._dataLoaded = false
        self._errorCode = 0
        self:RequestBrowseStudio(nil)
    else
        self._isloading = false
        self._dataLoaded = true
        self._errorCode = 0
    end
end

function M:IsLoading()
    return self._isloading
end

function M:IsReady()
    return self._dataLoaded
end

function M:ErrorCode()
    return self._errorCode
end

function M:IsLoaded()
    return self.isLoaded
end

function M:Cleanup()
    self._dataLoaded = false
    self._errorCode = 0
    self._isloading = false
end

--IDataGetter end

-- 埋点相关 start
--入驻埋点
function M:_SubmitHeroOnSite(studios)
    if not studios then
        return
    end

    for i, v in ipairs(studios) do
        local roomData = self:RoomDataByRoomId(v.StudioId)
        local heroIds = roomData:CurRoleLiveHeros()


        local id = roomData:Type()
        local index = roomData:RoomIndex()
        if index > 0 then
            id = tostring(id) .. ":" .. index
        end
        local heros = ""
        for key, heroId in pairs(heroIds) do
            if key ~= 1 then
                heros = heros .. "," .. heroId
            else
                heros = heros .. heroId
            end
        end
        -- local dataKey = { "cabin_id", "garrison_hero_list" }
        local dataValues = { tostring(id), tostring(heros) }
        IBuriedPointDataMgr:SubmitData(BuriedPointConst.Cabin_garrison, dataValues)
    end
end

--升级埋点
function M:_SubmitUpgrade(data)
    if data.Type == OtakuRoomType.EST_Bridge then
        GameKeyNodeMgr:GetInstance():Record(EGameKeyNode.OtakuBrigeLevelUp)
    elseif data.Type == OtakuRoomType.EST_Produce then
        GameKeyNodeMgr:GetInstance():Record(EGameKeyNode.OtakuProduceRoomUp)
    end
    local roomData = self:RoomDataByRoomId(data.StudioId)
    local id = roomData:Type()
    local index = roomData:RoomIndex()
    if index > 0 then
        id = tostring(id) .. ":" .. index
    end
    -- local dataKey = { "cabin_id", "cabin_level" }
    local dataValues = { tostring(id), tostring(data.Level) }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Cabin_level_up, dataValues)
end

-- 埋点相关 end

-- 拿全部数据
function M:RoomDatas()
    return self.m_RoomDatas
end

-- 通过房间Id 拿data数据
function M:RoomDataByRoomId(studioId)
    return self.m_RoomDatas[studioId]
end

-- 通过房间类型 拿data数据
function M:RoomDatasByRoomType(type)
    local roomDatas = MapUtil.FilterValues(self.m_RoomDatas, function(v) return v:Type() == type end)
    table.sort(roomDatas, function(a, b)
        if a:BuildTick() ~= b:BuildTick() then
            return a:BuildTick() < b:BuildTick()
        else
            return a:RoomId() < b:RoomId()
        end
    end)
    return roomDatas
end

-- 已建造房间数量
function M:GetRoomNumByType(roomType)
    local roomDatas = self:RoomDatasByRoomType(roomType)
    return #roomDatas
end

function M:GetDeployRoomTypeByHeroId(heroId)
    for _, roomData in pairs(self.m_RoomDatas) do
        local rolesData = roomData:RoleLives()
        local roleData = MapUtil.Find(rolesData, function(v) return v.HeroId == heroId end)
        if roleData then
            return roleData, roomData
        end
    end
    return nil, nil
end

function M:GetSettleIndexByRoomId(studioId)
    local roomData = self:RoomDataByRoomId(studioId)
    return roomData:GetSettleIndex()
end

function M:UpdateSettleSelectByRoomId(studioId, index)
    local roomData = self:RoomDataByRoomId(studioId)
    roomData:UpdateSettleSelect(index)
end

function M:GetAllLiveSpaceHeroUp()
    local num = 0
    for i, v in pairs(self.m_RoomDatas) do
        num = num + #(v:RoleLives())
    end
    return num
end

function M:GetUnlockLiveSpaceNum()
    local num = 0
    for i, v in pairs(self.m_RoomDatas) do
        if v:Type() ~= OtakuRoomType.EST_Canteen then
            num = num + v:GetUnlockLiveSpaceNum()
        else
            num = num + 2 + v:GetSeatLimit()
        end
    end
    return num
end

-- 建造舱室
function M:RequestBuildStudio(type, callback)
    self.m_BuildStudioCallBack = callback
    local data = {}
    data.Type = type
    NetPack:SendMessage(MessageId.RequestBuildStudio, data)
end

-- 入驻 info = { HeroId = heroId , Position = position}
function M:RequestGarrisonStudio(studioId, liveType, info, clean, callback)
    self.m_StudioGarrisonCallback = callback
    local data = {}
    data.StudioId = studioId
    data.LiveType = liveType
    data.Clean = clean
    data.Garrisons = info
    NetPack:SendMessage(MessageId.RequestGarrisonStudio, data)
end

--取消入驻
function M:RequestCancelGarrisonStudio(studioId, liveType, position, callback)
    self.m_CancelGarrisonCallback = callback
    local data = {}
    data.StudioId = studioId
    data.Position = position
    data.LiveType = liveType
    NetPack:SendMessage(MessageId.RequestCancelGarrisonStudio, data)
end

--升级舱室
function M:RequestStudioUpgrade(studioId, callback)
    if self.m_upgradeCallback then return end
    self.m_upgradeCallback = callback
    NetPack:SendMessage(MessageId.RequestStudioUpgrade, { StudioId = studioId })
end

--请求雇员总览数据
function M:RequestBrowseStudio(callBack)
    self.m_browseStudioCallback = callBack
    NetPack:SendMessage(MessageId.RequestBrowseStudio, {})
end

--雇员总览协议返回
function M:OnResponseBrowseStudio(messageId, result, msg)
    self._isloading = false
    self._dataLoaded = true
    if result ~= 0 then
        return
    end

    self.isLoaded = true
    -- 基础数据
    local studios = msg.Studios
    table.sort(studios, function(v1, v2) return v1.Type < v2.Type end)

    for _, v in ipairs(studios) do
        local dataCenter = self.m_OtakuTypes[v.Type]
        local data = dataCenter.New(v)
        self.m_RoomDatas[v.StudioId] = data
    end

    if not table.isNullOrEmpty(msg.Maker) then -- 制作数据
        for _, v in ipairs(msg.Maker) do
            self.m_RoomDatas[v.StudioId]:ExtraData(v)
        end
    end

    if not table.isNullOrEmpty(msg.Expedition) then -- 远征数据
        local roomdata = self:RoomDatasByRoomType(OtakuRoomType.EST_Survey)
        roomdata[1]:ExtraData(msg.Expedition)
    end

    if not table.isNullOrEmpty(msg.DiningTable) then --餐厅餐桌CD时间
        local roomdata = self:RoomDatasByRoomType(OtakuRoomType.EST_Canteen)
        for _, restaurantData in pairs(roomdata) do
            restaurantData:ExtraData(msg.DiningTable)
        end
    end

    if self.m_browseStudioCallback then
        self.m_browseStudioCallback()
        self.m_browseStudioCallback = nil
    end
end

-- 建造舱室协议返回
function M:OnResponseBuildStudio(messageId, result, msg)
    if result ~= 0 then return end

    msg.Data.BuildTick = GameUtil.GetCurTimeTick() + 2
    local dataCenter = self.m_OtakuTypes[msg.Data.Type]
    local roomData = dataCenter.New(msg.Data)
    self.m_RoomDatas[msg.Data.StudioId] = roomData

    if self.m_BuildStudioCallBack then
        self.m_BuildStudioCallBack(roomData)
        self.m_BuildStudioCallBack = nil
    end
end

-- 入驻协议返回
function M:OnResponseGarrisonStudio(messageId, result, msg)
    if result ~= 0 then
        self.m_StudioGarrisonCallback = nil
        return
    end

    self:_OnUpdateRooms(msg.Studios, OtakuType.NetUpdateType.Garrison)
    -- 入驻埋点
    self:_SubmitHeroOnSite(msg.Studios)

    if self.m_StudioGarrisonCallback then
        self.m_StudioGarrisonCallback()
        self.m_StudioGarrisonCallback = nil
    end
end

-- 取消入驻协议返回
function M:OnResponseCancelGarrisonStudio(messageId, result, msg)
    if result ~= 0 then
        self.m_CancelGarrisonCallback = nil
        return
    end

    self:_OnUpdateRoom(msg.Studio, OtakuType.NetUpdateType.CancelGarrison)
    -- 入驻埋点
    self:_SubmitHeroOnSite({ msg.Studio })

    if self.m_CancelGarrisonCallback then
        self.m_CancelGarrisonCallback()
        self.m_CancelGarrisonCallback = nil
    end
end

-- 升级舱室协议返回
function M:OnResponseStudioUpgrade(messageId, result, msg)
    if result ~= 0 then
        self.m_upgradeCallback = nil
        return
    end

    -- 升级成功弹窗
    local roomData = self:RoomDataByRoomId(msg.Studio.StudioId)
    UIContextMgr:GetInstance():Show(UIDefine.OtakuUplevelPopup, roomData, function()
        self:_OnUpdateRoom(msg.Studio, OtakuType.NetUpdateType.Upgrade)
        --升级埋点
        self:_SubmitUpgrade(msg.Studio)

        if self.m_upgradeCallback then
            self.m_upgradeCallback()
            self.m_upgradeCallback = nil
        end
    end)
end

-- 远征任务
function M:OnNotifyExpeditionChange(_, result, msg)
    if result ~= 0 then return end

    local tasks = msg.Tasks
    local roomdata = self:RoomDatasByRoomType(OtakuRoomType.EST_Survey)[1]
    for _, v in ipairs(tasks) do
        roomdata:UpdateExtraData(v)
        EventMgr:Broadcast(UIMessageNames.EXPMISSION_UPDATE, v)
    end
end

-- 刷新单独房间数据
function M:_OnUpdateRoom(studio, netUpdateType)
    local roomData = self:RoomDataByRoomId(studio.StudioId)
    roomData:Update(studio, netUpdateType)
end

-- 刷新多个房间数据
function M:_OnUpdateRooms(studios, netUpdateType)
    for _, v in ipairs(studios) do
        local roomData = self:RoomDataByRoomId(v.StudioId)
        roomData:Update(v, netUpdateType)
    end
end

-- 根据[OtakuRoomType]进入不同舱室
function M:EnterRoomStudioByType(roomType, studioId, jumpCallback)
    local reqId, rspId, callback
    if roomType == OtakuRoomType.EST_Produce then
        reqId = MessageId.RequestEnterProduceStudio
        rspId = MessageId.ResponseEnterProduceStudio
        callback = function(roomData)
            UIContextMgr:GetInstance():Show("OtakuManufacturingCabin", roomData)
            if jumpCallback ~= nil then
                jumpCallback()
            end
        end
    elseif roomType == OtakuRoomType.EST_Canteen then
        reqId = MessageId.RequestEnterCanteenStudio
        rspId = MessageId.ResponseEnterCanteenStudio
        callback = function(roomData)
            UIContextMgr:GetInstance():Show(UIDefine.RestaurantRootUI, roomData)
            -- ModuleMgr:GetInstance():ChangeModule(ModuleConfig.Restaurant.id, roomData)
            if jumpCallback ~= nil then
                jumpCallback()
            end
        end
    end

    if not reqId or not rspId then
        Logger.LogError("无相关协议")
        return
    end

    if not studioId or (studioId == 0) then
        local roomDatas = self:RoomDatasByRoomType(roomType)
        local roomData = roomDatas[1]
        if not roomData then
            GameHelper.TipsById(5579) --房间未建造
            return
        end
        studioId = roomData:RoomId()
    end
    if self.m_rsEnterRoomDic[rspId] then return end

    self.m_rsEnterRoomDic[rspId] = NetPack:RegistResponse(rspId, Bind(self, self.OnRsEnterRoomStudio))
    self.m_enterRoomCallbackDic[rspId] = callback
    NetPack:SendMessage(reqId, { StudioId = studioId })
end

function M:OnRsEnterRoomStudio(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsEnterRoomDic[messageId])
    self.m_rsEnterRoomDic[messageId] = nil

    if result ~= 0 then return end

    if self.m_enterRoomCallbackDic[messageId] then
        local roomData = self:RoomDataByRoomId(msg.StudioId)
        if roomData then
            self.m_enterRoomCallbackDic[messageId](roomData)
        else
            GameHelper.Tips("roomData is nil, StudioId == " .. tostring(msg.StudioId))
        end
        self.m_enterRoomCallbackDic[messageId] = nil
    end
end

-- ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓ 制造相关 start ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

function M:OnNotifyStudioMakeStateChange(_, result, msg)
    if result ~= 0 then return end

    -- 制作数据
    for _, v in ipairs(msg.Produces or {}) do
        self.m_RoomDatas[v.StudioId]:ExtraData(v)
    end
end

-- 制造开始请求
function M:RqStudioProduce(request, callback)
    if self.m_rsMakeStart then return end

    self.m_makeCallback = callback
    local messageId = MessageId.ResponseStudioProduce
    local handler = Bind(self, self.OnResponseStudioProduce)
    self.m_rsMakeStart = NetPack:RegistResponse(messageId, handler)
    NetPack:SendMessage(MessageId.RequestStudioProduce, request)
end

-- 制造开始响应
function M:OnResponseStudioProduce(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsMakeStart)
    self.m_rsMakeStart = nil
    if result ~= 0 then return end

    local produce = msg.Produce
    self.m_RoomDatas[produce.StudioId]:ExtraData(produce)

    if self.m_makeCallback then
        self.m_makeCallback()
        self.m_makeCallback = nil
    end
    -- 开始制造
    GameHelper.TipsById(5544)
    --制造仓埋点
    -- local dataKey = { "produce_item_id", "produce_num" }
    local dataValues = { tostring(produce.MakeItemId), tostring(produce.MakeItemNum) }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Cabin_prodce, dataValues)

    local cycleType = protocol.ECycleEvent.ECET_ROLE_MASK
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    if not cycleData:IsExistMask(0) then
        self:RqStudioMakerFast({ StudioId = produce.StudioId })
    end
end

-- 制造快速完成请求
function M:RqStudioMakerFast(request, callback)
    if self.m_rsMakeFast then return end

    self.m_isMakeFast = true
    local messageId = MessageId.ResponseStudioMakerFast
    local handler = Bind(self, self.OnResponseStudioMakerFast)
    self.m_rsMakeFast = NetPack:RegistResponse(messageId, handler)
    NetPack:SendMessage(MessageId.RequestStudioMakerFast, request)
end

-- 制造快速完成响应
function M:OnResponseStudioMakerFast(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsMakeFast)
    self.m_rsMakeFast = nil
    if result ~= 0 then return end

    local produce = msg.Produce
    self.m_RoomDatas[produce.StudioId]:ExtraData(produce)

    self:RqStudioMakerAward(produce.StudioId)
end

-- 制造仓领取请求
function M:RqStudioMakerAward(studioId)
    if self.m_rsMakeAward then return end

    local messageId = MessageId.ResponseStudioMakerAward
    local handler = Bind(self, self.OnResponseStudioMakerAward)
    self.m_rsMakeAward = NetPack:RegistResponse(messageId, handler)
    NetPack:SendMessage(MessageId.RequestStudioMakerAward, { StudioId = studioId })
end

-- 制造仓领取响应
function M:OnResponseStudioMakerAward(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsMakeAward)
    self.m_rsMakeAward = nil
    if result ~= 0 then return end

    local produce, studioId = msg.Produce, msg.StudioId
    self.m_RoomDatas[studioId]:ExtraData(produce)

    -- 显示制造道具
    local itemDic = {}
    for _, item in ipairs(msg.Items or {}) do
        local num = itemDic[item.Id] or 0
        itemDic[item.Id] = item.Cnt + num
    end
    GameHelper.ItemTips(itemDic)
    IRedPointMgr:ForceCheck(RedPointConst.OtakuProduceRedPointChecker)
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Cabin_prodce_get)
    if self.m_isMakeFast then self.m_isMakeFast = false end
end

-- 一键领取制造舱
function M:MakeCabinClaim(callback)
    local roomDatas = self:RoomDatasByRoomType(OtakuRoomType.EST_Produce)
    if #roomDatas <= 0 then
        GameHelper.TipsById(5580) -- 未建造制造舱
        return
    end

    if self.m_rsAllMakerAward then return end

    self.m_makeClaimCallback = callback
    local messageId = MessageId.ResponseStudioMakerAwardAll
    local handler = Bind(self, self.OnResponseStudioMakerAwardAll)
    self.m_rsAllMakerAward = NetPack:RegistResponse(messageId, handler)
    NetPack:SendMessage(MessageId.RequestStudioMakerAwardAll, {})
end

function M:OnResponseStudioMakerAwardAll(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsAllMakerAward)
    self.m_rsAllMakerAward = nil
    if result ~= 0 then return end

    for _, v in ipairs(msg.Produce or {}) do
        self.m_RoomDatas[v.StudioId]:ExtraData(v)
    end

    local itemDic = {}
    for _, item in ipairs(msg.Items or {}) do
        local num = itemDic[item.Id] or 0
        itemDic[item.Id] = item.Cnt + num
    end
    GameHelper.ShowGetItems(itemDic)
    IRedPointMgr:ForceCheck(RedPointConst.OtakuProduceRedPointChecker)
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Cabin_prodce_get)
    if self.m_makeClaimCallback then
        self.m_makeClaimCallback()
        self.m_makeClaimCallback = nil
    end
end

-- 获取制造列表
function M:GetMakeItemList(makeType)
    if not makeType then makeType = OtakuType.MakeType.MakeCabin end
    local list = self.m_makeItems[makeType]
    if not list then
        list = {}
        local configs = ConfigHelper.GetCfgsByLua("makeItem")
        for _, makeItem in pairs(configs) do
            if makeItem.makeType == makeType then
                tInsert(list, makeItem)
            end
        end
        self.m_makeItems[makeType] = list
    end

    return list
end

function M:GetMakeItemsByLv(level, makeType)
    if not makeType then makeType = OtakuType.MakeType.MakeCabin end
    local makeItems = self:GetMakeItemList(makeType)
    local list = {}
    for _, value in ipairs(makeItems) do
        if value.houseLimit == level then
            tInsert(list, value)
        end
    end
    return list
end

function M:IsMakeFast()
    return self.m_isMakeFast
end

-- ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ 制造相关  end  ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

-- 获取合成列表
function M:GetComposeItemsByType(tabType)
    local list = self.m_composeItemDic[tabType]
    if not list then
        list = {}
        local ComposeCabin = OtakuType.MakeType.ComposeCabin
        local makeItems = self:GetMakeItemList(ComposeCabin)
        for _, makeItem in ipairs(makeItems) do
            if makeItem.type == tabType then
                tInsert(list, makeItem)
            end
        end
        self.m_composeItemDic[tabType] = list
    end
    return list
end

-- 获取makeitem配置
function M:GetMakeItemByItemId(itemId)
    if not itemId or itemId <= 0 then return nil end

    local ComposeCabin = OtakuType.MakeType.ComposeCabin
    local makeItems = self:GetMakeItemList(ComposeCabin)
    for _, makeItem in ipairs(makeItems) do
        if makeItem.item == itemId then return makeItem end
    end
    return nil
end

-- 合成舱合成道具
function M:RqCompoundMakeItem(request, callback)
    if self.m_rsComposeItem then return end

    self.m_composeRequest = request
    self.m_composeCallback = callback
    local msgId = MessageId.ResponseCompoundMakeItem
    local handler = Bind(self, self.OnResponseCompoundMakeItem)
    self.m_rsComposeItem = NetPack:RegistResponse(msgId, handler)
    NetPack:SendMessage(MessageId.RequestCompoundMakeItem, request)
end

function M:OnResponseCompoundMakeItem(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsComposeItem)
    self.m_rsComposeItem = nil
    if result ~= 0 then return end
    self.m_composeRequest = nil

    if self.m_composeCallback then
        self.m_composeCallback(msg)
        self.m_composeCallback = nil
    end
    --合成仓埋点
    local idsStr = ""
    local numStr = ""
    for k, v in pairs(msg.Items) do
        if k == 1 then
            idsStr = idsStr .. v.Id
            numStr = numStr .. v.Cnt
        else
            idsStr = idsStr .. "," .. v.Id
            numStr = numStr .. "," .. v.Cnt
        end
    end
    local effectItems = ""
    for k, v in pairs(msg.EffectItems) do
        if k == 1 then
            effectItems = effectItems .. v.Id
        else
            effectItems = effectItems .. "," .. v.Id
        end
    end
    local typeData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(OtakuType.OtakuRoomType.EST_Compose)
    local roleLives = typeData[1]:RoleLives()
    local heros = ""
    for k, v in pairs(roleLives) do
        if k ~= 1 then
            heros = heros .. "," .. v.HeroId
        else
            heros = v.HeroId
        end
    end
    local dataValues = { idsStr, numStr, heros, effectItems }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Cabin_sythetic, dataValues)
end

-- houseRes
function M:GetHouseResByTypeIndex(roomType, index)
    if self.m_houseResDic[roomType] == nil then
        self.m_houseResDic[roomType] = {}
    end
    if self.m_houseResDic[roomType][index] ~= nil then
        return self.m_houseResDic[roomType][index]
    end
    local configs = ConfigHelper.GetCfgsByLua("houseRes")
    for _, value in pairs(configs) do
        if self.m_houseResDic[value.type] == nil then
            self.m_houseResDic[value.type] = {}
        end
        self.m_houseResDic[value.type][value.index] = value
    end
    return self.m_houseResDic[roomType][index]
end

-- house 表数据
function M:GetHouseByBridgeLv(bridgeLv)
    if not self.m_houseDic then self.m_houseDic = {} end
    local house = self.m_houseDic[bridgeLv]
    if not house then
        local configs = ConfigHelper.GetCfgsByLua("house")
        for _, value in pairs(configs) do
            self.m_houseDic[value.level] = value
        end
        house = self.m_houseDic[bridgeLv]
    end
    if not house then Logger.LogError("house is nil. level = " .. bridgeLv) end
    return house
end

-- houseLevel 表数据
function M:GetHouseLevelByType(roomType)
    local houseLevels = self.m_houseLevelDic[roomType]
    if not houseLevels then
        local configs = ConfigHelper.GetCfgsByLua("houseLevel")
        for _, value in pairs(configs) do
            local room_type = value.type
            if not self.m_houseLevelDic[room_type] then
                self.m_houseLevelDic[room_type] = {}
            end
            tInsert(self.m_houseLevelDic[room_type], value)
        end
        for _, list in pairs(self.m_houseLevelDic) do
            table.sort(list, function(a, b)
                return a.level < b.level
            end)
        end
        houseLevels = self.m_houseLevelDic[roomType]
    end
    if not houseLevels then Logger.LogError("houseLevel is nil. type = " .. roomType) end
    return houseLevels
end

-- 最大级别houseLevel配置
function M:GetMaxHouseLevelCfgByType(roomType)
    local houseLevels = self:GetHouseLevelByType(roomType)
    if houseLevels and #houseLevels > 0 then
        return houseLevels[#houseLevels]
    end
    return nil
end

-- 舰桥中心等级限制内可建造房间数量上限【house】
function M:GetRoomBuildLimitByType(roomType, bridgeLv)
    local field = self.m_houseFieldDic[roomType]
    if field then
        return self:GetHouseByBridgeLv(bridgeLv)[field][1]
    end
    return 0
end

-- 房间建造最大数量
function M:GetMaxRoomBuildNumByType(roomType)
    local field = self.m_houseFieldDic[roomType]
    local mainType = OtakuRoomType.EST_Bridge
    local houseLevel = self:GetMaxHouseLevelCfgByType(mainType)
    if field and houseLevel then
        return self:GetHouseByBridgeLv(houseLevel.level)[field][1]
    end
    return 0
end

-- 房间最大可升级等级
function M:GetMaxRoomLevelByType(roomType)
    local field = self.m_houseFieldDic[roomType]
    local mainType = OtakuRoomType.EST_Bridge
    local houseLevel = self:GetMaxHouseLevelCfgByType(mainType)
    if field and houseLevel then
        return self:GetHouseByBridgeLv(houseLevel.level)[field][2]
    end
    return 0
end

-- 舰桥中心等级限制内房间可升级上限【house】
function M:GetRoomLvLimitByType(roomType, bridgeLv)
    local field = self.m_houseFieldDic[roomType]
    if field then
        return self:GetHouseByBridgeLv(bridgeLv)[field][2]
    end
    return 0
end

-- 舰桥中心当前等级房间可升级上限
function M:GetRoomCurUpLimitByType(roomType)
    local bridgeLv = self:GetBridgeCenterLevel()
    return self:GetRoomLvLimitByType(roomType, bridgeLv)
end

-- 舰桥中心当前等级房间可建造上限
function M:GetRoomCurBuildLimitByType(roomType)
    local bridgeLv = self:GetBridgeCenterLevel()
    return self:GetRoomBuildLimitByType(roomType, bridgeLv)
end

-- 舰桥中心等级
function M:GetBridgeCenterLevel(roomType, roomLevel)
    if roomType and roomLevel then
        local field = self.m_houseFieldDic[roomType]
        if field then
            if not self.m_houseDic then self:GetHouseByBridgeLv(1) end
            for lv, house in pairs(self.m_houseDic) do
                if house[field][2] == roomLevel then return lv end
            end
        end
    else
        local bridgeLv = 0
        local roomDatas = self:RoomDatasByRoomType(OtakuRoomType.EST_Bridge)
        for _, roomData in ipairs(roomDatas) do
            local level = roomData:Level()
            if level > bridgeLv then bridgeLv = level end
        end
        return bridgeLv
    end
    return 0
end

-- 一键领取调查舱
function M:SurveyCabinClaim(callback)
    local roomDatas = self:RoomDatasByRoomType(OtakuRoomType.EST_Survey)
    if #roomDatas == 0 then
        GameHelper.TipsById(5648) -- 未建造调查舱
        return
    end

    local roomData = roomDatas[1]
    local ids = roomData:GetFinishSurveyIds()
    if #ids > 0 then
        roomData:RqAwardExpMissionAll(callback, ids)
    else
        GameHelper.TipsById(5649) -- 没有可领取调查任务
    end
end

-- 所有已开始调查任务的英雄
function M:GetSurveyAllAssignHeros()
    local list = {}
    local roomDatas = self:RoomDatasByRoomType(OtakuRoomType.EST_Survey)
    for _, roomData in ipairs(roomDatas) do
        for heroId, _ in pairs(roomData:GetAllHeros()) do
            tInsert(list, heroId)
        end
    end
    return list
end

-- 调查舱任务数量限制
function M:GetSurveyNumLimit(roomLevel)
    local index = (roomLevel - 1) * 2 + 1
    if index < self.m_surveyLimit.Length then
        return self.m_surveyLimit[index]
    end
    return 0
end

-- 舰桥中心升级解锁房间建造数量列表
function M:GetBridgeUpUnlockList(bridgeLevel, index)
    local list = {}
    local curHouse = self:GetHouseByBridgeLv(bridgeLevel)
    local nextHouse = self:GetHouseByBridgeLv(bridgeLevel + 1)
    if curHouse and nextHouse then
        if not self.m_roomFmt then self.m_roomFmt = ConfigHelper.GetLocalString(6210) end
        if not self.m_levelFmt then self.m_levelFmt = ConfigHelper.GetLocalString(6209) end
        for mType, field in pairs(self.m_houseFieldDic) do
            local houseRes = self:GetHouseResByTypeIndex(mType, index)
            local curNum = curHouse[field][1] -- 解锁房间数量
            local nextNum = nextHouse[field][1]
            local name = ConfigHelper.GetLocalString(houseRes.name)
            if curNum < nextNum then -- 没有变化时不显示对应条目
                tInsert(list, {
                    unlockType = 2,  -- 房间解锁
                    roomType = mType,
                    roomIcon = houseRes.icon,
                    roomName = string.format(self.m_roomFmt, name),
                    curMaxNum = curNum,
                    nextMaxNum = nextNum
                })
            end
            local curLv = curHouse[field][2] -- 解锁等级上限
            local nextLv = nextHouse[field][2]
            if curLv < nextLv then           -- 没有变化时不显示对应条目
                tInsert(list, {
                    unlockType = 1,          -- 等级解锁
                    roomType = mType,
                    roomIcon = houseRes.icon,
                    roomName = string.format(self.m_levelFmt, name),
                    curMaxNum = curLv,
                    nextMaxNum = nextLv
                })
            end
        end
    end
    table.sort(list, function(a, b)
        if a.unlockType == b.unlockType then
            return a.roomType > b.roomType     -- 2.再显示房间数量解锁 type大到小
        else
            return a.unlockType < b.unlockType -- 1.先显示等级解锁
        end
    end)
    return list
end

----------------------小红点---------------------------------------
-- 这里没有重构代码，直接从以前的地方copy出来的，最好重构之前的代码
-- 将OtakuMainUICtrl中处理数据的部分分离到这个类中，去除view和数据的耦合
-- 核对是否存在可建造的小红点
function M:CheckRedDotInOtaku()
    local roomDatas = nil

    for type, count in pairs(self.m_roomCountByType) do
        roomDatas = self:RoomDatasByRoomType(type)
        for i = 1, count do
            if not roomDatas[i] then
                local isLock2 = self:IsCompose(type, i)
                local resConfig = roomDatas[i] or OtakuRoomDataMgr:GetInstance():GetHouseResByTypeIndex(type, i)
                local isLock1 = GameHelper.CheckLockByOpenConditionIds(resConfig.openCondition)
                local isLock = isLock1 and isLock2
                if isLock then
                    return true
                end
            end
        end
    end
    return false
end

function M:IsCompose(type, index)
    if type == OtakuRoomType.EST_Dormitory then
        return true
    end

    local typeData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(type)
    local bridgeData = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(OtakuRoomType.EST_Bridge)

    if bridgeData == nil or #bridgeData == 0 then
        return false
    end

    local level = bridgeData[1]:Level()
    local houseConfig = ConfigHelper.GetCfgs("house")
    local config = houseConfig[level]
    local roomConfigType = {
        [OtakuRoomType.EST_Produce] = "make",
        [OtakuRoomType.EST_Communication] = "communication",
        [OtakuRoomType.EST_Dormitory] = "room",
        [OtakuRoomType.EST_Canteen] = "restaurant",
        [OtakuRoomType.EST_Compose] = "makeUp",
        [OtakuRoomType.EST_Survey] = "expMission",
        [OtakuRoomType.EST_Kitchen] = "kitchen"
    }
    local configName = roomConfigType[type]
    local length = config[configName][1]
    return (#typeData < length and #typeData >= index - 1) or false
end

----------------------小红点代码结束---------------------------------------

return M
