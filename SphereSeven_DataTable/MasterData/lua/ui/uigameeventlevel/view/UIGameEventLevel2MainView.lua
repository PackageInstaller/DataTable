--
-- <代码文件解释说明>
--

---@class UIGameEventLevel2MainView : UIBaseView
---@field model UIGameEventLevel2MainModel
---@field ctrl UIGameEventLevel2MainCtrl
local UIGameEventLevel2MainView = BaseClass("UIGameEventLevel2MainView",UIBaseView)
local base = UIBaseView
local this = UIGameEventLevel2MainView

local DEMON_ITEM = tonumber(Z_Misc["DEMON_ITEM"].Value[1])

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))

    self.timeText = LangUtil.BindText(self.langRc:GetObject("TimeText"))
    self.lastTimeText = LangUtil.BindText(self.langRc:GetObject("LastTimeText"))
    self.itemRateText = LangUtil.BindText(self.langRc:GetObject("ItemRateText"))
    self.itemImage =self.langRc:GetObject("ItemImage"):GetComponent("Image")
    self.itemImage1 = self.langRc:GetObject("ItemImage1"):GetComponent("Image")
    self.itemRateText1 = LangUtil.BindText(self.langRc:GetObject("ItemRateText1"))
    self.exOpenTimeText = LangUtil.BindText(self.langRc:GetObject("ExOpenTimeText"))

    LangUtil.BindText(self.shopButton.transform:Find("Mask/Text")).text = LangUtil.GetSysLang(839)
    LangUtil.BindText(self.taskButton.transform:Find("Mask/Text")).text = LangUtil.GetSysLang(839)
    LangUtil.BindText(self.exButton.transform:Find("Mask/Text")).text = LangUtil.GetSysLang(839)
    LangUtil.BindText(self.levelButton.transform:Find("Mask/Text")).text = LangUtil.GetSysLang(839)
    self.changeStageText = LangUtil.BindText(self.langRc:GetObject("ChangeStageText"))
end

function this:OnCreate()
    base.OnCreate(self)

    
    UIPublic.SetBackButton(
        self.rc:GetObject("ReturnButton"), 
        UIWindowNames.UIGameEventLevel2Main,
        547
    ) 

    self.addButton = self.rc:GetObject("AddButton")
    self.addButtonId = nil
    UIUtil.AddBtnEvent(self.addButton, function()
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIGameEventLevelRateUp, {
            eventId = self.model.gameEvent.eventId,
            itemId = self.addButtonId
        })
    end)
    self.addButton1 = self.rc:GetObject("AddButton1")
    self.addButtonId1 = nil
    UIUtil.AddBtnEvent(self.addButton1, function()
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIGameEventLevelRateUp, {
            eventId = self.model.gameEvent.eventId,
            itemId = self.addButtonId1
        })
    end)

    self.shopButton = self.rc:GetObject("ShopButton")
    self.shopMask = self.shopButton.transform:Find("Mask").gameObject
    UIUtil.AddBtnEvent(self.shopButton, function()
        if self.model.shopModule == nil or self.model.shopModule.status ~= GameEventStatus.GameEventStatusInProgress then
            return
        end
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIGameEventLevelStore, {
            eventId = self.model.gameEvent.eventId,
            moduleId = self.model.shopModule.moduleId,
        })
    end)

    self.taskButton = self.rc:GetObject("TaskButton")
    self.taskMask = self.taskButton.transform:Find("Mask").gameObject
    UIUtil.AddBtnEvent(self.taskButton, function()
        if self.model.taskModule == nil or self.model.taskModule.status ~= GameEventStatus.GameEventStatusInProgress then
            return
        end
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIGameEventLevelTask, {
            eventId = self.model.gameEvent.eventId,
            moduleId = self.model.taskModule.moduleId,
        })
    end)

    self.exButton = self.rc:GetObject("ExButton")
    self.exOpenImage = self.rc:GetObject("ExOpenImage")
    self.exMask = self.exButton.transform:Find("Mask").gameObject
    UIUtil.AddBtnEvent(self.exButton, function()
        if self.model.exLevelModule == nil or self.model.exLevelModule.status ~= GameEventStatus.GameEventStatusInProgress then
            return
        end
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIGameEventLevelExLevel, {
            eventId = self.model.gameEvent.eventId,
            moduleId = self.model.exLevelModule.moduleId,
        })
    end)

    self.levelButton = self.rc:GetObject("LevelButton")
    self.levelMask = self.levelButton.transform:Find("Mask").gameObject
    UIUtil.AddBtnEvent(self.levelButton, function()
        if self.model.levelModule == nil or self.model.levelModule.status ~= GameEventStatus.GameEventStatusInProgress then
            return
        end
        UIManager:GetInstance():OpenWindow(UIWindowNames.UILaunchAtk, {
            mode = 2,
            chapterId = self.model.levelModule.config.ShowParams[1],
        })
    end)

    self.stage1Image = self.rc:GetObject("Stage1Image")
    self.stage2Image = self.rc:GetObject("Stage2Image")
    self.changeStageButton = self.rc:GetObject("ChangeStageButton")
    UIUtil.AddBtnEvent(self.changeStageButton, function() 
        if self.model.stageIndex == 1 then
            self:OnChangeStageButton(2)
        else
            self:OnChangeStageButton(1)
        end
    end)

    self.ItemBg1 = self.rc:GetObject("ItemBg1")
end

