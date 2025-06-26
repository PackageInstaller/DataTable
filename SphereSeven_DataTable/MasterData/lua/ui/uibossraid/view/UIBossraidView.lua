--
-- <代码文件解释说明>
--

---@class UIBossraidView : UIBaseView
---@field model UIBossraidModel
---@field ctrl UIBossraidCtrl
---@field bossLastTimeTexts {text:UnityEngine.UI.Text, time:number}[] @ 战斗结束时间-text
local UIBossraidView = BaseClass("UIBossraidView",UIBaseView)
local base = UIBaseView
local this = UIBossraidView

local BossraidBossItem = "BossraidBossItem"
local BossraidLeaderItem = "BossraidLeaderItem"
local BossraidRewardItem = "BossraidRewardItem"

local BOSSRAID_ITEM = tonumber(Z_Misc["BOSSRAID_ITEM"].Value[1])	-- 总力战货币
local BOSSRAID_TICK = tonumber(Z_Misc["BOSSRAID_TICK"].Value[1])	-- 总力战挑战卷
local BOSSRAID_TICK_COST_COUNT = tonumber(Z_Misc["BOSSRAID_TICK_COST_COUNT"].Value[1])	-- 总力战挑战卷消耗数量
local BOSSRAID_LEADER_REQUEST_COUNT_LIMIT = tonumber(Z_Misc["BOSSRAID_LEADER_REQUEST_COUNT_LIMIT"].Value[1])	-- 总力战排行榜一次请求数量上限
local BOSSRAID_LEVEL_LAST_TIME_LIMIT = tonumber(Z_Misc["BOSSRAID_LEVEL_LAST_TIME_LIMIT"].Value[1])	-- 总力战战斗时间限制(单位:秒)

local TabType = {
    Fight = 1,
    Rank = 2,
    Reward = 3,
}

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

function this:SetDifficult(root, diff)
    -- image
    LangUtil.BindText(root.transform:Find("Text")).text = LangUtil.GetSysLang(Diff[diff].syslangKey) --对应难度
    coroutine.start(function () 
        root:GetComponent("Image").sprite = AtlasManager:GetInstance():CoLoadImageAsync(string.format("UI/Bossraid/%s.png", Diff[diff].image))
    end)
end


function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    -- LangUtil.GetSpriteLang(999, function(sprite) 
    --     self.langRc:GetObject("XXXImage"):GetComponent("Image").sprite = sprite 
    -- end)
    
    LangUtil.BindText(self.rc:GetObject("ShopButtonText")).text = LangUtil.GetSysLang(1409) --兌換商店

    self.rankText = LangUtil.BindText(self.rc:GetObject("RankText"))
    self.scoreText = LangUtil.BindText(self.rc:GetObject("ScoreText"))

    self.scoreRewardText = LangUtil.BindText(self.rc:GetObject("ScoreRewardText"))
    LangUtil.BindText(self.rc:GetObject("RankRewardText")).text = LangUtil.GetSysLang(1411) --排行奖励
    self.lastTimeText = LangUtil.BindText(self.rc:GetObject("LastTimeText"))
end

function this:OnTabClick(index)
    for i, v in ipairs(self.tabList) do
        v.active:SetActive(i == index)
    end

    self.currentTab = index
    self.bossScrollView:SetActive(index == TabType.Fight)
    self.leaderScrollView:SetActive(index == TabType.Rank)
    self.scoreRewardScrollView:SetActive(index == TabType.Reward)
    self.rankRewardScrollView:SetActive(index == TabType.Reward)

    self.rankButton:SetActive(false) --(index == TabType.Rank)

    if index == TabType.Rank then
        self.model.bossraid:ClearLeader()
        self.ctrl:RequestLeaderboard(1, BOSSRAID_LEADER_REQUEST_COUNT_LIMIT, 1)
        self.leaderScroll:MoveTop()
    end
end

