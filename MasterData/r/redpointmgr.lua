---@class RedPointMgr
local RedPointMgr = class("RedPointMgr")
local cjson = require "cjson"

function RedPointMgr:ctor(...)
    ---@type table
    self.RedPointList = {}
end

local RedPointEnum = {
    ["TestPoint111"] = {["child"] = {}},
    ["TestPoint222"] = {["child"] = {}},
    --h5订阅有礼主界面按钮 例子
    ["H5SubscribePanel"] = {
        ["child"] = {"H5SubscribePanelSubscribe1", "H5SubscribePanelSubscribe2", "H5SubscribePanelSubscribe3"},
    },
    --h5订阅有礼 订阅 例子
    ["H5SubscribePanelSubscribe1"] = {
        ["child"] = {},
    },
    --h5订阅有礼 小程序 例子
    ["H5SubscribePanelSubscribe2"] = {
        ["child"] = {},
    },
    --h5订阅有礼 桌面 例子
    ["H5SubscribePanelSubscribe3"] = {
        ["child"] = {},
    },

    --主界面活动页面红点
    ["ActivityPanelRedPoint"] = {["child"] = {}},

    --主界面任务按钮红点
    ["TaskBtnRedJudge"] = {["child"] = {"TaskPanelDayTaskRedJudge", "TaskPanelWeekTaskRedJudge", "TaskPanelAchieveTaskRedJudge"}},
    --日常任务红点
    ["TaskPanelDayTaskRedJudge"] = {["child"] = {}},
    --周常任务红点
    ["TaskPanelWeekTaskRedJudge"] = {["child"] = {}},
    --成就任务红点
    ["TaskPanelAchieveTaskRedJudge"] = {["child"] = {"TaskPanelAchieveLevelRedJudge"}},
    --成就任务-成就等级红点
    ["TaskPanelAchieveLevelRedJudge"] = {["child"] = {}},

    --主界面船坞按钮红点
    ["DockBtnRedJudge"] = {["child"] = {}},

    --主界面科技树按钮红点
    ["ScienceTreeBtnRedJudge"] = {["child"] = {}},

    --主界面展开按钮红点
    ["ChangeBtnRedJudge"] = {["child"] = {"GraphPaperRedJudge"}},
    --主界面派遣按钮红点
    ["DispatchBtnRedJudge"] = {["child"] = {}},
    --主界面图纸制作按钮红点
    ["GraphPaperRedJudge"] = {["child"] = {}},

    --主界面邮件按钮红点
    ["MailBtnRedJudge"] = {["child"] = {}},

    --主界面家园按钮红点
    ["HomeBtnRedJudge"] = {["child"] = {}},

    --主界面仓库按钮红点
    ["WarehouseBtnRedJudge"] = {["child"] = {}},

    --通知红点判断
    ["NoticeRedJudge"] = {["child"] = {}},

    ["QuestionRedJudge"] = {["child"] = {}},

    -- ["b1b"] = {["child"] = {"b21b", "b22b"}},
    -- ["b21b"] = {["child"] = {"b31b", "b32b" }},
    -- ["b22b"] = {["child"] = {"b33b", "b34b", "b35b"}},
    -- ["b31b"] = {["child"] = {}},
    -- ["b32b"] = {["child"] = {}},
    -- ["b33b"] = {["child"] = {}},
    -- ["b34b"] = {["child"] = {}},
    -- ["b35b"] = {["child"] = {}},
}

function RedPointMgr:b1b()
    return UIMgr:GetUI("MainPanel"):getRedTest(1)
end
function RedPointMgr:b21b()
    return UIMgr:GetUI("MainPanel"):getRedTest(21)
end
function RedPointMgr:b22b()
    return UIMgr:GetUI("MainPanel"):getRedTest(22)
end
function RedPointMgr:b31b()
    return UIMgr:GetUI("MainPanel"):getRedTest(31)
end
function RedPointMgr:b32b()
    return UIMgr:GetUI("MainPanel"):getRedTest(32)
end
function RedPointMgr:b33b()
    return UIMgr:GetUI("MainPanel"):getRedTest(33)
end
function RedPointMgr:b34b()
    return UIMgr:GetUI("MainPanel"):getRedTest(34)
end
function RedPointMgr:b35b()
    return UIMgr:GetUI("MainPanel"):getRedTest(35)
end

--注册红点 会递归同时注册全部子节点
function RedPointMgr:Register(name, obj, func)
    local nowRedPoint = RedPointEnum[name]
    if not self.RedPointList[name] then
        self.RedPointList[name] = nowRedPoint
    end
    if func then
        self.RedPointList[name]["func"] = func
    end
    if obj then
        self.RedPointList[name]["obj"] = obj
    end

    --刷新红点数据
    self:RefreshByTopParent(name, obj, func)
end

--从父节点遍历全部子节点向下刷新
function RedPointMgr:RefreshByTopParent(name)
    -- LuaLogger.ds("!!!!!!!!!!!!", name)
    if not self.RedPointList[name] then
        self.RedPointList[name] = RedPointEnum[name]
    end
    self:SingleRefresh(name)
    local nowRedPoint = self.RedPointList[name]
    for k, v in pairs(nowRedPoint.child) do
        self:RefreshByTopParent(v)
        if self.RedPointList[v].state == true then
            nowRedPoint.state = self.RedPointList[v].state
        end
    end
    --回调
    if self.RedPointList[name]["func"] and UICommonUtils.Checkobj(self.RedPointList[name]["obj"].gameObject) then
        self.RedPointList[name]["func"](nowRedPoint.state)
    end
end

