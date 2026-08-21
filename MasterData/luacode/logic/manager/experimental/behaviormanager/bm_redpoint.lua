-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_redpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local BM_RedPoint = class("BM_RedPoint")
local OnRedPointNumChanged = function(self, notification)
  -- function num : 0_0 , upvalues : _ENV
  local id = (notification.userInfo).redPointID
  local params = (notification.userInfo).redPointParams
  local deltaNum = (notification.userInfo).deltaNum
  local map = (self._dm):GetParentsIdAndParams(id, params)
  if map then
    for k,v in pairs(map) do
      (self._dm):ChangeRedPointNum(k, v, deltaNum)
    end
  end
end

BM_RedPoint.Ctor = function(self)
  -- function num : 0_1 , upvalues : _ENV, OnRedPointNumChanged
  self._redPoint = (NekoData.Data).redPoint
  self._dm = (NekoData.DataManager).DM_RedPoint
  self._cacheHandleData = {}
  ;
  (LuaNotificationCenter.AddObserver)(self, OnRedPointNumChanged, Common.n_RedPointNumChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnItemChanged, Common.n_ItemRemove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnItemChanged, Common.n_ItemAdd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnItemChanged, Common.n_ItemNumModify, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnItemChanged, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleLevelUp, Common.n_LevelUp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshRoles, Common.n_RoleEnergyChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleInfoChange, Common.n_RoleInfoChange, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshRoleGood, Common.n_RefreshRoleGood, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleGoodReceiveAward, Common.n_RoleGoodReceiveAward, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleSkinCheckedOrGain, Common.n_SkinCheckedOrGain, nil)
end

local GetParentsIdAndParamsList = function(self, list, childId, childParams)
  -- function num : 0_2 , upvalues : _ENV, GetParentsIdAndParamsList
  local map = (self._dm):GetParentsIdAndParams(childId, childParams)
  if map then
    (table.insert)(list, 1, map)
    for k,v in pairs(map) do
      GetParentsIdAndParamsList(self, list, k, v)
    end
  else
    do
      do return  end
    end
  end
end

local GetAllChildsId = function(self, map, parentId)
  -- function num : 0_3 , upvalues : _ENV, GetAllChildsId
  local treeNode = ((self._dm)._linkTreeNodes)[parentId]
  if treeNode then
    for childId,_ in pairs(treeNode._childs) do
      map[childId] = true
      GetAllChildsId(self, map, childId)
    end
  end
  do
    return 
  end
end

BM_RedPoint.HandleCacheNotifications = function(self)
  -- function num : 0_4 , upvalues : _ENV, GetParentsIdAndParamsList, GetAllChildsId
  local needHandleDataMap = {}
  for id,data in pairs(self._cacheHandleData) do
    if type(data) == "table" then
      for i,params in ipairs(data) do
        local list = {}
        GetParentsIdAndParamsList(self, list, id, params)
        local needClearId = false
        for i,map in ipairs(list) do
          for k,v in pairs(map) do
            if (self._cacheHandleData)[k] then
              local childs = {}
              GetAllChildsId(self, childs, k)
              for childId,_ in pairs(childs) do
                if childId == id then
                  needClearId = true
                else
                  -- DECOMPILER ERROR at PC49: Confused about usage of register: R30 in 'UnsetPending'

                  ;
                  (self._cacheHandleData)[childId] = nil
                end
              end
            end
          end
        end
        if needClearId then
          needClearId = false
          -- DECOMPILER ERROR at PC60: Confused about usage of register: R14 in 'UnsetPending'

          ;
          (self._cacheHandleData)[id] = nil
          break
        end
      end
    else
      do
        local list = {}
        GetParentsIdAndParamsList(self, list, id, nil)
        do
          local needClearId = false
          for i,map in ipairs(list) do
            for k,v in pairs(map) do
              if (self._cacheHandleData)[k] then
                local childs = {}
                GetAllChildsId(self, childs, k)
                for childId,_ in pairs(childs) do
                  if childId == id then
                    needClearId = true
                  else
                    -- DECOMPILER ERROR at PC100: Confused about usage of register: R25 in 'UnsetPending'

                    ;
                    (self._cacheHandleData)[childId] = nil
                  end
                end
              end
            end
          end
          if needClearId then
            needClearId = false
            -- DECOMPILER ERROR at PC111: Confused about usage of register: R9 in 'UnsetPending'

            ;
            (self._cacheHandleData)[id] = nil
            break
          end
          -- DECOMPILER ERROR at PC113: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC113: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC113: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for id,data in pairs(self._cacheHandleData) do
    if type(data) == "table" then
      for i,params in ipairs(data) do
        (self._dm):UpdateRedPointNum(id, R15_PC132)
      end
    else
      do
        do
          ;
          (self._dm):UpdateRedPointNum(id)
          -- DECOMPILER ERROR at PC141: Confused about usage of register: R7 in 'UnsetPending'

          ;
          (self._cacheHandleData)[id] = nil
          -- DECOMPILER ERROR at PC142: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC142: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC142: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  ;
  (self._dm):ClearCacheRefreshNotifications()
