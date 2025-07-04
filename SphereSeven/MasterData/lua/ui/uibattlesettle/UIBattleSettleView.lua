---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/6/3 14:41
---

local UIBattleSettleView = BaseClass("UIBattleSettleView",UIBaseView)
local base = UIBaseView
local this = UIBattleSettleView

local winPrefab = "UI/Effects/Battle/WIN.prefab"
local losePrefab = "UI/Effects/Battle/Failure.prefab"

local function InitContent(self,data)
    for k,v in pairs(self.itemList) do
        v.gameObject:SetActive(false)
    end
    local count = 0
    local rewardInfoList1 = {}
    -- if UIUtil.AcyivitySettleReward()  then
    --     table.insertto(rewardInfoList1,data.RewardInfoList,0)
    --     table.insertto(rewardInfoList1,data.RewardInfoList,table.count(data.RewardInfoList) +1)
    -- else
    --     table.insertto(rewardInfoList1,data.RewardInfoList,0)
    -- end
    local rewardList = {}--self.model.data.rsp.reward_result

    for _, value in ipairs(self.data.rsp.first_reward_result) do
        table.insert(rewardList, value)
    end

    for _, value in ipairs(self.data.rsp.first_perfect_reward_result) do
        table.insert(rewardList, value)
    end

    for _, value in ipairs(self.data.rsp.normal_reward_result) do
        table.insert(rewardList, value)
    end

    if rewardList ~= nil then
        for _, value in ipairs(rewardList) do
            if value.type ~= RewardType.RewardTypeExp then
                count = count + 1
                local object = self.itemList[count]
                object:SetActive(true)
                local itemBg = object.transform:GetComponent("Image")
                local avatar = object.transform:Find("Avatar"):GetComponent("Image")
                local amount = object.transform:Find("Amount"):GetComponent("Text")

                amount.text = value.count
                UIPublic.InitItemIconNew(avatar, itemBg, value.type, value.id)

                UIUtil.AddBtnEvent(object,function(go)
                    local showData = {}
                    local showType = ShowType.Item
                    if value.type == RewardType.RewardTypeEquipment then
                        showType = ShowType.Equip
                    elseif value.Type == RewardType.RewardTypeCharacter then
                        showType = ShowType.Card
                    elseif value.Type == RewardType.RewardTypeFightSoul then
                        showType = ShowType.FightSoul
                    end
                    showData.showType = showType
                    showData.tempId = value.id
                    showData.count = value.count
                    UIUtil.OpenThingsDetailWindow(showData)
                end)
            end
        end
    end

    -- for _,v in table.pairsByKeys(rewardInfoList1) do
    --     count = count + 1
        
    --     local object = self.itemList[count]
    --     if UIUtil.AcyivitySettleReward() and table.count(rewardInfoList1)/2 < count then
    --         LangUtil.BindText(object.transform:Find("FrameActivity/Image/Text")).text = LangUtil.GetSysLang(966)
    --         object.transform:Find("FrameActivity").gameObject:SetActive(true)
    --     else
    --         object.transform:Find("FrameActivity").gameObject:SetActive(false)
    --     end
    --     local itemBg = object.transform:GetComponent("Image")
    --     local avatar = object.transform:Find("Avatar"):GetComponent("Image")
    --     local name = LangUtil.BindText(object.transform:Find("Mask/Name"))
    --     local amount = LangUtil.BindText(object.transform:Find("Amount"), FontType.All_Number)
    --     object:SetActive(true)
    --     amount.text = (UIUtil.AcyivitySettleReward() and {"x"..math.ceil(v.Num/2)} or {"x"..v.Num})[1]
    --     local tempId = v.TemplateId
    --     local kind
    --     if v.RewardTypeInfo == "Unknown" then -- Unknown

    --     elseif v.RewardTypeInfo == "Item" then --Item
    --         kind = GoodsKind.Item
    --         local z_item = Z_Item[tempId]
    --         if tempId == 0 then
    --             local item = table.first(Game.Scene.Player:GetComponent("ItemComponent").Items,function(a) return a.Id == v.Id end)
    --             z_item=Z_Item[item.Id]
    --         end
    --         UIPublic.InitItemIcon(avatar, itemBg, kind, tempId)
    --         name.text = LangUtil.GetConfLang(z_item, "Name")
    --     elseif v.RewardTypeInfo == "Card" then --Card
    --         kind = GoodsKind.Card
    --         UIPublic.InitItemIcon(avatar, itemBg, kind, tempId)
    --         local z_card = Z_Card[tempId]
    --         name.text = LangUtil.GetConfLang(z_card, "Name")
    --     elseif v.RewardTypeInfo == "FightSoul" then --FightSoul
    --         kind = GoodsKind.FightSoul
    --         UIPublic.InitItemIcon(avatar, itemBg, kind, tempId)
    --         local z_fightSoul = Z_FightSoul[tempId]
    --         name.text = LangUtil.GetConfLang(z_fightSoul, "Name")
    --     elseif v.RewardTypeInfo == "StarStone" then --StarStone
    --         kind = GoodsKind.FreeStarStone
    --         local z_currency = Z_Currency[3]
    --         UIPublic.InitItemIcon(avatar, itemBg, kind, tempId)
    --         name.text = LangUtil.GetConfLang(z_currency, "Name")
    --     elseif v.RewardTypeInfo == "GoldCoin" then --GoldCoin
    --         kind = GoodsKind.GoldCoin
    --         local z_currency = Z_Currency[1]
    --         UIPublic.InitItemIcon(avatar, itemBg, kind, tempId)
    --         name.text = LangUtil.GetConfLang(z_currency, "Name")
    --     elseif v.RewardTypeInfo == "MagicCrystal" then --MagicCrystal
    --         kind = GoodsKind.MagicCrystal
    --         local z_currency = Z_Currency[5]
    --         UIPublic.InitItemIcon(avatar, itemBg, kind, tempId)
    --         name.text = LangUtil.GetConfLang(z_currency, "Name")
    --     elseif v.RewardTypeInfo == "StarSand" then
    --         kind = GoodsKind.StarSand
    --         local z_currency = Z_Currency[4]
    --         UIPublic.InitItemIcon(avatar, itemBg, kind, tempId)
    --         name.text = LangUtil.GetConfLang(z_currency, "Name")
    --     end

    --     UIUtil.ScrollText(name)
    --     UIUtil.AddBtnEvent(avatar.gameObject,function() 
    --         UIPublic.OpenThingsDetail(kind, tempId)
    --     end)
    -- end