--从子节点向上刷新
---@param childName string 红点名称
---@param isRefreshed boolean 是否已经刷新过
function RedPointMgr:RefreshByChild(childName)
    -- LuaLogger.ds("!!!!!!!!!!!!", name)
    if not self.RedPointList[childName] then
        self.RedPointList[childName] = RedPointEnum[childName]
    end
    local childRedpoint = self.RedPointList[childName]
    --寻找所有父节点
    local parentList = self:FindAllParent(childName)
    for _, singleParent in pairs(parentList) do
        self:SingleRefresh(singleParent)
        local parentRedpoint = self.RedPointList[singleParent]
        --若父节点没有红
        if parentRedpoint.state ~= true then
            --若子节点有红点 则父节点必定有红点
            if self.RedPointList[childName].state == true then
                parentRedpoint.state = true
            else
                --若子节点没有红点 则父节点的红点状态需要重新计算
                for _, v in pairs(parentRedpoint.child) do
                    if self.RedPointList[v].state == true then
                        parentRedpoint.state = true
                        break
                    end
                end
            end
        end
        if self.RedPointList[singleParent]["func"] and UICommonUtils.Checkobj(self.RedPointList[singleParent]["obj"].gameObject) then
            self.RedPointList[singleParent]["func"](parentRedpoint.state)
        end
        --继续递归找父节点的上级
        self:RefreshByChild(singleParent)
    end
end

function RedPointMgr:SetRedDotState(key, state)
    if self:GetRedDotState(key) == state then
        return
    end
    RedDotManager.SetRedDotState(key, state)
end

function RedPointMgr:GetRedDotState(key)
    return RedDotManager.GetRedDotState(key)
end

-- --寻找最高层红点
-- function RedPointMgr:FindMostTop(name)
--     --LuaLogger.ds("寻找最高层红点", name)
--     local redPointObj = self.RedPointList[name]
--     if not redPointObj then
--         return
--     end
--     if self:FindSingleParent(name) then
--         return self:FindMostTop(self:FindSingleParent(name))
--     else
--         return name
--     end
-- end

-- --寻找上一级的父节点
-- function RedPointMgr:FindSingleParent(name)
--     --LuaLogger.ds("寻找上一级红点", name)
--     for k, v in pairs(RedPointEnum) do
--         if tablex.contains(v.child, name) then
--             --LuaLogger.ds("上一级红点   ", k)
--             if self.RedPointList[k] then
--                 return k
--             end
--         end
--     end
--     --LuaLogger.ds("已经是最高层", name)
--     return false
-- end

--寻找所有父节点
function RedPointMgr:FindAllParent(name)
    --LuaLogger.ds("寻找上一级红点", name)
    local parentList = {}
    for k, v in pairs(RedPointEnum) do
        if tablex.contains(v.child, name) then
            --LuaLogger.ds("上一级红点   ", k)
            if self.RedPointList[k] then
                table.insert(parentList, k)
            end
        end
    end
    return parentList
end

--刷新节点
--刷新自身所有子节点 和父节点及其父节点
function RedPointMgr:Refresh(name)
    --LuaLogger.ds('红点刷新', name)
    local redPointObj = self.RedPointList[name]
    if not redPointObj then
        return
    end
    self:RefreshByTopParent(name)
    self:RefreshByChild(name, true)
end

---刷新单层节点
---@param name any
function RedPointMgr:SingleRefresh(name)
    --LuaLogger.ds("单层红点刷新", name.. debug.traceback())
    local nowRedPoint = self.RedPointList[name]
    if nowRedPoint then
        nowRedPoint.state = self[name]()
    end
end

function RedPointMgr:GetRedPointState(name)
    return self.RedPointList[name].state
end


--------------------------每个红点对应的的判断逻辑--------------------------


-------------------------------MainPanel-------------------------------

--活动界面红点逻辑
function RedPointMgr:ActivityPanelRedPoint()
    local idList = UICommonUtils.GetActivityShowIdList(GE.ActivityFunctionType.ActivityPanel)
    for _, id in pairs(idList) do
        if RedPointMgr:getRedPointByActivityId(id) == true then
            return true
        end
    end
    return false
end

--根据活动id判断是否有红点
function RedPointMgr:getRedPointByActivityId(activityId)
    local cfg = Config.GetActivityInfo(activityId)
    if not cfg then
        return false
    end
    --首充红点 有待领取的奖励
    if cfg.Type == GE.ActivityType.FirstCharge then
        local taskgroup = cfg.TaskGroup[1]
        local taskList = Config.GetTaskInfoByTaskTypeAndGroup(GE.MissionType.FirstCharge, taskgroup)
        for k, missionCfg in pairs(taskList) do
            local missionData = Me:getMissionListById(missionCfg.id)
            if missionData and missionData.state == GE.MissionState.Unclaimed then
                return true
            end
        end
    elseif cfg.Type == GE.ActivityType.HeroExchange then
        local taskgroup = cfg.TaskGroup[1]
        local taskList = Config.GetTaskInfoByTaskTypeAndGroup(GE.MissionType.HeroExchange, taskgroup)
        for k, missionCfg in pairs(taskList) do
            local missionData = Me:getMissionListById(missionCfg.id)
            if missionData and missionData.state == GE.MissionState.Unclaimed then
                return true
            end
        end
    elseif cfg.Type == GE.ActivityType.PortConstruction then
        local taskgroup = cfg.TaskGroup[1]
        local taskList = Config.GetTaskInfoByTaskTypeAndGroup(GE.MissionType.PortConstruction, taskgroup)
        for k, missionCfg in pairs(taskList) do
            local missionData = Me:getMissionListById(missionCfg.id)
            if missionData and missionData.state == GE.MissionState.Unclaimed then
                return true
            end
        end
    elseif cfg.Type == GE.ActivityType.Sign then
        local signId = cfg.activityPara[1]
        local signData = Me:getSignDataById(signId)
        if not signData then
            return false
        end
        for i = 1, signData.signIndex do
            if tablex.find(signData.alreadyAwards, i) == false then
                return true
            end
        end
    --指挥官等级
    elseif cfg.Type == GE.ActivityType.CommanderRank then
        local minipassData = Me:getMiniPassInfo(cfg.id)
        local isBuy = minipassData and minipassData.openExtraReward or false

        local taskgroup = cfg.TaskGroup[1]
        local taskList = Config.GetTaskInfoByTaskTypeAndGroup(GE.MissionType.CommanderRank, taskgroup)
        for k, missionCfg in pairs(taskList) do
            local missionData = Me:getMissionListById(missionCfg.id)
            if missionData and missionData.state == GE.MissionState.Unclaimed then
                --普通阶段奖励
                if missionCfg.type == 1 then
                    return true
                --付费阶段奖励
                elseif missionCfg.type == 2 and isBuy then
                    return true
                end
            end
        end
    end
    --活动是否看过
    local watchedList = MyPrefs:GetString(GE.LocalCustomDataKey.WatchedActivityList, "")
    local data = {}
    if watchedList ~= "" then
        data = cjson.decode(watchedList)
    end
    if data[tostring(activityId)] ~= true then
        return true
    end
    return false
