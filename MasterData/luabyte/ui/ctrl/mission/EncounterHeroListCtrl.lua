local EncounterHeroListCtrl = BaseClass("EncounterHeroListCtrl")
local M = EncounterHeroListCtrl
local MessageId = Proto.MessageId
local EncounterHeroItemView = require("UI.View.Mission.EncounterHeroItemView")
local EncounterHeroItemCtrl = require("UI.Ctrl.Mission.EncounterHeroItemCtrl")
local EncounterFriendHeroItemView = require("UI.View.Mission.EncounterFriendHeroItemView")
local EncounterFriendHeroItemCtrl = require("UI.Ctrl.Mission.EncounterFriendHeroItemCtrl")
local EChapterType = ChapterConst.EChapterType
local tInsert = table.insert
local MAX_UP = 8 -- A\B两队各自上阵上限

function M:__init(view)
    self._view = view
    self._view.friendAndMineState:SetState(1) -- 1为我的，2为助战
    self._view.friendAndMineState:onClick(Bind(self, self._OnClickHeroState))
    -- 刷新助战
    self._view.btnRefFri:onClick(Bind(self, self._OnClickRefFri))
    self._btnRefFriState = UIUtil.FindComponent(self._view.btnRefFri.transform, typeof(CS.UIState), nil)
    self._view.scrollView:Init(EncounterHeroItemCtrl, EncounterHeroItemView)
    self._CreateItemHandler = Bind(self, self._OnCreateItem)
    self._view.scrollView:SetCreateItemCallback(self._CreateItemHandler)
    self._view.friendScrollView:Init(EncounterFriendHeroItemCtrl, EncounterFriendHeroItemView)
    self._view.friendScrollView:SetCreateItemCallback(self._CreateItemHandler)
    self._view.heroTab:Init(0, Bind(self, self._OnClickHeroType))
    self._OnSelectHeroItemHandler = Bind(self, self._OnSelectHeroItem)
end

-- item创建时回调
function M:_OnCreateItem(item)
    item.onClickCallback = self._OnSelectHeroItemHandler
end

-- item点击回调
function M:_OnSelectHeroItem(heroId, isup, friendId)
    if self._isMyHero then
        self._curPland:SetHero(heroId)
        self:_CheckDataList()
        self:UpdateHeroList()
    else
        self._onUpdateListHandler = self._onUpdateListHandler or Bind(self, self._OnUpdateList)
        if self.helpNum > 0 then
            self._curPland:SetFriendHero(friendId, heroId, self._onUpdateListHandler)
        else
            self._curPland:SetFriendHero(nil, nil, self._onUpdateListHandler)
        end
    end
end

-- check当前英雄列表的数据
function M:_CheckDataList()
    -- 获得当前A，B编队的上阵角色
    local plandAId = EnTeamConfMgr:GetInstance():GetPlandAId()
    local plandBId = EnTeamConfMgr:GetInstance():GetPlandBId()
    -- A,B阵型上阵英雄ID
    local upHeroIdsA = {}
    local upHeroIdsB = {}
    local otherHeroIds = {}
    local lockedHeroIds = EnTeamConfMgr:GetInstance():GetLockedHeroIds()
    -- 英雄页签
    if self._isMyHero then
        upHeroIdsA = EnTeamConfMgr:GetInstance():GetHeroIdsByType(plandAId)
        upHeroIdsB = EnTeamConfMgr:GetInstance():GetHeroIdsByType(plandBId)
        local upHeroA = EnTeamConfMgr:GetInstance():GetFriendHeroIdByTeamId(plandAId)
        if upHeroA > 0 then
            tInsert(otherHeroIds, upHeroA)
        end
        local upHeroB = EnTeamConfMgr:GetInstance():GetFriendHeroIdByTeamId(plandBId)
        if upHeroB > 0 then
            tInsert(otherHeroIds, upHeroB)
        end
        -- 助战英雄页签
    else
        local upHeroA = EnTeamConfMgr:GetInstance():GetFriendHeroIdByTeamId(plandAId)
        local upHeroB = EnTeamConfMgr:GetInstance():GetFriendHeroIdByTeamId(plandBId)
        if upHeroA > 0 then
            upHeroIdsA = { upHeroA }
        end
        if upHeroB > 0 then
            upHeroIdsB = { upHeroB }
        end
        otherHeroIds = EnTeamConfMgr:GetInstance():GetHeroIdsByType(plandAId)
        local tmpIds = EnTeamConfMgr:GetInstance():GetHeroIdsByType(plandBId)
        for _, i in ipairs(tmpIds) do
            tInsert(otherHeroIds, i)
        end
    end
    -- 当前页签
    local heroDataList = self._isMyHero and self._myHeroDataList or self._friendHeros
    for _, d in ipairs(heroDataList) do
        local isup = false
        local isSame = false
        local heroIdx = 0
        -- 在当前列表中有的话，就是上阵
        local idxA = table.indexof(upHeroIdsA, d.heroId)
        local idxB = 0
        d.isA = false
        if idxA and idxA > 0 then
            isup = true
            heroIdx = idxA
            d.isA = true
        else
            idxB = table.indexof(upHeroIdsB, d.heroId)
            if idxB and idxB > 0 then
                isup = true
                heroIdx = idxB
                d.isA = false
            end
        end
        d.isLock = false
        -- 未在当前列表中上阵，但是另外一个列表里面上阵了，就是isSame = true
        if not isup then
            if table.indexof(otherHeroIds, d.heroId) then
                isSame = true
            end
        else
            -- 上锁中
            if table.indexof(lockedHeroIds, d.heroId) then
                d.isLock = true
            end
        end
        d.isup = isup
        d.isSame = isSame
        d.heroIdx = heroIdx

    end