function this:InitBossItem(arg)
    local diffBgImageKey = {
        599, -- 普通
        598, -- 困难
        597, -- 地狱
        600, -- 真皇
    }
    -- Z_BossraidLevel
    local data = arg.data
    local object = arg.go
    local index = arg.index

    ---@type ReferenceCollector
    local rc = object:GetComponent("ReferenceCollector")
    local rawItem = rc:GetObject("ItemPrefab").gameObject
    rawItem:SetActive(false)
    local battle = rc:GetObject("Battle")
    local retry = rc:GetObject("Retry")
    battle:SetActive(self.model.bossraid.remainBattle.levelId~= data.Id)
    retry:SetActive(self.model.bossraid.remainBattle.levelId == data.Id)
    LangUtil.BindText(rc:GetObject("Name")).text = data.Name
    LangUtil.BindText(rc:GetObject("Name2")).text = data.Name

    -- coroutine.start(function () 
    --     coroutine.waitforframes(5)
    --     LangUtil.GetSpriteLang(diffBgImageKey[data.Diff], function(sprite) 
    --         battle:GetComponent("Image").sprite = sprite 
    --     end)
    --     retry:GetComponent("Image").sprite = AtlasManager:GetInstance():CoLoadImageAsync(string.format("UI/Bossraid/%s.png", data.BgImage))
    -- end)

    local itemContent = rc:GetObject("ItemContent").transform
    local zDrop = Z_Drop[data.NormalDropId]
    for index, value in ipairs(zDrop) do
        local item
        if index > itemContent.childCount then
            item = GameObject.Instantiate(rawItem, itemContent)
        else
            item = itemContent:GetChild(index - 1).gameObject
        end
        item:SetActive(true)
        -- local itemRc = item:GetComponent("ReferenceCollector")
        -- local icon = itemRc:GetObject("Icon"):GetComponent("Image")
        -- local itemBg = itemRc:GetObject("ItemBg"):GetComponent("Image")
        -- local frame = itemRc:GetObject("Frame"):GetComponent("Image")
        -- UIPublic.InitItemIconNew(icon, itemBg, value.RewardType, value.RewardId, value.RewardCount, true, false, frame)
        -- itemRc:GetObject("Num"):GetComponent("Text").text = value.Count
        UIPublic.InitRewardItem(
            {
                itemPrefab = item,
                type = value.RewardType,
                id = value.RewardId,
                count = value.RewardCount,
                isShowThingsDetail = true,
                isShowCount = true,
                -- countText = rc:GetObject("Num"):GetComponent("Text")
            }
        )
    end
    for i = table.count(zDrop) + 1, itemContent.childCount do
        itemContent:GetChild(i - 1).gameObject:SetActive(false)
    end

    local battleButton = rc:GetObject("BattleButton")
    UIUtil.AddBtnEvent(battleButton, function()
        if self.model ~=nil and self.model.bossraid ~= nil then
            self.model.bossraid.oldScore = self.model.bossraid.totalScore
        end
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIBossraidSectionInfo, {
            levelId = data.Id,
            bossraidId = self.model.bossraid.bossraidId,
        })
    end)
    UIUtil.SetSprite(battleButton.transform:Find("Image"):GetComponent("Image"), AtlasConfig.Item, GetItemIcon(Z_Item[BOSSRAID_TICK]))
    LangUtil.BindText(battleButton.transform:Find("Text")).text = BOSSRAID_TICK_COST_COUNT

    local mask = rc:GetObject("Mask")
    mask:SetActive(self.model.bossraid.remainBattle.levelId ~= 0 and self.model.bossraid.remainBattle.levelId ~= nil and self.model.bossraid.remainBattle.levelId ~= data.Id) -- 其他的关卡战斗中, 这里显示遮罩
    LangUtil.BindText(rc:GetObject("MaskText")).text = LangUtil.GetSysLang(1414) --战斗中

    self:SetDifficult(rc:GetObject("Difficulty"), data.Diff)

    table.insert(self.bossLastTimeTexts,
        {
            text = LangUtil.BindText(rc:GetObject("LastTimeText")),
        }
    )

    local simulate = rc:GetObject("Simulate")
    simulate:SetActive(self.model.bossraid.remainBattle.isSimulate)
    LangUtil.BindText(simulate.transform:Find("Text")).text = LangUtil.GetSysLang(1415) --模拟中

    local retryButton = rc:GetObject("RetryButton")
    UIUtil.AddBtnEvent(retryButton, function()
        if self.model ~=nil and self.model.bossraid ~= nil then
            self.model.bossraid.oldScore = self.model.bossraid.totalScore
        end
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIBossraidSectionInfo, {
            levelId = data.Id,
            bossraidId = self.model.bossraid.bossraidId,
        })
    end)
    LangUtil.BindText(retryButton.transform:Find("Text")).text = LangUtil.GetSysLang(1416) --重试

    -- boss血条
    if self.model.bossraid.remainBattle.levelId == data.Id then
        local hpScrollbar = rc:GetObject("HpScrollbar"):GetComponent("Scrollbar")
        local zBattleLevel = Z_BattleLevel[data.LevelId]
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
        end
        hpScrollbar.size = size
        LangUtil.BindText(rc:GetObject("HpText")).text = currentHp .. "/" .. zMonsterBoss.Hp
    end
