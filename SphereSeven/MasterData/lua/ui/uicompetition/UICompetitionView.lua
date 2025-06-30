-- 数据刷新完成
--[[
    init 每个item 需要对应type进行特殊处理
    切换类型时的刷新
    排行榜数据的多次获取 怎么处理 临时只获取50个
    第四页 奖励的数据 需要拼一下

    助战编队操作 (挺简单的)
    体力判定 + 请求刷新体力
]]--


local ARENA_POWER_MAX = tonumber(Z_Misc["ARENA_POWER_CONFIG"].Value[2])
local ARENA_POWER_RECOVER_ITEM_ID = tonumber(Z_Misc["ARENA_POWER_RECOVER_ITEM"].Value[1])
local ARENA_POWER_RECOVER_ITEM_COUNT = tonumber(Z_Misc["ARENA_POWER_RECOVER_ITEM"].Value[2])
local DIAMOND_ID = tonumber(Z_Misc["DIAMOND_ID"].Value[1])
local ARENA_CHALLENGER_EXPIRE = tonumber(Z_Misc["ARENA_CHALLENGER_EXPIRE"].Value[1]) -- 刷新角色剩余时间

local ARENA_LEADERBOARD_PAGE = tonumber(Z_Misc["ARENA_LEADERBOARD_PAGE"].Value[1]) -- 排行榜分页大小

local ARENA_AUTO_BATTLE_COST_ID = tonumber(Z_Misc["ARENA_AUTO_BATTLE_COST"].Value[1]) -- 扫荡购买道具
local ARENA_AUTO_BATTLE_COST_COUNT = tonumber(Z_Misc["ARENA_AUTO_BATTLE_COST"].Value[2]) -- 扫荡购买需要道具数量

---@class UICompetitionTypeList
---@field textSysKey number @ 按钮文字多语言id
---@field spriteKey number @ 按钮图片多语言id
---@field prefab string @ item预制体
---@field scrollView UnityEngine.GameObject @ 滚动视图
---@field go UnityEngine.GameObject @ 按钮
---@field text UnityEngine.GameObject @ 按钮文字
---@field active UnityEngine.GameObject @ 按钮选中状态

---@class UICompetitionView : UIBaseView
---@field model UICompetitionModel
---@field ctrl UICompetitionCtrl
---@field typeList table<number, UICompetitionTypeList>
---@field scroll VerticalScroll
local UICompetitionView = BaseClass("UICompetitionView",UIBaseView)
local base = UIBaseView
local this = UICompetitionView

local CompetitionCharacterItem = "CompetitionCharacterItem"
local CompetitionRewardItem = "CompetitionRewardItem"
-- Dangrad

local MILITARY_ORDER_ID = tonumber(Z_Misc["MILITARY_ORDER_ID"].Value[1])

local function removeTimer(self)
    if self.timer ~=nil then
        self.timer:Stop()
        self.timer=nil
    end
end

function this:OnResetTimes(func)
        -- 1296 是否使用XX个YY恢复挑战次数
        if self.model.arenaInfo.power >= ARENA_POWER_MAX then
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(1292))
        else
            local itemCount = UIPublic.GetItemAmount(ARENA_POWER_RECOVER_ITEM_ID)
            local item2Count = UIPublic.GetItemAmount(DIAMOND_ID)
            if itemCount >= ARENA_POWER_RECOVER_ITEM_COUNT then
                ---@type ToolTipFirstData
                local tipData = {}
                local str = string.gsub(LangUtil.GetSysLang(1296), "XX", ARENA_POWER_RECOVER_ITEM_COUNT)
                tipData.message = string.gsub(str, "YY", Z_Item[ARENA_POWER_RECOVER_ITEM_ID].Name)
                tipData.callBack = function()
                    PublicRequest.SendRequest(
                        PROTOCOL.ArenaAddChallengeTimesReq,
                        {},
                        function(response, error)
                            if error == 0 and func ~= nil then
                                func()
                            end
                        end
                    )
                end
                UIUtil.ToolTipFirst(tipData)

            elseif itemCount + item2Count >= ARENA_POWER_RECOVER_ITEM_COUNT then
                ---@type ToolTipFirstData
                local tipData = {}
                local str = string.gsub(LangUtil.GetSysLang(1296), "XX", itemCount)
                str = string.gsub(str, "YY", Z_Item[ARENA_POWER_RECOVER_ITEM_ID].Name)
                tipData.message = str .. "\n" .. string.gsub(LangUtil.GetSysLang(1353), "XX", ARENA_POWER_RECOVER_ITEM_COUNT - itemCount)
                tipData.callBack = function()
                    PublicRequest.SendRequest(
                        PROTOCOL.ArenaAddChallengeTimesReq,
                        {},
                        function(response, error)
                            if error == 0 and func ~= nil then
                                func()
                            end
                        end
                    )
                end
                UIUtil.ToolTipFirstStarLight(tipData)
            else
                ---@type ToolTipFirstData
                local tipData = {}
                tipData.message = LangUtil.GetSysLang(1490)
                tipData.callBack = function()
                    UIManager:GetInstance():OpenWindow(UIWindowNames.UIAllShop, {
                        ShopTitleType = ShopTitleType.Diamond,
                    })
                end
                UIUtil.ToolTipFirst(tipData)
            end
        end