function this:OnChangeStageButton(index)
    self.model.stageIndex = index
    self.model:OnRefresh()
    self.stage1Image:SetActive(self.model.stageIndex == 1)
    self.stage2Image:SetActive(self.model.stageIndex == 2)
    if self.model.stageIndex == 1 then
        self.changeStageText.text = LangUtil.GetSysLang(1518)
    else
        self.changeStageText.text = LangUtil.GetSysLang(1517)
    end
    self:RefreshAllInfo()
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    self:OnChangeStageButton(self.model.stageIndex)
    if self.model.levelModules[2] ~= nil and self.model.levelModules[2].status == GameEventStatus.GameEventStatusInProgress then
        self.changeStageButton:SetActive(true)
    else
        self.changeStageButton:SetActive(false)
    end
end

function this:RefreshAllInfo()
        -- 时间
        if self.model.levelModule.status == GameEventStatus.GameEventStatusInProgress then
            local lastTimeText = ""
            local time1 = TimeUtil.ConvertTimeForm(self.model.levelModule.endTime - TimeUtil.GetServerTime())
            if time1.day > 0 then
                lastTimeText = lastTimeText .. time1.day .. LangUtil.GetSysLang(2006) -- 天
            end
            if time1.hour > 0 then
                lastTimeText = lastTimeText .. time1.hour .. LangUtil.GetSysLang(2007) -- 小时
            end
            if time1.day == 0 then
                lastTimeText = lastTimeText .. time1.minute .. LangUtil.GetSysLang(1478) -- 分
            end
            self.lastTimeText.text = LangUtil.GetSysLang(1422) .. lastTimeText
    
            local startTIme = TimeUtil.GetServerTimeSplitData(self.model.levelModule.startTime, false)
            local endTime = TimeUtil.GetServerTimeSplitData(self.model.levelModule.endTime, false)
            self.timeText.text = startTIme.month ..LangUtil.GetSysLang(2004) .. startTIme.day .. LangUtil.GetSysLang(1421) .. startTIme.hour .. ":" .. startTIme.min
                                .. "-" .. endTime.month ..LangUtil.GetSysLang(2004) .. endTime.day .. LangUtil.GetSysLang(1421) .. endTime.hour .. ":" .. endTime.min
        else
            self.lastTimeText.text = ""
            self.timeText.text = LangUtil.GetSysLang(839)
        end
    
        self.taskMask:SetActive(self.model.taskModule ~= nil and self.model.taskModule.status == GameEventStatus.GameEventStatusEnded)
        self.shopMask:SetActive(self.model.shopModule ~= nil and self.model.shopModule.status == GameEventStatus.GameEventStatusEnded)
        self.exMask:SetActive(self.model.exLevelModule ~= nil and self.model.exLevelModule.status == GameEventStatus.GameEventStatusEnded)
        self.levelMask:SetActive(self.model.levelModule ~= nil and self.model.levelModule.status == GameEventStatus.GameEventStatusEnded)
    
        local index = 0
        for itemId, value in pairs(self.model.LevelDropBoostList) do
            index = index + 1
            local currentRate = 0
            for _, levelDropBoostModule in ipairs(value) do
                if levelDropBoostModule.isOn then
                    currentRate = currentRate + levelDropBoostModule.rate
                end
            end
            if index == 1 then
                UIUtil.SetSprite(self.itemImage, AtlasConfig.Item, GetItemIcon(Z_Item[itemId]))
                self.itemRateText.text = "+" .. currentRate .. "%"
                self.addButtonId = itemId
            end
            if index == 2 then
                UIUtil.SetSprite(self.itemImage1, AtlasConfig.Item, GetItemIcon(Z_Item[itemId]))
                self.itemRateText1.text = "+" .. currentRate .. "%"
                self.addButtonId1 = itemId
            end
        end
        self.ItemBg1:SetActive(index > 1)
    
        UIPublic.InitButton(self.exButton, self.model.exLevelModule.status == GameEventStatus.GameEventStatusInProgress)
        UIPublic.InitButton(self.levelButton, self.model.levelModule.status == GameEventStatus.GameEventStatusInProgress)
        if self.model.exLevelModule.status == GameEventStatus.GameEventStatusInProgress or self.model.exLevelModule.status == GameEventStatus.GameEventStatusEnded then
            self.exOpenImage:SetActive(false)
        else
            self.exOpenImage:SetActive(true)
            local exOpenTime = TimeUtil.ConvertTimeForm(self.model.exLevelModule.startTime - TimeUtil.GetServerTime())
            local exOpenTimeText = ""
            if exOpenTime.day > 0 then
                exOpenTimeText = exOpenTimeText .. exOpenTime.day .. LangUtil.GetSysLang(2006) -- 天
            end
            if exOpenTime.hour > 0 then
                exOpenTimeText = exOpenTimeText .. exOpenTime.hour .. LangUtil.GetSysLang(2007) -- 小时
            end
            if exOpenTime.day == 0 then
                exOpenTimeText = exOpenTimeText .. exOpenTime.minute .. LangUtil.GetSysLang(1478) -- 分
            end
            self.exOpenTimeText.text = exOpenTimeText .. LangUtil.GetSysLang(1423)
        end
        
        ---@type HintComponent
        local hintComponent = Game.Scene:GetComponent("HintComponent")
        local eventHint = hintComponent.SingleActivity:GetChild(self.model.gameEvent.eventId)
        if eventHint:GetChild(self.model.taskModule.moduleId) ~= nil then
            eventHint:GetChild(self.model.taskModule.moduleId):AddObject(self.taskButton.transform:Find("Hint").gameObject, "entryButton")
        end
end

function this:OnAddListener()
    base.OnAddListener(self)
    -- self:AddUIListener(UIMessageNames.xxx, func)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    -- self:RemoveUIListener(UIMessageNames.xxx)
end


function this:OnDisable()
    base.OnDisable(self)
end

function this:OnDestroy()
    base.OnDestroy(self)
end

return this