end

-- 点击切换我的和助战好友
function M:_OnClickHeroState(go)
    local curState = self._view.friendAndMineState:GetState()
    if curState == 1 then
        curState = 2
        self._isMyHero = false
        if self._friendHeros == nil then
            FriendDataMgr:GetInstance():SendRequestFriendHeroData(Bind(self, self._OnLoadFriendHeroCallBack))
        else
            self:_OnClickHeroType(self._curHeroType)
        end
    else
        curState = 1
        self._isMyHero = true
        self:_OnClickHeroType(self._curHeroType)
    end
    self._view.btnRefFri:SetActive(not self._isMyHero)
    self._view.friendAndMineState:SetState(curState)

end

-- 刷新英雄列表，供EnounterChooseUI调用
function M:UpdateHeroList()
    if self._isMyHero then
        self._view.scrollView:UpdateList()
    else
        self._view.friendScrollView:UpdateList()
    end
end

function M:RefreshHeroList(teamId, friendId)
    self:_OnUpdateList()
    -- local typeStr = teamId == EnTeamConfMgr:GetInstance():GetPlandAId() and "A" or "B"
    -- self:_OnClickSelectPland(typeStr)
    -- if friendId then
    --     self._view.friendScrollView:UpdateList()
    -- else
    --     self._view.scrollView:UpdateList()
    -- end
end

function M:Show(selectTeamIdx)
    self._curHeroType = 0
    self._isMyHero = true

    self:_OnClickHeroType(self._curHeroType)
    if selectTeamIdx == 0 then
        self._plandA:Show()
        self._plandB:NoSelect()
        self._curPland = self._plandA
        self._curPlandType = EnTeamConfMgr:GetInstance():GetPlandAId()
    elseif selectTeamIdx == 1 then
        self._plandA:NoSelect()
        self._plandB:Show()
        self._curPland = self._plandB
        self._curPlandType = EnTeamConfMgr:GetInstance():GetPlandBId()
    else
        self._plandA:NoSelect()
        self._plandB:NoSelect()
    end
    self:_CheckSelect()
    self._view.btnRefFri:SetActive(not self._isMyHero)
    self:_InitHelperNum()
end

--- 设置助战次数
function M:_InitHelperNum()
    -- 配置次数大于这个数的时候不显示
    local system321 = ConfigHelper.GetSystemParam(321)
    self.helpAllNum = ConfigHelper.GetSystemParam(325)
    self.helpNum = self.helpAllNum
    if self.helpAllNum >= system321 then
        -- Logger.LogError("不需要显示助战次数")
        self._view.helpNumState:SetState(1)
    else
        self._view.helpNumState:SetState(2)
        local UITeamConfigContext = UIContextMgr:GetInstance():GetContext("UITeamConfig")
        UITeamConfigContext:GetHelperNum(EChapterType.ECT_Encounter, Bind(self, self.HelperNumCallBack))
        -- Logger.LogError("需要显示助战次数")
    end
end