end

--船坞按钮
function RedPointMgr:DockBtnRedJudge()
    local state = false
    local roleList = Me:getHeroList()
    for _, roleServerData in pairs(roleList) do
        if RedPointMgr:DockRolePanelRoleListRedJudge(roleServerData.id) == true then
            if RedPointMgr:GetRedDotState("DockBtnRedJudge".. roleServerData.id) == false then
                state = true
            end
        else
            RedPointMgr:SetRedDotState("DockBtnRedJudge".. roleServerData.id, false)
        end
    end
    return state
end

--科技树按钮
function RedPointMgr:ScienceTreeBtnRedJudge()
    for i = 1, 4 do
        if RedPointMgr:TechnologyTreePageRedJudge(i) == true then
            return true
        end
    end
    return false
end

--任务按钮
function RedPointMgr:TaskBtnRedJudge()
    return false
end


--展开按钮
function RedPointMgr:ChangeBtnRedJudge()
    return false
end

--派遣按钮
function RedPointMgr:DispatchBtnRedJudge()
    --是否已开启
    local functionState = Me:getFunctionOpenStateById(GE.FunctionOpenModule.ShipDispatch)
    if functionState == GE.FunctionOpenState.Lock then
        return false
    end

    --是否生成了新的随机任务
    if RedPointMgr:GetRedDotState("RandomDispatchEventRed") == true then
        return true
    end
    --是否有派遣已完成
    local dispatchTaskList = Me:getDispatchTaskList()
    for id, info in pairs(dispatchTaskList) do
        if info.state == GE.DispatchState.Finish then
            return true
        end
    end
    return false
end

--派遣任务按钮
function RedPointMgr:DispatchTaskBtnRedJudge()
    --是否生成了新的随机任务
    if RedPointMgr:GetRedDotState("RandomDispatchEventRed") == true then
        return true
    end
    --是否有派遣已完成
    local dispatchTaskList = Me:getDispatchTaskList()
    for id, info in pairs(dispatchTaskList) do
        if info.state == GE.DispatchState.Finish then
            local dispatchCfg = Config.GetDispatchInfo(info.dispatchId)
            if dispatchCfg and dispatchCfg.type == GE.DispatchType.Random then
                return true
            end
        end
    end
    local dispatchCfg = Config.GetAllConfig("DispatchTable")
    for _, cfg in pairs(dispatchCfg) do
        if cfg.type == 2 then
            local pregress = Me:getDispatchChapterProgress(cfg.id)
            if pregress == 1 then
                local isReceive = Me:dispatchChapterRewardIsReceive(cfg.id)
                if isReceive == false then
                    return true
                end
            end
        end
    end
    return false
end

--邮件按钮
function RedPointMgr:MailBtnRedJudge()
    if RedPointMgr:GetRedDotState("NewMailRed") == false then
        return false
    end
    -- if PlayerPrefs.GetInt("MailBtnRed"..os.date("%Y-%m-%d",os.time()), 0) == 1 then
    --     return false
    -- end
    return true
end

--家园按钮
function RedPointMgr:HomeBtnRedJudge()
    local state = false
    if RedPointMgr:HomeBulidRedJudge(10003) then
        state = true
    end
     if RedPointMgr:HomeBulidRedJudge(10009) then
        state = true
    end
     if RedPointMgr:HomeBulidRedJudge(10004) then
        state = true
    end
    return state
end

--仓库按钮
function RedPointMgr:WarehouseBtnRedJudge()
    if RedPointMgr:WarePanelTypeBtnRedJudge(GE.ItemTypeIndex.weapon) then
        return true
    end
    if RedPointMgr:WarePanelTypeBtnRedJudge(GE.ItemTypeIndex.equip) then
        return true
    end
    if RedPointMgr:WarePanelTypeBtnRedJudge(GE.ItemTypeIndex.debris) then
        return true
    end
    if RedPointMgr:WarePanelTypeBtnRedJudge(GE.ItemTypeIndex.materials) then
        return true
    end
    if RedPointMgr:WarePanelTypeBtnRedJudge(GE.ItemTypeIndex.item) then
        return true
    end
    return false
end

-------------------------------DockRolePanel-------------------------------
--角色列表红点
function RedPointMgr:DockRolePanelRoleListRedJudge(roleId)
    --船坞信息页签红点
    if self:DockRolePanelRoleMsgBtnRedJudge(roleId) then
        return true
    end
    if self:DockRolePanelAffectionlBtnRedJudge(roleId) then
        return true
    end
    if self:DockRolePanelFileBtnRedJudge(roleId) then
        return true
    end
    return false
end

--船坞信息页签红点
function RedPointMgr:DockRolePanelRoleMsgBtnRedJudge(roleId)
    --角色是否可升级
    if self:RoleCanLvUp(roleId) then
        return true
    end
    --角色是否可升星
    if self:RoleCanStarUp(roleId) then
        return true
    end
    --角色天赋树是否可升级
    if self:RoleTalentTreeCanUp(roleId) then
        return true
    end
    --武器可装备
    if self:RoleWeaponSlotRedJudge(roleId, 1) or self:RoleWeaponSlotRedJudge(roleId, 2) then
        return true
    end
    --装备可装备
    for i = 1, 4 do
        if self:RoleEquipSlotRedJudge(roleId, i) then
            return true
        end
    end
    return false
end

