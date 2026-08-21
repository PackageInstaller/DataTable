local M = BaseClass("PlotAtlasDataMgr", Singleton)
local MessageId = Proto.MessageId
local tInsert = table.insert
local tSort = table.sort

function M:__init()
    self.m_unlocIdDic = {}       -- 剧情图鉴已解锁storyBook表Id
    self.m_bookRwdData = {}      -- 百科图鉴奖励记录
    self.m_bookUnlockNum = {}    -- 百科图鉴解锁数量
    self.m_dormUnlockDick = {}   -- 宿舍图鉴已解锁bookDormitoryStory表id
    self.m_heroFactionDic = {}   -- 英雄图鉴阵营字典
    self.m_mainStoryBookDic = {} -- 主线剧情图鉴配置字典
    self.m_bookTypeDic = nil     -- 百科图鉴类型数据
    self.m_bookGroupDic = nil    -- 百科图鉴数据
    self.m_dormStoryDic = nil    -- 宿舍剧情
    self.m_heroRwdDatas = nil
    self.m_storyGroupDic = nil   -- 剧情图鉴数据
    self.m_enterBookCallback = nil
    self.m_atlasResetCallback = nil
end

function M:Cleanup()
end

function M:Dispose()
    NetPack:UnRegistResponse(MessageId.ResponseEnterBook, self.m_rsEnterBook)
    NetPack:UnRegistResponse(MessageId.ResponseRewardBookAward, self.m_rsBookAward)
    NetPack:UnRegistResponse(MessageId.RequestUnlockBookStory, self.m_rsUnlockStory)
    NetPack:UnRegistResponse(MessageId.ResponseEnterBookStory, self.m_rsEnterBookStory)
    NetPack:UnRegistResponse(MessageId.ResponseRewardBooksAward, self.m_rsFastBooksAward)

    self.m_rsEnterBook = nil
    self.m_rsBookAward = nil
    self.m_rsUnlockStory = nil
    self.m_rsFastBooksAward = nil
    self.m_rsEnterBookStory = nil

    self.m_unlockStoryCallback = nil
    self.m_enterStoryCallback = nil
    self.m_atlasResetCallback = nil
    self.m_enterBookCallback = nil
    self.m_mainStoryBookDic = nil
    self.m_heroFactionDic = nil
    self.m_dormUnlockDick = nil
    self.m_bookUnlockNum = nil
    self.m_storyGroupDic = nil
    self.m_bookGroupDic = nil
    self.m_heroRwdDatas = nil
    self.m_dormStoryDic = nil
    self.m_bookRwdData = nil
    self.m_bookTypeDic = nil
    self.m_unlocIdDic = nil
    self.m_heroList = nil
end

-- 百科图鉴内容
function M:_InitBookGroups()
    if not self.m_bookGroupDic then
        self.m_bookGroupDic = {}
        for _, config in pairs(ConfigHelper.GetCfgsByLua("book")) do
            local bookType = config.type
            if not self.m_bookGroupDic[bookType] then
                self.m_bookGroupDic[bookType] = {}
            end
            tInsert(self.m_bookGroupDic[bookType], config)
        end
    end
end

-- 剧情图鉴内容
function M:_InitStoryGroups()
    if not self.m_storyGroupDic then
        self.m_storyGroupDic = {}
        for _, config in pairs(ConfigHelper.GetCfgsByLua("bookStory")) do
            local subType = config.subType
            if not self.m_storyGroupDic[subType] then
                self.m_storyGroupDic[subType] = {}
            end
            tInsert(self.m_storyGroupDic[subType], config)
        end
    end
end

-- 剧情图鉴类型
function M:_InitStoryTyps()
    if not self.m_storyTypeDic then
        self.m_storyTypeDic = {}
        for _, config in pairs(ConfigHelper.GetCfgsByLua("bookStoryChapter")) do
            local _type = config.type
            if not self.m_storyTypeDic[_type] then
                self.m_storyTypeDic[_type] = {}
            end
            tInsert(self.m_storyTypeDic[_type], config)
        end
    end
end