function M:HelperNumCallBack(num)
    self.helpNum = self.helpAllNum - num
    self._view.labHelpNum:SetText(tostring(self.helpNum))
end

function M:_CheckSelect()
    local teamIdx = -1
    if self._plandA:GetSelect() then
        teamIdx = 0
    elseif self._plandB:GetSelect() then
        teamIdx = 1
    end
    EventMgr:Broadcast(UIMessageNames.ENCOUNTE_CHOOSE_MISSION, teamIdx)
end

function M:Init(plandA, plandB)
    self._heros = {}
    self._curHeroType = 0
    self._isMyHero = true -- true 是我的  false 是好友的
    self._plandA = plandA;
    self._plandB = plandB;
    self._curPlandType = 0
    self._plandA._view.transform:onClick(Bind(self, self._OnClickSelectPland, "A"))
    self._plandB._view.transform:onClick(Bind(self, self._OnClickSelectPland, "B"))
    -- 我的英雄列表
    self._myHeroDataList = {}
    -- 好友助阵列表
    self._friendHeros = nil
    local datas = IHeroDataMgr:GetHeros()
    local myHeroLen = datas.Count
    for i = 0, myHeroLen - 1 do
        local csHeroData = datas[i]
        local d = {}
        local heroCfg = csHeroData:GetHeroCfg()
        d.heroId = csHeroData:GetHeroId()
        d.level = csHeroData:GetLevel()
        d.teamIdx = 0
        d.heroIdx = 0
        d.isup = false
        d.isSame = false
        d.profession = heroCfg.Profession
        d.rare = heroCfg.rare
        tInsert(self._myHeroDataList, d)
    end
end

-- 设置我的英雄列表
function M:_ShowMyHeroListByType()
    local data = nil

    if self._curHeroType == 0 then
        data = self._myHeroDataList
    else
        data = {}
        for _, d in ipairs(self._myHeroDataList) do
            if d.profession == self._curHeroType then
                tInsert(data, d)
            end
        end
    end
    self:_FitData(data)
    self._view.scrollView:SetDataList(data)
    self._view.myHeroList:SetActive(true)
    self._view.friendHeroList:SetActive(false)
end

-- 设置助战英雄列表
function M:_ShowFriendHeroListByType()
    local data = nil
    if self._curHeroType == 0 then
        data = self._friendHeros
    else
        data = {}
        for _, d in ipairs(self._friendHeros) do
            if d.profession == self._curHeroType then
                tInsert(data, d)
            end
        end
    end
    self:_FitData(data)
    self._view.friendScrollView:SetDataList(data)
    self._view.myHeroList:SetActive(false)
    self._view.friendHeroList:SetActive(true)
end

function M:_FitData(herodatas)
    table.sort(herodatas, function(v1, v2)
        if v1 == nil or v2 == nil then
            return false
        end
        if v1 == v2 then
            return false
        end
        if v1.isup and not v2.isup then
            return true
        elseif not v1.isup and v2.isup then
            return false
        else
            if v1.level == v2.level then
                if v1.rare == v2.rare then
                    return false
                end
                return v1.rare > v2.rare
            else
                if v1.level == v2.level then
                    return false
                end
                return v1.level > v2.level
            end
        end
    end)
end

-- 点击非好友详细信息
function M:_OnClickNotFri(friendId)
    self:RequestRecommendFriendInfo(friendId)
end

-- 请求推荐好友信息 Req
function M:RequestRecommendFriendInfo(FriendId)
    self._TempResponseRecommendFriendInfoCallback = NetPack:RegistResponse(MessageId.ResponseRecommendFriendInfo,
        Bind(self, self._ResponseRecommendFriendInfoCallback))
    local request = {}
    request.FriendId = FriendId
    NetPack:SendMessage(MessageId.RequestRecommendFriendInfo, request)
end