end

function this:OnSweepButton()
    local itemCount = self.model.arenaInfo.power
    local zSeason = Z_ArenaSeasonConfig[self.model.arenaInfo.season]
    local zSeasonDIvision = Z_ArenaSeasonReward[zSeason.Reward][self.model.arenaInfo.division]
    local rewardId = zSeasonDIvision.WinReward
    local zReward = Z_Reward[rewardId][1]

    local rewardCount = zReward.Count * itemCount
    local message = string.gsub(LangUtil.GetSysLang(1482), "XXX", rewardCount) .. "\n"
    local func
    if self.model.arenaInfo.lastAutoBattle > 0 then
        message = message .. string.gsub(LangUtil.GetSysLang(1483), "XXX", self.model.arenaInfo.lastAutoBattle)
        func = function()
            PublicRequest.SendRequest(
                PROTOCOL.ArenaAutoBattleReq,
                {},
                function(response, error)
                    if error == 0 then
                        UIPublic.OpenRewardUI(response.reward_results)
                    end
                end
            )
        end
    else
        local countText = "<color=red>" .. self.model.arenaInfo.lastAutoBattle .. "</color>"
        message = message .. string.gsub(LangUtil.GetSysLang(1483), "XXX", countText)

        local diamonCount = UIPublic.GetItemAmount(DIAMOND_ID)
        local freeDiamondCount = UIPublic.GetItemAmount(ARENA_AUTO_BATTLE_COST_ID)
        
        local text = string.gsub(LangUtil.GetSysLang(1484), "XXX", ARENA_AUTO_BATTLE_COST_COUNT)
        text = string.gsub(text, "YYY", Z_Item[ARENA_AUTO_BATTLE_COST_ID].Name)
        text = string.gsub(text, "ZZZ", freeDiamondCount)
        message = message .. "\n" .. text

        if freeDiamondCount >= ARENA_AUTO_BATTLE_COST_COUNT then
            func = function()
                Logger.Log(1)
                PublicRequest.SendRequest(
                    PROTOCOL.ArenaAutoBattleReq,
                    {},
                    function(response, error)
                        if error == 0 then
                            UIPublic.OpenRewardUI(response.reward_results)
                        end
                    end
                )
            end
        else
            func = function()
                local needDiamonCount = ARENA_AUTO_BATTLE_COST_COUNT - freeDiamondCount
                if needDiamonCount <= diamonCount then
                    ---@type ToolTipFirstData
                    local tipData = {}
                    tipData.message = string.gsub(LangUtil.GetSysLang(1489), "XX", needDiamonCount)
                    tipData.callBack = function()
                        PublicRequest.SendRequest(
                            PROTOCOL.ArenaAutoBattleReq,
                            {},
                            function(response, error)
                                if error == 0 then
                                    UIPublic.OpenRewardUI(response.reward_results)
                                end
                            end
                        )
                    end
                    UIUtil.ToolTipFirstStarLight(tipData)
                else
                    -- 钱不够
                    UIUtil.ToolTipFourth(LangUtil.GetSysLang(1486))
                end
            end
        end
    end
    UIUtil.ToolTipFirstStarLight({
        message = message,
        callBack = function()
            if self.model.arenaInfo.power == 0 then
                self:OnResetTimes(
                    function()
                        self:OnSweepButton()
                    end
                )
            else
                func()
            end
        end
    })