--角色是否有可赠送的好感度礼物（配置存在且背包数量>0）
function RedPointMgr:RoleHasAvailableAffectionGift(roleId)
    local roleCfg = Config.GetCharacterInfo(roleId)
    if not roleCfg then
        return false
    end
    local affectionConfig = Config.GetAffectionInfo(roleCfg.affection)
    if not affectionConfig or not affectionConfig.Gift or not next(affectionConfig.Gift) then
        return false
    end
    for _, giftId in pairs(affectionConfig.Gift) do
        local giftItemData = Me:getItemById(giftId)
        if giftItemData and giftItemData.num > 0 then
            return true
        end
    end
    return false
end

--船坞羁绊页签红点
function RedPointMgr:DockRolePanelAffectionlBtnRedJudge(roleId)
    if not self:RoleHasAvailableAffectionGift(roleId) then
        return false
    end
    if self:RoleAffectionCanUp(roleId) then
        return true
    end
    --角色好感度道具是否满足可升级
    if self:RoleAffectionItemCanUp(roleId) then
        return true
    end
    return false
end

--档案页签红点
function RedPointMgr:DockRolePanelFileBtnRedJudge(roleId)
    if self:DockRolePanelFileToggleRedJudge(roleId) then
        return true
    end
    if self:DockRolePanelCvToggleRedJudge(roleId) then
        return true
    end
    return false
end

--档案toggle红点
function RedPointMgr:DockRolePanelFileToggleRedJudge(roleId)
    local filesList = Config.GetArchiveInfoById(roleId)
    if not filesList then
        return false
    end
    for _, fileCfg in pairs(filesList) do
        if self:RoleFileRedJudge(roleId, fileCfg.id) then
            return true
        end
    end
    return false
end

--语音toggle红点
function RedPointMgr:DockRolePanelCvToggleRedJudge(roleId)
    local soundList = Config.GetAffectionSoundInfoById(roleId)
    if not soundList then
        return false
    end
    for _, soundCfg in pairs(soundList) do
        if self:RoleCvRedJudge(roleId, soundCfg.id) then
            return true
        end
    end
    return false
end

--角色是否可升级
function RedPointMgr:RoleCanLvUp(roleId)
    local roleData = Me:getPlayerHero(roleId)
    if not roleData then
        return false
    end
    local curLv = roleData.level
    local nextLv = curLv + 1
    local userLevel = Me:getUserLevel()  -- 用户等级
    if nextLv > userLevel then
        return false
    end
    local lvCfgInfo = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.role, nextLv)
    local needExp = lvCfgInfo.exp_sum - roleData.exp
    local expItem = Me:getItemById(110011)
    local hasExp = expItem and expItem.num or 0
    if hasExp < needExp then
        return false
    end
    return true
end

--角色是否可升星
function RedPointMgr:RoleCanStarUp(roleId)
    local roleCfg =Config.GetCharacterInfo(roleId)
    if not roleCfg then
        return false
    end
    local roleData = Me:getPlayerHero(roleId)
    if not roleData then
        return false
    end
    local costCfg = roleCfg.patchCost[roleData.star + 1]
    if not costCfg then
        return false
    end
    local itemId = costCfg[2]
    local neddNum = costCfg[3]
    local itemData = Me:getItemById(itemId)
    if not itemData or itemData.num < neddNum then
        return false
    end
    return true
end

--角色天赋树是否可升级
function RedPointMgr:RoleTalentTreeCanUp(roleId)
    --LuaLogger.e("检测角色天赋树是否可升级:".. roleId)
    local roleCfg = Config.GetCharacterInfo(roleId)
    if not roleCfg then
        return false
    end
    local roleData = Me:getPlayerHero(roleId)
    if not roleData then
        return false
    end
    if roleData.level <= 1 then
        return false
    end
    local treeInfo =  Config.GetTalentTreeInfoByTreeId(roleCfg.talentTree)
    if not treeInfo then
        return false
    end
    if self:RoleTalentTreeStageCanUp(roleId) then
        return true
    end
    for _, treeCfg in pairs(treeInfo) do
        local canUp = true
        --检测是否重复获得
        if tablex.find(roleData.talentTreeList, treeCfg.id) then
            --LuaLogger.e("角色天赋树已获得:".. roleId..".".. treeCfg.id)
            canUp = false
        end
         --检测前置条件
        for _, value in pairs(treeCfg.unlock) do
            if not tablex.find(roleData.talentTreeList, value) then
                --LuaLogger.e("角色天赋树前置条件未满足:".. roleId..".".. treeCfg.id)
                canUp = false
            end
        end
        --检测消耗资源
        local cost = treeCfg.cost or {}
        if next(cost) then
            if not Me:checkItemListEnough2(cost) then
                --LuaLogger.e("角色天赋树消耗资源不足:".. roleId..".".. treeCfg.id)
                canUp = false
            end
        end
        --检测消耗特殊消耗
        local isUnlocked = Me:isSiblingTalentUnlocked(roleData.talentTreeList, treeCfg.id, treeCfg.unlock)
        local specialCost = treeCfg.specialCost or {}
        if isUnlocked and next(specialCost) then
            if not Me:checkItemEnough2(specialCost) then
                --LuaLogger.e("角色天赋树特殊消耗资源不足:".. roleId..".".. treeCfg.id)
                canUp = false
            end
        end
        if next(treeCfg.extraUnlock) and treeCfg.extraUnlock[1] == GE.TreeExtraUnlock.Level then
            if roleData.level < treeCfg.extraUnlock[2] then
                --LuaLogger.e("角色天赋树等级未满足:".. roleId..".".. treeCfg.id)
                canUp = false
            end
        end
        if canUp then
            --LuaLogger.e("角色天赋树可以升级:".. roleId..".".. treeCfg.id)
            return true
        end
    end
    return false
end


--角色天赋树阶段是否可升级
function RedPointMgr:RoleTalentTreeStageCanUp(roleId)
    local roleCfg = Config.GetCharacterInfo(roleId)
    if not roleCfg then
        return false
    end
    local roleData = Me:getPlayerHero(roleId)
    if not roleData then
        return false
    end
    local treeStageCfgList = Config.GetTalentTreeStageInfoByTreeId(roleCfg.talentTree)
    if not treeStageCfgList then
        return false
    end
    for _, stageCfg in pairs(treeStageCfgList) do
        if self:RoleTalentTreeStageLevelCanUp(roleId, stageCfg.stageId) then
            return true
        end
    end
    return false
