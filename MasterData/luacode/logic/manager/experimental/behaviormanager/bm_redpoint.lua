local CSkin = BeanManager.GetTableByName("role.cskin")
local BM_RedPoint = class("BM_RedPoint")

local function OnRedPointNumChanged(self, notification)
  local id = notification.userInfo.redPointID
  local params = notification.userInfo.redPointParams
  local deltaNum = notification.userInfo.deltaNum
  local map = self._dm:GetParentsIdAndParams(id, params)
  if map then
    for k, v in pairs(map) do
      self._dm:ChangeRedPointNum(k, v, deltaNum)
    end
  end
end

function BM_RedPoint:Ctor()
  self._redPoint = NekoData.Data.redPoint
  self._dm = NekoData.DataManager.DM_RedPoint
  self._cacheHandleData = {}
  LuaNotificationCenter.AddObserver(self, OnRedPointNumChanged, Common.n_RedPointNumChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnItemChanged, Common.n_ItemRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.OnItemChanged, Common.n_ItemAdd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnItemChanged, Common.n_ItemNumModify, nil)
  LuaNotificationCenter.AddObserver(self, self.OnItemChanged, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRoleLevelUp, Common.n_LevelUp, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRoles, Common.n_RoleEnergyChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRoleInfoChange, Common.n_RoleInfoChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRoleGood, Common.n_RefreshRoleGood, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRoleGoodReceiveAward, Common.n_RoleGoodReceiveAward, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRoleSkinCheckedOrGain, Common.n_SkinCheckedOrGain, nil)
end

local function GetParentsIdAndParamsList(self, list, childId, childParams)
  local map = self._dm:GetParentsIdAndParams(childId, childParams)
  if map then
    table.insert(list, 1, map)
    for k, v in pairs(map) do
      GetParentsIdAndParamsList(self, list, k, v)
    end
  else
    return
  end
end

local function GetAllChildsId(self, map, parentId)
  local treeNode = self._dm._linkTreeNodes[parentId]
  if treeNode then
    for childId, _ in pairs(treeNode._childs) do
      map[childId] = true
      GetAllChildsId(self, map, childId)
    end
  end
  return
end

function BM_RedPoint:HandleCacheNotifications()
  local needHandleDataMap = {}
  for id, data in pairs(self._cacheHandleData) do
    if type(data) == "table" then
      for i, params in ipairs(data) do
        local list = {}
        GetParentsIdAndParamsList(self, list, id, params)
        local needClearId = false
        for i, map in ipairs(list) do
          for k, v in pairs(map) do
            if self._cacheHandleData[k] then
              local childs = {}
              GetAllChildsId(self, childs, k)
              for childId, _ in pairs(childs) do
                if childId == id then
                  needClearId = true
                else
                  self._cacheHandleData[childId] = nil
                end
              end
            end
          end
        end
        if needClearId then
          needClearId = false
          self._cacheHandleData[id] = nil
          break
        end
      end
    else
      local list = {}
      GetParentsIdAndParamsList(self, list, id, nil)
      local needClearId = false
      for i, map in ipairs(list) do
        for k, v in pairs(map) do
          if self._cacheHandleData[k] then
            local childs = {}
            GetAllChildsId(self, childs, k)
            for childId, _ in pairs(childs) do
              if childId == id then
                needClearId = true
              else
                self._cacheHandleData[childId] = nil
              end
            end
          end
        end
      end
      if needClearId then
        needClearId = false
        self._cacheHandleData[id] = nil
        break
      end
    end
  end
  for id, data in pairs(self._cacheHandleData) do
    if type(data) == "table" then
      for i, params in ipairs(data) do
        self._dm:UpdateRedPointNum(id, params)
      end
    else
      self._dm:UpdateRedPointNum(id)
    end
    self._cacheHandleData[id] = nil
  end
  self._dm:ClearCacheRefreshNotifications()
end

function BM_RedPoint:GetRedPointNum(id, params)
  return self._dm:GetRedPointNum(id, params)
end

local function BuildCache(self, map, index, paramNum, params, id)
  local key = params[index]
  if index < paramNum then
    if not map[key] then
      map[key] = {}
    end
    return BuildCache(self, map[key], index + 1, paramNum, params, id)
  elseif index == paramNum then
    if not map[key] then
      map[key] = true
      return true
    end
  else
    return
  end
end

function BM_RedPoint:cacheRefreshNotifications(id, params)
  local record = self._dm._redPointLinkCfgRecords[id]
  if record then
    local key = id
    if record.paramNum > 0 then
      if BuildCache(self, self._redPoint.cacheRefreshNotifications[id], 1, record.paramNum, params, id) then
        if not self._cacheHandleData[id] then
          self._cacheHandleData[id] = {}
        end
        table.insert(self._cacheHandleData[id], params)
      end
    elseif not self._redPoint.cacheRefreshNotifications[id] then
      self._redPoint.cacheRefreshNotifications[id] = true
      self._cacheHandleData[id] = true
    end
  else
    LogErrorFormat("BM_RedPoint", "RedPoint id(: %s, params: %s) is error.", id, params)
  end
