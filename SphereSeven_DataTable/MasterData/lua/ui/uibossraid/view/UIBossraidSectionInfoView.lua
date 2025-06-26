--
-- <代码文件解释说明>
--

---@class UIBossraidSectionInfoView : UIBaseView
---@field model UIBossraidSectionInfoModel
---@field ctrl UIBossraidSectionInfoCtrl
local UIBossraidSectionInfoView = BaseClass("UIBossraidSectionInfoView",UIBaseView)
local base = UIBaseView
local this = UIBossraidSectionInfoView
local Diff = {
    {
        syslangKey = 117,--普通
        image = "img_g",
    },
    {
        syslangKey = 118,--困难
        image = "img_b",
    },
    {
        syslangKey = 119,--地狱
        image = "img_z",
    },
    {
        syslangKey = 120,--炼狱
        image = "img_o",
    },
}
local BOSSRAID_TICK = tonumber(Z_Misc["BOSSRAID_TICK"].Value[1])	-- 总力战挑战卷

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    -- LangUtil.GetSpriteLang(999, function(sprite) 
    --     self.langRc:GetObject("XXXImage"):GetComponent("Image").sprite = sprite 
    -- end)
 
    LangUtil.BindText(self.langRc:GetObject("TitleName")).text = self.model.levelConfig.Name

    self.infoText = LangUtil.BindText(self.langRc:GetObject("InfoText"))
    self.name = LangUtil.BindText(self.langRc:GetObject("Name"))
    self.level = LangUtil.BindText(self.langRc:GetObject("Level"))
    self.hpText = LangUtil.BindText(self.langRc:GetObject("HpText"))
    LangUtil.BindText(self.simulate.transform:Find("Text")).text = LangUtil.GetSysLang(1415) --模拟中


    LangUtil.GetSpriteLang(593, function(sprite) 
        self.mopUpButton.transform:Find("Image"):GetComponent("Image").sprite = sprite
    end)

    LangUtil.GetSpriteLang(592, function(sprite) 
        self.simulateButton.transform:Find("Image"):GetComponent("Image").sprite = sprite
    end)

    LangUtil.GetSpriteLang(602, function(sprite) 
        self.battleButton.transform:Find("Image"):GetComponent("Image").sprite = sprite
    end)

    LangUtil.GetSpriteLang(603, function(sprite) 
        self.giveUpButton.transform:Find("Image"):GetComponent("Image").sprite = sprite
    end)

    LangUtil.GetSpriteLang(595, function(sprite) 
        self.retryButton.transform:Find("Image"):GetComponent("Image").sprite = sprite
    end)
end