end

--角色天赋树具体阶段是否可升级
function RedPointMgr:RoleTalentTreeStageLevelCanUp(roleId, stageId)
    --已激活
    local isStageUnlocked = Me:getTalentTreeStageDataById(roleId, stageId) ~= nil
    if isStageUnlocked == true then
        return false
    end
    local roleCfg = Config.GetCharacterInfo(roleId)
    if not roleCfg then
        return false
    end
    local roleData = Me:getPlayerHero(roleId)
    if not roleData then
        return false
    end
    --当前阶段所有节点全激活
    local stageConfigs = Config.GetTalentTreeInfoByTreeIdStageId(roleCfg.talentTree, stageId)
    if stageConfigs then
        for _, value in pairs(stageConfigs) do
            if not tablex.find(roleData.talentTreeList, value.id) then
                return false
            end
        end
    end
    return true
end

--角色好感度可升级
function RedPointMgr:RoleAffectionCanUp(roleId)
    local roleData = Me:getPlayerHero(roleId)
    if not roleData then
        return false
    end
    local curLevelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.affection, roleData.affectionLevel)
    if not curLevelData then
        return false
    end
    local maxLevel = curLevelData.max_level
    if roleData.affectionExp >= curLevelData.exp and roleData.affectionLevel < maxLevel then
        return true
    end
    return false
end

--角色好感度道具满足可升级
function RedPointMgr:RoleAffectionItemCanUp(roleId)
    local roleData = Me:getPlayerHero(roleId)
    local roleCfg = Config.GetCharacterInfo(roleId)
    if not roleData or not roleCfg then
        return false
    end
    local curLevelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.affection, roleData.affectionLevel)
    if not curLevelData then
        return false
    end
    local maxLevel = curLevelData.max_level
    --如果已经达到最大等级或者当前经验已经满足升级条件，则不需要再判断
    if roleData.affectionLevel >= maxLevel or roleData.affectionExp >= curLevelData.exp then
        return false
    end
    local addExp = 0

    local affectionConfig = Config.GetAffectionInfo(roleCfg.affection)
    if affectionConfig then
        for _, giftId in pairs(affectionConfig.Gift) do
            local giftItemData = Me:getItemById(giftId)
            local giftItemCfg = Config.GetItemInfo(giftId)
            if giftItemCfg and giftItemData and giftItemData.num > 0 then
                addExp = addExp + (giftItemCfg.effect[2] * giftItemData.num)
            end
        end
    end
    if roleData.affectionExp + addExp >= curLevelData.exp then
        return true
    end
    return false
end

--角色档案红点
function RedPointMgr:RoleFileRedJudge(roleId, fileId)
    local roleData = Me:getPlayerHero(roleId)
    if not roleData then
        return false
    end
    local fileCfg = Config.GetArchiveInfo(fileId)
    if not fileCfg then
        return false
    end
    if fileCfg.unlock and next(fileCfg.unlock) and fileCfg.unlock[1] == GE.FilesUnlockType.affectionLevel then
        if roleData.affectionLevel < fileCfg.unlock[2] then
            return false
        end
    end
    if RedPointMgr:GetRedDotState("RoleArchiveCheck".. fileId) == true then
        return false
    end
    return true
end

--角色语音红点
function RedPointMgr:RoleCvRedJudge(roleId, soundId)
    local roleData = Me:getPlayerHero(roleId)
    if not roleData then
        return false
    end
    local soundCfg = Config.GetAffectionSoundInfo(soundId)
    if not soundCfg or not soundCfg.unlock or tablex.size(soundCfg.unlock) == 0 then
        return false
    end
    if soundCfg.unlock[1] == GE.FilesUnlockType.affectionLevel then
        if roleData.affectionLevel < soundCfg.unlock[2] then
            return false
        end
    else
        return false
    end
    if RedPointMgr:GetRedDotState("RoleAffectionSoundCheck".. soundId) == true then
        return false
    end
    return true
end

--角色武器红点
function RedPointMgr:RoleWeaponSlotRedJudge(roleId, pos)
    local roleData = Me:getPlayerHero(roleId)
    if not roleData then
        return false
    end
    if roleData.level <= 1 then
        return false
    end
    if pos == 2 then
        local weaponLock = Me:getWeaponLockStateById(roleId)
        if weaponLock == false then
            return false
        end
    end
    local weaponId = roleData.carryWeapon[pos]
    if weaponId ~= 0 then
        return false
    end
    local weaponMapData = Me:getAllWeaponData()
    if not weaponMapData or tablex.size(weaponMapData) == 0 then
        return false
    end
    local roleCfg = Config.GetCharacterInfo(roleId)
    if not roleCfg then
        return false
    end
    
    -- 使用角色数据中的负载值（已包含天赋树加成）
    local maxLoad = roleData.load or 0
    
    -- 计算另一个武器槽已装备的武器的负载值
    local otherPartId = pos == 1 and 2 or 1
    local otherWeaponId = roleData.carryWeapon[otherPartId] or 0
    local otherWeaponLoad = 0
    if otherWeaponId ~= 0 then
        local otherweaponData = Me:getWeaponDataById(otherWeaponId)
        if otherweaponData then
            local otherweaponConfig = Config.GetWeaponInfo(otherweaponData.cid)
            if otherweaponConfig and otherweaponConfig.load then
                otherWeaponLoad = otherweaponConfig.load
            end
        end
    end
    
    local count = 0
    for _, weaponData in pairs(weaponMapData) do
        if weaponData.ownerId == 0 then
            local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
            if weaponConfig and tablex.contains(roleCfg.useWeaponType,weaponConfig.type) then
                -- 检查负载值是否满足：当前武器负载 + 另一个槽位武器负载 <= 最大负载
                local weaponLoad = weaponConfig.load or 0
                local totalLoad = weaponLoad + otherWeaponLoad
                if maxLoad >= totalLoad then
                    count = count + 1
                end
            end
        end
    end
    if count == 0 then
        return false
    end
    return true