end

function this:OnCreate()
    base.OnCreate(self)
    self.typeIndex = 1
    self.itemDataList = {{},{},{},{}}

    ---@type UnityEngine.Transform
    local typeLayout = self.rc:GetObject("TypeLayout").transform
    self.typeList = {
        {
            --- 挑战
            textSysKey = 1268,
            spriteKey = 463,
            prefab = CompetitionCharacterItem,
            --ArenaChallenger
            showTimesInfo = true,
        },
        {
            --- 战斗记录
            textSysKey = 1269,
            spriteKey = 464,
            prefab = CompetitionCharacterItem,
            --ArenaRole
        },
        {
            --- 排行榜
            textSysKey = 1270,
            spriteKey = 465,
            prefab = CompetitionCharacterItem,
            --ArenaChallenger
        },
        {
            --- 段位奖励
            textSysKey = 1271,
            spriteKey = 466,
            prefab = CompetitionRewardItem,
            --奖励
        },
    }
    self.scrollView1 = self.rc:GetObject("Scroll View1"):GetComponent("ScrollRect")
    self.scrollView2 = self.rc:GetObject("Scroll View2"):GetComponent("ScrollRect")

    for i = 0, typeLayout.childCount - 1 do
        local go = typeLayout:GetChild(i).gameObject
        self.typeList[i + 1].go = go
        self.typeList[i + 1].text = go.transform:Find("Text")
        self.typeList[i + 1].active = go.transform:Find("Active").gameObject
        UIUtil.AddBtnEventNoBug(go, function()
            if self.clickTabTime ~= nil and TimeUtil.GetServerTime() - self.clickTabTime < ClickTimeInterval then
                return
            end
            self.clickTabTime = TimeUtil.GetServerTime()
            self:OnClickType(i + 1)
        end)
    end

    self.scroll = VerticalScroll.New()
    self.scroll:SetUpdateCount(4)

    UIPublic.SetBackButton(
        self.rc:GetObject("ReturnButton"),
        UIWindowNames.UICompetition,
        484
    )

    -- 左侧信息

    UIPublic.SetHelpButton(self.rc:GetObject("HelpButton"), UIWindowNames.UICompetition)

    self.divisionImage = self.rc:GetObject("DivisionImage"):GetComponent("Image")

    UIUtil.AddBtnEventNoBug(self.rc:GetObject("TeamButton"), function()

        local cards = Game.Scene.Player:GetComponent("CardComponent").Cards
        if table.count(cards) == 0 then
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(1294))
            return
        end
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIFormatNew, {
            type = FormationOpenType.Competition
        })
    end)
    
    UIUtil.AddBtnEventNoBug(self.rc:GetObject("ArenaShopButton"), function() 
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIAllShop, {
            ShopTitleType = ShopTitleType.General,
            GeneralShopType = StoreType.Arena,
        })
    end)

    -- 次数/刷新
    self.timesInfo = self.rc:GetObject("TimesInfo")
    UIUtil.AddBtnEventNoBug(self.rc:GetObject("ResetTimesButton"), function()
        self:OnResetTimes()
    end)
    UIUtil.AddBtnEventNoBug(self.rc:GetObject("RefreshChallengerButton"), function() 
        self.ctrl:RefreshArenaChallenger()
        self.refreshArenaChallengerLastTime = TimeUtil.GetServerTime()
    end)

    UIUtil.AddBtnEventNoBug(self.rc:GetObject("SweepButton"), function() 
        self:OnSweepButton()
    end)
    
    self.timer = TimerManager:GetInstance():GetTimer(1, self.timer_action, self)
    self.timer:Start()
    self.timer:Pause()
    -- self.isRefreshTime = false
    -- self.refreshTime1 = 0
    -- self.refreshTime2 = 0

    self:RefreshContent(self.typeIndex)