function this:OnCreate()
    base.OnCreate(self)

    UIUtil.AddBtnEvent(self.rc:GetObject("EventBg"), function()
        self.ctrl.CloseSelf()
    end)

    self.EnemyRoot = self.rc:GetObject("EnemyRoot")
    self.info = self.rc:GetObject("Info")
    self.itemList = {}
    self.rawItem = self.rc:GetObject("RawItem")
    self.rawItem:SetActive(false)

    self.bossInfo = self.rc:GetObject("BossInfo")
    self.difficulty = self.rc:GetObject("Difficulty")
    self.hpScrollbar = self.rc:GetObject("HpScrollbar"):GetComponent("Scrollbar")
    self.simulate = self.rc:GetObject("Simulate")

    self.mopUpButton = self.rc:GetObject("MopUpButton") -- 扫荡
    self.simulateButton = self.rc:GetObject("SimulateButton")
    self.battleButton = self.rc:GetObject("BattleButton")
    self.giveUpButton = self.rc:GetObject("GiveUpButton")
    self.retryButton = self.rc:GetObject("RetryButton")
    
    self.enemyRoot = self.rc:GetObject("EnemyRoot")
    UIUtil.AddBtnEvent(self.mopUpButton, function()
        local tickCount = UIPublic.GetItemAmount(BOSSRAID_TICK)
        if tickCount == 0 then
            local text = string.gsub(LangUtil.GetSysLang(1066), "XXX", Z_Item[BOSSRAID_TICK].Name)
            UIUtil.ToolTipFourth(text)
            return
        end
        if self.model.bossraid.levelStatus == nil or self.model.bossraid.levelStatus[self.model.levelId] == nil or not self.model.bossraid.levelStatus[self.model.levelId].passed then
            return
        end
        if self.completesCount then --没有完成全部条件时 不能扫荡
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(2171))
            return
        end

        local func = function(uid, count)
            local tickCount = UIPublic.GetItemAmount(BOSSRAID_TICK)
            if tickCount < count then
                local text = string.gsub(LangUtil.GetSysLang(1066), "XXX", Z_Item[BOSSRAID_TICK].Name)
                UIUtil.ToolTipFourth(text)
                return
            end
            PublicRequest.SendRequest(
            PROTOCOL.LevelSweepReq,
            {
                level_type = LevelType.LevelTypeBossraid,
                level_id = self.model.levelId,
                times = count,
                level_params = {
                    self.model.bossraidId
                }
            },
            function(info, errorCode)
                if table.any(info.reward_result, function(v) return v.type == RewardType.RewardTypeCharacter end) then
                    local rewardResult = {}
                    for key, value in pairs(info.reward_result) do
                        if value.type == RewardType.RewardTypeCharacter then
                            table.insert(rewardResult, value)
                        end
                        
                    end
                    UIPublic.OpenRewardUI(rewardResult)
                else
                    UIPublic.OpenRewardUI(info.reward_result)
                    local count = 0
                    for index, value in ipairs(info.reward_result) do
                        if value.type == RewardType.RewardTypeExp then
                            count = count + value.count
                        end
                    end
                end
            end
            )
        end

        local data = {
            message = LangUtil.GetSysLang(2154),
            title = LangUtil.GetSysLang(2121),
            maxCount = nil,
            tempId = BOSSRAID_TICK,
            callBack = func,
            isShowCurrentCount = true,
        }
        UIUtil.ToolTipFirstChooseCount(data) 
    end)
    UIUtil.AddBtnEvent(self.simulateButton, function()
        local isSupport = true
        if self.model.bossraid.remainBattle ~= nil then
            isSupport = not self.model.bossraid.remainBattle.isUsedSupport
        end
        UIUtil.OpenFormat({
            type = FormationOpenType.Bossraid,
            ignoreEquipCountLimit = true,
            isSupport = isSupport,
            chooseCardUI = UIWindowNames.UIBossraidChooseCard,
            confirmCallBack = function(extraParam)
                UIPublic.LaunchAtk({
                    LevelType = LevelType.LevelTypeBossraid,
                    CurLevelId = self.model.levelId,
                    bossraidId = self.model.bossraidId,
                    isSimulate = 1,
                },
                extraParam
                )
                UIManager:GetInstance():CloseWindow(UIWindowNames.UIFormatNew);
            end
        })
        self.ctrl.CloseSelf()
    end)

    UIUtil.AddBtnEvent(self.battleButton, function()
        local tickCount = UIPublic.GetItemAmount(BOSSRAID_TICK)
        if tickCount == 0 then
            local text = string.gsub(LangUtil.GetSysLang(1066), "XXX", Z_Item[BOSSRAID_TICK].Name)
            UIUtil.ToolTipFourth(text)
            return
        end
        local isSupport = true
        if self.model.bossraid.remainBattle ~= nil then
            isSupport = not self.model.bossraid.remainBattle.isUsedSupport
        end
        UIUtil.OpenFormat({
            type = FormationOpenType.Bossraid,
            ignoreEquipCountLimit = true,
            isSupport = isSupport,
            chooseCardUI = UIWindowNames.UIBossraidChooseCard,
            confirmCallBack = function(extraParam)
                UIPublic.LaunchAtk({
                    LevelType = LevelType.LevelTypeBossraid,
                    CurLevelId = self.model.levelId,
                    bossraidId = self.model.bossraidId,
                    isSimulate = 0,
                },extraParam
                )
                UIManager:GetInstance():CloseWindow(UIWindowNames.UIFormatNew);
            end
        })
        self.ctrl.CloseSelf()
    end)

    UIUtil.AddBtnEvent(self.retryButton, function()
        local isSupport = true
        if self.model.bossraid.remainBattle ~= nil then
            isSupport = not self.model.bossraid.remainBattle.isUsedSupport
        end
        UIUtil.OpenFormat({
            type = FormationOpenType.Bossraid,
            ignoreEquipCountLimit = true,
            isSupport = isSupport,
            chooseCardUI = UIWindowNames.UIBossraidChooseCard,
            confirmCallBack = function(extraParam)
                local isSimulate = 0
                if self.model.bossraid.remainBattle.isSimulate then
                    isSimulate = 1
                end
                UIPublic.LaunchAtk({
                    LevelType = LevelType.LevelTypeBossraid,
                    CurLevelId = self.model.levelId,
                    bossraidId = self.model.bossraidId,
                    isSimulate = isSimulate,
                },extraParam
                )
                UIManager:GetInstance():CloseWindow(UIWindowNames.UIFormatNew);
            end
        })
        self.ctrl.CloseSelf()
    end)

    UIUtil.AddBtnEvent(self.giveUpButton, function()
        ---@type ToolTipFirstData
        local tipData = {}
        tipData.message = LangUtil.GetSysLang(1513)
        tipData.callBack = function()
            PublicRequest.SendRequest(
                PROTOCOL.BossraidCancelReq,
                {
                    bossraid_id = self.model.bossraid.bossraidId,
                },
                function(response)
                    self.ctrl.CloseSelf()
                end
            )
        end
        UIUtil.ToolTipFirst(tipData)
    end)
end