-- 图鉴类型
function M:_InitAtlasTypes()
    if not self.m_bookTypeDic then
        self.m_bookTypeDic = {}
        for _, config in pairs(ConfigHelper.GetCfgsByLua("bookReward")) do
            self.m_bookTypeDic[config.type] = config
        end
    end
end

-- 显示图鉴奖励
function M:_ShowBookReward(rewards)
    local itemDic = {}
    for _, item in ipairs(rewards or {}) do
        local num = itemDic[item.Id] or 0
        itemDic[item.Id] = item.Cnt + num
    end
    GameHelper.ShowGetItems(itemDic)
end

-- 响应进入百科图鉴协议
function M:OnRsEnterBook(messageId, result, msg)
    self._isloading = false
    self._dataLoaded = true
    self._errorCode = result
    NetPack:UnRegistResponse(messageId, self.m_rsEnterBook)
    self.m_rsEnterBook = nil

    if result ~= 0 then return end

    for _, types in ipairs(msg.Books or {}) do
        local rewards = types.Rewards
        local record = self:GetBookRwdData(types.BookType)
        for _, idx in ipairs(rewards or {}) do
            local index = idx + 1
            if record and not record[index] then record[index] = true end
        end
        -- 战员图鉴奖励
        if types.BookType == 5 then self:_UpdateRewardState(rewards) end
    end

    IRedPointMgr:ForceCheck(RedPointConst.HeroAltasRedPointChecker)
end

-- 使用百科图鉴类型获取百科图鉴数据
function M:GetBookGroupByType(_type)
    self:_InitBookGroups()
    return (_type == 0) and self.m_bookGroupDic or self.m_bookGroupDic[_type]
end

-- 所有module类型字典数据
function M:GetBookTypeConfigs(moduleType)
    if not moduleType then moduleType = 1 end
    local list = {}
    for _, config in pairs(self:GetBookAwdByType()) do
        if config.module == moduleType then tInsert(list, config) end
    end
    table.sort(list, function(a, b) return a.type < b.type end)
    return list
end

-- 剧情图鉴指定类型数据
function M:GetBookStorysBySubType(subType)
    self:_InitStoryGroups()
    return self.m_storyGroupDic[subType]
end

-- 剧情图鉴类型
function M:GetBookStoryTypes(mType)
    self:_InitStoryTyps()
    return mType and self.m_storyTypeDic[mType] or self.m_storyTypeDic
end

-- 主线剧情图鉴子类型组
function M:GetMainStoryBookBySubType(mSubType)
    if not self.m_mainStoryBookDic[mSubType] then
        local dic = {}
        for _, value in ipairs(self:GetBookStoryTypes(EnumConst.StoryBookType.Main) or {}) do
            local subType = value.subType
            for _, cfg in ipairs(self:GetBookStorysBySubType(subType) or {}) do
                local group = dic[subType]
                if not group then group = {} end
                tInsert(group, cfg)
                dic[subType] = group
            end
        end
        if not dic[mSubType] then dic[mSubType] = {} end
        self.m_mainStoryBookDic = dic
    end
    return self.m_mainStoryBookDic[mSubType]
end

--领取图鉴奖励Req
function M:RequestRewardBookAward(rewardIndex)
    if self.m_rsBookAward then return end

    local messagId = MessageId.ResponseRewardBookAward
    local handler = Bind(self, self.ResponseRewardBookAwardCallback)
    self.m_rsBookAward = NetPack:RegistResponse(messagId, handler)
    local request = { BookType = 5, RewardIndex = rewardIndex }
    NetPack:SendMessage(MessageId.RequestRewardBookAward, request)
end

--领取图鉴奖励Ack
function M:ResponseRewardBookAwardCallback(messagId, result, msg)
    NetPack:UnRegistResponse(messagId, self.m_rsBookAward)
    self.m_rsBookAward = nil

    if result ~= 0 then return end

    self:_ShowBookReward(msg.Items)
    self:_UpdateRewardState({ msg.RewardIndex })
    IRedPointMgr:ForceCheck(RedPointConst.HeroAltasRedPointChecker)
end

