
---@class SocietyRole : Entity
---@field isOnLine boolean @是否在线
---@field supportUnits BattleUnit
local SocietyRole = BaseClass("SocietyRole",Entity)
local base = Entity
local this = SocietyRole

---@param self SocietyRole
local function UpdateStatue(self)
    if self.info.loginTime > self.info.logoutTime then
        self.isOnLine = true
    else
        self.isOnLine = false
    end
end

---@param SocietyRoleInfo protocol.SocietyRole
function this:Awake(SocietyRoleInfo)
    base.Awake(self)

    self.info = {}

    if SocietyRoleInfo.info ~= nil then
        self.info.roleId = SocietyRoleInfo.info.role_id
        self.info.username = SocietyRoleInfo.info.username
        self.info.level = SocietyRoleInfo.info.level
        self.info.headPortrait = SocietyRoleInfo.info.head_portrait
        self.info.avatar = ""
        if Z_HeadPortrait[SocietyRoleInfo.info.head_portrait] ~= nil then
            self.info.avatar = SocietyRoleInfo.info.head_portrait--Z_HeadPortrait[playerInfo.using_head_portrait].Resourse
        end

        self.info.loginTime = SocietyRoleInfo.info.login_time
        self.info.logoutTime = SocietyRoleInfo.info.logout_time
        self.info.registerTime = SocietyRoleInfo.info.register_time
        self.info.totalOnlineDuration = SocietyRoleInfo.info.total_online_duration

        self.info.showGirl = SocietyRoleInfo.info.show_girl

        self.info.battleInfo = {}
        self.info.battleInfo.levelStartTimes = SocietyRoleInfo.info.battle_info.level_start_times
        self.info.battleInfo.enemySlavedCount = SocietyRoleInfo.info.battle_info.enemy_slaved_count
        self.info.battleInfo.mostUsedCharacters = {}
        for _, value in ipairs(SocietyRoleInfo.info.battle_info.most_used_characters) do
            table.insert(
                self.info.battleInfo.mostUsedCharacters,
                {
                    characterId = value.character_id,
                    battleTimes = value.battle_times
                }
            )
        end

        self.info.taskInfo = {}
        self.info.taskInfo.achievementFinishCount = SocietyRoleInfo.info.task_info.achievement_finish_count

        self.info.recruitInfo = {}
        self.info.recruitInfo.totalRecruitTimes = SocietyRoleInfo.info.recruit_info.total_recruit_times

        self.info.collection = {}
        self.info.collection.characterCollection = SocietyRoleInfo.info.collection.character_collection
        self.info.collection.fightSoulCollection = SocietyRoleInfo.info.collection.fight_soul_collection
        self.info.collection.equipmentCollection = SocietyRoleInfo.info.collection.equipment_collection
        self.info.collection.enemyCollection = SocietyRoleInfo.info.collection.enemy_collection
        
        self.info.friendCount = SocietyRoleInfo.info.friend_count

        self.info.roleInfoArena = {}
        if SocietyRoleInfo.info.arena ~= nil then
            self.info.roleInfoArena.highest_division = SocietyRoleInfo.info.arena.highest_division
            self.info.roleInfoArena.highest_division_season = SocietyRoleInfo.info.arena.highest_division_season
            self.info.roleInfoArena.current_division = SocietyRoleInfo.info.arena.current_division
            self.info.roleInfoArena.attack_times = SocietyRoleInfo.info.arena.attack_times
        end
    end

    self.isRequested = SocietyRoleInfo.is_requested
    self.supportUnits = Game.Registry:NewObject("BattleUnit", SocietyRoleInfo.support_units[1])

    UpdateStatue(self)
end

---@param SocietyRoleInfo protocol.SocietyRole
function this:UpdateData(SocietyRoleInfo)
    if SocietyRoleInfo.info ~= nil then
        self.info.roleId = SocietyRoleInfo.info.role_id
        self.info.username = SocietyRoleInfo.info.username
        self.info.level = SocietyRoleInfo.info.level
        self.info.headPortrait = SocietyRoleInfo.info.head_portrait
        self.info.loginTime = SocietyRoleInfo.info.login_time
        self.info.logoutTime = SocietyRoleInfo.info.logout_time
        self.info.registerTime = SocietyRoleInfo.info.register_time
        self.info.totalOnlineDuration = SocietyRoleInfo.info.total_online_duration

        self.info.showGirl = SocietyRoleInfo.info.show_girl

        self.info.battleInfo = {}
        self.info.battleInfo.levelStartTimes = SocietyRoleInfo.info.battle_info.level_start_times
        self.info.battleInfo.enemySlavedCount = SocietyRoleInfo.info.battle_info.enemy_slaved_count
        self.info.battleInfo.mostUsedCharacters = {}
        for _, value in ipairs(SocietyRoleInfo.info.battle_info.most_used_characters) do
            table.insert(
                self.info.battleInfo.mostUsedCharacters,
                {
                    characterId = value.character_id,
                    battleTimes = value.battle_times
                }
            )
        end

        self.info.taskInfo = {}
        self.info.taskInfo.achievementFinishCount = SocietyRoleInfo.info.task_info.achievement_finish_count

        self.info.recruitInfo = {}
        self.info.recruitInfo.totalRecruitTimes = SocietyRoleInfo.info.recruit_info.total_recruit_times

        self.info.collection = {}
        self.info.collection.characterCollection = SocietyRoleInfo.info.collection.character_collection
        self.info.collection.fightSoulCollection = SocietyRoleInfo.info.collection.fight_soul_collection
        self.info.collection.equipmentCollection = SocietyRoleInfo.info.collection.equipment_collection

        self.info.friendCount = SocietyRoleInfo.info.friend_count

        self.info.roleInfoArena = {}
        if SocietyRoleInfo.info.arena ~= nil then
            self.info.roleInfoArena.highest_division = SocietyRoleInfo.info.arena.highest_division
            self.info.roleInfoArena.highest_division_season = SocietyRoleInfo.info.arena.highest_division_season
            self.info.roleInfoArena.current_division = SocietyRoleInfo.info.arena.current_division
            self.info.roleInfoArena.attack_times = SocietyRoleInfo.info.arena.attack_times
        end
    end

    self.isRequested = SocietyRoleInfo.is_requested
    self.supportUnits = Game.Registry:NewObject("BattleUnit", SocietyRoleInfo.support_units[1])

    UpdateStatue(self)
end

function this.Dispose(self)
    base.Dispose(self)
end

return this