end

function this:InitLeaderItem(arg)
    ---@type BossraidLeaderboardRecord
    local data = arg.data
    local object = arg.go
    local index = arg.index

    ---@type ReferenceCollector
    local rc = object:GetComponent("ReferenceCollector")
	-- uint64 role_id = 1;
	-- string username = 2;
	-- uint32 level = 3;
	-- uint32 portrait = 4;
	-- uint32 rank = 5;
    local AvatarValue = rc:GetObject("Avatar"):GetComponent("Image")
    if data.portrait ~= nil and  Z_HeadPortrait[data.portrait] ~= nil then
        local avatarStr = Z_HeadPortrait[data.portrait].Resourse
        UIUtil.SetPlayerIcon(AvatarValue,avatarStr)
    end
    LangUtil.BindText(rc:GetObject("LevelText")).text = data.level
    LangUtil.BindText(rc:GetObject("NoText")).text = "NO." .. data.rank
    LangUtil.BindText(rc:GetObject("NameText")).text = data.username
    LangUtil.BindText(rc:GetObject("Text")).text = LangUtil.GetSysLang(1493) .. data.record.score
    LangUtil.BindText(rc:GetObject("TeamText")).text = LangUtil.GetSysLang(1494)
    UIUtil.AddBtnEventNoBug(rc:GetObject("TeamButton"), function()
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIBossraidTeamInfo, {data = data})
    end)
    if data.record.levelConfig == nil then
        Logger.LogError("leader record levelConfig is nil, role_id:" .. data.role_id)
        self:SetDifficult(rc:GetObject("Difficulty"), 1)
    else
        self:SetDifficult(rc:GetObject("Difficulty"), data.record.levelConfig.Diff)
    end
    local formation = data.record.formations[1]
    if formation == nil then
        formation = {
            units = {},
        }
    end
    
    ---@type UnityEngine.Transform
    local content = rc:GetObject("Content").transform
    for i = 0, content.childCount-1 do
        local index = i + 1
        ---@type BattleUnit
        ---@param v BattleUnit
        local unit = table.first(formation.trueUnits, function(v) return v.formationPostion == index end)
        local child = content:GetChild(i)
        local cardItem = child:GetChild(0)
        if unit == nil or unit.cardData == nil then
            cardItem.gameObject:SetActive(false)
        else
            cardItem.gameObject:SetActive(true)
            UIPublic.InitCardItemLittle(unit.cardData, cardItem.gameObject)
        end
    end