end


function this:OnLangCreate()
    LangUtil.GetSpriteLang(467, function(sprite) self.langRc:GetObject("TitleImage"):GetComponent("Image").sprite = sprite end)

    for _, value in ipairs(self.typeList) do
        LangUtil.BindText(value.text).text = LangUtil.GetSysLang(value.textSysKey)
        LangUtil.GetSpriteLang(value.spriteKey, function(sprite) value.active.transform:GetComponent("Image").sprite = sprite end)
    end
    LangUtil.BindText(self.langRc:GetObject("SweepText")).text = LangUtil.GetSysLang(1488) -- 速戰
    self.divisionNameText = LangUtil.BindText(self.langRc:GetObject("DivisionNameText"))
    self.seasonText = LangUtil.BindText(self.langRc:GetObject("SeasonText"))
    self.seasonLastTimeText = LangUtil.BindText(self.langRc:GetObject("SeasonLastTimeText"))
    ---@type UnityEngine.Transform
    self.infoLayout = self.langRc:GetObject("InfoLayout").transform
    local infoData = {
        [1] = {
            title = LangUtil.GetSysLang(1251),
        },
        [2] = {
            title = LangUtil.GetSysLang(1252),
        },
        [3] = {
            title = LangUtil.GetSysLang(1253),
        },
        [4] = {
            title = LangUtil.GetSysLang(1254),
        },
        [5] = {
            title = LangUtil.GetSysLang(1255),
            itemId = MILITARY_ORDER_ID
        },
    }
    for i = 0, self.infoLayout.childCount - 1 do
        local index = i + 1
        local child = self.infoLayout:GetChild(i)
        LangUtil.BindText(child).text = infoData[index].title
        local image = child:GetChild(0):Find("Image").gameObject
        if infoData[index].itemId == nil then
            image:SetActive(false)
        else
            image:SetActive(true)
            UIUtil.SetSprite(image:GetComponent("Image"),AtlasConfig.Item,GetItemIcon(Z_Item[infoData[index].itemId]))
        end
    end

    LangUtil.BindText(self.langRc:GetObject("TeamText")).text = LangUtil.GetSysLang(1256)
    LangUtil.BindText(self.langRc:GetObject("ArenaShopText")).text = LangUtil.GetSysLang(1257)

    local titleLayout = self.langRc:GetObject("TitleLayout").transform
    local titleSysKeys = {
        1263, 1264, 1265, 1266, 1272, 1267
    }
    for i = 1, titleLayout.childCount-1 do
        LangUtil.BindText(titleLayout:GetChild(i)).text = LangUtil.GetSysLang(titleSysKeys[i + 1])
    end

    LangUtil.BindText(self.langRc:GetObject("NoteText")).text = LangUtil.GetSysLang(1259)
    self.timesText = LangUtil.BindText(self.langRc:GetObject("TimesText"))
    LangUtil.BindText(self.langRc:GetObject("ResetTimesText")).text = LangUtil.GetSysLang(1261)
    LangUtil.BindText(self.langRc:GetObject("RefreshChallengerText")).text = LangUtil.GetSysLang(1262)
end

function this:OnEnable()
    base.OnEnable(self)
    self.ctrl:RefreshArenaChallenger()
    self.refreshArenaChallengerLastTime = TimeUtil.GetServerTime()
    self:OnRefresh()
end