end

--角色装备红点
function RedPointMgr:RoleEquipSlotRedJudge(roleId, pos)
    local roleData = Me:getPlayerHero(roleId)
    if not roleData then
        return false
    end
    if roleData.level <= 1 then
        return false
    end
    local equipId =  roleData.carryEquip[pos]
    if equipId ~= 0 then
        return false
    end
    local roleCfg = Config.GetCharacterInfo(roleId)
    if not roleCfg then
        return false
    end
    local equipDataList = Me:getEquipListByPart(pos, roleCfg.useEquipType)
    if not equipDataList or tablex.size(equipDataList) == 0 then
        return false
    end
    local count = 0
    for _, v in pairs(equipDataList) do
        if v.ownerId == 0 then
            count = count + 1
        end
    end
    if count == 0 then
        return false
    end
    return true
end

-------------------------------Technology-------------------------------

--科技树page红点
function RedPointMgr:TechnologyTreePageRedJudge(pageId)
    local treeNodeDataList = Me:getTechnologyTreeNodeInfoByPageId(pageId)
    for groupId, nodeData in pairs(treeNodeDataList) do
        local canUp = Me:getTechTreeNodeCanUp(groupId, true)
        if canUp then
            return true
        end
    end
    return false
end 

-------------------------------task-------------------------------

--日常任务页签
function RedPointMgr:TaskPanelDayTaskRedJudge()
    local missionList = Me:getMissionList()
    for k, v in pairs(missionList) do
        local taskConfig = Config.GetTaskTableInfo(v.id)
        if taskConfig and taskConfig.taskType == GE.MissionType.EveryDay and taskConfig.type == GE.DayTaskType.DayCommon then
            if v.state == GE.MissionState.Unclaimed then
                return true
            end
        end
    end
    return false
end

--周常任务页签
function RedPointMgr:TaskPanelWeekTaskRedJudge()
    local missionList = Me:getMissionList()
    for k, v in pairs(missionList) do
        local taskConfig = Config.GetTaskTableInfo(v.id)
        if taskConfig and taskConfig.taskType == GE.MissionType.EveryWeek and taskConfig.type == GE.WeekTaskType.WeekCommon then
            if v.state == GE.MissionState.Unclaimed then
                return true
            end
        end
    end
    return false
end

--成就任务页签
function RedPointMgr:TaskPanelAchieveTaskRedJudge()
    local missionList = Me:getMissionList()
    for k, v in pairs(missionList) do
        local taskConfig = Config.GetTaskTableInfo(v.id)
        if taskConfig and taskConfig.taskType == GE.MissionType.Achieve then
            if v.state == GE.MissionState.Unclaimed then
                return true
            end
        end
    end
    return false
end

--成就积分
function RedPointMgr:TaskPanelAchieveLevelRedJudge()
    local missionList = Me:getMissionList()
    for k, v in pairs(missionList) do
        local taskConfig = Config.GetTaskTableInfo(v.id)
        if taskConfig and taskConfig.taskType == GE.MissionType.AchieveLevel then
            if v.state == GE.MissionState.Unclaimed then
                return true
            end
        end
    end
    return false
end

--成就任务类型toggle
function RedPointMgr:TaskPanelAchieveToggleRedJudge(type)
    local missionList = Me:getMissionList()
    for k, v in pairs(missionList) do
        local taskConfig = Config.GetTaskTableInfo(v.id)
        if taskConfig and taskConfig.taskType == GE.MissionType.Achieve and taskConfig.type == type then
            if v.state == GE.MissionState.Unclaimed then
                return true
            end
        end
    end
    return false
end


-------------------------------HomeLand-------------------------------
--家园建筑红点
function RedPointMgr:HomeBulidRedJudge(consId)
    local cfg = Config.GetConstructionInfo(consId)
    if cfg == nil then
       return false 
    end
    if cfg.titlevisible == 1 then
        return false
    end

    --角色可部署
    if self:CanDisposeRole(consId) then
        return true
    end
    --建筑可升级
    if self:HomeBulidCanUp(consId) then
        return true
    end
    return false
    --家园可升级
end

--可部署角色
function RedPointMgr:CanDisposeRole(consId)
    local disposeRoleList = Me:getDisposeRole(consId)
    if not disposeRoleList then
        return false
    end
    local constructData = Me:getConstructionDataById(consId)
    if not constructData or constructData.level <= 0 then
        return false
    end
    local constructLvCfg = Config.GetConstructionLevelInfoByTypeLevel(consId, constructData.level)
    if not constructLvCfg then
        return false
    end
    local unlockList = {}
    for _, ef in pairs(constructLvCfg.effect) do
        if ef[1] == GE.HomeBuildEffectType.UnlockPos then
            unlockList = tablex.copy(ef) --解锁的角色位置
        end
    end
    table.remove(unlockList, 1) --移除第一个元素
    local count = 0
    for index, roleId in pairs(disposeRoleList) do
        if tablex.find(unlockList, index) and roleId == 0 then
            count = count + 1
        end
    end
    if count == 0 then
        return false
    end
    count = 0
    local heroList = ClientData:GetRoleList()
    local homeDisposeRoleList = Me:getInHomeDisposeRole()
	for k, v in pairs(heroList) do
		if tablex.find(homeDisposeRoleList, v.id) == false then
			count = count + 1
		end
	end
    if count == 0 then
        return false
    end
    return true
end

--家园可升级
function RedPointMgr:HomeBulidCanUp(consId)
    local consData = Me:getConstructionDataById(consId)
    local maxLv = Me:getHomeBuildingMaxLevel(consId)
    if not consData or consData.level >= maxLv then
        return false
    end
    local constructLvCfg = Config.GetConstructionLevelInfoByTypeLevel(consId, consData.level + 1)
    if not constructLvCfg then
        return false
    end
    --检测升级所需资源
    local itemList = {}
    for _, v in pairs(constructLvCfg.cost) do
        table.insert(itemList, {
            id = v[2],
            num = v[3],
            type = v[1]
        })
    end
    table.insert(itemList, {
        id = constructLvCfg.costResource[2],
        num = constructLvCfg.costResource[3],
        type = constructLvCfg.costResource[1]
    })
    if not Me:checkItemListEnough(itemList) then
        return false
    end
    return true
