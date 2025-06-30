
--
-- <代码文件解释说明>
--

---@class UIPlayerInfoCtrl
---@field model UIPlayerInfoModel
---@field player Player
local UIPlayerInfoCtrl = BaseClass("UIPlayerInfoCtrl",UIBaseCtrl)
local this = UIPlayerInfoCtrl

--- 初始化数据
function this:InitData()
    self.player = Game.Scene.Player
end

function this:IsPlayer()
    return true
end

function this:getUIName()
    return UIWindowNames.UIPlayerInfo
end

function this.GetBackButtonText()
    return LangUtil.GetSysLang(440)
end

--- 获取常用角色
---@return {character_id:number, battle_times:number}
function this:GetMostCharacters()
    return self.player.MostUsedCharacters
end

---@return number, number
function this:GetCardIdAndSkinId()
    return self.player.SocietyShowGirl.character_id, self.player.SocietyShowGirl.skin_id
end

--- 是否显示 nameEdit 按钮
function this.isNameEdit()
    return true
end

--- 是否显示 修改头像按钮
function this.isShowIconChangeButton()
    return true
end

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIPlayerInfo) 
end

function this:GetOnlineTimeText()
    local time = self.player.OnLineTime
    local hour    = math.floor(time/3600)
    local minute  = math.fmod(math.floor(time/60), 60)

    if hour >= 1 then
        if minute >= 0 then
            local str = string.gsub(LangUtil.GetSysLang(1177), "XX", hour)
			return string.gsub(str, "YY", minute)
        else
            local str = string.gsub(LangUtil.GetSysLang(1178), "XX", hour)
            return str
        end
    else
        local str = string.gsub(LangUtil.GetSysLang(1179), "XX", minute)
        return str
    end
end

--- 成就数量
function this:GetAchievementFinishCount()
    return self.player.AchievementFinishCount
end

--- 好友数量
function this:GetFriendsCount()
    return table.count(self.player:GetComponent("FriendComponent"):GetFriends())
end

-- 抽卡次数
function this:GetRecruitCount()
    return self.player.totalRecruitTimes
end

--- 出击次数
function this:GetBattleCount()
    return self.player.LevelStartCount
end

--- 击杀数量
function this:GetKillCount()
    return self.player.KillCount
end

--- 卡牌收集进度 -- value:number, progress:number value:收集数量 progress:进度(0-100)
function this:GetCardProgress()
    local ret = {}
    ret.value = self.player.collection.characterCollection

    local allCardNum = self.player:GetComponent("CardComponent"):GetAllCardKindCount()
    ret.progress = math.floor(ret.value / allCardNum * 100)

    return ret
end

--- 装备收集进度 -- value:number, progress:number value:收集数量 progress:进度(0-100)
function this:GetEquipProgress()
    local ret = {}
    ret.value = self.player.collection.equipmentCollection

    local allCount = self.player:GetComponent("EquipComponent"):GetAllEquipKindCount()
    ret.progress = math.floor(ret.value / allCount * 100)

    return ret
end

--- 敌人收集进度 -- value:number, progress:number value:收集数量 progress:进度(0-100)
function this:GetEnemyProgress()
    local ret = {}
    ret.value = self.player.collection.enemyCollection

    local allCount = table.count(table.choose(Z_Card,function(k,v)
        return v.IsMonster == 1 and v.NotOpen ~= 1
    end))

    ret.progress = math.floor(ret.value / allCount * 100)

    return ret
end

--- 争霸次数
function this:GetPVPCount()
    ---@type CompetitionComponent
    local competitionComponent = Game.Scene:GetComponent("CompetitionComponent")
    local arenaInfo = competitionComponent:GetArenaInfo()
    return arenaInfo.history.attackTotalCount
end

--- 战魂收集进度 -- value:number, progress:number value:收集数量 progress:进度(0-100)
function this:GetFightSoulProgress()
    local ret = {}
    ret.value = self.player.collection.fightSoulCollection

    local allFightSoulCount = self.player:GetComponent("FightSoulComponent"):GetAllFightSoulKindCount()
    ret.progress = math.floor(ret.value / allFightSoulCount * 100)

    return ret
end

--- 所有收集进度(0-100)
function this:GetAllGatherProgress()
    local cardProgress = self:GetCardProgress()
    local equipProgress = self:GetEquipProgress()
    local enemyProgress = self:GetEnemyProgress()
    local fightSoulProgress = self:GetFightSoulProgress()

    local progress = math.floor((cardProgress.progress + equipProgress.progress + enemyProgress.progress + fightSoulProgress.progress) / 4)

    return progress
end