function this:timer_action()
    if self.model.arenaInfo.power >= ARENA_POWER_MAX then
        -- 进攻次数X/Y
        local timesText = string.gsub(LangUtil.GetSysLang(1273), "X", self.model.arenaInfo.power)
        timesText = string.gsub(timesText, "Y", ARENA_POWER_MAX)
        self.timesText.text = timesText
    else
        -- 进攻次数X/Y, 下次回复还有HH:MM:SS
        local timesText = string.gsub(LangUtil.GetSysLang(1260), "X", self.model.arenaInfo.power)
        timesText = string.gsub(timesText, "Y", ARENA_POWER_MAX)
        local timeData = TimeUtil.ConvertTimeForm(self.model.arenaInfo.last_power_refresh_time + tonumber(Z_Misc["ARENA_POWER_CONFIG"].Value[1]) * 60 - TimeUtil.GetServerTime())
        timesText = string.gsub(timesText, "HH", timeData.hour)
        timesText = string.gsub(timesText, "MM", timeData.minute)
        timesText = string.gsub(timesText, "SS", timeData.second)
        self.timesText.text = timesText
    end

    local zSeason = Z_ArenaSeasonConfig[self.model.arenaInfo.season]
    local timeData = TimeUtil.ConvertTimeForm(TimeUtil.ParseDateTime(zSeason.EndTime) - TimeUtil.GetServerTime())
    if timeData.day > 0 then
        self.seasonLastTimeText.text = LangUtil.GetSysLang(3118) .. ":" .. timeData.day .. LangUtil.GetSysLang(2006) .. timeData.hour .. LangUtil.GetSysLang(2007)
    else
        self.seasonLastTimeText.text = LangUtil.GetSysLang(3118) .. ":" .. timeData.hour .. LangUtil.GetSysLang(2007)
    end
end

function this:Update()
    if self.refreshArenaChallengerLastTime + ARENA_CHALLENGER_EXPIRE * 10 <= TimeUtil.GetServerTime() then
        self.ctrl:RefreshArenaChallenger()
        self.refreshArenaChallengerLastTime = TimeUtil.GetServerTime()
    end
end

---@param go UnityEngine.GameObject
---@param data ArenaChallenger | ArenaRecord
---@param type number @ 当前第几个页签
function this:InitCharacterData(go, data, type)
    ---@type ReferenceCollector
    local rc = go:GetComponent("ReferenceCollector")
    local role
    local battleFormation
    if type == 2 then
        if data.challenger == nil then
            return
        end
        role = data.challenger.role
        battleFormation = data.challenger.battleFormation
    else
        if data.challenger ~= nil then
            return
        end
        role = data.role
        battleFormation = data.battleFormation
    end

    local zSeason = Z_ArenaSeasonConfig[self.model.arenaInfo.season]
    local zSeasonDIvision = Z_ArenaSeasonReward[zSeason.Reward][role.division]

    local bgImage = rc:GetObject("BgImage"):GetComponent("Image")
    if type == 2 or role.rank > 3 then
        bgImage.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Competition/img_list_information_bg.png")
    else
        bgImage.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Competition/img_list_information_no".. role.rank .."_bg.png")
    end

    local avatar = rc:GetObject("Avatar"):GetComponent("Image")
    UIUtil.SetPlayerIcon(avatar,role.portrait)

    LangUtil.BindText(rc:GetObject("LevelText"), FontType.All_Number).text = role.level
    LangUtil.BindText(rc:GetObject("DivisionNameText")).text = LangUtil.GetConfLang(zSeasonDIvision, "Name")
    LangUtil.BindText(rc:GetObject("DivisionNoText")).text = "NO. " .. role.rank
    LangUtil.BindText(rc:GetObject("NameText")).text = role.username
    
    local divisionImage = rc:GetObject("DivisionImage"):GetComponent("Image")
    UIUtil.SetSprite(divisionImage, AtlasConfig.Dangrad, zSeasonDIvision.Icon .. ".png",true)
    
    ---@type UnityEngine.Transform
    local content
    local content1 = rc:GetObject("Content")
    local content2 = rc:GetObject("Content2")
    if type == 1 or type == 2 then
        content = content1.transform
        content1:SetActive(true)
        content2:SetActive(false)
    else
        content = content2.transform
        content1:SetActive(false)
        content2:SetActive(true)
    end
    for i = 0, content.childCount - 1 do
        local cardItem = content:GetChild(i)
        local battleUnit = battleFormation.units[i + 1]
        if battleUnit == nil or battleUnit.cardData == nil then
            cardItem.gameObject:SetActive(false)
        else
            cardItem.gameObject:SetActive(true)
            UIPublic.InitCardItemLittle(
                battleUnit.cardData,
                cardItem
            )
        end
    end

    --- 右侧按钮/战斗结果
    local battleResult = rc:GetObject("BattleResult")
    local BattleButton = rc:GetObject("BattleButton")
    local battleResultImage = rc:GetObject("BattleResultImage"):GetComponent("Image")
    ---@type UnityEngine.UI.Text
    local battleResultText = LangUtil.BindText(rc:GetObject("BattleResultText"))
    if type == 1 then
        battleResult:SetActive(false)
        BattleButton:SetActive(true)
        UIUtil.AddBtnEventNoBug(
            BattleButton,
            function()
                if self.model.arenaInfo.power <= 0 then
                    UIUtil.ToolTipFourth(LangUtil.GetSysLang(1291))
                    return
                end
                UIUtil.OpenFormat({
                    type = FormationOpenType.Battle,
                    ignoreEquipCountLimit = true,
                    isSupport = false,
                    confirmCallBack = function(extraParam)
                        UIPublic.LaunchAtk({
                            LevelType = LevelType.LevelTypeArena,
                            CurLevelId = ArenaLevelId,
                            index = data.index,
                            isAuto = 0,
                        })
                        UIManager:GetInstance():CloseWindow(UIWindowNames.UIFormatNew);
                    end,
                    autoCallBack = function()
                        UIPublic.LaunchAtk({
                            LevelType = LevelType.LevelTypeArena,
                            CurLevelId = ArenaLevelId,
                            index = data.index,
                            isAuto = 1,
                        })
                        UIManager:GetInstance():CloseWindow(UIWindowNames.UIFormatNew);
                    end
                })
            end

            
        )
    elseif type == 2 then
        battleResult:SetActive(true)
        BattleButton:SetActive(false)

        if data.result > 0 then
            if data.attack then
                LangUtil.GetSpriteLang(480, function(sprite) battleResultImage.sprite = sprite end)
            else
                LangUtil.GetSpriteLang(482, function(sprite) battleResultImage.sprite = sprite end)
            end
            battleResultText.text = "+" .. data.result
            battleResultText.color = Color.New(255/255, 144/255, 75/255)
        else
            if data.attack then
                LangUtil.GetSpriteLang(481, function(sprite) battleResultImage.sprite = sprite end)
            else
                LangUtil.GetSpriteLang(483, function(sprite) battleResultImage.sprite = sprite end)
            end
            battleResultText.text = data.result
            battleResultText.color = Color.New(179/255, 179/255, 179/255)
        end

    else
        battleResult:SetActive(false)
        BattleButton:SetActive(false)
    end