end

-------------------------------Item-------------------------------

--图纸
function RedPointMgr:GraphPaperRedJudge()
    local state = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.WeaponMake)
    if state == GE.FunctionOpenState.Lock then
        return false
    end
    local itemList = ClientData:getItemMap()
    for key, value in pairs(itemList) do
        if value.num > 0 then
            local itemCfg = Config.GetItemInfo(key)
            if itemCfg and itemCfg.useType == 8 then
                if RedPointMgr:GetRedDotState("NewItem".. itemCfg.id) == false then
                    return true
                end
            end
        end
    end
    return false
end

--仓库页签
function RedPointMgr:WarePanelTypeBtnRedJudge(type)
    if type == GE.ItemTypeIndex.weapon then
        for key, value in pairs(Me:getAllWeaponData()) do
            if RedPointMgr:GetRedDotState("NewWeapon".. value.id) == false then
                return true
            end
        end
    elseif type == GE.ItemTypeIndex.equip then
        for key, value in pairs(Me:getAllEquipData()) do
            if RedPointMgr:GetRedDotState("NewEquip".. value.id) == false then
                return true
            end
        end
    else
        for key, value in pairs(ClientData:getItemMap()) do
            if value.num > 0 then
                local itemCfg = Config.GetItemInfo(key)
                if itemCfg and itemCfg.isShow == 1 and itemCfg.type == type then
                    if RedPointMgr:GetRedDotState("NewItem".. itemCfg.id) == false then
                        return true
                    end
                end
            end
        end
    end
    return false
end
--------------------------------------------------------------------------

-------------------------------Notice-------------------------------
--公告红点
function RedPointMgr:NoticeRedJudge()
    local noticeList = ClientData:GetAllNoticeData()
    for _, notice in pairs(noticeList or {}) do
        local canShow = true
        if notice.start_time and notice.start_time ~= "" then
            local startTime = DLuaUtil.ParseConfigTimeClient(notice.start_time)
            if startTime > os.time() then
                canShow = false
            end
        end
        if notice.end_time and notice.end_time ~= "" then
            local endTime = DLuaUtil.ParseConfigTimeClient(notice.end_time)
            if endTime < os.time() then
                canShow = false
            end
        end
        if canShow and notice.id and (RedPointMgr:GetRedDotState("Notice"..notice.id) == false) then
            return true
        end
    end
    return false
end
--------------------------------------------------------------------

-------------------------------SeaMapPanel-------------------------------
--判断指定章节是否有未领取的奖励
function RedPointMgr:ChapterRewardRedJudge(chapterId)
    local chapterData = Config.GetChapterInfo(chapterId)
    if not chapterData then
        return false
    end
    
    --计算章节当前获得的星数
    local nowStar = 0
    for _, level in pairs(chapterData.PveLevel) do
        local levelConfig = Config.GetPveLevelInfo(level[1])
        if levelConfig and levelConfig.type == GE.LevelType.Battle then
            local levelData = Me:getLevelDataByid(level[1])
            if levelData then
                nowStar = nowStar + levelData.star
            end
        end
    end
    
    --检查是否有可领取的奖励
    local starCfgList = Config.GetChapterStarInfoByChapterId(chapterId)
    if starCfgList and next(starCfgList) then
        for i = 1, 3 do
            local starConfig = starCfgList[i]
            if starConfig then
                local needStar = starConfig.complete[2]
                local isGet = Me:getChapterAwardDataById(starCfgList[i].id) and true or false
                --如果星数达到要求且未领取，则显示红点
                if nowStar >= needStar and not isGet then
                    return true
                end
            end
        end
    end
    
    return false
end

--判断指定难度模式下是否有章节奖励未领取
function RedPointMgr:DifficultModeRedJudge(mode)
    local Map = Config.GetAllConfig("MapTable")
    if not Map then
        return false
    end
    
    for _, mapData in pairs(Map) do
        local chapterCfg = Config.GetChapterInfoByMap(mapData.id)
        if chapterCfg then
            for _, chapterData in pairs(chapterCfg) do
                --mode 1:普通模式 2:困难模式
                if mode == 1 and chapterData.Type == GE.ChapterType.MainStory then
                    if self:ChapterRewardRedJudge(chapterData.id) then
                        return true
                    end
                elseif mode == 2 and chapterData.Type == GE.ChapterType.MainDifficult then
                    if self:ChapterRewardRedJudge(chapterData.id) then
                        return true
                    end
                end
            end
        end
    end
    
    return false
end
--------------------------------------------------------------------


--------------------------------------------------------------------
---通行证小红点

function RedPointMgr:PassPanelWeekTaskRedJudge(activityId)
    if activityId == 0 or activityId == nil then
        return false
    end
    local activityData = Config.GetActivityInfo(activityId)
    local missionList = Me:getMissionList()
    for k, v in pairs(missionList) do
        local taskConfig = Config.GetTaskTableInfo(v.id)
        if taskConfig and taskConfig.taskType == GE.MissionType.PassTask then
            if taskConfig.refreshType == 2 and v.state == GE.MissionState.Unclaimed and tablex.contains(activityData.TaskGroup,taskConfig.taskGroup) then
                return true
            end
        end
    end
    return false
end

function RedPointMgr:PassPanelSeasonTaskRedJudge(activityId)
    if activityId == 0 or activityId == nil then
        return false
    end

    local activityData = Config.GetActivityInfo(activityId)
    local missionList = Me:getMissionList()
    for k, v in pairs(missionList) do
        local taskConfig = Config.GetTaskTableInfo(v.id)
        if taskConfig and taskConfig.taskType == GE.MissionType.PassTask and tablex.contains(activityData.TaskGroup,taskConfig.taskGroup) then
            if taskConfig.refreshType == 0 and v.state == GE.MissionState.Unclaimed then
                return true
            end
        end
    end
    return false