end

BM_RedPoint.GetRedPointNum = function(self, id, params)
  -- function num : 0_5
  return (self._dm):GetRedPointNum(id, params)
end

local BuildCache = function(self, map, index, paramNum, params, id)
  -- function num : 0_6 , upvalues : BuildCache
  local key = params[index]
  if index < paramNum then
    if not map[key] then
      map[key] = {}
    end
    return BuildCache(self, map[key], index + 1, paramNum, params, id)
  else
    if index == paramNum and not map[key] then
      map[key] = true
      return true
    end
  end
  do return  end
end

BM_RedPoint.cacheRefreshNotifications = function(self, id, params)
  -- function num : 0_7 , upvalues : BuildCache, _ENV
  local record = ((self._dm)._redPointLinkCfgRecords)[id]
  if record then
    local key = id
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

    if record.paramNum > 0 and BuildCache(self, ((self._redPoint).cacheRefreshNotifications)[id], 1, record.paramNum, params, id) then
      if not (self._cacheHandleData)[id] then
        (self._cacheHandleData)[id] = {}
      end
      ;
      (table.insert)((self._cacheHandleData)[id], params)
    end
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

    if not ((self._redPoint).cacheRefreshNotifications)[id] then
      ((self._redPoint).cacheRefreshNotifications)[id] = true
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._cacheHandleData)[id] = true
    end
  else
    do
      LogErrorFormat("BM_RedPoint", "RedPoint id(: %s, params: %s) is error.", id, params)
    end
  end
end

BM_RedPoint.OnItemChanged = function(self)
  -- function num : 0_8
  self:cacheRefreshNotifications(1)
  self:cacheRefreshNotifications(100001)
end

BM_RedPoint.OnRefreshRoles = function(self, notification)
  -- function num : 0_9 , upvalues : _ENV
  for i,v in ipairs((notification.userInfo).list) do
    self:cacheRefreshNotifications(2, {v.id})
    self:cacheRefreshNotifications(100002, {v.id})
  end
end

BM_RedPoint.OnRoleLevelUp = function(self, notification)
  -- function num : 0_10
  self:cacheRefreshNotifications(2, {(notification.userInfo).key})
  self:cacheRefreshNotifications(100002, {(notification.userInfo).key})
end

BM_RedPoint.OnRoleInfoChange = function(self, notification)
  -- function num : 0_11
  local userInfo = notification.userInfo
  if userInfo then
    if userInfo.name and userInfo.name == "sevolution" then
      self:cacheRefreshNotifications(5, {userInfo.key})
      self:cacheRefreshNotifications(105, {userInfo.key})
    else
      if userInfo.name and userInfo.name == "sroleadd" then
        self:cacheRefreshNotifications(2, {userInfo.roleId})
        self:cacheRefreshNotifications(100002, {userInfo.roleId})
      else
        if userInfo.name and userInfo.name == "sroleupdatebreaklv" then
          self:cacheRefreshNotifications(12, {userInfo.key, userInfo.breakLv})
          self:cacheRefreshNotifications(112, {userInfo.key, userInfo.breakLv})
        end
      end
    end
  end
