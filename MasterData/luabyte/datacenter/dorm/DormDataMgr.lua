local M = BaseClass("DormDataMgr", Singleton)
local PersonChapterData = require("DataCenter.Dorm.PersonChapterData")
local MessageId = Proto.MessageId
local tInsert = table.insert

function M:__init()
    self._OnResponseGiveHeroItemHandle = nil
    self._OnResponseLookRoomStoryHandle = nil
    self._enterDormitoryStudioCallback = nil
    self._responseEnterDormitoryStudioHandler = nil
    self._giveGiftCallback = nil -- 送礼回调
    self._addFavor = 0
    self._giveHeroId = 0
    self.m_copyDataDic = nil -- 个人副本通关记录数据
    self.timelineParts = nil
    self._rspEndBattle = NetPack:RegistResponse(MessageId.ResponsePersonalCopyEndBattle,
        Bind(self, self.OnRspPersonalCopyEndBattle))
end

local function SortData(data1, data2)
    local cfg1 = data1.data:GetItemCfg()
    local cfg2 = data2.data:GetItemCfg()
    --1、同道具类型按照道具品质排序，品质高得排前面，即4在前，1最后；配置字段quality；
    if cfg1.quality == cfg2.quality then
        --2、同类型同品质，按照配置字段order
        return cfg1.order < cfg2.order
    else
        return cfg1.quality > cfg2.quality
    end
end

--进入宿舍
function M:EnterDormitoryStudio(roomId, callback)
    if self._isSending then
        return
    end

    self._enterDormitoryStudioCallback = callback
    local request = {}
    request.HeroId = roomId
    NetPack:SendMessage(MessageId.RequestEnterDormitoryStudio, request)
    self._isSending = true
    self._responseEnterDormitoryStudioHandler = NetPack:RegistResponse(MessageId.ResponseEnterDormitoryStudio,
        Bind(self, self.OnResponseEnterDormitoryStudio))
end

--进入宿舍返回
function M:OnResponseEnterDormitoryStudio(messagId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseEnterDormitoryStudio, self._responseEnterDormitoryStudioHandler)
    self._responseEnterDormitoryStudioHandler = nil
    self._isSending = false

    if result ~= 0 then
        return
    end

    --更新宿舍激活状态
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(msg.HeroId)
    rshd:UpdateDormActive(1)

    ModuleMgr:GetInstance():ChangeModule(ModuleConfig.Dorm.id, msg.HeroId)

    if self._enterDormitoryStudioCallback then
        self._enterDormitoryStudioCallback(msg)
    end

    self.__enterDormitoryStudioCallback = nil
end

-- 获得所有礼物
function M:GetGiftItems(heroId)
    self.systemId = ConfigHelper.GetSystemParam(358)
    local heroCfg = ConfigHelper.GetCfg("hero", heroId)
    local csItemDatas = ItemDataMgr:GetInstance():GetItemsByTypes({ 12 })
    local datas = {}
    local len = csItemDatas.Count
    local isGuide = (DormHelper.CheckGift(heroId, self.systemId) == false and self.heroId == 110003)

    for i = 0, len - 1 do
        local isAvilable = false -- 是否可用于该角色
        local isForHero = false  -- 是否为该角色专有
        local itemData = csItemDatas[i]

        if itemData.Num > 0 then
            local itemCfg = itemData:GetItemCfg()
            isAvilable, isForHero = OtakuHelper.HasUnlockAct(heroCfg, itemCfg)

            if isAvilable then
                local data = {}
                data.data = itemData  -- heroData from c#
                data.isSelect = false -- isSelect
                if isGuide == true then
                    if itemCfg.id == self.systemId then
                        data.selectable = true
                    else
                        data.selectable = false
                    end
                else
                    data.selectable = true
                end
                data.isUp = OtakuHelper.IsUpGiftItem(heroCfg, itemCfg.id)
                data.quality = itemCfg.quality
                tInsert(datas, data)
            end
        end
    end
    table.sort(datas, SortData)
    return datas
