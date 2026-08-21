--baoruichang
--2021/12/9 20:10:14

local UIVotingHeroCtrl = BaseClass("UIVotingHeroCtrl", BaseUICtrl)
local M = UIVotingHeroCtrl
local UIVotingHeroPropItemCtrl = require("UI.Ctrl.UIVotingHero.UIVotingHeroPropItemCtrl")
local UIVotingHeroPropItemView = require("UI.View.UIVotingHero.UIVotingHeroPropItemView")
local UIVotingHeroRankItemCtrl = require("UI.Ctrl.UIVotingHero.UIVotingHeroRankItemCtrl")
local UIVotingHeroRankItemView = require("UI.View.UIVotingHero.UIVotingHeroRankItemView")
local VotingTimer = EnumConst.VotingTimer
--VotingHeroUI
function M:Init()
    self.ScrollView1 = self._view.ScrollView1
    self.ScrollView1:Init(UIVotingHeroPropItemCtrl, UIVotingHeroPropItemView)
    
    self.ScrollView2 = self._view.ScrollView2
    self.ScrollView2:Init(UIVotingHeroRankItemCtrl, UIVotingHeroRankItemView)
    
    self._view.btnVote:onClick(self, self.OnClickVote)
    self._view.btnLeft:SetOnClick(self, self.OnClickLeft)
    self._view.btnRight:SetOnClick(self, self.OnClickRight)
    self._view.toggleInformation.onValueChanged:AddListener(Bind(self, self.OnClickInfo))
    self._view.toggleSupport.onValueChanged:AddListener(Bind(self, self.OnClickSupport))
    self.selectType = {
        Info = 1,  --个人资料 (资料)
        Vote = 2 --支持 (排行)
    }
    self.selectIndex = self.selectType.Info

    self._RefSelfRankList = EventMgr:AddListener(UIMessageNames.VOTING_HEROVOTEREF, Bind(self, self.RefSelfRankList))
end

--进入UI，可传参数
function M:OnEnter(heroId, voteState)
    self.heroId = heroId
    --投票按钮状态
    self.voteState = voteState
    self._view.btnLeft.gameObject:SetActive(self:GetContext():GetHeroNum() > 1)
    self._view.btnRight.gameObject:SetActive(self:GetContext():GetHeroNum() > 1)
end

function M:OnShow()
    self._view.btnVote.gameObject:SetActive(self.voteState and true or false)
    self:UpdateHero()
end

function M:UpdateHero()
    if self.selectIndex == self.selectType.Info then
        self:ClickInfo()
    else
        self:ClickVote()
    end
    
    self._view.Role:SetImageWhole(self.heroId, 1)
    self:InitHeroInfo()
end

function M:InitHeroInfo()
    local nowState = VotingDataMgr:GetInstance():GetNowState()
    
    if nowState == VotingTimer.Timer2 or nowState == VotingTimer.Timer4 then
        self._view.tfTips.gameObject:SetActive(false)
        return 
    end
    
    self._view.tfTips.gameObject:SetActive(true)
    local conf = ConfigHelper.GetCfgByLua("activityGirl", VotingDataMgr:GetInstance():GetActivityGirlId())
    local heroIndex = 0
    
    for key, value in pairs(conf.hero) do
        if value == self.heroId then
            heroIndex = key
            break
        end
    end
    
    if heroIndex <= 0 then
        self._view.tfTips.gameObject:SetActive(false)
        return 
    end
    
    if nowState == VotingTimer.Timer1 or nowState == VotingTimer.Timer3 then
        local tipsId = conf.eightTalk[heroIndex]
        
        if tipsId and tipsId > 0 then
            self._view.textTips:SetText(tipsId)
            self._view.anim:Play("text_bg_layout")
        else
            self._view.tfTips.gameObject:SetActive(false)
        end
        return 
    end
    
    if nowState == VotingTimer.Timer5 then
        local tipsId = conf.twoTalk[heroIndex]
        
        if tipsId and tipsId > 0 then
            self._view.textTips:SetText(tipsId)
            self._view.anim:Play("text_bg_layout")
        else
            self._view.tfTips.gameObject:SetActive(false)
        end
        return 
    end
    
    if nowState == VotingTimer.Timer6 then
        self.twoTips = conf.winTalk
        self.twoTipsIndex = 1
        self:TimerCallBack()
        if self._timer then
            self._timer:Stop()
        end
        self._timer = TimerManager:GetInstance():GetTimer(5, Bind(self, self.TimerCallBack))
        self._timer:Start()
    end