end

local function InitExpArea(self,data)
    --if true then return end
    local player = Game.Scene.Player
    local transform = self.exp_area.transform
    local level_text = LangUtil.BindText(transform:Find("Level"), FontType.All_Number)
    local name_text = LangUtil.BindText(transform:Find("Name"))
    local slider = transform:Find("Background/Fill"):GetComponent("Image")
    local getExp = LangUtil.BindText(transform:Find("GetExp"), FontType.All_Number)
    local expText = LangUtil.BindText(transform:Find("Background/Text"), FontType.All_Number)
    local levelUp = transform:Find("LevelUp")
    
    local addExp = 0
    if self.data.rsp.normal_reward_result ~= nil then
        for _, rewardInfo in ipairs(self.data.rsp.normal_reward_result) do
            if rewardInfo.type == RewardType.RewardTypeExp then
                addExp = rewardInfo.count
            end
        end
    end
    getExp.text = "EXP  +".. addExp--self.data.AddExp
    level_text.text = "LV.".. player.Level
    name_text.text = player.Nickname

    local zPlayerLevel = Z_PlayerLevelUp[player.Level]
    if zPlayerLevel == nil then
        expText.text = "--/--"
        slider.fillAmount = 1
    else
        expText.text = player.Exp.."/".. zPlayerLevel.Exp
        slider.fillAmount = player.Exp / zPlayerLevel.Exp
    end
    
    local func = function()
        coroutine.start(function () 
            coroutine.waitforseconds(1)
            levelUp.gameObject:SetActive(false)
            coroutine.waitforseconds(0.2)
            getExp.gameObject:SetActive(true)
            getExp.transform:DOLocalMoveY(0, 0.2):SetEase(Ease.InQuad)
        end)
    end
    if not self.data.IsLevelUp then
        levelUp.gameObject:SetActive(false)
        getExp.gameObject:SetActive(true)
        getExp.transform:DOLocalMoveY(-30, 0)
        getExp.transform:DOLocalMoveY(0, 0.2):SetEase(Ease.InQuad)
    else
        levelUp.gameObject:SetActive(true)
        getExp.gameObject:SetActive(false)
        levelUp.transform:DOLocalMoveY(-30, 0)
        getExp.transform:DOLocalMoveY(-30, 0)
        levelUp.transform:DOLocalMoveY(0, 0.2):SetEase(Ease.InQuad).onComplete = function() func() end
    end
end

