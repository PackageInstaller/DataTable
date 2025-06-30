---
---

local UICommonLevelView = BaseClass("UICommonLevelView",UIBaseView)
local base = UIBaseView
local this = UICommonLevelView
local data = {}

local ContentParam = {
    prefabName = "CommonLevelItem",
    func = UIPublic.InitVsFightSoulItemMId,
    childIndex = 1, --- 需要显示在 Thumbnail 下第几个image
}

function this.OnCreate(self)
    base.OnCreate(self)
    self.clientData = ClientData:GetInstance()
    
    self.player = Game.Scene.Player
    self.commonLevelComponent = self.player:GetComponent("CommonLevelComponent")
    self.backBtn = self.rc:GetObject("BackButton")
    self.LeftTimeText = self.rc:GetObject("LeftTimeText")
    self.backGround = self. rc:GetObject("Background"):GetComponent("Image")
    self.expImage = self.rc:GetObject("ExpImage")
    self.goldImage = self.rc:GetObject("GoldImage")

    self.vs_scroll = VerticalScroll.New()
    self.vs_scroll:SetUpdateCount(15)
    self.vs_scrollView = self.rc:GetObject("ScrollView"):GetComponent("ScrollRect")
    self.vs_scroll:Clear()
    self.vs_scroll:ScrollInit(data, 
    self.vs_scrollView, ContentParam.prefabName, function (arg)
        local gameObject = arg.go
        UIPublic.InitCommonLevelItem(self, arg.data, gameObject.transform)
    end)
    UIPublic.SetBackButton(
        self.backBtn,
        UIWindowNames.UICommonLevel,
        nil
    )
end

function this.OnLangCreate(self)
end

function this.OnEnable(self)
    base.OnEnable(self)
    self:OnRefresh()
end

function this.OnRefresh(self)
    if TimeUtil.GetServerTimeSplitData().wday == 1 then
        self.day = 7
    else
        self.day = TimeUtil.GetServerTimeSplitData().wday - 1
    end

    --local data = {}
    data = {}
    local backText 
    if self.model.levelType == LevelType.LevelTypeChallenge then
        if self.model.challengeType == ChallengeType.Dragon then
            for _, value in ipairs(self.commonLevelComponent.CommonLevels[self.model.levelType][self.model.challengeType]) do
                for _, dateValue in ipairs(value.OpenDate) do
                    if dateValue == self.day then
                        table.insert(data,value)
                    end
                end
            end
            backText = 408
            UIPublic.SetHelpButton(self.rc:GetObject("HelpButton"), UIWindowNames.UICommonLevel, 1)
        else
            data = self.commonLevelComponent.CommonLevels[self.model.levelType][self.model.challengeType]
            backText = 429
            UIPublic.SetHelpButton(self.rc:GetObject("HelpButton"), nil)
        end
        
        self.expImage:SetActive(self.model.challengeType == ChallengeType.Exp)
        self.goldImage:SetActive(self.model.challengeType == ChallengeType.Gold)
        coroutine.start(function ()
            self.backGround.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/BackGround/bg_challenge" .. self.model.challengeType .. ".jpg")
         end)
    else
        self.expImage:SetActive(false)
        self.goldImage:SetActive(false)
        data = self.commonLevelComponent.CommonLevels[self.model.levelType]
        coroutine.start(function ()
            self.backGround.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/BackGround/bg_challenge" .. self.model.levelType .. ".jpg")
         end)
        if self.model.levelType == LevelType.LevelTypeTower then
            backText = 413
        elseif self.model.levelType == LevelType.LevelTypeMonthlyTower  then
            backText = 412
        end
        table.sort(data, function (a, b) 
            return a.id < b.id
        end)
        UIPublic.SetHelpButton(self.rc:GetObject("HelpButton"), nil)

    end
    --self.vs_scroll:Clear()
    self.vs_scroll:RefreshData(data)
    -- self.vs_scroll:ScrollInit(data, 
    -- self.vs_scrollView, ContentParam.prefabName, function (arg)
    --     local gameObject = arg.go
    --     --local fightSoul = arg.data
    --     UIPublic.InitCommonLevelItem(self, arg.data, gameObject.transform)
    -- end)
    self.LeftTimeText:SetActive(self.model.levelType == LevelType.LevelTypeMonthlyTower)
    self.LeftTimeText:GetComponent("Text").text = this.secondsToTime(self,TimeUtil.GetMonthLastSeconds())
    
    UIPublic.SetBackButtonText(self.backBtn.transform:Find("TextImage"):GetComponent("Image"), backText)

    if self.model.isOpenDetail then
        local info ={
                levelId = self.model.openId, 
                levelTypeId = self.model.levelType
            }
            UIManager:GetInstance():OpenWindow(UIWindowNames.UIStorySectionInfo, info)
        self.model.isOpenDetail = false
        self.model.openId = nil
    end


    if self.model.levelType == LevelType.LevelTypeMonthlyTower or self.model.levelType == LevelType.LevelTypeTower then
        local passTimes = 0
        for index, value in ipairs(data) do
            if value.passTimes > 0 then
                passTimes = passTimes + 1
            end
        end


        coroutine.start(function ()
            coroutine.waitforframes(10)
            self.vs_scroll:MoveToLastPos((#data - passTimes) / #data)
         end)

        --self.vs_scroll:MoveToLastPos((#data - passTimes) / #data)
    end
end

function this.secondsToTime(self,seconds)
    local days = math.floor(seconds / (24 * 3600))
    local remainingSeconds = seconds % (24 * 3600)
    local hours = math.floor(remainingSeconds / 3600)
    remainingSeconds = remainingSeconds % 3600
    local minutes = math.floor(remainingSeconds / 60)

    if days > 0 then
        local str = string.gsub(LangUtil.GetSysLang(885), "XX", days)--离重置还剩XX天YY小时
        return string.gsub(str, "YY", hours)
    else
        local str = string.gsub(LangUtil.GetSysLang(886), "XX", hours)--离重置还剩XX小时YY分
        return string.gsub(str, "YY", minutes)
    end
end

function this.OnAddListener(self)
    base.OnAddListener(self)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
end

function this.OnViewTop(self)
    base.OnViewTop(self)
    -- UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)
    -- self.comTopView = UIManager:GetInstance():GetWindow(UIWindowNames.UIComTop).View
    -- self.comTopView:InitComTop(self, self:GetName())
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
    --UIManager:GetInstance():CloseWindow(UIWindowNames.UIComTop)
end

function this.OnDisable(self)
    base.OnDisable(self)
end

function this.OnDestroy(self)
    base.OnDestroy(self)
    self.vs_scroll:Dispose()
end


return this