end

-- 送礼
function M:GiftGiving(heroId, itemId, itemNum, giveGiftCallback)
    local request = {}
    request.ItemId = itemId
    request.ItemNum = itemNum
    request.HeroId = heroId
    self._giveGiftId = itemId
    NetPack:SendMessage(MessageId.RequestGiveHeroItem, request)
    self._giveGiftCallback = giveGiftCallback
    self._OnResponseGiveHeroItemHandle = NetPack:RegistResponse(MessageId.ResponseGiveHeroItem,
        Bind(self, self._OnResponseGiveHeroItem))
end

-- 送礼协议返回
function M:_OnResponseGiveHeroItem(messageId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseGiveHeroItem, self._OnResponseGiveHeroItemHandle)

    if result ~= 0 then
        return
    end

    self._addFavor = msg.AddFavor
    self._giveHeroId = msg.HeroId
    local dataValues = { tostring(2) }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Interaction, dataValues)
    GameKeyNodeMgr:GetInstance():Record(EGameKeyNode.HerosFavorAbilityUp)
    GameKeyNodeMgr:GetInstance():Record(EGameKeyNode.Gift)
    local giftItemCfg = ConfigHelper.GetCfgByLua("item", self._giveGiftId)
    local groupId = giftItemCfg.effectArgs[5]
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
    --更新送礼列表
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(msg.HeroId)
    rshd:UpdateGiftRec(self._giveGiftId)
    --宿舍心流体验
    if self.module.isGuide then
        IGuideMgr:ManualTriggerGuideSystem()
        self.module.isGuide = false
        DormHelper.SetFreeLookCamera(true)
    end
    -- 触发timeline
    if giftItemCfg and groupId > 0 then
        local timelineId = DormHelper.GetTimelineId(self._giveHeroId, groupId)
        local timelineCfg = ConfigHelper.GetCfgByLua("timeline", timelineId)
        local furnitures = {}
        if #timelineCfg.furnitureId > 0 then
            for key, value in pairs(timelineCfg.furnitureId) do
                local furniture = self.module:GetFurniture(value)
                if furniture then
                    tInsert(furnitures, furniture.gameObj)
                end
            end
        end
        --播放timeline
        DormHelper.PlayTimeline(timelineId, furnitures, function(...)
            UIContextMgr:GetInstance():GetContext("DormGift"):clearCallback()
            UIContextMgr:GetInstance():Close("DormGift")
            if #timelineCfg.dormParams > 0 then
                self.timelineParms = MapUtil.Find(DormConst.TimelineParms, function(c)
                    return c.type == timelineCfg.dormParams[1]
                end)
                self.actionParms = timelineCfg.dormParams[2]
                if self.timelineParms then
                    DormHelper.SetRoleAndCamera(self.timelineParms.furniture, self.timelineParms.watchPoint,
                        Bind(self, self.GiftTimelineCallBack))
                end
            end
        end)
    else
        self:GiftFeedBack(msg)
    end

    if self._giveGiftCallback then
        self._giveGiftCallback(self._giveHeroId, self._addFavor, nil)
    end

    self._giveGiftCallback = nil
end

--送礼反馈
function M:GiftFeedBack(msg)
    -- 通用送礼反馈
    local curFuritureData = DormHelper.GetCurrentFurnitureData()
    local actionId = DormHelper.GetRandomGiftWord(self._giveHeroId)
    if actionId then
        DormHelper.PlayActionById(curFuritureData, actionId)
    end
    if msg.Gifts and #msg.Gifts > 0 then
        GameHelper.ItemTipsByTableArr(msg.Gifts)
    end
end