local function InitConditionArea(self,data)
    if data.rsp.level_type == LevelType.LevelTypeBossraid then
        self.condition_area:SetActive(false)
        self.noteText.text = ""
        coroutine.start(function()
            coroutine.waitforseconds(1)
            local against_component = Game.Scene:GetComponent("AgainstComponent")
            ---@type BossraidComponent
            local bossraidComponent = Game.Scene.Player:GetComponent("BossraidComponent")
            if against_component ~= nil and bossraidComponent ~= nil and against_component.BattleData.Bossraid.bossraidId ~= nil then
                local bossraid = bossraidComponent:GetBossraid(against_component.BattleData.Bossraid.bossraidId)
                local upScore = bossraid.totalScore - bossraid.oldScore
                if upScore > 0 then
                    self.noteText.text = LangUtil.GetSysLang(1514) .. "\n" .. upScore
                else
                    self.noteText.text = ""
                end
            end
        end)
    else
        self.condition_area:SetActive(true)
        self.noteText.text = ""

        local transform = self.condition_area.transform
        local condition_tab = {}
        --local z_storyLevel = Game.Scene:GetComponent("AgainstComponent"):GetCurZBattleLevel()
        --local conditionRewards = loadtable(z_storyLevel.ConditionRewards)
        local completeData = self.model.data.reached_goals
    
        for i = 0,transform.childCount -1 do
            condition_tab[i+1] = transform:GetChild(i)
        end
        --local IsReachRewardCond = {[1] = data.IsReachRewardCond1,[2] = data.IsReachRewardCond2,[3] = data.IsReachRewardCond3}
    
        for i = 1,#condition_tab do
            local condition = condition_tab[i].transform
            local star = condition:Find("Star")
            local content = LangUtil.BindText(condition:Find("Content"))
            if completeData[i] ~= nil then
               star.gameObject:SetActive(true)
               local image = star:Find("StarLight")
               content.text = Z_BattleEndCondition[completeData[i]].Description
               image.gameObject:SetActive(completeData[i] ~= nil)
            else
               content.text = ""
               star.gameObject:SetActive(false)
            end
        end
    end

    -- for i = 1,#condition_tab do
    --     local condition = condition_tab[i].transform
    --     local star = condition:Find("Star")
    --     local content = LangUtil.BindText(condition:Find("Content"))
    --     if conditionRewards[i] ~= nil then
    --        star.gameObject:SetActive(true)
    --        local image = star:Find("StarLight")
    --        content.text = UIPublic.GetConditionStr(conditionRewards[i])
    --        image.gameObject:SetActive(IsReachRewardCond[i] == 1)
    --     else
    --        content.text = ""
    --        star.gameObject:SetActive(false)
    --     end
    --     local content = LangUtil.BindText(condition:Find("Content"))
    --     content.text = Z_BattleEndCondition[i].Description
    -- end
end

local function OnClickConfirmButton(self)
    self.ctrl:CloseSelf()
    if self.data.IsSweep == nil or self.data.IsSweep == 0  then
        Game.Scene:GetComponent("BattleComponent").fsm:Switch(BattleState.LeaveScene)
    else
        --coroutine.start(function ()
        --    coroutine.waitforframes(3)
        --    Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI,"Home") 
        --end)
    end
end

function this.OnCreate(self)
    base.OnCreate(self)

    self.content = self.rc:GetObject("Content")
    self.condition_area = self.rc:GetObject("ConditionArea")
    self.exp_area = self.rc:GetObject("ExpArea")
    self.close_btn2 = self.rc:GetObject("CloseButton2")
    self.bg = self.rc:GetObject("Bg")
    self.propWnd = self.rc:GetObject("PropWindow")
    self.abysmInfo = self.rc:GetObject("AbysmInfo")
    self.abysmSettle = self.rc:GetObject("AbysmSettle")
    self.competition = self.rc:GetObject("Competition")
    self.titleTxt = self.rc:GetObject("Text")
    self.close_btn = self.rc:GetObject("CloseButton")
    self.confirm_btn = self.rc:GetObject("ConfirmBtn")

    self.HistoryCompetition = self.rc:GetObject("HistoryCompetition")
    self.HistoryEventBg = self.rc:GetObject("HistoryEventBg")
    self.HistoryText = self.rc:GetObject("HistoryText")
    self.CurrentText = self.rc:GetObject("CurrentText")

    UIUtil.GetButtonDataComponent(self.close_btn2):Add("self",self)
    UIUtil.AddBtnEvent(self.close_btn2, function()
        if self.data.IsSweep == nil or self.data.IsSweep == 0 then if Game.Scene:GetComponent("BattleComponent").fsm ~= nil then -- 避免出错这里卡死
                Game.Scene:GetComponent("BattleComponent").fsm:Switch(BattleState.LeaveScene)
            else
                UIManager:GetInstance():CloseWindow(UIWindowNames.UIBattleSettle)
            end
        else
            UIManager:GetInstance():CloseWindow(UIWindowNames.UIBattleSettle)
        end
    end)

    self.itemList = {}
    for i = 0, self.content.transform.childCount - 1 do
        self.itemList[i + 1] = self.content.transform:GetChild(i).gameObject
    end
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.rc:GetObject("RewardText")).text = LangUtil.GetSysLang(3049)--奖励物品
    LangUtil.BindText(self.rc:GetObject("BackText")).text = LangUtil.GetSysLang(145)--确定
    self.noteText = LangUtil.BindText(self.rc:GetObject("NoteText"))