end

function RedPointMgr:PassPanelPassPortRedJudge(activityId)
    if activityId == 0 or activityId == nil then
        return false
    end

    local passdataMap = Me:getPassDataMap()
    local passServeData = passdataMap[activityId]
    if not passServeData then
        return false
    end
    local passPortTables = Config.GetAllConfig("PassportTable")
    for i, value in pairs(passPortTables) do
        if value.PassportId == activityId then
            if value.Level <= passServeData.level then
                if not tablex.find(passServeData.basePassRwdStates,value.Level) then
                    return true
                end
                if passServeData.openAdvance == 1 then
                    if not tablex.find(passServeData.advancePassRwdStates,value.Level) then
                        return true
                    end
                end
            end
        end
    end
    return false
end

--问卷调查红点
function RedPointMgr:QuestionRedJudge()
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.Question)
    local  isActive  = state == GE.FunctionOpenState.Open
    local questionOpenList = UICommonUtils.QuestionOpenList()
    if isActive == true and #questionOpenList > 0 then
        local localTime = MyPrefs:GetInt(GE.LocalCustomDataKey.QuestionPanelCustomDataKey.."QuestionPanel",0)
        if not DLuaUtil.IsSameDay(localTime, DLuaUtil.GetLocalTime()) then
            return true
        end
    end
    return false
end

function RedPointMgr:PassPanelRedJudge(activityId)
    if self:PassPanelPassPortRedJudge(activityId) then
        return true
    end
    if self:PassPanelWeekTaskRedJudge(activityId) then
        return true
    end
    if self:PassPanelSeasonTaskRedJudge(activityId) then
        return true
    end
    return false
end

--------------------------------------------------------------------

-------------------------------WeeklyBossMainPanel-------------------------------

--海图面板活动红点
function RedPointMgr:SeaMapPanelActivityLevelRedJudge()
    if self:SeaMapPanelBossActBtnRedJudge() then
        return true
    end
    return false
end

--海图面板boss活动按钮红点
function RedPointMgr:SeaMapPanelBossActBtnRedJudge()
    if self:WeeklyBossMainPanelCurrentRewardsBtnRedJudge() then
        return true
    end
    if self:WeeklyBossMainPanelAchievementBtnRedJudge() then
        return true
    end
    return false
end

--周常boss主界面当前奖励按钮红点
function RedPointMgr:WeeklyBossMainPanelCurrentRewardsBtnRedJudge()
    local bossActivity = Me:getBossActivityData()
    -- 活动有效性检查
    if not bossActivity or not bossActivity.nowPeriod then
        return false
    end

    -- 时间有效性检查
    local nowTime = DLuaUtil.GetGreenwichTime()
    local remainingTime = DLuaUtil.getBossActivityRemainingTime(bossActivity.closingTime, nowTime)
    if remainingTime.day == 0 and remainingTime.hour == 0 and remainingTime.min < 10 then
        return false
    end
    -- 计算总积分
    local totalScore = 0
    local bossBattleCfg = Config.GetPveBossBattleInfoByIssue(bossActivity.nowPeriod)
    if not bossBattleCfg then return false end

    for _, bossId in pairs(bossBattleCfg.BossBattleId or {}) do
        --local bossLevelData = bossActivity.bossLevelMap[bossId]
        if bossActivity.bossLevelMap and bossActivity.bossLevelMap[bossId] then
            totalScore = totalScore + (bossActivity.bossLevelMap[bossId].nowScore or 0)
        end
    end
    local allScoreConfigs = Config.GetAllConfig("PveBossBattleScoreTable")
    if allScoreConfigs then
        for _, config in pairs(allScoreConfigs) do
            if not tablex.find(bossActivity.scoreRewardList, config.id) 
                and totalScore >= config.scoreNum then
                return true
            end
        end
    end
    return false
end

--周常boss主界面成就按钮红点
function RedPointMgr:WeeklyBossMainPanelAchievementBtnRedJudge()
    local bossBattleLevelCfg = Config.GetAllConfig("PveBossBattleLevelTable")
    local bossLevelList = {}
    for _, value in pairs(bossBattleLevelCfg) do
        table.insert(bossLevelList, value)
    end
    for _, bossLevelCfg in pairs(bossLevelList) do
        local bossId = bossLevelCfg.id
        if self:WeeklyBossAchievementPanelBossToggleRedJudge(bossId) then
            return true
        end
    end
    return false
end

--周常boss成就面板boss toggle红点
function RedPointMgr:WeeklyBossAchievementPanelBossToggleRedJudge(bossId)
    local bossTaskDataMap = {}
    local achiTaskCfglist = Config.GetTaskInfoByTaskType(GE.MissionType.BossTask)
    for _, taskCfg in pairs(achiTaskCfglist) do
        if not bossTaskDataMap[taskCfg.type] then
            bossTaskDataMap[taskCfg.type] = {}
        end
        local taskData = Me:getMissionListById(taskCfg.id)
        table.insert(bossTaskDataMap[taskCfg.type], {taskCfg = taskCfg, taskData = taskData})
    end
    local taskList = bossTaskDataMap[bossId] or {}
    for _, taskMap in pairs(taskList) do
        local taskData = taskMap.taskData
        local isFinish = taskData and taskData.state == GE.MissionState.Unclaimed--任务已完成，未领取奖励
        if isFinish then
            return true
        end
    end
    return false
end


function RedPointMgr:initMsg()
	GameMsgMgr:regEvent(GameMsgType.FunctionOpenMapUpdate, self, self.CheckFunctionOpen)
end


function RedPointMgr:CheckFunctionOpen()

    CoveManager.instance():CheckFunctionOpen()
end




--------------------------------------------------------------------

function RedPointMgr:Clear()
    GameMsgMgr:unRegEvent(GameMsgType.FunctionOpenMapUpdate, self, self.CheckFunctionOpen)
end

return RedPointMgr