--播放timeline回调
function M:GiftTimelineCallBack(data)
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    self.dormAction:SwitchFurnitureAction(self.timelineParms.furniture, data)
    UIContextMgr:GetInstance():Show("Dorm")
    if self.actionParms > 0 then
        local curFuritureData = DormHelper.GetCurrentFurnitureData()
        DormHelper.PlayActionById(curFuritureData, self.actionParms)
    end
    self.timelineParms = nil
    self.actionParms = nil
end

-- 查看好感度等级剧情
function M:LookHeroFeelingLevelStory(heroId, feelingLevel, stepId, index, lookHeroFeelingLevelStoryCallback)
    if self._isSending then
        return
    end

    self._isSending = true

    local request = {}
    request.HeroId = heroId
    request.FeelingLevel = feelingLevel
    request.StepId = stepId
    request.Index = index
    NetPack:SendMessage(MessageId.RequestLookHeroFeelingLevelStory, request)
    self._lookHeroFeelingLevelStoryCallback = lookHeroFeelingLevelStoryCallback
    self._responseLookHeroFeelingLevelStoryHandler = NetPack:RegistResponse(MessageId.ResponseLookHeroFeelingLevelStory,
        Bind(self, self.OnResponseLookHeroFeelingLevelStory))
end

-- 查看好感度等级剧情返回
function M:OnResponseLookHeroFeelingLevelStory(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseLookHeroFeelingLevelStory, self._responseLookHeroFeelingLevelStoryHandler)

    if result ~= 0 then
        return
    end

    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(msg.HeroId)
    rshd:UpdateRoomStory(msg.RoomStory)

    if self._lookHeroFeelingLevelStoryCallback then
        self._lookHeroFeelingLevelStoryCallback(msg)
    end

    self._lookHeroFeelingLevelStoryCallback = nil
    self._responseLookHeroFeelingLevelStoryHandler = nil
end

--英雄触发小剧场任务
function M:HeroEventStoryTrigger(heroId, eventType, eventId, callback)
    if self._isSending then
        return
    end

    self._isSending = true

    local request = {}
    request.HeroId = heroId
    request.EventType = eventType
    request.EventId = eventId
    NetPack:SendMessage(MessageId.RequestHeroEventStoryTrigger, request)
    self._heroEventStoryTriggerCallback = callback
    self._responseHeroEventStoryTriggerHandler = NetPack:RegistResponse(MessageId.ResponseHeroEventStoryTrigger,
        Bind(self, self.OnResponseHeroEventStoryTrigger))
end

--英雄触发小剧场任务返回
function M:OnResponseHeroEventStoryTrigger(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseHeroEventStoryTrigger, self._responseHeroEventStoryTriggerHandler)
    if result ~= 0 then
        return
    end

    if self._heroEventStoryTriggerCallback then
        self._heroEventStoryTriggerCallback(msg)
    end

    self._responseHeroEventStoryTriggerHandler = nil
end

--英雄小剧场领奖协议
function M:HeroEventStoryCommit(heroId, callBack)
    if self._isSending then
        return
    end

    self._isSending = true

    local request = {}
    request.HeroId = heroId
    NetPack:SendMessage(MessageId.RequestHeroEventStoryCommit, request)
    self._heroEventStoryCommitCallback = callBack
    self._responseHeroEventCommitTriggerHandler = NetPack:RegistResponse(MessageId.ResponseHeroEventStoryCommit,
        Bind(self, self.OnResponseHeroEventStoryCommit))
end

--英雄小剧场领奖协议返回
function M:OnResponseHeroEventStoryCommit(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseHeroEventStoryCommit, self._responseHeroEventCommitTriggerHandler)
    if result ~= 0 then
        return
    end

    if self._heroEventStoryCommitCallback then
        self._heroEventStoryCommitCallback(msg)
    end

    self._responseHeroEventCommitTriggerHandler = nil
end