end

BM_RedPoint.OnRefreshRoleGood = function(self, notification)
  -- function num : 0_12
  self:cacheRefreshNotifications(9, {(notification.userInfo).roleId})
  self:cacheRefreshNotifications(109, {(notification.userInfo).roleId})
end

BM_RedPoint.OnRoleGoodReceiveAward = function(self, notification)
  -- function num : 0_13
  self:cacheRefreshNotifications(10, {(notification.userInfo).roleId, (notification.userInfo).level})
  self:cacheRefreshNotifications(110, {(notification.userInfo).roleId, (notification.userInfo).level})
end

BM_RedPoint.OnRoleSkinCheckedOrGain = function(self, notification)
  -- function num : 0_14 , upvalues : _ENV, CSkin
  local skinRecorder = notification.userInfo
  if type(notification.userInfo) == "number" then
    skinRecorder = CSkin:GetRecorder(notification.userInfo)
  end
  if skinRecorder then
    self:cacheRefreshNotifications(8, {skinRecorder.roleid, skinRecorder.id})
    self:cacheRefreshNotifications(108, {skinRecorder.roleid, skinRecorder.id})
  else
    LogErrorFormat("OnRoleSkinCheckedOrGain", "recorder with id %s is not exist in cskin", notification.userInfo)
  end
end

BM_RedPoint.SetUnCheckedByRedPointKey = function(self, redPointKey)
  -- function num : 0_15 , upvalues : _ENV
  (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. redPointKey, 0)
end

local SetCheckedByRedPointKey = function(self, id, params)
  -- function num : 0_16 , upvalues : _ENV
  local redPointKey = id
  if params then
    for i,v in ipairs(params) do
      redPointKey = redPointKey .. "_" .. v
    end
  end
  do
    local checked = self:IsCheckedByRedPointKey(redPointKey)
    if not checked and self:GetRedPointNum(id, params) > 0 then
      (((CS.UnityEngine).PlayerPrefs).SetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. redPointKey, 1)
    end
  end
end

BM_RedPoint.ClearAllRedPointsByRoleId = function(self, roleId)
  -- function num : 0_17 , upvalues : _ENV, SetCheckedByRedPointKey
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
  if role then
    local allNodes = role:GetAllSkillNodes()
    for skillNodeId,_ in pairs(allNodes) do
      SetCheckedByRedPointKey(self, 104, {roleId, skillNodeId})
    end
    local evolutionLimit = role:GetEvolutionLimit()
    for i = 1, evolutionLimit do
      SetCheckedByRedPointKey(self, 106, {roleId, i})
    end
    local fashionList = role:GetSkinIDList()
    for _,skinId in ipairs(fashionList) do
      SetCheckedByRedPointKey(self, 108, {roleId, skinId})
    end
    if not role:GetIsLeader() then
      local giftList = role:GetRelationRewardList()
      for i,v in ipairs(giftList) do
        SetCheckedByRedPointKey(self, 110, {roleId, v.favourLv})
      end
    end
    do
      local maxBreakLv = role:GetMaxBreakLv()
      for i = 1, maxBreakLv do
        SetCheckedByRedPointKey(self, 112, {roleId, i})
      end
      self:cacheRefreshNotifications(100002, {roleId})
    end
  end
end

BM_RedPoint.IsCheckedByRedPointKey = function(self, redPointKey)
  -- function num : 0_18 , upvalues : _ENV
  do return (((CS.UnityEngine).PlayerPrefs).GetInt)((((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0") .. redPointKey, 0) ~= 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return BM_RedPoint