-- 图鉴批量领奖 Req
function M:BooksFastAward(data)
    if self.m_rsFastBooksAward then return end

    local messagId = MessageId.ResponseRewardBooksAward
    local handler = Bind(self, self.OnRsRewardBooksAward)
    self.m_rsFastBooksAward = NetPack:RegistResponse(messagId, handler)

    NetPack:SendMessage(MessageId.RequestRewardBooksAward, data)
end

-- 图鉴批量领奖 Rsp
function M:OnRsRewardBooksAward(messagId, result, msg)
    NetPack:UnRegistResponse(messagId, self.m_rsFastBooksAward)
    self.m_rsFastBooksAward = nil

    if result ~= 0 then return end

    self:_ShowBookReward(msg.Items)
    if msg.BookType == 5 then
        self:_UpdateRewardState(msg.RewardIndex or {})
    end
    IRedPointMgr:ForceCheck(RedPointConst.HeroAltasRedPointChecker)
end

function M:GetBookRwdData(bookType)
    local rwdData = self.m_bookRwdData[bookType]
    if not rwdData then
        rwdData = {}
        local bookRwd = self:GetBookAwdByType(bookType)
        local limitNum = bookRwd and bookRwd.limitNum or {}
        for _, _ in pairs(limitNum) do tInsert(rwdData, false) end
        self.m_bookRwdData[bookType] = rwdData
    end
    return rwdData
end

--英雄奖励数据
function M:GetHeroRwdDatas()
    if not self.m_heroRwdDatas then self:_InitHeroRewardData() end
    return self.m_heroRwdDatas
end

-- 获取百科图鉴解锁数量 只需要总解锁数量可不传参数
function M:GetPlotAtlasUnlockNum(bookType, list)
    local typeList = {}
    if not bookType or bookType <= 0 then
        bookType = 0
        for key, _ in pairs(self:GetBookAwdByType()) do typeList[key] = 0 end
    else
        typeList[bookType] = 0
    end

    for _type, _ in pairs(typeList) do
        local configs = self:GetBookGroupByType(_type)
        for _, value in ipairs(configs or {}) do
            local unlock = GameHelper.CheckLockByOpenConditionId(value.openCondition)
            if unlock then typeList[_type] = typeList[_type] + 1 end
            local tbl = { IsUnlock = unlock, Config = value }
            if list then tInsert(list, tbl) end
        end
    end

    local curUnlockNum = 0
    local preUnlockNum = 0
    for key, newNum in pairs(typeList) do
        local unlockNum = self:GetUnlockAtlasNum(key)
        if newNum > unlockNum then self:ChangeBookState(key, true) end
        preUnlockNum = preUnlockNum + unlockNum
        curUnlockNum = curUnlockNum + newNum
        self.m_bookUnlockNum[key] = newNum
        PlayerPrefTools.SetPlayerPrefs("BookReward" .. key, newNum)
    end

    if bookType == 0 then
        self.m_bookUnlockNum[bookType] = curUnlockNum
        if curUnlockNum > preUnlockNum then
            self:ChangeBookState(0, true)
        end
    end

    return curUnlockNum
end

function M:ChangeBookState(bookType, state)
    if state == false and self.m_atlasResetCallback then
        self.m_atlasResetCallback(bookType)
    end
end

-- 设置图鉴解锁状态重置回调，用于红点
function M:SetBookStateRestCallback(resetCallback)
    self.m_atlasResetCallback = resetCallback
end

-- bookReward
function M:GetBookAwdByType(_type)
    self:_InitAtlasTypes()
    return _type and self.m_bookTypeDic[_type] or self.m_bookTypeDic
end

function M:GetUnlockAtlasNum(bookType)
    local num = self.m_bookUnlockNum[bookType]
    if not num then
        local keyName = "BookReward" .. bookType
        num = PlayerPrefTools.GetPlayerPrefsInt(keyName, 0)
        self.m_bookUnlockNum[bookType] = num
    end
    return num
end

function M:GetBookAwdDic(module)
    local dic = {}
    if not module then module = 1 end
    for t, config in pairs(self:GetBookAwdByType()) do
        if config.module == module then dic[t] = config end
    end
    -- bookReward
    return dic