--刷新爱心值
function M:RequestRefreshLoveValue(heroId, loveValue, eventId, callBack)
    if self._isSending then
        return
    end

    self._isSending = true

    local request = {}
    request.HeroId = heroId
    request.LoveValue = loveValue
    request.EventId = eventId
    NetPack:SendMessage(MessageId.RequestRefreshLoveValue, request)
    self.requestRefreshLoveValueCallBack = callBack
    self.responseRefreshLoveValueHandler = NetPack:RegistResponse(MessageId.ResponseRefreshLoveValue,
        Bind(self, self.OnResponseRefreshLoveValue))
end

--刷新爱心值回调
function M:OnResponseRefreshLoveValue(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseRefreshLoveValue, self.responseRefreshLoveValueHandler)
    if result ~= 0 then
        return
    end

    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(msg.HeroId)
    if not IsNull(rshd) then
        rshd:UpdateLoveValue(msg.TotalLoveValue, msg.Timestamp)
    end
    local itemDic = {}
    for _, item in ipairs(msg.FlipCardAward or {}) do
        local num = itemDic[item.Id] or 0
        itemDic[item.Id] = item.Cnt + num
    end
    GameHelper.DormItemTips(itemDic,true)

    EventMgr:Broadcast(UIMessageNames.DORM_INTERACT_CLICK)
    if self.requestRefreshLoveValueCallBack then
        self.requestRefreshLoveValueCallBack(msg)
    end

    self.responseRefreshLoveValueHandler = nil
    if msg.TotalLoveValue >= 100 then
        IBuriedPointDataMgr:SubmitData(BuriedPointConst.Mood)
    end
end

--爱心值满100触发事件领奖
function M:RequestLoveValueAward(heroId, type, eventId, groupId, stepId, index, callBack)
    if self._isSending then
        return
    end

    self._isSending = true

    local request = {}
    request.Type = type
    request.HeroId = heroId
    request.EventId = eventId
    if type == 1 then
        request.GroupId = groupId
        request.StepId = stepId
        request.Index = index
    else
        request.EventId = eventId
    end
    NetPack:SendMessage(MessageId.RequestLoveValueAward, request)
    self.requestLoveValueAwardCallBack = callBack
    self.responsetLoveValueAwardHandler = NetPack:RegistResponse(MessageId.ResponseLoveValueAward,
        Bind(self, self.OnResponseLoveValueAward))
end

--爱心值领奖回调
function M:OnResponseLoveValueAward(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseLoveValueAward, self.responsetLoveValueAwardHandler)
    if result ~= 0 then
        return
    end

    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(msg.HeroId)
    if not IsNull(rshd) then
        rshd:UpdateIsTrigger(1)
    end

    if self.requestLoveValueAwardCallBack then
        self.requestLoveValueAwardCallBack(msg)
    end

    self.responsetLoveValueAwardHandler = nil
    EventMgr:Broadcast(UIMessageNames.DORM_UPDATE_FAVOR)
end

--替换宿舍风格
function M:DormChangeStyle(heroId, index, callBack)
    if self._isSending then
        return
    end

    self._isSending = true

    local request = {}
    request.HeroId = heroId
    request.RoomStyle = index
    NetPack:SendMessage(MessageId.RequestChangeRoomStyle, request)
    self._dormChangeStyleCallBack = callBack
    self._OnResponseChangeRoomStyleHandler = NetPack:RegistResponse(MessageId.ResponseChangeRoomStyle,
        Bind(self, self.OnResponseChangeRoomStyle))
end

--替换宿舍风格回调
function M:OnResponseChangeRoomStyle(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseChangeRoomStyle, self._OnResponseChangeRoomStyleHandler)

    if result ~= 0 then
        return
    end

    if self._dormChangeStyleCallBack then
        self._dormChangeStyleCallBack(msg)
    end

    self._OnResponseChangeRoomStyleHandler = nil
end