function this:InitLeft(zStorySection)
    local launchAtkData = {}
    launchAtkData.CurLevelId = zStorySection.Id
    launchAtkData.CurLevelDifficulty = diff
    launchAtkData.LevelType = self.LevelType
    UIBattelModeInfo.NewInitMonsterArea(self.enemyRoot.transform, zStorySection.LevelId )
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    local isOnBattle = self.model.bossraid.remainBattle.levelId ~= nil and self.model.bossraid.remainBattle.levelId ~= 0

    self.info:SetActive(not isOnBattle)
    self.bossInfo:SetActive(isOnBattle)
    
    self.mopUpButton:SetActive(not isOnBattle)
    self.simulateButton:SetActive(not isOnBattle)
    self.battleButton:SetActive(not isOnBattle)
    self.giveUpButton:SetActive(isOnBattle)
    self.retryButton:SetActive(isOnBattle)
    UIPublic.InitButton(self.mopUpButton, self.model.bossraid.levelStatus ~= nil and self.model.bossraid.levelStatus[self.model.levelId] ~= nil and self.model.bossraid.levelStatus[self.model.levelId].passed)

    self.simulate:SetActive(self.model.bossraid.remainBattle.isSimulate)
    self.infoText.text = self.model.bossraid.config.Info

    local zDrop = Z_Drop[self.model.levelConfig.NormalDropId]
    for index, value in ipairs(zDrop) do
        local item = self.itemList[index]
        if item == nil then
            item = GameObject.Instantiate(self.rawItem)
            item.transform:SetParent(self.rawItem.transform.parent, false)
            item:SetActive(true)
            item.transform:SetParent(self.rawItem.transform.parent)
            item.transform.localPosition = Vector3.New(0,0,0)
            item.transform.localScale = Vector3.New(1,1,1)
            self.itemList[index] = item
        end
        item:SetActive(true)

        -- local rc = item.transform:Find("Panel/ItemPrefab"):GetComponent("ReferenceCollector")
        -- local icon = rc:GetObject("Icon"):GetComponent("Image")
        -- local itemBg = rc:GetObject("ItemBg"):GetComponent("Image")
        -- local frame = rc:GetObject("Frame"):GetComponent("Image")
        -- UIPublic.InitItemIconNew(icon, itemBg, value.RewardType, value.RewardId, value.RewardCount, true, false, frame)
        UIPublic.InitRewardItem(
            {
                itemPrefab = item.transform:Find("Panel/ItemPrefab"),
                type = value.RewardType,
                id = value.RewardId,
                count = value.RewardCount,
                isShowThingsDetail = true,
                isShowCount = true,
                -- countText = rc:GetObject("Num"):GetComponent("Text")
            }
        )
        -- rc:GetObject("Num"):GetComponent("Text").text = value.RewardCount
    end

    for i = table.count(zDrop) + 1, #self.itemList do
        self.itemList[i]:SetActive(false)
    end
    local zBattleLevel = Z_BattleLevel[self.model.levelConfig.LevelId]
    local batchs = {
        "Batch1",
        "Batch2",
        "Batch3",
    }
    local zMonsterBoss
    for _, k in ipairs(batchs) do
        local batchId = zBattleLevel[k]
        if Z_MonsterBatch[batchId] ~= nil then
            local zMonsterBatch = Z_MonsterBatch[batchId]
            for i = 1, 6 do
                local key = "Monster" .. i
                if zMonsterBatch[key] ~= nil and zMonsterBatch[key] ~= 0 then
                    local monsterId = zMonsterBatch[key]
                    local zMonster = Z_Monster[monsterId]
                    if zMonster.IsBoss == 1 then
                        zMonsterBoss = zMonster
                        break
                    end
                end
            end
        end
    end
    local size = 1
    local maxHp
    if zMonsterBoss == nil then
        maxHp = 0
    else
        maxHp = zMonsterBoss.Hp
    end
    local currentHp = maxHp
    if zMonsterBoss ~= nil then
        for i, v in pairs(self.model.bossraid.remainBattle.mosters) do
            if v.monsterId == zMonsterBoss.Id then
                size = v.remainHp/maxHp
                currentHp = v.remainHp
                break
            end
        end
        self.level.text = "LV." .. zMonsterBoss.Level
    end
    self.hpScrollbar.size = size
    self.hpText.text = currentHp .. "/" .. maxHp
    self.name.text = self.model.levelConfig.Name

    LangUtil.BindText(self.difficulty.transform:Find("Text")).text = LangUtil.GetSysLang(Diff[self.model.levelConfig.Diff].syslangKey) --对应难度
    coroutine.start(function () 
        self.difficulty:GetComponent("Image").sprite = AtlasManager:GetInstance():CoLoadImageAsync(string.format("UI/Bossraid/%s.png", Diff[self.model.levelConfig.Diff].image))
    end)

    self:InitLeft(self.model.levelConfig)
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