end

-- 检查图鉴奖励红点
function M:CheckAtlasRedPoint(atlasType, module)
    if not atlasType or atlasType == 0 then
        for _, bookRwd in pairs(self:GetBookAwdDic(module)) do
            if self:CheckOneAtlasRedPoint(bookRwd) then return true end
        end
        return false
    end

    local bookRwd = self:GetBookAwdByType(atlasType)
    return self:CheckOneAtlasRedPoint(bookRwd)
end

function M:CheckOneAtlasRedPoint(bookRwd)
    local atlasType = bookRwd.type
    local record = self:GetBookRwdData(atlasType)
    local unLockNum = self:GetPlotAtlasUnlockNum(atlasType)
    for i, limitNum in ipairs(bookRwd.limitNum) do
        if unLockNum >= limitNum then
            if not record or not record[i] then
                return true
            end
        end
    end
    return false
end

function M:_CheckStoryBookRedPoint(cfg)
    local keyName = "StoryBook" .. tostring(cfg.id)
    local value = PlayerPrefTools.GetPlayerPrefsInt(keyName, 0)
    if value > 0 then return false end
    return JumpMgr:GetInstance():CheckLockByOpenConditionIds(cfg.openCondition)
end

-- 剧情图鉴红点 bookStory表type字段 0：检测所有
function M:CheckStoryBookRedPointByType(mType)
    if mType == 0 then
        for _, typeDic in pairs(self:GetBookStoryTypes() or {}) do
            for _, value in ipairs(typeDic) do
                local curTime = TimeUtil.GetNowTimeStamp()
                if (value.time == 0) or (value.time < curTime) then
                    for _, cfg in ipairs(self:GetBookStorysBySubType(value.subType) or {}) do
                        if self:_CheckStoryBookRedPoint(cfg) then return true end
                    end
                end
            end
        end
    else
        for _, value in pairs(self:GetBookStoryTypes(mType) or {}) do
            local curTime = TimeUtil.GetNowTimeStamp()
            if (value.time == 0) or (value.time < curTime) then
                for _, cfg in ipairs(self:GetBookStorysBySubType(value.subType) or {}) do
                    if self:_CheckStoryBookRedPoint(cfg) then return true end
                end
            end
        end
    end
    return false
end

-- 剧情图鉴子类型红点 bookStory表subType字段 0：不检测
function M:CheckStoryBookRedPointBySubType(mSubType)
    if mSubType == 0 then return false end
    for _, cfg in ipairs(self:GetBookStorysBySubType(mSubType)) do
        if self:_CheckStoryBookRedPoint(cfg) then return true end
    end
    return false
end

-- 剧情图鉴红点 bookStory表id字段
function M:CheckStoryBookRedPointById(id)
    local cfg = ConfigHelper.GetCfgByLua("bookStory", id)
    if cfg then return self:_CheckStoryBookRedPoint(cfg) end

    Logger.LogError("bookStory is 空, id = " .. tostring(id))
    return false
end

-- 注销主线剧情图鉴红点
function M:CheckOffStoryBookRedPoint(subType)
    for _, cfg in ipairs(self:GetBookStorysBySubType(subType) or {}) do
        if JumpMgr:GetInstance():CheckLockByOpenConditionIds(cfg.openCondition) then
            PlayerPrefTools.SetPlayerPrefs("StoryBook" .. tostring(cfg.id), 1)
        end
    end
end

function M:_CheckEncyclopediaRedPoint(cfg)
    local keyName = "Encyclopedia" .. tostring(cfg.id)
    local value = PlayerPrefTools.GetPlayerPrefsInt(keyName, 0)
    if value > 0 then return false end
    return GameHelper.CheckLockByOpenConditionId(cfg.openCondition)
end

-- 百科全书红点 book表type字段 0：检测所有
function M:CheckEncyclopediaRedPointByType(mType)
    local group = self:GetBookGroupByType(mType)
    if mType == 0 then
        for _, values in pairs(group or {}) do
            for _, cfg in ipairs(values) do
                if self:_CheckEncyclopediaRedPoint(cfg) then return true end
            end
        end
    else
        for _, cfg in ipairs(group or {}) do
            if self:_CheckEncyclopediaRedPoint(cfg) then return true end
        end
    end
    return false