--氛围值奖励领取
function M:RequestAwardAtmosphere(heroId, callback)
    if self._isSending then
        return
    end

    self.rewardHeroId = heroId
    self._isSending = true

    local request = {}
    request.HeroId = heroId
    NetPack:SendMessage(MessageId.RequestAwardAtmosphere, request)
    self.awardAtmosphereCallback = callback
    self.OnResponseAwardAtmosphereHandler = NetPack:RegistResponse(MessageId.ResponseAwardAtmosphere,
        Bind(self, self.OnResponseAwardAtmosphere))
end

function M:OnResponseAwardAtmosphere(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseAwardAtmosphere, self.OnResponseAwardAtmosphereHandler)

    if result ~= 0 then
        return
    end

    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self.rewardHeroId)
    if not IsNull(rshd) then
        rshd:UpdateAtmosphere(msg.Level)
    end
    --宿舍氛围值领取埋点
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Atmosphere, { msg.Level })
    if self.awardAtmosphereCallback then
        self.awardAtmosphereCallback(msg)
    end

    self.OnResponseAwardAtmosphereHandler = nil
end

-- 进入个人副本
function M:EnterPersonalCopy(data, callback)
    if not data then return end

    local mission = data.MissionCfg
    local dataValues = { tostring(mission.id) }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Plot_reading, dataValues)
    -- 当关卡为文字类型关卡时则直接进入对应剧情模式即可
    if mission.wordsMission == 1 then
        if not StoryDataMgr:GetInstance():TriggerStoryByGroupIds(mission.storyID, mission.id, StoryConst.TriggerType.Story, function()
                if callback then callback(ModuleMgr:GetInstance():GetCurrentModule().roleStudio) end
                NetPack:SendMessage(MessageId.RequestPersonalCopyEndBattle, {
                    HeroId = data.HeroId(),
                    MissionId = mission.id,
                    ChapterId = mission.ChapterId,
                    IsWin = protocol.BattleRes.WIN,
                })
                GameHelper.DoPlayerAction(PlayerAction.OpenRoom)
            end)
        then
            GameHelper.TipsById(5202) -- 没有配置剧情
        end
    else
        local idArr = mission.beforeBattlestoryID or { Length = 0 }
        local groupId = idArr.Length > 0 and idArr[0] or 0
        -- 当关卡为战斗关卡时则直接进入该战斗关卡的战前剧情内，在战前剧情结束后在弹出对应关卡详情面板
        if not StoryDataMgr:GetInstance():TriggerStoryByGroupId(groupId, mission.id, function()
                UIContextMgr:GetInstance():Show("DormPersonalEventPopup", data)
            end)
        then
            --	如果没有配置战前剧情则直接进入关卡详情面板
            UIContextMgr:GetInstance():Show("DormPersonalEventPopup", data)
        end
    end
end

-- 请求个人副本数据
function M:DoReqLoadPersonalCopy()
    if self.m_rsLoadPersonal then return end

    local chapters = {}
    self:_InitPersonData()
    for id, _ in pairs(self.m_copyDataDic) do table.insert(chapters, id) end
    for _, data in ipairs(ActivityDataMgr:GetInstance():GetActivitySimpleByType(ActivityType.DORM_PUZZLE)) do
        if not data:IsClosed() then
            local cfgs = ConfigHelper.GetCfgsByLua("activityRoomFlip", { activityId = data:ActivityId() })
            local cfg = cfgs and cfgs[1] or nil
            if cfg then
                local id, heroId = cfg.chapterId, cfg.hero
                if not self:GetPersonData(id) then
                    if not self.m_heroChapterDic[heroId] then self.m_heroChapterDic[heroId] = {} end
                    table.insert(chapters, id)
                    table.insert(self.m_heroChapterDic[heroId], id)
                    local info = { ChapterId = id, LastMissionId = 0 }
                    self.m_copyDataDic[id] = PersonChapterData.New(info, heroId, data:EndTime())
                end
            else
                Logger.LogError("activityRoomFlip is nil, @锵锵, id = " .. data:ActivityId())
            end
        end
    end
    local msgId = MessageId.ResponseLoadPersonalCopy
    local msgHander = Bind(self, self.OnRspLoadPersonalCopy)
    self.m_rsLoadPersonal = NetPack:RegistResponse(msgId, msgHander)
    NetPack:SendMessage(MessageId.RequestLoadPersonalCopy, { Chapters = chapters })