end

function this.ShowCompetition(self,changeScore, score)
    self.bg:SetActive(false)
    self.propWnd:SetActive(false)
    self.competition:SetActive(true)
    self.HistoryCompetition:SetActive(false)
    self.Mask = self.rc:GetObject("ComopetitionMask")
    LangUtil.GetSpriteLang(554, function(sprite) self.rc:GetObject("RewardTitleTxt"):GetComponent("Image").sprite = sprite end)
    ---@type CompetitionComponent
    local CompetitionComponent = Game.Scene:GetComponent("CompetitionComponent")
    ---@type ArenaInfo
    local newArenaInfo = CompetitionComponent:GetArenaInfo()
    local newScore = changeScore + score
    local oldScore = score
    local addScore = changeScore
    UIUtil.AddBtnEvent(self.Mask, function() Game.Scene:GetComponent("BattleComponent").fsm:Switch(BattleState.LeaveScene) end)
    LangUtil.BindText(self.rc:GetObject("BattleText")).text = LangUtil.GetSysLang(3067)..":"
    if addScore > 0 then
        LangUtil.BindText(self.rc:GetObject("AddScoreText")).text = "+" ..  addScore
    elseif addScore == 0 then
        LangUtil.BindText(self.rc:GetObject("AddScoreText")).text = "-" .. addScore
    else
        LangUtil.BindText(self.rc:GetObject("AddScoreText")).text = addScore
    end
    local scoreTxt = LangUtil.BindText(self.rc:GetObject("ScoreText"))
    local initScore = oldScore
    scoreTxt.text = initScore
    coroutine.start(function () 
        while(true) do
            coroutine.waitforframes(1)
            initScore = initScore + Time.deltaTime * 15
            if not IsNull(scoreTxt) then
                scoreTxt.text = Mathf.Floor(initScore)
                if initScore > newScore then
                    scoreTxt.text = newScore
                    break
                end
            else
                break
            end
        end
    end)
    local itemContent = self.rc:GetObject("ItemContent").transform
    local itemPrefab = self.rc:GetObject("ItemPrefab")

    local rewardResultTable = {}

    if self.data.rsp.first_reward_result ~= nil then
        for _, value in ipairs(self.data.rsp.first_reward_result) do
            table.insert(rewardResultTable, value)
        end
    end

    if self.data.rsp.first_perfect_reward_result ~= nil then
        for _, value in ipairs(self.data.rsp.first_perfect_reward_result) do
            table.insert(rewardResultTable, value)
        end
    end

    if self.data.rsp.normal_reward_result ~= nil then
        for _, value in ipairs(self.data.rsp.normal_reward_result) do
            table.insert(rewardResultTable, value)
        end
    end

    for index, value in ipairs(rewardResultTable) do
    --for index, value in ipairs(self.data.rsp.reward_result) do
        -- type, id, count
        local item
        if itemContent.childCount < index then
            item = GameObject.Instantiate(itemPrefab)
            item.transform:SetParent(itemContent, false)
            item:SetActive(true)
        else
            item = itemContent:GetChild(index - 1).gameObject
        end
        UIPublic.InitRewardItem({
            itemPrefab = item,
            type = value.type,
            id = value.id,
            count = value.count,
            nameText = LangUtil.BindText(item.transform:Find("Name/Value")),
            isShowCount = true,
            isShowThingsDetail = true,
            bag = false,
        })
    end
    for i = table.count(rewardResultTable), itemContent.childCount - 1 do
        itemContent:GetChild(i).gameObject:SetActive(false)
    end

    local textLayoutRect = self.rc:GetObject("TextLayout"):GetComponent("RectTransform")
    -- 调整坐标0,0
    if table.count(rewardResultTable) > 0 then
        textLayoutRect.anchoredPosition = Vector2.New(0, -155)
    else
        textLayoutRect.anchoredPosition = Vector2.New(0, -30)
    end

    UIUtil.AddBtnEvent(self.close_btn, function() Game.Scene:GetComponent("BattleComponent").fsm:Switch(BattleState.LeaveScene) end)
    UIUtil.AddBtnEvent(self.confirm_btn, function() Game.Scene:GetComponent("BattleComponent").fsm:Switch(BattleState.LeaveScene) end)