end

-- 百科全书红点 book表id字段
function M:CheckEncyclopediaRedPointById(id)
    local cfg = ConfigHelper.GetCfgByLua("book", id)
    if cfg then return self:_CheckEncyclopediaRedPoint(cfg) end

    Logger.LogError("book is 空, id = " .. tostring(id))
    return false
end

-- 注销百科图鉴红点
function M:CheckOffEncyclopediaRedPoint(mType)
    local group = self:GetBookGroupByType(mType)
    for _, cfg in ipairs(group or {}) do
        if GameHelper.CheckLockByOpenConditionId(cfg.openCondition) then
            local keyName = "Encyclopedia" .. tostring(cfg.id)
            PlayerPrefTools.SetPlayerPrefs(keyName, 1)
        end
    end
end

function M:_CheckNewHeroRedPoint(heroData)
    if heroData and heroData:IsHave() then
        local keyName = "HeroBookNewGet" .. tostring(heroData:GetHeroId())
        if PlayerPrefTools.GetPlayerPrefsInt(keyName, 0) == 0 then return true end
    end
    return false
end

-- 英雄图鉴新获得英雄红点
function M:CheckNewHeroRedPointById(heroId)
    if heroId <= 0 then return false end
    return self:_CheckNewHeroRedPoint(IHeroDataMgr:GetMyHeroDataById(heroId))
end

-- 英雄图鉴新获得英雄红点 0：检测所有 faction:阵营
function M:CheckNewHeroRedPointByFaction(faction)
    if faction == 0 then
        local cs_allHeroList = IHeroDataMgr:GetHeros()
        for i = 0, cs_allHeroList.Count - 1 do
            if self:_CheckNewHeroRedPoint(cs_allHeroList[i]) then return true end
        end
    else
        if not self.m_heroFactionDic[faction] then
            local cs_allHeros = IHeroDataMgr:GetAllHeros()
            for i = 0, cs_allHeros.Count - 1 do
                local heroData = cs_allHeros[i]
                if heroData then
                    local f = heroData:GetFaction()
                    if not self.m_heroFactionDic[f] then self.m_heroFactionDic[f] = {} end
                    self.m_heroFactionDic[f][heroData:GetHeroId()] = heroData
                end
            end
            if not self.m_heroFactionDic[faction] then self.m_heroFactionDic[faction] = {} end
        end
        for _, heroData in pairs(self.m_heroFactionDic[faction]) do
            if self:_CheckNewHeroRedPoint(heroData) then return true end
        end
    end
    return false
end

-- 注销英雄图鉴红点
function M:CheckOffNewFactionHeroRedPoint()
    local cs_heros = IHeroDataMgr:GetHeros()
    for i = 0, cs_heros.Count - 1 do
        local v = cs_heros[i]
        if v and v:IsHave() then
            PlayerPrefTools.SetPlayerPrefs("HeroBookNewGet" .. tostring(v:GetHeroId()), 1)
        end
    end
end

-------------------------HeroAtlasData-------------------------------

-- 英雄奖励数据
function M:_InitHeroRewardData()
    self.m_heroRwdDatas = {}
    for _, heroReward in pairs(ConfigHelper.GetCfgs("heroReward")) do
        tInsert(self.m_heroRwdDatas, { heroReward = heroReward })
    end
end

function M._SortHeroBook(data1, data2)
    -- 可领取:1 >> 未领取:0 >> 已领取:2
    local v1, v2 = data1.state, data2.state
    if v1 == v2 then
        return data1.heroReward.order < data2.heroReward.order
    else
        if (v1 + v2) == 1 then
            return v1 > v2
        else
            return v1 < v2
        end
    end
end