-- 请求推荐好友信息Ack
function M:_ResponseRecommendFriendInfoCallback(messagId, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseRecommendFriendInfo, self._TempResponseRecommendFriendInfoCallback)
    self._TempResponseRecommendFriendInfoCallback = nil

    if result ~= 0 then
        Logger.LogError("错误：" .. tostring(result))
        return
    end

    self.playerData = self.playerData or {}
    local data = nil

    if self.playerData[msg.FriendId] then
        data = self.playerData[msg.FriendId]
    else
        data = {}
        self.playerData[msg.FriendId] = data
    end

    data.FriendId = msg.FriendId

    local BaseData = {}
    data.BaseData = BaseData
    BaseData.FriendId = msg.FriendId -- 好友ID
    BaseData.Nickname = msg.Nickname -- 昵称
    BaseData.Avatar = msg.Avatar -- 看板娘、立绘
    BaseData.PlayerIconId = msg.PlayerIconId -- 头像
    BaseData.Level = msg.Level -- 等级
    BaseData.Online = msg.Online -- 在线状态
    BaseData.LogoutTime = msg.LogoutTime -- 离线时间
    local DetailData = {}
    data.DetailData = DetailData
    DetailData.MissionId = msg.MissionId
    DetailData.EliteId = msg.DetailData
    DetailData.HeroList = msg.HeroList
    DetailData.Achievements = msg.Achievements
    DetailData.AchievementsFinishedCount = msg.AchievementsFinishedCount
    UIContextMgr:GetInstance():Show("FriendInfo", data, -1)
end

function M:_OnClickHeroType(index)
    self._curHeroType = index
    self:_CheckDataList()
    if self._isMyHero then
        self:_ShowMyHeroListByType()
        return
    end
    self:_ShowFriendHeroListByType()
end

-- 点击刷新助战好友列表
function M:_OnClickRefFri()
    if self.refFriTimer and self.refFriTimer > 0 then
        return
    end
    FriendDataMgr:GetInstance():SendRequestFriendHeroData(Bind(self, self._OnLoadFriendHeroCallBack))
end

-- 助战好友列表协议返回
function M:_OnLoadFriendHeroCallBack(data)
    self._friendHeros = {}
    for _, f in ipairs(data) do
        local d = {}
        d.heroId = f.HeroId
        d.level = f.Level
        d.teamIdx = 0
        d.heroIdx = 0
        d.isup = false
        local cfg = ConfigHelper.GetCfg("hero", d.heroId)
        d.profession = cfg.Profession
        d.rare = cfg.rare
        d.isFriend = f.IsFriends
        d.nickName = f.Nickname
        d.grade = f.Grade
        d.friendId = f.FriendId
        tInsert(self._friendHeros, d)
    end
    self:_OnClickHeroType(self._curHeroType)
    self.refFriTimer = ConfigHelper.GetSystemParam(308)
    self._view.labRefTimer:SetText(tostring(self.refFriTimer))
    self._btnRefFriState:SetState(2)
    if self.refFriTimer > 0 then
        if self._timer then
            self._timer:Stop()
        end
        self._timer = TimerManager:GetInstance():GetTimer(1, Bind(self, self.TimerCallBack), self)
        self._timer:Start()
    end
end

function M:TimerCallBack()
    self.refFriTimer = self.refFriTimer - 1
    self._view.labRefTimer:SetText(tostring(self.refFriTimer))

    if self.refFriTimer <= 0 and self._timer then
        self._btnRefFriState:SetState(1)
        self._timer:Stop()
        self._timer = nil
    end
end

-- 按等级排序
function M:_OnClickSortByLevel()
    if not self._isMyHero then
        return
    end

    table.sort(self._heros, function(v1, v2)
        return v1:GetLevel() > v2:GetLevel()
    end)

    -- self:_ShowList(self._heros)
end

function M:_OnClickSelectPland(type)
    local plandName = string.format("_pland%s", type)
    local plandType = string.format("GetPland%sId", type)
    local isShowA = type == "A" and "Show" or "NoSelect"
    local isShowB = type == "B" and "Show" or "NoSelect"
    if type == "A" then
        if not self._plandA[isShowA](self._plandA) then
            return
        end
        self._plandB[isShowB](self._plandB)
    else
        if not self._plandB[isShowB](self._plandB) then
            return
        end
        self._plandA[isShowA](self._plandA)
    end

    self._curPland = self[plandName]
    self._curPlandType = EnTeamConfMgr:GetInstance()[plandType](EnTeamConfMgr:GetInstance())

    if not self._isMyHero then
        self._view.friendScrollView:UpdateList()
    end
    self:_CheckSelect()
end

function M:_OnUpdateList()
    self:_CheckDataList()
    self:UpdateHeroList()
end

function M:OnDispose()
    self._friendHeros = nil
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end
    if self._view then
        self._view.heroTab:DisposeAll()
        self._view:OnDispose()
        self._view = nil
    end
end

return EncounterHeroListCtrl