end

function this.Competition(self)
    ---@type CompetitionComponent
    local competition_component = Game.Scene:GetComponent("CompetitionComponent")
    self.bg:SetActive(false)
    self.propWnd:SetActive(false)
    self.competition:SetActive(false)
    self.HistoryCompetition:SetActive(true)
    self.rc:GetObject("History"):SetActive(false)

    ---@type ArenaInfo
    local arenaInfo = competition_component:GetArenaInfo()
    local division = arenaInfo.division --当前段位
    local score = arenaInfo.score --当前积分
    if division == nil then
        Logger.LogError("newDivision or division is nil")
        self:ShowCompetition(0, score)
        return
    end
    coroutine.start(function ()
        coroutine.waitforseconds(1)
        Game.Scene:GetComponent("BgmComponent"):Stop()
        self.img:DOFade(128 / 255, 0)
        local prefabPath = self.data.battle_result == BattleResultType.BattleResultWin and winPrefab or losePrefab
        local zSeason = Z_ArenaSeasonConfig[arenaInfo.season]
        local zDivision = Z_ArenaSeasonReward[zSeason.Reward][division]
        local changeScore = 0
        if zDivision ~= nil then
            if self.data.battle_result == BattleResultType.BattleResultWin then
                changeScore = zDivision.WinScore
            else
                changeScore = zDivision.LoseScore
            end
        end

        local efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(prefabPath)
        efx.transform:DOShakePosition(1,20,100,90)
        efx.transform:SetParent(self.gameObject.transform, false)
        table.csenu(efx:GetComponentsInChildren(typeof(Transform)),function (v)
            v.gameObject.layer = LayerMask.NameToLayer("UI")
        end)
        table.csenu(efx:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystemRenderer)),function (smr)
            smr.sortingOrder = self.canvas.unity_canvas.sortingOrder + 1
        end)
        if self.data.battle_result == BattleResultType.BattleResultWin then
            Game.Scene:GetComponent("SoundComponent"):CoPlay(CommonSoundPath.battleWin)
        else
            Game.Scene:GetComponent("SoundComponent"):CoPlay(CommonSoundPath.battleLose)
        end
        coroutine.waitforseconds(3)
        GameObjectPool:GetInstance():RecycleGameObject(prefabPath, efx)

        ---@type ArenaInfo
        local newArenaInfo = competition_component:GetArenaInfo()
        local newDivision = newArenaInfo.division --当前段位
        -- competition_component:GetCompetitionInfo(function()
            if newDivision ~= division  then
                self.HistoryEventBg.gameObject:SetActive(true)
                UIUtil.AddBtnEvent( self.HistoryEventBg,function(go)   end)
                local zSeason = Z_ArenaSeasonConfig[arenaInfo.season]

                if newDivision == nil or division == nil then
                    Logger.LogError("newDivision or division is nil")
                    self:ShowCompetition(changeScore, score)
                    return
                end

                LangUtil.BindText(self.rc:GetObject("HistoryText")).text = LangUtil.GetConfLang(Z_ArenaSeasonReward[zSeason.Reward][newDivision], "Name")
                LangUtil.BindText(self.rc:GetObject("CurrentText")).text = LangUtil.GetConfLang(Z_ArenaSeasonReward[zSeason.Reward][division], "Name")
                --self.rc:GetObject("CurrentText"):GetComponent("Image").sprite = AtlasManager:GetInstance():CoLoadImageAsync(PathUtil.Path_Dangrad..Z_Competition[newDivision].LevelUpImage..".png")
                local num = 0
                --competition_component:GetReward(true ,Competition_Com.info.cplayer.division,function(RewardInfoList)
                --    for i, v in pairs(RewardInfoList) do
                --        num = num + v.Num 
                --    end  
                --end)
                local path = "UI/Effects/Battle/"..Z_ArenaSeasonReward[zSeason.Reward][newDivision].Effect..".prefab"
                local efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(path)
                efx.transform:SetParent(self.HistoryCompetition.transform, false)
                table.csenu(efx:GetComponentsInChildren(typeof(Transform)),function (v)
                    v.gameObject.layer = LayerMask.NameToLayer("UI")
                end)
                table.csenu(efx:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystemRenderer)),function (smr)
                    smr.sortingOrder = self.canvas.unity_canvas.sortingOrder + 1
                end)
                local tex = ResourcesManager:GetInstance():CoLoadAsync(PathUtil.Path_Dangrad..Z_ArenaSeasonReward[zSeason.Reward][newDivision].LevelUpImage..".png", typeof(CS.UnityEngine.Texture2D))
                local tex2 = ResourcesManager:GetInstance():CoLoadAsync(PathUtil.Path_Dangrad..LangUtil.GetSysLang(3063)..".png", typeof(CS.UnityEngine.Texture2D))
                efx.transform:Find("Root/Image"):GetComponent("ParticleSystemRenderer").material:SetTexture("_MainTex", tex)
                efx.transform:Find("Root/DuanWei"):GetComponent("ParticleSystemRenderer").material:SetTexture("_MainTex", tex2)
                coroutine.start(function ()
                    coroutine.waitforseconds(1.2)
                    self.rc:GetObject("History"):SetActive(true)
                    coroutine.waitforseconds(2.3)
                    UIUtil.AddBtnEvent( self.HistoryEventBg,function(go)
                        GameObjectPool:GetInstance():RecycleGameObject(path, efx)
                        self:ShowCompetition(changeScore, score)
                        self.HistoryEventBg.gameObject:SetActive(false) 
                    end)
                    
                end)
            else
                self:ShowCompetition(changeScore, score)
            end
        -- end)
    end)