end

function M:TimerCallBack()
    self.twoTipsIndex = self.twoTipsIndex + 1
    if self.twoTipsIndex > #self.twoTips then
        self.twoTipsIndex = 1
    end
    local tipsId = self.twoTips[self.twoTipsIndex]
    self._view.anim:Play("text_bg_layout")
    self._view.textTips:SetText(tipsId)
end

function M:UpdateHeroRank()
    self:GetContext():RequestVoteInfo(self.heroId)
    local heroRankData = self:GetContext():GetHeroRankData(self.heroId)

    if not heroRankData then
        self:GetContext():HeroSupportRankReq(self.heroId)
    else
        self:UpdateHeroRankList(heroRankData.Data)
    end
end

function M:UpdateHeroRankList(datas)
    self.ScrollView2:SetDataList(datas)
end

function M:UpdateSelfHeroRankList(data)
    if data.heroId ~= self.heroId then
        return
    end

    self._view.textSelfValue:SetText(tostring(data.cnt))
    self._view.textSelfName:SetText(IPlayerData.NickName)

    if data.rank > 0 then
        self._view.textSelfIndex:SetText(tostring(data.rank))
        self._view.tfNoRank.gameObject:SetActive(false)
    else
        self._view.textSelfIndex:SetText("")
        self._view.tfNoRank.gameObject:SetActive(true)
    end
end

function M:UpdateDataHeroInfo()
    self:InitHeroData()
    self._view.textName:SetAvatarName(self.heroId, RoleType.ERT_Hero)
    self._view.imgProfession:SetProfessional(self.heroId)
end

function M:InitHeroData()
    self.heroData = {}
    local heroConf = ConfigHelper.GetCfgByLua("hero", self.heroId)
    local personTitle = heroConf.personTitle
    local personInformation = heroConf.personInformation

    for i = 0, personTitle.Length - 1 do
        local data = {
            key = personTitle[i],
            value = personInformation[i]
        }
        self.heroData[i] = data
    end
end

function M:OnClickVote()
    local heroData = self:GetContext():GetAHeroData(self.heroId)
    UIContextMgr:GetInstance():Show(UIDefine.UIVotingVote, self.heroId, heroData.Ticket)
end

function M:OnClickLeft()
    self.heroId = self:GetContext():GetHeroId(self.heroId, true)
    self:UpdateHero()
end

function M:OnClickRight()
    self.heroId = self:GetContext():GetHeroId(self.heroId, false)
    self:UpdateHero()
end

function M:OnClickInfo(isOn)
    if not isOn then
        return
    end

    if self.selectIndex == self.selectType.Info then
        return
    end

    self.selectIndex = self.selectType.Info
    self:ClickInfo()
end

function M:OnClickSupport(isOn)
    if not isOn then
        return
    end

    if self.selectIndex == self.selectType.Vote then
        return
    end

    self.selectIndex = self.selectType.Vote
    self:ClickVote()
end

--更新自己对
function M:RefSelfRankList()
    if self.selectIndex ~= self.selectType.Vote then
        return
    end

    self.selectIndex = self.selectType.Vote
    self:ClickVote()
end

function M:ClickInfo()
    self._view.Left1.gameObject:SetActive(true)
    self._view.Left2.gameObject:SetActive(false)
    self:UpdateDataHeroInfo()
    self.ScrollView1:SetDataList(self.heroData)
end

function M:ClickVote()
    self._view.Left1.gameObject:SetActive(false)
    self._view.Left2.gameObject:SetActive(true)
    self:UpdateHeroRank()
end

function M:OnDispose()
    M.super.OnDispose(self)
    EventMgr:RemoveListener(UIMessageNames.VOTING_HEROVOTEREF, self._RefSelfRankList)
    if self._timer then
        self._timer:Stop()
        self._timer = nil
    end
end

return UIVotingHeroCtrl