function M:InitHeroData()
    self.m_heroList = {}
    local cs_allHeroList = IHeroDataMgr:GetAllHeros()
    for i = 0, cs_allHeroList.Count - 1 do
        local heroData = cs_allHeroList[i]
        local heroId = heroData:GetHeroId()
        local isHas = heroData:IsHave()
        tInsert(self.m_heroList, {
            heroId = heroId,
            order = heroData:GetOrder(),
            rare = heroData:GetRare(),
            faction = heroData:GetFaction(),
            profession = heroData:GetProfession(),
            isCollect = isHas and 1 or 2,
        })
    end
    self:_SortData()
    return self.m_heroList
end

function M:_SortData()
    table.sort(self.m_heroList, function(a, b)
        if a.isCollect == b.isCollect then
            if a.rare == b.rare then
                return a.order < b.order
            else
                return a.rare > b.rare
            end
        else
            return a.isCollect < b.isCollect
        end
    end)
end

---------------------初始化数据End----------------------

---------------------IDataGetter Begin-----------------
--用于在登录的时候初始化相关数据
function M:LoadData()
    self._isloading = true
    self._dataLoaded = false
    self._errorCode = 0
    self:RequestEnterBook()
end

function M:IsLoading()
    return self._isloading
end

function M:IsReady()
    return self._dataLoaded
end

function M:ErrorCode()
    return self._isloading
end

---------------------IDataGetter End-------------------

---------------------网络消息Begin----------------------
function M:RequestEnterBook()
    if self.m_rsEnterBook then return end
    self.m_rsEnterBook = NetPack:RegistResponse(MessageId.ResponseEnterBook, Bind(self, self.OnRsEnterBook))
    local types = {}
    local cfgs = ConfigHelper.GetCfgsByLua("bookReward")
    for _, cfg in pairs(cfgs) do tInsert(types, cfg.type) end
    NetPack:SendMessage(MessageId.RequestEnterBook, { Types = types })
end

---------------------网络消息End----------------------

---------------------设置数据Begin--------------------
function M:_UpdateRewardState(indexList)
    local idxDic = {}
    for i, v in ipairs(indexList) do idxDic[v] = i end
    for _, data in pairs(self:GetHeroRwdDatas()) do
        if idxDic[data.heroReward.id] then data.state = 2 end -- 2:已经领取
    end
    EventMgr:Broadcast(UIMessageNames.HERO_ATLAS_REWARD_STATE_UPDATE)
end

---------------------设置数据End----------------------

---------------------获取数据Begin--------------------

function M:_GetRewardItems(citems)
    local rewards = {}
    for _, citem in ipairs(citems) do
        if rewards[citem.Id] then
            rewards[citem.Id] = rewards[citem.Id] + citem.Cnt
        else
            rewards[citem.Id] = citem.Cnt
        end
    end
    return rewards
end

function M:GetHeros(index)
    if index == 0 then
        return self.m_heroList
    else
        local list = {}
        for _, value in ipairs(self.m_heroList) do
            -- if value.profession == index then
            if value.faction == index then tInsert(list, value) end
        end
        return list
    end
end