end

-- 个人数据回调
function M:OnRspLoadPersonalCopy(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsLoadPersonal)
    self.m_rsLoadPersonal = nil
    if result ~= 0 then return end

    for _, info in ipairs(msg.Data or {}) do
        self:_UpdatePersonData(info)
    end
end

-- 战斗结算
function M:OnRspPersonalCopyEndBattle(_, result, msg)
    if result ~= 0 then return end

    self:_UpdatePersonData(msg)
    local mission = ConfigHelper.GetCfgByLua("mission", msg.MissionId)
    if mission and mission.wordsMission == 1 then
        GameHelper.ShowGetItemsByItems(msg.Awards, function()
            EventMgr:Broadcast(UIMessageNames.DORM_PERSONALCOPY_ENDBATTLE, msg.HeroId)
        end)
    end
end

function M:_UpdatePersonData(info)
    local id = info.ChapterId
    local data = self:GetPersonData(id)
    data:UpdateLastMissionId(info.LastMissionId)
end

-- 当前英雄的个人副本通关记录
function M:GetPersonalPassRecord(heroId)
    local chapters, datas = self:GetHeroChapters(heroId), {}
    for _, id in ipairs(chapters) do
        local data = self:GetPersonData(id)
        if data then table.insert(datas, data) end
    end

    table.sort(datas, function(a, b)
        return a:ChapterId() < b:ChapterId()
    end)
    return datas
end

function M:GetPersonData(chapterId)
    self:_InitPersonData()
    return self.m_copyDataDic[chapterId]
end

-- 英雄的普通个人副本
function M:GetHeroChapters(heroId)
    self:_InitPersonData()
    return self.m_heroChapterDic[heroId] or {}
end

function M:_InitPersonData()
    if not self.m_copyDataDic and not self.m_heroChapterDic then
        self.m_copyDataDic = {}
        self.m_heroChapterDic = {}
        local heroCfgs = ConfigHelper.GetCfgs("hero")
        if heroCfgs and heroCfgs.Length > 0 then
            for i = 0, heroCfgs.Length - 1 do
                local hero = heroCfgs[i]
                local mIds = hero.chapterId
                if mIds and (mIds.Length > 0) then
                    local arr, heroId = {}, hero.id
                    for j = 0, mIds.Length - 1 do
                        local id = mIds[j]
                        table.insert(arr, id)
                        local info = { ChapterId = id, LastMissionId = 0 }
                        self.m_copyDataDic[id] = PersonChapterData.New(info, heroId)
                    end
                    self.m_heroChapterDic[heroId] = arr
                end
            end
        end
    end
end

-- 个人副本列表
function M:GetPersonalCopyList(heroId)
    local dataList, doingData = {}, nil
    for _, cptData in ipairs(self:GetPersonalPassRecord(heroId)) do
        local missionDatas = cptData:GetAllMissions()
        for _, md in ipairs(missionDatas) do
            local unlock = md.FirstLock() == 0
            local isDoing = not md.IsPass() and md.IsPrePass()
            -- 正在进行的关卡
            if not doingData and isDoing and unlock then doingData = md end
        end
        tInsert(dataList, missionDatas)
    end
    return dataList, doingData
end

-- 是否通关个人副本关卡
function M:IsPassPersonalCopy(_, missionId)
    local mission = ConfigHelper.GetCfgByLua("mission", missionId)
    if mission then
        local data = self:GetPersonData(mission.chapterID)
        return data and data:IsPassMission(missionId) or false
    else
        Logger.LogError("mission is nil, @锵锵, id = " .. missionId)
    end
    return false
