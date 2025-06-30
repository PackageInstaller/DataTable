--
-- <代码文件解释说明>
--

---@class UIFightSoulInfoView : UIBaseView
---@field model UIFightSoulInfoModel
---@field ctrl UIFightSoulInfoCtrl
---@field tabList {func: UIFightSoulInfoPropSubView, active:UnityEngine.GameObject, panel:UnityEngine.GameObject}[]
local UIFightSoulInfoView = BaseClass("UIFightSoulInfoView",UIBaseView)
local base = UIBaseView
local this = UIFightSoulInfoView

local PropSubView = require "UI.UIFightSoulInfo.UIFightSoulInfoPropSubView"
local MergeSubView = require "UI.UIFightSoulInfo.UIFightSoulInfoMergeSubView"
local LevelUpSubView = require "UI.UIFightSoulInfo.UiFightSoulLevelUpSubView"

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    local keys = {488, 490, 492}
    local leftBtnCtrl = self.langRc:GetObject("LeftBtnCtrl").transform
    for i = 0, leftBtnCtrl.childCount-2 do
        local child = leftBtnCtrl:GetChild(i)
        local image = child:Find("Image"):GetComponent("Image")
        LangUtil.GetSpriteLang(keys[i+1], function(sprite) image.sprite = sprite end)
        local activeImage = child:Find("Active/Image"):GetComponent("Image")
        LangUtil.GetSpriteLang(keys[i+1]+1, function(sprite) activeImage.sprite = sprite end)
    end
    
    for _, value in ipairs(self.tabList) do
        value.func.OnLangCreate(self)
    end
    LangUtil.BindText(self.decomposeButton.transform:Find("Text")).text = LangUtil.GetSysLang(3114)
end

function this:OnChangeTab(index)
    self.currentTab = index
    for i, v in ipairs(self.tabList) do
        v.active:SetActive(i == index)
        v.panel:SetActive(i == index)
    end
    self.tabList[index].func.OnRefresh(self)
end

function this:ChangeFightSoul(offset)
    if self.model.index + offset <= 0 or self.model.index + offset > #self.model.idList then
        return
    end
    self.model.index = self.model.index + offset
    self.model:RefreshFightSoul()
    self.tabList[self.currentTab].func.ClearChoose(self)
    self:OnRefresh()
end

function this:OnCreate()
    base.OnCreate(self)
    self.clientData = ClientData:GetInstance()
    self.isSkip = self.clientData.isSkipFightSoulMerge == 1
    self.fightSoulFace = self.rc:GetObject("UIFightSoulCardInfo")
    UIUtil.AddBtnEvent(self.fightSoulFace.transform:Find("LockRoot").gameObject, function()
        self.ctrl:ChangeLock()
    end)
    
    self.currentTab = 1
    self.tabList = {
        {
            func = PropSubView,
            panel = self.rc:GetObject("PropPanel"),
        },
        {
            func = MergeSubView,
            panel = self.rc:GetObject("MergePanel"),
        },
        {
            func = LevelUpSubView,
            panel = self.rc:GetObject("LevelUpPanel"),
        }
    }

    for _, value in ipairs(self.tabList) do
        value.func.Init(self, value.panel)
    end

    local leftBtnCtrl = self.langRc:GetObject("LeftBtnCtrl").transform
    for i = 0, leftBtnCtrl.childCount-2 do
        local child = leftBtnCtrl:GetChild(i)
        local index = i + 1
        self.tabList[index].active = child:Find("Active").gameObject,
        UIUtil.AddBtnEventNoBug(child.gameObject, function()
            self:OnChangeTab(index)
        end)
    end

    UIPublic.SetBackButton(
        self.rc:GetObject("BackButton"),
        UIWindowNames.UIFightSoulInfo,
        486
    )

    self.lastButton = self.rc:GetObject("LastButton")
    self.nextButton = self.rc:GetObject("NextButton")
    UIUtil.AddBtnEvent(self.lastButton,function()
        self:ChangeFightSoul(-1)
    end)
    UIUtil.AddBtnEvent(self.nextButton,function()
        self:ChangeFightSoul(1)
    end)

    self.decomposeButton = self.rc:GetObject("DecomposeButton")
    UIUtil.AddBtnEvent(self.decomposeButton,function()
        if self.model.fightSoul.Lock then
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(2037)) -- 该战魂已被锁定
            return
        end
    
        ---@type ToolTipGetItemData
        local uiData = {}
        uiData.itemText = LangUtil.GetSysLang(252) -- 分解可获得
        local itemId = tonumber(Z_Misc["FIGHT_SOUL_DECOMPOSE_SHOW_ITEM_ID"].Value[1])
    
        local itemCount = 0
        local rewardId = Z_FightSoulDecompose[self.model.fightSoul.config.Rare].RewardId
        local rewardList = Z_Reward[rewardId]
        local rewards = {}
        for i = 1, self.model.fightSoul.Star do
            for _, v in ipairs(rewardList) do
                if rewards[v.ObjId] == nil then
                    rewards[v.ObjId] = v.Count
                else
                    rewards[v.ObjId] = rewards[v.ObjId] + v.Count
                end
            end    
        end
        uiData.items = {}
        for key, value in pairs(rewards) do
            table.insert(uiData.items,{
                id = key,
                count = value
            })
        end
        uiData.bottomText = LangUtil.GetSysLang(787) -- 确定要进行战魂归魂吗
        uiData.callBack = function()
            PublicRequest.SendRequest(
                PROTOCOL.FightSoulDecomposeReq,
                {
                    uids = {self.model.fightSoul.Id}
                },
                function(msg, error)
                    if error == 0 or error == nil then
                        UIPublic.OpenRewardUI(msg.reward_results)
                        self.ctrl.CloseSelf()
                    end
                end
            )
        end
    
        UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipGetItem, uiData)
    end)
end

function this:OnEnable()
    base.OnEnable(self)

    UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)
    self.comTopView = UIManager:GetInstance():GetWindow(UIWindowNames.UIComTop).View
    self.comTopView:InitComTop(self, self:GetName())

    for key, value in pairs(self.tabList) do
        if value.func.OnEnable ~= nil then
            value.func.OnEnable(self)
        end
    end
    self:OnRefresh()
end

function this:OnRefresh()
    self.lastButton:SetActive(self.model.index > 1)
    self.nextButton:SetActive(self.model.index < #self.model.idList)
    self:OnChangeTab(self.currentTab)
    UIPublic.InitFightSoulFace(self.model.fightSoul, self.fightSoulFace.transform)
end

---@param self UIFightSoulInfoView
local function ON_FIGHTSOUL_DATA_UPDATE(self)
    for key, value in pairs(self.tabList) do
        value.func.OnFightSoulUpdate(self)
    end
    self:OnRefresh()
end

function this.OnViewTop(self)
    -- UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)
    -- self.comTopView = UIManager:GetInstance():GetWindow(UIWindowNames.UIComTop).View
    -- self.comTopView:InitComTop(self, self:GetName())
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddUIListener(UIMessageNames.ON_FIGHTSOUL_DATA_UPDATE, ON_FIGHTSOUL_DATA_UPDATE)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveUIListener(UIMessageNames.ON_FIGHTSOUL_DATA_UPDATE)
end


function this:OnDisable()
    base.OnDisable(self)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIComTop)
end

function this:OnDestroy()
    base.OnDestroy(self)
end

return this