end

---@param go UnityEngine.GameObject
---@param data table @ Z_ArenaSeasonReward 表中 当前这一行的数据
function this:InitDivisionRewardData(go, data)
    ---@type ReferenceCollector
    local rc = go:GetComponent("ReferenceCollector")
    
    local divisionImage = rc:GetObject("DivisionImage"):GetComponent("Image")
    if data.Icon == nil then
        return
    end

    UIUtil.SetSprite(divisionImage, AtlasConfig.Dangrad, data.Icon .. ".png",true)
    LangUtil.BindText(rc:GetObject("DivisionNameText")).text = LangUtil.GetConfLang(data, "Name")
    LangUtil.BindText(rc:GetObject("PointText"), FontType.All_Number).text = data.Score
    if data.Rank > 0 then
        LangUtil.BindText(rc:GetObject("RankText"), FontType.All_Number).text = string.gsub(LangUtil.GetSysLang(452), "ExNum", data.Rank)
    else
        LangUtil.BindText(rc:GetObject("RankText"), FontType.All_Number).text = LangUtil.GetSysLang(2009)
    end


    local rewardList = {
        {
            layout = rc:GetObject("SeasonRewardLayout").transform, -- 赛季奖励
            key = "SeasonMail"
        },
        {
            layout = rc:GetObject("WeeklyRewardLayout").transform, -- 每周奖励
            key = "WeekMail"
        },
        {
            layout = rc:GetObject("AchieveRewardLayout").transform, -- 首次到达奖励
            key = "AchieveMail"
        },
    }

    for _, value in ipairs(rewardList) do
        local mailId = data[value.key]
        local zMail = Z_SysMail[mailId]
        local zRewards
        if zMail == nil then
            zRewards = {}
        else
            local rewardId = zMail.Reward
            zRewards = Z_Reward[rewardId]
        end

        for i = 0, value.layout.childCount - 1 do
            local itemPrefab = value.layout:GetChild(i)
            local index = i + 1
            if zRewards[index] == nil then
                itemPrefab.gameObject:SetActive(false)
            else
                itemPrefab.gameObject:SetActive(true)
                local zReward = zRewards[index]
                local reward = UIPublic.GetRewardDataNew(zReward.Type, zReward.ObjId, zReward.Count)
                local rc = itemPrefab:GetComponent("ReferenceCollector")
                local icon = rc:GetObject("Icon"):GetComponent("Image")
                local itemBg = rc:GetObject("ItemBg"):GetComponent("Image")
                LangUtil.BindText(rc:GetObject("Num"), FontType.All_Number).text = reward.count
                UIPublic.InitItemIconNew(icon, itemBg, reward.type, reward.id)
            end
        end
    end