-- 英雄图鉴数据
function M:GetRewardData()
    if not self.m_heroRwdDatas then self:_InitHeroRewardData() end
    for _, data in pairs(self.m_heroRwdDatas) do
        if not data.state then data.state = 0 end
        local heroDatas, haveNum = {}, 0
        for _, heroId in pairs(data.heroReward.hero) do
            local have = IHeroDataMgr:HasHero(heroId)
            if have then haveNum = haveNum + 1 end
            tInsert(heroDatas, { heroId = heroId, state = have })
        end
        if (data.state == 0) and (haveNum >= #heroDatas) then
            data.state = 1 -- 1: 可领取
        end
        data.showHeros = heroDatas
        data.haveNum = haveNum
    end
    tSort(self.m_heroRwdDatas, self._SortHeroBook)
    return self.m_heroRwdDatas
end

---------------------获取数据End----------------------
---------------------数据判断Begin--------------------
--是否是待领取奖励(红点)
function M:IsPendingAward(index)
    --协议未请求完毕不刷新红点
    if not self._dataLoaded then return false end
    if index == 0 then
        local redPointState = false
        for _, data in pairs(self:GetHeroRwdDatas()) do
            redPointState = redPointState or self:IsPendingAwardData(data)
            if redPointState then return true end
        end
        return false
    end
    for _, data in pairs(self:GetHeroRwdDatas()) do
        if data.heroReward.id == index then
            return self:IsPendingAwardData(data)
        end
    end
    return false
end

function M:IsPendingAwardData(data)
    if data.state == 1 then
        return true
    elseif not data.state or data.state == 0 then
        local have, heroReward = true, data.heroReward
        for _, heroId in pairs(heroReward.hero) do
            have = have and IHeroDataMgr:HasHero(heroId)
            if not have then break end
        end
        if have then
            data.state = 1
            return true
        end
    end
    return false
end

function M:SetHeroAtlasOnOpen()
    self.onOpen = true
end

function M:GetHeroAtlasOnOpen()
    return self.onOpen
end

function M:SendEnterBookStory(request, callback)
    if self.m_rsEnterBookStory then return end

    self.m_enterStoryCallback = callback
    local messagId = MessageId.ResponseEnterBookStory
    local handler = Bind(self, self.OnResponseEnterBookStory)
    self.m_rsEnterBookStory = NetPack:RegistResponse(messagId, handler)
    NetPack:SendMessage(MessageId.RequestEnterBookStory, request)
end

function M:OnResponseEnterBookStory(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsEnterBookStory)
    self.m_rsEnterBookStory = nil
    if result ~= 0 then return end

    for _, roleBook in ipairs(msg.Books or {}) do
        for k, v in pairs(roleBook.Pages or {}) do
            self.m_unlocIdDic[k] = v == 1 -- 1:已解锁
        end
        for k, v in pairs(roleBook.Dormitory or {}) do
            self.m_dormUnlockDick[k] = v == 1 -- 1:已解锁
        end
    end

    if self.m_enterStoryCallback then
        self.m_enterStoryCallback()
        self.m_enterStoryCallback = nil
    end
end

function M:SendUnlockBookStory(request, callback)
    if self.m_rsUnlockStory then return end

    self.m_unlockStoryCallback = callback
    local messagId = MessageId.ResponseUnlockBookStory
    local handler = Bind(self, self.OnResponseUnlockBookStory)
    self.m_rsUnlockStory = NetPack:RegistResponse(messagId, handler)
    NetPack:SendMessage(MessageId.RequestUnlockBookStory, request)
end

function M:OnResponseUnlockBookStory(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsUnlockStory)
    self.m_rsUnlockStory = nil
    if result ~= 0 then return end

    if msg.SubStoryId > 0 then
        self.m_dormUnlockDick[msg.SubStoryId] = true
    else
        self.m_unlocIdDic[msg.BookStoryId] = true
    end
    if self.m_unlockStoryCallback then
        self.m_unlockStoryCallback()
        self.m_unlockStoryCallback = nil
    end
    GameHelper.TipsById(6292) -- 解锁成功
end

function M:SendRewardBookStoryAward(request, callback)
    -- body
end

function M:OnResponseRewardBookStoryAward(messageId, result, msg)
    -- body
end

-- id: bookStory表id
function M:IsUnlockStoryBook(id)
    return self.m_unlocIdDic[id] or false
end

-- 宿舍剧情 Start -------------------

function M:GetDormStorysByType(nType)
    if not self.m_dormStoryDic then
        self.m_dormStoryDic = {}
        local dormType
        for _, cfg in pairs(ConfigHelper.GetCfgs("bookDormitoryStory") or {}) do
            dormType = cfg.dormitoryType
            if not self.m_dormStoryDic[dormType] then self.m_dormStoryDic[dormType] = {} end
            table.insert(self.m_dormStoryDic[dormType], cfg)
        end
    end
    return self.m_dormStoryDic[nType]
end

-- id: bookDormitoryStory表id
function M:IsUnlockDormBook(id)
    return self.m_dormUnlockDick[id] or false
end

-- 宿舍剧情  End  -------------------

-- 是否初始化英雄图鉴
function M:IsInitHero()
    return self.m_heroRwdDatas ~= nil
end

return M