end

function this:InitScoreRewardItem(arg)
    local data = arg.data
    local object = arg.go
    local index = arg.index

    ---@type ReferenceCollector
    local rc = object:GetComponent("ReferenceCollector")
    LangUtil.BindText(rc:GetObject("Text")).text = LangUtil.GetSysLang(1417)
    LangUtil.BindText(rc:GetObject("ScoreText")).text = data.Score

    local more = rc:GetObject("More")
    local rewardLayout = rc:GetObject("RewardLayout").transform
    local zMail = Z_SysMail[data.Mail]
    local zReward = Z_Reward[zMail.Reward]
    for i = 0, rewardLayout.childCount-1 do
        rewardLayout:GetChild(i).gameObject:SetActive(false)
    end

    local maxCount
    if table.count(zReward) > rewardLayout.childCount - 1 then
        more:SetActive(true)
        UIUtil.AddBtnEvent(more, function()
            UIManager:GetInstance():OpenWindow(UIWindowNames.UIMoreItem, {
                rewards = zReward,
            })
        end)
        maxCount = rewardLayout.childCount - 2
    else
        more:SetActive(false)
        maxCount = table.count(zReward)
    end

    local isGet = false
    if self.model.bossraid.receivedReward ~= nil and table.contains(self.model.bossraid.receivedReward, data.Score) then
        isGet = true
    end
    rc:GetObject("Mask"):SetActive(isGet)
    for i = 1, maxCount do
        local value = zReward[i]
        local item = rewardLayout:GetChild(i).gameObject
        item:SetActive(true)
        -- local itemRc = item:GetComponent("ReferenceCollector")
        -- local icon = itemRc:GetObject("Icon"):GetComponent("Image")
        -- local itemBg = itemRc:GetObject("ItemBg"):GetComponent("Image")
        -- local frame = itemRc:GetObject("Frame"):GetComponent("Image")
        -- UIPublic.InitItemIconNew(icon, itemBg, value.Type, value.ObjId, value.Count, true, false, frame)
        -- itemRc:GetObject("Num"):GetComponent("Text").text = value.Count
        UIPublic.InitRewardItem(
            {
                itemPrefab = item,
                type = value.Type,
                id = value.ObjId,
                count = value.Count,
                isShowThingsDetail = true,
                isShowCount = true,
                -- countText = rc:GetObject("Num"):GetComponent("Text")
            }
        )
        item.transform:Find("IsGet").gameObject:SetActive(isGet)
    end

end

function this:InitRankRewardItem(arg)
    local data = arg.data
    local object = arg.go
    local index = arg.index

    ---@type ReferenceCollector
    local rc = object:GetComponent("ReferenceCollector")
    LangUtil.BindText(rc:GetObject("Text")).text = LangUtil.GetSysLang(1418)
    LangUtil.BindText(rc:GetObject("ScoreText")).text = data.RankShowText
    rc:GetObject("Mask"):SetActive(false)
    local more = rc:GetObject("More")
    local rewardLayout = rc:GetObject("RewardLayout").transform
    local zMail = Z_SysMail[data.Mail]
    local zReward = Z_Reward[zMail.Reward]
    for i = 0, rewardLayout.childCount-1 do
        rewardLayout:GetChild(i).gameObject:SetActive(false)
    end

    local maxCount
    if table.count(zReward) > rewardLayout.childCount - 1 then
        more:SetActive(true)
        UIUtil.AddBtnEvent(more, function()
            UIManager:GetInstance():OpenWindow(UIWindowNames.UIMoreItem, {
                rewards = zReward,
            })
        end)
        maxCount = rewardLayout.childCount - 2
    else
        more:SetActive(false)
        maxCount = table.count(zReward)
    end

    for i = 1, maxCount do
        local value = zReward[i]
        local item = rewardLayout:GetChild(i).gameObject
        item:SetActive(true)
        -- local itemRc = item:GetComponent("ReferenceCollector")
        -- local icon = itemRc:GetObject("Icon"):GetComponent("Image")
        -- local itemBg = itemRc:GetObject("ItemBg"):GetComponent("Image")
        -- local frame = itemRc:GetObject("Frame"):GetComponent("Image")
        -- UIPublic.InitItemIconNew(icon, itemBg, value.Type, value.ObjId, value.Count, true, false, frame)
        -- itemRc:GetObject("Num"):GetComponent("Text").text = value.Count
        UIPublic.InitRewardItem(
            {
                itemPrefab = item,
                type = value.Type,
                id = value.ObjId,
                count = value.Count,
                isShowThingsDetail = true,
                isShowCount = true,
                -- countText = rc:GetObject("Num"):GetComponent("Text")
            }
        )
        item.transform:Find("IsGet").gameObject:SetActive(false)
    end