end

function this:RefreshContent(typeIndex)
    self.scroll:Clear()
    local scrollView
    if typeIndex ~= 4 then
        scrollView = self.scrollView1
        self.scrollView1.gameObject:SetActive(true)
        self.scrollView2.gameObject:SetActive(false)
    else
        scrollView = self.scrollView2
        self.scrollView1.gameObject:SetActive(false)
        self.scrollView2.gameObject:SetActive(true)
    end
    self.scroll:ScrollInit(self.itemDataList[typeIndex], scrollView, self.typeList[typeIndex].prefab, function (arg)
        ---@type UnityEngine.GameObject
        local gameObject = arg.go
        if typeIndex ~= 4 then
            ---@type ArenaChallenger | ArenaRecord
            local data = arg.data
            local index = arg.index
            self:InitCharacterData(gameObject, data, typeIndex)
        else
            self:InitDivisionRewardData(gameObject, arg.data)
        end
    end,
    function(data, index)
        if typeIndex ~= 3 then
            return
        end

        if ARENA_LEADERBOARD_PAGE * (self.leaderboardPage - 2) > table.count(self.itemDataList[3]) then
            -- 当前数量太少了, 就没必要继续刷新了
            return
        end

        self.ctrl:RequestLeaderboard(self.leaderboardPage + 1)
    end)
end

--- 刷新左侧竞技场数据
function this:RefreshArenaInfo()
    local zSeason = Z_ArenaSeasonConfig[self.model.arenaInfo.season]
    local zSeasonReward = Z_ArenaSeasonReward[zSeason.Reward]
    local data = zSeasonReward[self.model.arenaInfo.division]
    UIUtil.SetSprite(self.divisionImage, AtlasConfig.Dangrad, data.Icon .. ".png",true)

    self.divisionNameText.text = LangUtil.GetConfLang(data, "Name")
    self.seasonText.text = zSeason.Name

    local infoData = {
        [1] = {
            value = self.model.arenaInfo.rank .. LangUtil.GetSysLang(1286),
        },
        [2] = {
            value = self.model.arenaInfo.battle_season_count .. LangUtil.GetSysLang(1287),
        },
        [3] = {
            value = self.model.arenaInfo.score .. LangUtil.GetSysLang(2065),
        },
        [4] = {
            
        },
        [5] = {
            value = UIPublic.GetItemAmount(MILITARY_ORDER_ID),
        },
    }
    if self.model.arenaInfo.battle_season_count ~= 0 then
        -- 显示一位小数
        infoData[4].value = string.format("%.2f", self.model.arenaInfo.battle_season_win_count / self.model.arenaInfo.battle_season_count * 100) .. "%"
    else
        infoData[4].value = "0%"
    end

    for i = 0, self.infoLayout.childCount - 1 do
        local index = i + 1
        local child = self.infoLayout:GetChild(i)
        local value = child:GetChild(0):Find("Value")
        LangUtil.BindText(value).text = infoData[index].value
    end
end

function this:RefreshContentShow(moveTop)
    self.scroll:RefreshData(self.itemDataList[self.typeIndex])
    if moveTop == nil or moveTop then
        self.scroll:MoveTop()
    end
end