end

function this.CommonMode(self)
    self.bg:SetActive(true)
    self.propWnd:SetActive(false)
    self.competition:SetActive(false)
    self.HistoryCompetition:SetActive(false)
    if self.data == nil or self.data.IsSweep == nil or self.data.IsSweep == 0  then -- 非扫荡
        self.bg:SetActive(false)
        coroutine.start(function ()
            coroutine.waitforseconds(1)
            Game.Scene:GetComponent("BgmComponent"):Stop()
            self.img:DOFade(128 / 255, 0)
            local efx = GameObjectPool:GetInstance():CoGetGameObjectAsync(winPrefab)
            efx.transform:SetParent(self.gameObject.transform, false)
            efx.transform:DOShakePosition(1,20,100,90)
            table.csenu(efx:GetComponentsInChildren(typeof(Transform)),function (v)
                v.gameObject.layer = LayerMask.NameToLayer("UI")
            end)
            table.csenu(efx:GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystemRenderer)),function (smr)
                smr.sortingOrder = self.canvas.unity_canvas.sortingOrder + 1
            end)
            Game.Scene:GetComponent("SoundComponent"):CoPlay(CommonSoundPath.battleWin)
            coroutine.waitforseconds(3)
            GameObjectPool:GetInstance():RecycleGameObject(winPrefab, efx)
            self.bg:SetActive(true)
            self:OnRefresh()
            local IsAAutoGame = Game.Scene:GetComponent("AgainstComponent").IsAutoGame
            if IsAAutoGame ~= nil and IsAAutoGame ~= 0 then
                OnClickConfirmButton(self)
            end
        end)
    else
        self:OnRefresh()
        self.img:DOFade(128 / 255, 0)
        Game.Scene:GetComponent("SoundComponent"):CoPlay(CommonSoundPath.battleWin)
    end
end

function this.OnEnable(self)
    base.OnEnable(self)
    self.data = self.model.data
    local against_component = Game.Scene:GetComponent("AgainstComponent")
    self.img = self.gameObject:GetComponent("Image")
    self.img:DOFade(0, 0)
    coroutine.start(function ()
        if against_component.LevelType == LevelType.LevelTypeArena then
            self:Competition()
        else
            self:CommonMode()
        end
    end)
end

function this.OnRefresh(self)
    InitConditionArea(self,self.data)
    InitExpArea(self,self.data)
    InitContent(self,self.data)
    UIPublic.ActiveSetBattleSettle(self.gameObject.transform:Find("Bg"))

end

function this.OnDisable(self)

end

function this.OnDestroy(self)
    base.OnDestroy(self)
end

return this

