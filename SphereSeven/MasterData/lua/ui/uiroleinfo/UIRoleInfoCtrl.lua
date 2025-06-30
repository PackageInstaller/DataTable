
--
-- <代码文件解释说明>
--

---@class UIRoleInfoCtrl
---@field model UIRoleInfoModel
local UIRoleInfoCtrl = BaseClass("UIRoleInfoCtrl",UIBaseCtrl)
local this = UIRoleInfoCtrl

--- 初始化数据
function this:InitData()
end

function this:IsPlayer()
    return false
end

function this:getUIName()
    return UIWindowNames.UIRoleInfo
end

function this.GetBackButtonText()
    return LangUtil.GetSysLang(4049)
end

---@return {character_id:number, battle_times:number}
function this:GetMostCharacters()
    local ret = {}
    for index, value in ipairs(self.model.role.info.battleInfo.mostUsedCharacters) do
        table.insert(
            ret,
            {
                character_id = value.characterId,
                battle_times = value.battleTimes
            }
        )
    end
    return ret
end

---@return number, number
function this:GetCardIdAndSkinId()
    return self.model.role.info.showGirl.character_id, self.model.role.info.showGirl.skin_id
end

--- 是否显示 nameEdit 按钮
function this.isNameEdit()
    return false
end

--- 是否显示 修改头像按钮
function this.isShowIconChangeButton()
    return false
end

function this.CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIRoleInfo) 
end

function this:GetOnlineTimeText()
    local time = self.model.role.info.totalOnlineDuration
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
    return self.model.role.info.taskInfo.achievementFinishCount
end

--- 好友数量
function this:GetFriendsCount()
    return self.model.role.info.friendCount
end

-- 抽卡次数
function this:GetRecruitCount()
    return self.model.role.info.recruitInfo.totalRecruitTimes
end

--- 出击次数
function this:GetBattleCount()
    return self.model.role.info.battleInfo.levelStartTimes
end

--- 击杀数量
function this:GetKillCount()
    return self.model.role.info.battleInfo.enemySlavedCount
end

--- 卡牌收集进度 -- value:number, progress:number value:收集数量 progress:进度(0-100)
function this:GetCardProgress()
    local ret = {}
    ret.value = self.model.role.info.collection.characterCollection

    local allCardNum = Game.Scene.Player:GetComponent("CardComponent"):GetAllCardKindCount()
    ret.progress = math.floor(ret.value / allCardNum * 100)

    return ret
end

--- 装备收集进度 -- value:number, progress:number value:收集数量 progress:进度(0-100)
function this:GetEquipProgress()
    local ret = {}
    ret.value = self.model.role.info.collection.equipmentCollection

    local allCount = Game.Scene.Player:GetComponent("EquipComponent"):GetAllEquipKindCount()
    ret.progress = math.floor(ret.value / allCount * 100)

    return ret
end

--- 敌人收集进度 -- value:number, progress:number value:收集数量 progress:进度(0-100)
function this:GetEnemyProgress()
    local ret = {}
    ret.value = self.model.role.info.collection.enemyCollection

    local allCount = table.count(table.choose(Z_Card,function(k,v)
        return v.IsMonster == 1 and v.NotOpen ~= 1
    end))

    ret.progress = math.floor(ret.value / allCount * 100)

    return ret
end

--- 战魂收集进度 -- value:number, progress:number value:收集数量 progress:进度(0-100)
function this:GetFightSoulProgress()
    local ret = {}
    ret.value = self.model.role.info.collection.fightSoulCollection

    local allFightSoulCount = Game.Scene.Player:GetComponent("FightSoulComponent"):GetAllFightSoulKindCount()
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
    return UIPublic.GetExpValue(self.model.role.info.level, 0)
end

--- 显示的exp文本
function this:GetExpText()
    -- local zPlayerLevel = Z_PlayerLevelUp[self.model.role.info.level + 1]
    local expText 
    -- if zPlayerLevel == nil then
        expText = "--/--"
    -- else
    --     expText = Game.Scene.Player.Exp .."/".. zPlayerLevel.Exp
    -- end
    return expText
end

function this:GetNameText()
    return self.model.role.info.username
end

function this:GetRegisterTime()
    return self.model.role.info.registerTime
end

function this:GetLevel()
    return self.model.role.info.level
end

function this:GetUid()
    return self.model.role.info.roleId -- 或者 参数 Id
end

function this:GetAvater()
    return self.model.role.info.avatar
end

--- 争霸次数
function this:GetPVPCount()
    local ret = self.model.role.info.roleInfoArena.attack_times
    if ret == nil then
        ret = 0
    end
    return ret
end

--- 获取最高段位
function this:GetCompetitionHighestDivison()
    local ret = self.model.role.info.roleInfoArena.highest_division
    if ret == nil or ret == 0 then
        ret = 1
    end
    return ret
end

--- 获取最高段位赛季
function this:GetCompetitionHighestDivisonSeason()
    local ret = self.model.role.info.roleInfoArena.highest_division_season
    if ret == nil or ret == 0 then
        ret = 1
    end
    return ret
end

--- 获取当前段位
function this:GetCompetitionDivison()
    local ret = self.model.role.info.roleInfoArena.current_division
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
    return self.model.role.supportUnits.cardData
end

function this:GetSupportFightSoul()
    return self.model.role.supportUnits.fightSoulEntity
end

function this:OnClickSupportCard()
    return
end

function this:OnClickSupportFightSoul()
    return
end
return this