function this:OnClickType(type, force)
    if not force and self.typeIndex == type then
        return
    end

    if type == 3 then
        self.leaderboardPage = 0
        self.itemDataList[3] = self.ctrl:GetLeaderboard(self.leaderboardPage)
        if table.count(self.itemDataList[3]) == 0 then
            self.ctrl:RequestLeaderboard(self.leaderboardPage + 1)
        end
    end
    for key, value in pairs(self.typeList) do
        value.active:SetActive(key == type)
    end
    self.timesInfo:SetActive(type == 1)
    self.typeIndex = type
    self:RefreshContent(self.typeIndex)
end

--刷新所有界面数据显示
function this:OnRefresh()
    self.model:OnRefresh()
    self.itemDataList[1] = self.ctrl:GetArenaChallenger()
    self.itemDataList[2] = self.ctrl:GetArenaRecord()
    self.itemDataList[3] = {}
    self.itemDataList[4] = self.ctrl:GetDivisionReward()

    self:RefreshArenaInfo()
    self:OnClickType(self.typeIndex, true)
end

---@param self UICompetitionView
local function ON_CHALLENGER_UPDATE(self)
    self.itemDataList[1] = self.ctrl:GetArenaChallenger(false)
    if self.typeIndex == 1 then
        self:RefreshContentShow()
    end
end

---@param self UICompetitionView
local function ON_ARENA_UPDATE(self)
    self:RefreshArenaInfo()
end

---@param self UICompetitionView
local function ON_ARENA_RECORD_UPDATE(self)
    self.itemDataList[2] = self.ctrl:GetArenaRecord()
    if self.typeIndex == 2 then
        self:RefreshContentShow()
    end
end

---@param self UICompetitionView
local function ON_LEADERBOARD_UPDATE(self)
    self.leaderboardPage = self.leaderboardPage + 1
    self.itemDataList[3] = self.ctrl:GetLeaderboard(self.leaderboardPage)
    if self.typeIndex == 3 then
        self:RefreshContentShow(false)
    end
end


function this:OnAddListener()
    base.OnAddListener(self)
    
    -- DataManager:GetInstance():AddListener(DataMessageNames.ON_COMPETITION_INFO_CHG, self.InfoChg, self)
    self:AddUIListener(UIMessageNames.ON_CHALLENGER_UPDATE,ON_CHALLENGER_UPDATE)
    self:AddUIListener(UIMessageNames.ON_LEADERBOARD_UPDATE,ON_LEADERBOARD_UPDATE)
    self:AddUIListener(UIMessageNames.ON_ARENA_UPDATE,ON_ARENA_UPDATE)
    self:AddUIListener(UIMessageNames.ON_ARENA_RECORD_UPDATE,ON_ARENA_RECORD_UPDATE)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    -- DataManager:GetInstance():RemoveListener(DataMessageNames.ON_COMPETITION_INFO_CHG, self.InfoChg, self)
    self:RemoveUIListener(UIMessageNames.ON_CHALLENGER_UPDATE)
    self:RemoveUIListener(UIMessageNames.ON_LEADERBOARD_UPDATE)
    self:RemoveUIListener(UIMessageNames.ON_ARENA_UPDATE)
    self:RemoveUIListener(UIMessageNames.ON_ARENA_RECORD_UPDATE)
end

function this:OnViewTop()
    base.OnViewTop(self)
    self.timer:Resume()
end

function this:OnDisViewTop()
    base.OnDisViewTop(self)
end

function this:OnDisable()
     base.OnDisable(self) 
end

function this:OnDestroy()
    base.OnDestroy(self)
    self.scroll:Dispose()
    removeTimer(self)
    -- coroutine.stopwaiting(self.enableCo)
    -- coroutine.stopwaiting(self.refreshCo)
    -- coroutine.stopwaiting(self.refreshMa)
    -- coroutine.stopwaiting(self.updateCo)
    -- coroutine.stopwaiting(self.MAtchingCo)
    -- coroutine.stopwaiting(self.MatchingCo1)
    -- coroutine.stopwaiting(self.showCo)
    -- coroutine.stopwaiting(self.RefreshMatchCo)
end

return this