---@return number @ exp比例
function this:GetExpSliderProgress()
    return UIPublic.GetExpValue(self.player.Level,self.player.Exp)
end

--- 显示的exp文本
function this:GetExpText()
    local zPlayerLevel = Z_PlayerLevelUp[self.player.Level + 1]
    local expText 
    if zPlayerLevel == nil then
        expText = "--/--"
    else
        expText = self.player.Exp .."/".. zPlayerLevel.Exp
    end
    return expText
end

function this:GetNameText()
    return self.player.Nickname
end

function this:GetRegisterTime()
    return self.player.RegisterTime
end

function this:GetLevel()
    return self.player.Level
end

function this:GetUid()
    return self.player.AccountId -- 或者 参数 Id
end

function this:GetAvater()
    return self.player.Avatar
end

--- 获取最高段位
function this:GetCompetitionHighestDivison()
    ---@type CompetitionComponent
    local competitionComponent = Game.Scene:GetComponent("CompetitionComponent")
    local arenaInfo = competitionComponent:GetArenaInfo()
    local ret = arenaInfo.history.highestDivison
    if ret == nil or ret == 0 then
        ret = 1
    end
    return ret
end

--- 获取最高段位赛季
function this:GetCompetitionHighestDivisonSeason()
    ---@type CompetitionComponent
    local competitionComponent = Game.Scene:GetComponent("CompetitionComponent")
    local arenaInfo = competitionComponent:GetArenaInfo()
    local ret = arenaInfo.history.highestDivisonSeason
    if ret == nil or ret == 0 then
        ret = 1
    end
    return ret
end

--- 获取当前段位
function this:GetCompetitionDivison()
    ---@type CompetitionComponent
    local competitionComponent = Game.Scene:GetComponent("CompetitionComponent")
    local arenaInfo = competitionComponent:GetArenaInfo()
    local ret = arenaInfo.division
    if ret == nil or ret == 0 then
        ret = 1
    end
    return ret
end

--- 获取当前段位赛季
function this:GetCompetitionDivisonSeason()
    ---@type CompetitionComponent
    local competitionComponent = Game.Scene:GetComponent("CompetitionComponent")
    local arenaInfo = competitionComponent:GetArenaInfo()
    local ret = arenaInfo.season
    if ret == nil or ret == 0 then
        ret = 1
    end
    return ret
end

function this:GetSupportCard()
    return self.player:GetComponent("CardComponent"):Get(self.player.supportCardId)
end

function this:GetSupportFightSoul()
    return self.player:GetComponent("FightSoulComponent"):Get(self.player.supportFightSoulId)
end

function this:OnClickSupportCard()
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIFormationChooseCard, {
        currentCard = self:GetSupportCard(),
        cardList = {{card = self:GetSupportCard()}},
        ---@param card Card
        confirmCallBack = function(card)
            if card == nil then
                return
            end
            local fightSoulId = self.player.supportFightSoulId
            if fightSoulId ~= 0 then
                ---@type FightSoul
                local fightSoul = self:GetSupportFightSoul()
                if fightSoul == nil then
                    fightSoulId = 0
                else
                    local zFightSoul = Z_FightSoul[fightSoul.TemplateId]
                    if not table.contains(zFightSoul.ClassLimit, Z_Character[card.TemplateId].Class) then
                        fightSoulId = 0
                    end
                end
            end

            PublicRequest.SendRequest(
                PROTOCOL.SetSupportUnitReq,
                {
                    index = SupportUnitIndex,
                    character_id = card.Id,
                    fight_soul_id = fightSoulId,
                },
                nil
            )
        end
    })
end

function this:OnClickSupportFightSoul()
    if self:GetSupportCard() == nil then
        return
    end
    local fightSoulToCard = {}
    if self.player.supportFightSoulId ~= nil then
        fightSoulToCard[self.player.supportFightSoulId] = self:GetSupportCard().Id
    end
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIFormationChooseFightSoul, {
        -- index = index,
        characterId = nil,
        isShowProperty = false,
        class = Z_Character[self:GetSupportCard().TemplateId].Class,
        chooseFightSoul = self:GetSupportFightSoul(),
        fightSoulToCard = fightSoulToCard,
        ---@param fightSoul FightSoul
        confirmCallBack = function(fightSoul)
            local id
            if fightSoul ~= nil then
                id = fightSoul.Id
            end
            PublicRequest.SendRequest(
                PROTOCOL.SetSupportUnitReq,
                {
                    index = SupportUnitIndex,
                    character_id = self.player.supportCardId,
                    fight_soul_id = id,
                },
                nil
            )
        end
    })
end

return this