end

function this:OnCreate()
    base.OnCreate(self)

    local returnButton = self.rc:GetObject("ReturnButton")
    UIPublic.SetBackButton(
        returnButton,
        UIWindowNames.UIBossraid,
        594
    )
    UIPublic.SetHelpButton(self.rc:GetObject("HelpButton"), UIWindowNames.UIBossraid)

    local shopButton = self.rc:GetObject("ShopButton")
    UIUtil.AddBtnEventNoBug(shopButton, function() 
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIAllShop, {
            ShopTitleType = ShopTitleType.General,
            GeneralShopType = StoreType.Bossraid,
        })
    end)

    local syslangKeys = {
        1258, -- 战斗
        1270, -- 排行榜
        1271, -- 奖励
    }
    self.tabList = {}
    self.currentTab = TabType.Fight
    local tabLayout = self.rc:GetObject("TabLayout").transform
    for i, value in ipairs(syslangKeys) do
        local child = tabLayout:GetChild(i - 1)
        local index = i
        LangUtil.BindText(child:Find("Text")).text = LangUtil.GetSysLang(syslangKeys[index])
        LangUtil.BindText(child:Find("Active/Text")).text = LangUtil.GetSysLang(syslangKeys[index])
        self.tabList[index] = {
            active = child:Find("Active").gameObject,
        }
        UIUtil.AddBtnEvent(child.gameObject, function()
            self:OnTabClick(index)
        end)
    end

    self.difficulty = self.rc:GetObject("Difficulty")
    self.rankButton = self.rc:GetObject("RankButton")
    UIUtil.AddBtnEvent(self.rankButton, function()
        self.model.bossraid:ClearLeader()
        self.ctrl:RequestLeaderboard(self.model.bossraid.rank - BOSSRAID_LEADER_REQUEST_COUNT_LIMIT//2, self.model.bossraid.rank + BOSSRAID_LEADER_REQUEST_COUNT_LIMIT//2 - 1, self.model.bossraid.rank)
    end)

    self.bossLastTimeTexts = {}
    self.bossScrollView = self.rc:GetObject("BossScrollView")
    self.bossContent = self.rc:GetObject("BossContent").transform
    -- self.bossScroll = VerticalScroll.New()
    -- self.bossScroll:Clear()
    -- self.bossScroll:ScrollInit({}, self.bossScrollView, BossraidBossItem, function (arg)
    --     if self.model == nil then
    --         return
    --     end
    --     self:InitBossItem(arg)
    -- end) 

    self.leaderScrollView = self.rc:GetObject("LeaderScrollView")
    self.leaderContent = self.rc:GetObject("LeaderContent").transform:GetComponent("VerticalLayoutGroup")
    self.bossraidLeaderItem = self.rc:GetObject("BossraidLeaderItem")
    self.bossraidLeaderItem:SetActive(false)
    self.leaderScroll = VerticalScroll.New()
    self.leaderScroll:Clear()
    self.leaderScroll:ScrollInit({}, self.leaderScrollView, BossraidLeaderItem, function (arg)
        if self.model == nil then
            return
        end
        self:InitLeaderItem(arg)
    end, function()
        if not self.canRequestLeader then
            return
        end
        if table.count(self.model.bossraid.leaderboard) < BOSSRAID_LEADER_REQUEST_COUNT_LIMIT then
            return
        end
        -- Logger.LogError("拖到下面")
        self.canRequestLeader = false
        self.ctrl:RequestLeaderboard(self.model.bossraid.maxLeaderRank + 1, self.model.bossraid.maxLeaderRank + BOSSRAID_LEADER_REQUEST_COUNT_LIMIT)
    end,function()
        if self.model.bossraid.minLeaderRank == 1 then
            return
        end
        if not self.canRequestLeader then
            return
        end
        -- Logger.LogError("拖到上面")
        local currentCount = self.model.bossraid.maxLeaderRank - self.model.bossraid.minLeaderRank + 1 -- 用来记录下面有多少个(移动y轴)
        local min = self.model.bossraid.minLeaderRank - BOSSRAID_LEADER_REQUEST_COUNT_LIMIT
        if min <= 1 then
            min = 1
        end
        self.canRequestLeader = false
        self.ctrl:RequestLeaderboard(min, self.model.bossraid.minLeaderRank - 1, self.model.bossraid.minLeaderRank)
    end) 

    self.scoreRewardScrollView = self.rc:GetObject("ScoreRewardScrollView")
    self.scoreRewardScroll = VerticalScroll.New()
    self.scoreRewardScroll:Clear()
    self.scoreRewardScroll:ScrollInit({}, self.scoreRewardScrollView, BossraidRewardItem, function (arg)
        if self.model == nil then
            return
        end
        self:InitScoreRewardItem(arg)
    end) 

    self.rankRewardScrollView = self.rc:GetObject("RankRewardScrollView")
    self.rankRewardScroll = VerticalScroll.New()
    self.rankRewardScroll:Clear()
    self.rankRewardScroll:ScrollInit({}, self.rankRewardScrollView, BossraidRewardItem, function (arg)
        if self.model == nil then
            return
        end
        self:InitRankRewardItem(arg)
    end) 

    self.face = UILandlady.New(self.rc:GetObject("Paint"), 1005, self.rc:GetObject("Lines"))

    local item1 = self.rc:GetObject("Item1").transform
    UIUtil.SetSprite(item1:Find("Image"):GetComponent("Image"), AtlasConfig.Item, GetItemIcon(Z_Item[BOSSRAID_ITEM]))
    self.bossraidItemCountText = LangUtil.BindText(item1:Find("Text"))
    UIUtil.AddBtnEvent(item1.gameObject, function()
        local showData ={}
        showData.tempId = BOSSRAID_ITEM
        showData.showType = ShowType.Item
        UIUtil.OpenThingsDetailWindow(showData)
    end)
    local item2 = self.rc:GetObject("Item2").transform
    UIUtil.SetSprite(item2:Find("Image"):GetComponent("Image"), AtlasConfig.Item, GetItemIcon(Z_Item[BOSSRAID_TICK]))
    self.bossraidTickCountText = LangUtil.BindText(item2:Find("Text"))
    UIUtil.AddBtnEvent(item2.gameObject, function()
        local showData ={}
        showData.tempId = BOSSRAID_TICK
        showData.showType = ShowType.Item
        UIUtil.OpenThingsDetailWindow(showData)
    end)
end

function this:PlayAnim()
    self.face:CoPlay(1005)
end

function this:OnEnable()
    base.OnEnable(self)
    if self.model ~=nil and self.model.bossraid ~= nil then
        self.model.bossraid.oldScore = self.model.bossraid.totalScore
    end
    self:PlayAnim()
    self:OnTabClick(self.currentTab)
    self:OnRefresh()
end

function this:RefreshInfo()
    if self.model.bossraid.record.levelId == nil or self.model.bossraid.record.levelId == 0 then
        self.rankText.text = ""
        self.scoreText.text = ""
        self.difficulty:SetActive(false)
    else
        self.rankText.text = string.gsub(LangUtil.GetSysLang(1412), "XX", self.model.bossraid.rank)
        self.scoreText.text = LangUtil.GetSysLang(1493) .. self.model.bossraid.record.score
        self.difficulty:SetActive(true)
        self:SetDifficult(self.difficulty, self.model.bossraid.record.levelConfig.Diff)
    end
    self.scoreRewardText.text = LangUtil.GetSysLang(1410) .. " " .. LangUtil.GetSysLang(1512) .. self.model.bossraid.totalScore --积分奖励

    self.bossraidItemCountText.text = UIPublic.GetItemAmount(BOSSRAID_ITEM)
    self.bossraidTickCountText.text = UIPublic.GetItemAmount(BOSSRAID_TICK) .. "/" .. Z_Item[BOSSRAID_TICK].OwnMaxNum
end

function this:RefreshFight()
    self.bossLastTimeTexts = {}
    local datas = {}
    for index, value in ipairs(self.model.bossraid.config.LevelIds) do
        table.insert(datas, Z_BossraidLevel[value])
    end
    for i = 0, self.bossContent.childCount-1 do
        local child = self.bossContent:GetChild(i).gameObject
        if datas[i+1] == nil then
            child.gameObject:SetActive(false)
        else
            child.gameObject:SetActive(true)
            local arg = {}
            local index = i + 1
            arg.data = datas[index]
            arg.go = child
            arg.index = index
            self:InitBossItem(arg)
        end
    end
    -- self.bossScroll:RefreshData(datas)
end

function this:RefreshScoreReward()
    self.scoreRewardScroll:RefreshData(Z_BossraidScoreReward[self.model.bossraid.config.ScoreReward])
end

function this:RefreshRankReward()
    local rewards = Z_BossraidRankReward[self.model.bossraid.config.RankReward]
    local keys = {}
    for k in pairs(rewards) do
        table.insert(keys, k)
    end
    
    table.sort(keys, function(a, b)
        if a == 0 then
            return false
        elseif b == 0 then
            return true
        else
            return a < b
        end
    end)
    
    local sorted_tbl = {}
    for _, k in ipairs(keys) do
        table.insert(sorted_tbl, rewards[k])
    end
    self.rankRewardScroll:RefreshData(sorted_tbl)
end

function this:OnRefresh()
    self:RefreshInfo()
    self:RefreshFight()
    self:RefreshScoreReward()
    self:RefreshRankReward()
    self.leaderScroll:RefreshData(self.model.bossraid.leaderboard)
end

function this:Update()
    for index, value in ipairs(self.bossLastTimeTexts) do
        local time = TimeUtil.ConvertTimeForm(self.model.bossraid.remainBattle.battleStartTime + 3600 - TimeUtil.GetServerTime())
        value.text.text = time.hour .. ":" .. time.minute .. ":" .. time.second
    end

    local lastTime = TimeUtil.ParseDateTime(self.model.bossraid.config.EndTime) - TimeUtil.GetServerTime()
    if lastTime <= 0 then
        UIUtil.ToolTipFirst({
            title = LangUtil.GetSysLang(9),
            message = LangUtil.GetSysLang(1515),
            hideCloseBtn = true,
            callBack = function()
            self.ctrl.CloseSelf()
            end,
            closeCallBack = function()
            self.ctrl.CloseSelf()
            end,
            hideCloseBtn = true,
            hideBackBtn = true,
        })
        return
    end
    local time = TimeUtil.ConvertTimeForm(lastTime)
    
    local timeText = ""
    if time.day > 0 then
        timeText = timeText .. time.day .. LangUtil.GetSysLang(2006)
    end
    if time.hour > 0 then
        timeText = timeText .. time.hour .. LangUtil.GetSysLang(2007)    
    end
    if time.day == 0 or time.minute > 0 then
        timeText = timeText .. time.minute .. LangUtil.GetSysLang(2065)
    end

    self.lastTimeText.text = LangUtil.GetSysLang(1326) .. timeText
end

---@param self UIBossraidView
local function ON_BOSSRAID_UPDATE_PUSH(self)
    self:OnRefresh()
end

---@param self UIBossraidView
local function ON_BOSSRAID_LEADER_UPDATE_PUSH(self, topRank)
    self.leaderScroll:RefreshData(self.model.bossraid.leaderboard)
    if topRank ~= nil then
        local upCount = topRank - self.model.bossraid.minLeaderRank
        if upCount < 0 then upCount = 0 end
        local posX = self.leaderContent.transform.localPosition.x
        local itemHeight = self.bossraidLeaderItem:GetComponent("RectTransform").sizeDelta.y
        local height = upCount * itemHeight + self.leaderContent.spacing * upCount
        self.leaderContent.transform.localPosition = Vector3.New(posX, height, 0)
        local vec = self.leaderContent.transform.localPosition + Vector3.New(posX, height-0.1, 0)
        self.canRequestLeader = false
        self.leaderContent.transform:DOLocalMove(vec,0.5)
        self.canRequestLeader = true
    else
        self.canRequestLeader = true
    end
    -- if oldCount ~= nil then
    --     Logger.LogError("ON_BOSSRAID_LEADER_UPDATE_PUSH   move")
    --     local newCount = self.model.bossraid.maxLeaderRank - self.model.bossraid.minLeaderRank + 1
    --     local diff = newCount - oldCount
    --     local itemHeight = self.bossraidLeaderItem:GetComponent("RectTransform").sizeDelta.y
    --     local height = diff * itemHeight + self.leaderContent.spacing * (diff - 1)
    --     local posX = self.leaderContent.transform.localPosition.x
    --     self.leaderContent.transform.localPosition = self.leaderContent.transform.localPosition + Vector3.New(posX, height, 0)
    --     local vec = self.leaderContent.transform.localPosition + Vector3.New(posX, height-0.1, 0)
    --     self.canRequestLeader = false
    --     self.leaderContent.transform:DOLocalMove(vec,0.5)
    --     self.canRequestLeader = true
    --     Logger.LogError("----------------------------end   move")
    --     -- self.leaderContent.transform.localPosition = self.leaderContent.transform.localPosition + Vector3.New(0, height-0.1, 0)
    -- end
end

---@param self UIBossraidView
local function ON_ITEM_DATA_UPDATE(self)
    self:RefreshInfo()
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddUIListener(UIMessageNames.ON_BOSSRAID_UPDATE_PUSH, ON_BOSSRAID_UPDATE_PUSH)
    self:AddUIListener(UIMessageNames.ON_BOSSRAID_LEADER_UPDATE_PUSH, ON_BOSSRAID_LEADER_UPDATE_PUSH)
    self:AddUIListener(UIMessageNames.ON_ITEM_DATA_UPDATE, ON_ITEM_DATA_UPDATE)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveUIListener(UIMessageNames.ON_BOSSRAID_UPDATE_PUSH)
    self:RemoveUIListener(UIMessageNames.ON_BOSSRAID_LEADER_UPDATE_PUSH)
    self:RemoveUIListener(UIMessageNames.ON_ITEM_DATA_UPDATE)
end


function this:OnDisable()
    base.OnDisable(self)
    self.face:Disable()
end

function this:OnDestroy()
    base.OnDestroy(self)
    -- self.bossScroll:Dispose()
    self.leaderScroll:Dispose()
    self.scoreRewardScroll:Dispose()
    self.rankRewardScroll:Dispose()
end

return this