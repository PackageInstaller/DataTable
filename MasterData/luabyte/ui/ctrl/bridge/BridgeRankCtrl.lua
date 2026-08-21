local BridgeRankCtrl = BaseClass("BridgeRankCtrl", BaseUICtrl)
local M = BridgeRankCtrl


function M:Init()

    self._view.rewardTip.gameObject:onClick(Bind(self,self._OnClickTip))
    self._view.tipCloseBtn.gameObject:onClick(Bind(self,self._OnCloseTip))
    self._stars = {}
    for i = 1, 10 do
        self._stars[i] = self._view["Star" .. i]
    end


    self._responseAwardHandler = NetPack:RegistResponse( Proto.MessageId.ResponseBridgeRank, Bind(self, self._ResponseBridgeRank))
    
end

function M:OnDispose()
   NetPack:UnRegistResponse(Proto.MessageId.ResponseBridgeRank, self._ResponseBridgeRank)
   self._responseAwardHandler = nil
   M.super.OnDispose(self)
end

function M:OnEnter(lst,totle,id,myRank,myLevel)
    self._activeId = id
    self._allRank  = lst
    self._totlePage = Mathf.unity_mathf.CeilToInt(totle / 10)
    self._loadPage=-1
    self._view.scrollHelper:ScrollRectInCenterInit(self._totlePage, Bind(self,self._RequestRankData))
    self:_RefreshBridgeInfo()
    self._view.circularScrollView:Init(require("UI.Ctrl.Bridge.OnePageCtrl"), require("UI.View.Bridge.OnePageView"))
    self._view.circularScrollView:SetData(self._totlePage,Bind(self,self._RefreshRankByIdx))
    self:_RefreshMyRank(myRank)
    local rewardCfgs = ConfigHelper.GetCfgsByLua("rankReward", {activityId=id})
    --local rewardCfgs = CS.GameX.Config.ConfigHelper.GetRankRewardsByActiveId(id)
    self:_SetTipInfo(rewardCfgs)
    self:_SetBridgeLv(myLevel)


  
end


function M:_RequestRankData(page)
    if self._loadPage == -1 then--初次进入 不用再请求
        self._loadPage = Mathf.unity_mathf.CeilToInt(#self._allRank / 10)
        return
    end
    local needReq = self._loadPage<self._totlePage and page+1>=self._loadPage
    if needReq then
        local start  = self._loadPage*10
        local request = {}
        request.ActivityId = self._activeId
        request.StartRank = start
        request.RankCount = 10
        NetPack:SendMessage(Proto.MessageId.RequestBridgeRank,request)
    end
end

function M:_OnClickTip()
    self._view.tipPanel:SetActive(true)
end

function M:_OnCloseTip()
    self._view.tipPanel:SetActive(false)
end


function M:_RefreshBridgeInfo()
    self._view.playerName:SetText(IPlayerData.NickName)
    self._view.playerID:SetText(tostring(INetPack.accountId))
end


function M:_RefreshRankByIdx(idx)
    --[[local i=idx-1
    local index = i*10
    local count = 10
    local num = i*10+10
    if num>#self._allRank then
        count = self._allRank%10
    end]]
    return self._allRank
end

function M:_SetRankList(ranks,content,page)
    local item
    local round = page*10
    local len = Mathf.Max(content.childCount,#ranks)
    local ctrl = require("UI.Ctrl.Bridge.BridgeRankItemCtrl")
    content:ClearChildren()
    for i = 0, len-1 do
        if i< #ranks then
            local view = self._view.rankItem:Instantiate()
            item = ctrl.New(view)
            item:_SetInfo(ranks[i],i+round)
            
        end
    end
end

function M:_RefreshMyRank(rank)
    local isOpen = GameHelper.CheckLockByOpenConditionId(5)
    self._view.lockMask:SetActive(not isOpen)
    if isOpen then
        self._view.myLv:SetText(tostring(rank))
        self._view.noRank:SetActive(rank < 0)
    else
        self._view.noRank:SetActive(true)
    end
end

function M:_SetTipInfo(rewardCfgs)
    if rewardCfgs~=nil then
        self._view.tipsContent:ClearChildren()
        local ctrl = require("UI.Ctrl.Bridge.RankTipItemCtrl")
        local item
        for key, value in pairs(rewardCfgs) do
            local view = self._view.rankTipItem:Instantiate()
            item = ctrl.New(view)
            item:_SetRankItemInfo(value)
            view:SetParent(self._view.tipsContent)
        end
        
    end
end

function M:_SetBridgeLv(lv)
    for i = 1, 10 do
        self._stars[i].gameObject:SetActive(i<lv)
    end
end


function M:_ResponseBridgeRank(messageId, result, msg)
    if result == 0 then
        self._loadPage = Mathf.unity_mathf.CeilToInt(msg.StartRank / 10)+1
        for i = 1, #msg.Data do
            self._allRank[#self._allRank+1] = msg.Data[i]
        end
    end
end

return BridgeRankCtrl