end

-- 已解锁正在进行的关卡
function M:GetActivePersonalCopy(heroId)
    local _, data = self:GetPersonalCopyList(heroId)
    return data
end

function M:CheckDormRedPoint()
    local isShow = false
    local roleRoomCfgs = ConfigHelper.GetCfgsByLua("roleRoom")
    for key, value in pairs(roleRoomCfgs) do
        local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(value.heroId)
        if not IsNull(rshd) then
            if rshd.DormActive == 1 then
                if self:CheckHeroRedPoint(value.heroId) then
                    isShow = true
                    return isShow
                end
            end
        end
    end
    return isShow
end

--宿舍红点判断
function M:CheckHeroRedPoint(heroId)
    local isShow = false

    --判断是否宿舍固定剧情
    if PresentReturnDataMgr:GetRepresentFixedStoryByHeroId(heroId) then
        isShow = true
        return isShow
    end
    --判断是否有回礼
    if PresentReturnDataMgr:CheckHeroRePresentTips() then
        isShow = true
        return isShow
    end

    --判断是否有氛围值奖励
    if self:CheckAtmosphereAward(heroId) then
        isShow = true
        return isShow
    end
    if heroId then
        self.rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)
        if IsNull(self.rshd) then
            return false
        end
        local favor = self.rshd:GetFavor()
        local favorLevel = 0
        local curFavor = 0
        local nextFavor = 0
        local favorProgress = 0
        local stage = 0
        local roomStory = 0
        local roomStoryLevel = 0
        favorLevel, curFavor, nextFavor, favorProgress, stage, roomStory, roomStoryLevel = OtakuHelper.GetHeroFeeling(
            heroId
            , favor)
        if roomStory ~= 0 then
            isShow = true
            return isShow
        end
    end
    return isShow
end 

function M:CheckAtmosphereAward(HeroId)
    if HeroId > 0 then
        local heroAtmospheres = ConfigHelper.GetCfgsByLua("atmosphere", { heroId = HeroId })
        local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(HeroId)
        local curAtmosphere = OtakuFurniturDataMgr:GetAtmosphere(HeroId)
        local maxLevel = 0
        local isMax = false
        if not IsNull(rshd) then
            for k, v in pairs(heroAtmospheres) do
                if v.level > maxLevel then
                    maxLevel = v.level
                end
            end
            if rshd.Atmosphere == maxLevel then
                isMax = true
            end
            if isMax == false then
                local targetCfg = ConfigHelper.GetCfgsByLua("atmosphere",
                    { heroId = HeroId, level = rshd.Atmosphere + 1 })
                local canReward = curAtmosphere >= targetCfg[1].buffLabel
                return canReward
            end
        end
    end
    return false
end

--宿舍交互请求
function M:RequestDormInteract(heroId)
    local request = {}
    request.HeroId = heroId
    NetPack:SendMessage(MessageId.RequestDormInteract, request)
    self._responseDormInteract = NetPack:RegistResponse(MessageId.ResponseDormInteract,
        Bind(self, self.OnResponseDormInteract))
end

function M:OnResponseDormInteract(messageId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseDormInteract, self._responseDormInteract)
    if result ~= 0 then
    end
end

function M:Dispose()
    if self.m_rsLoadPersonal then
        NetPack:UnRegistResponse(MessageId.ResponseLoadPersonalCopy, self.m_rsLoadPersonal)
        self.m_rsLoadPersonal = nil
    end
    NetPack:UnRegistResponse(MessageId.ResponsePersonalCopyEndBattle, self._rspEndBattle)

    self._rspEndBattle = nil
    self.m_copyDataDic = nil
    self.m_heroChapterDic = nil
    self._giveGiftCallback = nil
    self._OnResponseGiveHeroItemHandle = nil
    self._OnResponseLookRoomStoryHandle = nil
end

return M