end

function BM_RedPoint:OnItemChanged()
  self:cacheRefreshNotifications(1)
  self:cacheRefreshNotifications(100001)
end

function BM_RedPoint:OnRefreshRoles(notification)
  for i, v in ipairs(notification.userInfo.list) do
    self:cacheRefreshNotifications(2, {
      v.id
    })
    self:cacheRefreshNotifications(100002, {
      v.id
    })
  end
end

function BM_RedPoint:OnRoleLevelUp(notification)
  self:cacheRefreshNotifications(2, {
    notification.userInfo.key
  })
  self:cacheRefreshNotifications(100002, {
    notification.userInfo.key
  })
end

function BM_RedPoint:OnRoleInfoChange(notification)
  local userInfo = notification.userInfo
  if userInfo then
    if userInfo.name and userInfo.name == "sevolution" then
      self:cacheRefreshNotifications(5, {
        userInfo.key
      })
      self:cacheRefreshNotifications(105, {
        userInfo.key
      })
    elseif userInfo.name and userInfo.name == "sroleadd" then
      self:cacheRefreshNotifications(2, {
        userInfo.roleId
      })
      self:cacheRefreshNotifications(100002, {
        userInfo.roleId
      })
    elseif userInfo.name and userInfo.name == "sroleupdatebreaklv" then
      self:cacheRefreshNotifications(12, {
        userInfo.key,
        userInfo.breakLv
      })
      self:cacheRefreshNotifications(112, {
        userInfo.key,
        userInfo.breakLv
      })
    end
  end
end

function BM_RedPoint:OnRefreshRoleGood(notification)
  self:cacheRefreshNotifications(9, {
    notification.userInfo.roleId
  })
  self:cacheRefreshNotifications(109, {
    notification.userInfo.roleId
  })
end

function BM_RedPoint:OnRoleGoodReceiveAward(notification)
  self:cacheRefreshNotifications(10, {
    notification.userInfo.roleId,
    notification.userInfo.level
  })
  self:cacheRefreshNotifications(110, {
    notification.userInfo.roleId,
    notification.userInfo.level
  })
end

function BM_RedPoint:OnRoleSkinCheckedOrGain(notification)
  local skinRecorder = notification.userInfo
  if type(notification.userInfo) == "number" then
    skinRecorder = CSkin:GetRecorder(notification.userInfo)
  end
  if skinRecorder then
    self:cacheRefreshNotifications(8, {
      skinRecorder.roleid,
      skinRecorder.id
    })
    self:cacheRefreshNotifications(108, {
      skinRecorder.roleid,
      skinRecorder.id
    })
  else
    LogErrorFormat("OnRoleSkinCheckedOrGain", "recorder with id %s is not exist in cskin", notification.userInfo)
  end
end

function BM_RedPoint:SetUnCheckedByRedPointKey(redPointKey)
  CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. redPointKey, 0)
end

local function SetCheckedByRedPointKey(self, id, params)
  local redPointKey = id
  if params then
    for i, v in ipairs(params) do
      redPointKey = redPointKey .. "_" .. v
    end
  end
  local checked = self:IsCheckedByRedPointKey(redPointKey)
  if not checked and self:GetRedPointNum(id, params) > 0 then
    CS.UnityEngine.PlayerPrefs.SetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. redPointKey, 1)
  end
end

function BM_RedPoint:ClearAllRedPointsByRoleId(roleId)
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  if role then
    local allNodes = role:GetAllSkillNodes()
    for skillNodeId, _ in pairs(allNodes) do
      SetCheckedByRedPointKey(self, 104, {roleId, skillNodeId})
    end
    local evolutionLimit = role:GetEvolutionLimit()
    for i = 1, evolutionLimit do
      SetCheckedByRedPointKey(self, 106, {roleId, i})
    end
    local fashionList = role:GetSkinIDList()
    for _, skinId in ipairs(fashionList) do
      SetCheckedByRedPointKey(self, 108, {roleId, skinId})
    end
    if not role:GetIsLeader() then
      local giftList = role:GetRelationRewardList()
      for i, v in ipairs(giftList) do
        SetCheckedByRedPointKey(self, 110, {
          roleId,
          v.favourLv
        })
      end
    end
    local maxBreakLv = role:GetMaxBreakLv()
    for i = 1, maxBreakLv do
      SetCheckedByRedPointKey(self, 112, {roleId, i})
    end
    self:cacheRefreshNotifications(100002, {roleId})
  end
end

function BM_RedPoint:IsCheckedByRedPointKey(redPointKey)
  return CS.UnityEngine.PlayerPrefs.GetInt(CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0") .. redPointKey, 0) ~= 0
end

return BM_RedPoint
