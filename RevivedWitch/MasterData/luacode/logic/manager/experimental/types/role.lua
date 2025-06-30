-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/role.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CVocationCfgTable = (BeanManager.GetTableByName)("role.cvocationcfg")
local CNpcShapeTable = (BeanManager.GetTableByName)("npc.cnpcshape")
local CRoleRarityCfgTable = (BeanManager.GetTableByName)("role.croleraritycfg")
local CRoleLevelCfgTable = (BeanManager.GetTableByName)("role.crolelevelcfg")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CRoleBreakCfgTable = (BeanManager.GetTableByName)("role.crolebreakcfg")
local CRoleItemTable = (BeanManager.GetTableByName)("item.croleitem")
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local CTalentPageCfg = (BeanManager.GetTableByName)("role.ctalentpagecfg")
local CTalentCfg = (BeanManager.GetTableByName)("role.ctalentcfg")
local CRoleEvolutionCfg = (BeanManager.GetTableByName)("role.croleevolutioncfg")
local CRoleSkin = (BeanManager.GetTableByName)("role.croleskin")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local CPlayerLevel = (BeanManager.GetTableByName)("role.cplayerlevel")
local CAttreffectIdName = (BeanManager.GetTableByName)("role.cattreffectidname")
local CSoundLines = (BeanManager.GetTableByName)("sound.csoundlines")
local CSoundLines_skin = (BeanManager.GetTableByNameWithLanguage)("sound.csoundlines_skin")
local CElementCfgTable = (BeanManager.GetTableByName)("role.celementcfg")
local CCardRoleConfig_HandBook = (BeanManager.GetTableByName)("handbook.ccardroleconfig_handbook")
local CFavourPresent = (BeanManager.GetTableByName)("role.cfavourpresent")
local CFavourExp = (BeanManager.GetTableByName)("role.cfavourexp")
local AttrTypeEnum = (LuaNetManager.GetBeanDef)("protocol.login.attrtype")
local EquipTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.equiptype")
local SlotEnum = (LuaNetManager.GetBeanDef)("protocol.yard.task")
local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
local CEventBoostRole = (BeanManager.GetTableByName)("activity.ceventboostrole")
local Skill = require("logic.manager.experimental.types.skill")
local CSkillMapTable = (BeanManager.GetTableByName)("skill.cskillmap")
local Role = strictclass("Role")
Role.Ctor = function(self, id, roleInfo, isBase)
  -- function num : 0_0 , upvalues : RoleConfigTable, CFavourPresent, CSoundLines, CRoleSkin, CSkillMapTable, CRoleBreakCfgTable, _ENV, CRoleEvolutionCfg, CEventBoostRole, CNpcShapeTable, CVocationCfgTable, CRoleRarityCfgTable
  self._roleId = id
  self._roleConfigRecord = RoleConfigTable:GetRecorder(id)
  self._relationPresentRecord = CFavourPresent:GetRecorder(id)
  self._soundLinesRecord = CSoundLines:GetRecorder(id)
  self._roleSkinRecord = CRoleSkin:GetRecorder(id)
  self._defaultFashionId = 0
  if not isBase then
    self._allSkillNodes = {}
    local allIds = CSkillMapTable:GetAllIds()
    local len = #allIds
    for i = 1, len do
      local record = CSkillMapTable:GetRecorder(allIds[i])
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R11 in 'UnsetPending'

      if record.roleID == self._roleId then
        (self._allSkillNodes)[record.id] = record
      end
    end
    self._allBreakRecords = {}
    allIds = CRoleBreakCfgTable:GetAllIds()
    for i = 1, #allIds do
      local recorder = CRoleBreakCfgTable:GetRecorder(allIds[i])
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R11 in 'UnsetPending'

      if recorder.breakType == self:GetBreakType() then
        (self._allBreakRecords)[recorder.breaklv] = recorder
      end
    end
    self._allBreakRecordList = {}
    for k,v in pairs(self._allBreakRecords) do
      (table.insert)(self._allBreakRecordList, v)
    end
    ;
    (table.sort)(self._allBreakRecordList, function(a, b)
    -- function num : 0_0_0
    do return a.breaklv < b.breaklv end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    self._evolutionLevelRecords = {}
    local evolutionType = (self._roleConfigRecord).evolutionType
    for _,id in ipairs(CRoleEvolutionCfg:GetAllIds()) do
      local record = CRoleEvolutionCfg:GetRecorder(id)
      if record.evolutionType == evolutionType then
        (table.insert)(self._evolutionLevelRecords, record)
      end
    end
    ;
    (table.sort)(self._evolutionLevelRecords, function(a, b)
    -- function num : 0_0_1
    do return a.evolutionLevel < b.evolutionLevel end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    self._eventBoostRecord = {}
    allIds = CEventBoostRole:GetAllIds()
    len = #allIds
    for i = 1, len do
      local record = CEventBoostRole:GetRecorder(allIds[i])
      -- DECOMPILER ERROR at PC137: Confused about usage of register: R12 in 'UnsetPending'

      if record.roleid == self._roleId then
        (self._eventBoostRecord)[record.id] = record
      end
    end
  end
  do
    if self._roleConfigRecord then
      self._shapeRecord = CNpcShapeTable:GetRecorder((self._roleConfigRecord).shapeID)
    else
      LogErrorFormat("Role", "role id %s is wrong", id)
    end
    self:RefreshByRoleInfo(roleInfo, isBase)
    if self._roleConfigRecord then
      self._vocationRecord = CVocationCfgTable:GetRecorder((self._roleConfigRecord).vocation)
      self._roleRarityRecord = CRoleRarityCfgTable:GetRecorder((self._roleConfigRecord).rarity)
      self._vocationName = (TextManager.GetText)((self._vocationRecord).nameTextID)
    end
  end
end

Role.RefreshByRoleInfo = function(self, roleInfo, isBase)
  -- function num : 0_1 , upvalues : _ENV, Skill, EquipTypeEnum, CRoleLevelCfgTable, CRoleEvolutionCfg
  if roleInfo then
    self._isLeader = roleInfo.isLeader
    self._birthday = roleInfo.birthday
    self._breakLv = roleInfo.breakLv
    self._lv = roleInfo.lv
    self._exp = roleInfo.exp
    self._lock = roleInfo.lock
    self._properties = roleInfo.properties
    self._isNew = roleInfo.redDot == 1
    for k,v in pairs(self._properties) do
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R8 in 'UnsetPending'

      if k ~= 10 and k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
        (self._properties)[k] = nil
      end
    end
    while self._showSkillList and (self._showSkillList)[#self._showSkillList] do
      (table.remove)(self._showSkillList, #self._showSkillList)
    end
    self._showSkillList = {}
    while self._notPassiveSkills and (self._notPassiveSkills)[#self._notPassiveSkills] do
      (table.remove)(self._notPassiveSkills, #self._notPassiveSkills)
    end
    self._notPassiveSkills = {}
    for i,v in ipairs(roleInfo.contractSkill) do
      local data = {}
      data.skillId = v.skillLevel
      data.skillItemId = v.skillItemId
      data.selected = v.selected == 1
      ;
      (table.insert)(self._notPassiveSkills, data)
      if data.selected then
        (table.insert)(self._showSkillList, {skillId = data.skillId, skillItemId = data.skillItemId, unlock = true})
      end
    end
    local num = #self._showSkillList
    for i = num + 1, 2 do
      if i == 1 then
        local skillItemId = (self._roleConfigRecord).contractskillid
        local skill = (Skill.Create)(skillItemId)
        ;
        (table.insert)(self._showSkillList, {skillId = skill:GetSkillId(), skillItemId = skillItemId, unlock = false})
      elseif i == 2 then
        local skillItemId = (self._roleConfigRecord).contractskillid2
        local skill = (Skill.Create)(skillItemId)
        ;
        (table.insert)(self._showSkillList, {skillId = skill:GetSkillId(), skillItemId = skillItemId, unlock = false})
      end
    end
    while self._passiveSkills and (self._passiveSkills)[#self._passiveSkills] do
      (table.remove)(self._passiveSkills, #self._passiveSkills)
    end
    self._passiveSkills = {}
    for i,v in ipairs(roleInfo.passiveskill) do
      (table.insert)(self._passiveSkills, v.id)
      local skill = (Skill.Create)(v.id, true)
      if skill:GetType() == (Skill.Type).Passive then
        (table.insert)(self._showSkillList, {skillId = v.id, unlock = true, isPassive = true})
      end
    end
    num = #self._showSkillList
    if num < 3 then
      (table.insert)(self._showSkillList, {skillId = (self._roleConfigRecord).contractskillid3, unlock = false, isPassive = true})
    end
    if self._unlockSkillNodes then
      for k,v in pairs(self._unlockSkillNodes) do
        -- DECOMPILER ERROR at PC230: Confused about usage of register: R9 in 'UnsetPending'

        (self._unlockSkillNodes)[k] = nil
      end
    else
      self._unlockSkillNodes = {}
    end
    for _,v in ipairs(roleInfo.unlockedNode) do
      -- DECOMPILER ERROR at PC241: Confused about usage of register: R9 in 'UnsetPending'

      (self._unlockSkillNodes)[v] = true
    end
    self._weapon = (roleInfo.equips)[EquipTypeEnum.WEAPON]
    self._armor = (roleInfo.equips)[EquipTypeEnum.ARMOR]
    self._jewelry = (roleInfo.equips)[EquipTypeEnum.JEWELRY]
    self._preSetWeapon = (roleInfo.preSetEquips)[EquipTypeEnum.WEAPON]
    self._preSetarmor = (roleInfo.preSetEquips)[EquipTypeEnum.ARMOR]
    self._preSetJewelry = (roleInfo.preSetEquips)[EquipTypeEnum.JEWELRY]
    self._hurtExtent = 0
    self._reviveTime = 0
    self._repairTime = 0
    self._evolution = roleInfo.evolution
    self._curLvBasePro = roleInfo.curLvBasePro
    for k,v in pairs(self._curLvBasePro) do
      -- DECOMPILER ERROR at PC294: Confused about usage of register: R9 in 'UnsetPending'

      if k ~= 10 and k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
        (self._curLvBasePro)[k] = nil
      end
    end
    self._nextLvBasePro = roleInfo.nextLvBasePro
    for k,v in pairs(self._nextLvBasePro) do
      -- DECOMPILER ERROR at PC318: Confused about usage of register: R9 in 'UnsetPending'

      if k ~= 10 and k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
        (self._nextLvBasePro)[k] = nil
      end
    end
    self._breakLvRange = roleInfo.breakLvRange
    self._power = roleInfo.power or 0
    self._talentPage = 0
    self._talentRow = 0
    if not self._talentInRowList then
      self._talentInRowList = {}
    end
    self._preBreakRecord = nil
    self._roleBreakRecord = nil
    self._nextBreakRecord = nil
    local recorder = (self._allBreakRecords)[self._breakLv - 1]
    if recorder then
      self._preBreakRecord = recorder
    end
    recorder = (self._allBreakRecords)[self._breakLv]
    if recorder then
      self._roleBreakRecord = recorder
    end
    recorder = (self._allBreakRecords)[self._breakLv + 1]
    if recorder then
      self._nextBreakRecord = recorder
    end
    self._roleLevelRecord = CRoleLevelCfgTable:GetRecorder(self._lv)
    self._energy = roleInfo.energy
    self._relationLevel = roleInfo.relationLevel
    self._relationProgress = roleInfo.goodProgress
    if self._relationReceiveMap then
      for k,v in pairs(self._relationReceiveMap) do
        -- DECOMPILER ERROR at PC377: Confused about usage of register: R10 in 'UnsetPending'

        (self._relationReceiveMap)[k] = nil
      end
    else
      self._relationReceiveMap = {}
    end
    for _,v in ipairs(roleInfo.receiveList) do
      -- DECOMPILER ERROR at PC388: Confused about usage of register: R10 in 'UnsetPending'

      (self._relationReceiveMap)[v] = true
    end
    self._defaultFashionId = roleInfo.skin
    self:UpdateSoundLines()
    if not self._fashions then
      self._fashions = {}
    end
    self._suitSkillsMap = roleInfo.suitSkills
    self._uniqueEquipLevel = roleInfo.specialWeaponLevel
    self._baseProAddPercent = roleInfo.addPercent
    self._runeLevel = roleInfo.runeLevel or 0
  end
  if self._roleConfigRecord then
    self._roleEvolutionCfg = nil
    do
      if not isBase and self._evolution then
        local evolutionType = (self._roleConfigRecord).evolutionType
        for _,id in ipairs(CRoleEvolutionCfg:GetAllIds()) do
          local record = CRoleEvolutionCfg:GetRecorder(id)
          if record.evolutionType == evolutionType and self._evolution + 1 == record.evolutionLevel then
            self._roleEvolutionCfg = record
            break
          end
        end
        self:CheckCanEvolutionByExclusiveItem()
      end
      self:UpdateShape()
      LogErrorFormat("Role", "role id %s is wrong", id)
      -- DECOMPILER ERROR: 40 unprocessed JMP targets
    end
  end
end

Role.Clone = function(self)
  -- function num : 0_2 , upvalues : _ENV
  return clone(self)
end

Role.GetRoleId = function(self)
  -- function num : 0_3
  return self._roleId
end

Role.GetId = function(self)
  -- function num : 0_4
  return self._roleId
end

Role.GetRoleConfig = function(self)
  -- function num : 0_5
  return self._roleConfigRecord
end

Role.GetItemId = function(self)
  -- function num : 0_6 , upvalues : _ENV, CRoleItemTable
  for k,v in pairs(CRoleItemTable:GetAllIds()) do
    local recorder = CRoleItemTable:GetRecorder(v)
    if recorder.roleid == self._roleId then
      return recorder.id
    end
  end
end

Role.CanResolve = function(self)
  -- function num : 0_7 , upvalues : CItemAttrTable
  local record = CItemAttrTable:GetRecorder(self:GetItemId())
  -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P1

  if record.resolvegetitem and (#record.resolvegetitem <= 0 or (record.resolvegetitem)[1] <= 0) then
    do return not record end
    do return false end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

Role.GetBirthDay = function(self)
  -- function num : 0_8
  return self._birthday
end

Role.GetRoleName = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local name = (TextManager.GetText)((self._roleConfigRecord).nameTextID)
  return (string.gsub)(name, "%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username)
end

Role.GetTitleName = function(self)
  -- function num : 0_10 , upvalues : _ENV
  return (TextManager.GetText)((self._roleConfigRecord).titleTextID)
end

Role.GetCvName = function(self)
  -- function num : 0_11
  return (self._roleConfigRecord).cv
end

Role.GetTitle = function(self)
  -- function num : 0_12 , upvalues : _ENV
  return (TextManager.GetText)((self._roleConfigRecord).titleTextID)
end

Role.GetArtistName = function(self)
  -- function num : 0_13
  return (self._roleConfigRecord).artist
end

Role.GetRoleHeight = function(self)
  -- function num : 0_14
  return (self._roleConfigRecord).height
end

Role.GetRoleWeight = function(self)
  -- function num : 0_15
  return (self._roleConfigRecord).weight
end

Role.GetRoleBloodType = function(self)
  -- function num : 0_16
  return (self._roleConfigRecord).bloodtype
end

Role.GetRoleHobby = function(self)
  -- function num : 0_17
  return (self._roleConfigRecord).hobby
end

Role.GetRoleAttribute = function(self)
  -- function num : 0_18
  return (self._roleConfigRecord).attribute
end

Role.GetRoleBackStory = function(self)
  -- function num : 0_19
  return (self._roleConfigRecord).backstory
end

Role.CanPlayVoice = function(self)
  -- function num : 0_20 , upvalues : CCardRoleConfig_HandBook, _ENV
  local record = CCardRoleConfig_HandBook:GetRecorder(self._roleId)
  if not record then
    LogErrorFormat("Role", "record with roleid %s is not exist in ccardroleconfig_handbook", self._roleId)
    return 
  end
  do return not record.vocal or record.vocal == 1 end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

Role.GetRoleEquipTypeList = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local str = (self._roleConfigRecord).roleEquipType
  local list = {}
  if str and str ~= "" then
    list = (string.split)(str, ";")
  end
  return list
end

Role.GetVocationId = function(self)
  -- function num : 0_22
  return (self._vocationRecord).id
end

Role.GetVocationName = function(self)
  -- function num : 0_23
  return self._vocationName
end

Role.GetVocationNameId = function(self)
  -- function num : 0_24
  return (self._vocationRecord).nameTextID
end

Role.GetVocationImageRecord = function(self)
  -- function num : 0_25 , upvalues : CImagePathTable, _ENV
  if self:GetRarityId() == 1 then
    if not CImagePathTable:GetRecorder((self._vocationRecord).imgR) then
      do return DataCommon.DefaultImageAsset end
      if self:GetRarityId() == 2 then
        if not CImagePathTable:GetRecorder((self._vocationRecord).imgSR) then
          do return DataCommon.DefaultImageAsset end
          if self:GetRarityId() == 3 then
            if not CImagePathTable:GetRecorder((self._vocationRecord).imgSSR) then
              do return DataCommon.DefaultImageAsset end
              if self:GetRarityId() == 4 then
                if not CImagePathTable:GetRecorder((self._vocationRecord).imgUR) then
                  do return DataCommon.DefaultImageAsset end
                  if self:GetRarityId() == 5 then
                    if not CImagePathTable:GetRecorder((self._vocationRecord).imgEX) then
                      do return DataCommon.DefaultImageAsset end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

Role.GetVocationDescribeImageRecord = function(self)
  -- function num : 0_26 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._vocationRecord).imgDescribe) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetVocationImgDrawRecord = function(self)
  -- function num : 0_27 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._vocationRecord).imgDraw) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetVocationBackgroundImgRecord = function(self)
  -- function num : 0_28 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._vocationRecord).imgBackground) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetShapeBustImageRecord = function(self)
  -- function num : 0_29 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._shapeRecord).bustID) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetShapeBigBustImageRecord = function(self)
  -- function num : 0_30 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._shapeRecord).bigbustID) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetShapeLiHuiImageRecord = function(self)
  -- function num : 0_31 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._shapeRecord).lihuiID) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetShapeHeadImageRecord = function(self)
  -- function num : 0_32 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._shapeRecord).headID) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetShapeLittleHeadImageRecord = function(self)
  -- function num : 0_33 , upvalues : CImagePathTable, _ENV
  if (self._shapeRecord).littleHeadID ~= 0 then
    if not CImagePathTable:GetRecorder((self._shapeRecord).littleHeadID) then
      do return DataCommon.DefaultImageAsset end
      return DataCommon.DefaultImageAsset
    end
  end
end

Role.GetDiamondHeadImageRecord = function(self)
  -- function num : 0_34 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._shapeRecord).DiamondHeadID) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetGachaRoleImageRecord = function(self)
  -- function num : 0_35 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._shapeRecord).drawShowID) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetModelRecord = function(self)
  -- function num : 0_36
  local data = {}
  data.assetBundle = (self._shapeRecord).assetBundleName
  data.assetName = (self._shapeRecord).prefabNameUI
  return data
end

Role.IsFashionLive2D = function(self)
  -- function num : 0_37 , upvalues : CSkin
  local skin = CSkin:GetRecorder(self._defaultFashionId)
  if skin.shapeType ~= 2 then
    do return not skin end
    do return false end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

Role.GetShapeLive2DRecord = function(self)
  -- function num : 0_38
  local t = {}
  if (self._shapeRecord).live2DPrefabName ~= "" and (self._shapeRecord).live2DAssetBundleName ~= "" then
    t.live2DPrefabName = (self._shapeRecord).live2DPrefabName
    t.live2DAssetBundleName = (self._shapeRecord).live2DAssetBundleName
    t.live2DScale = (self._shapeRecord).live2DScale
  end
  return t
end

Role.GetPhotoScale = function(self)
  -- function num : 0_39
  return (self._shapeRecord).photoScale
end

Role.GetPhotoPosition = function(self)
  -- function num : 0_40
  return (self._shapeRecord).photoLocation
end

Role.GetBattleEmotion = function(self)
  -- function num : 0_41 , upvalues : _ENV
  return tonumber((self._shapeRecord).battleEmotion)
end

Role.GetSkillHeadImageRecord = function(self)
  -- function num : 0_42 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._shapeRecord).skillHeadID) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetNpcShapePosition = function(self)
  -- function num : 0_43 , upvalues : _ENV
  local list = (string.split)((self._shapeRecord).positionrole, ",")
  return {x = tonumber(list[1]), y = tonumber(list[2]), z = tonumber(list[3])}
end

Role.GetHandbookShapePosition = function(self)
  -- function num : 0_44 , upvalues : _ENV
  local list = (string.split)((self._shapeRecord).position, ",")
  return {x = tonumber(list[1]), y = tonumber(list[2]), z = tonumber(list[3])}
end

Role.GetNpcShapePositionFriend = function(self)
  -- function num : 0_45 , upvalues : _ENV
  local list = (string.split)((self._shapeRecord).positionfriend, ",")
  return {x = tonumber(list[1]), y = tonumber(list[2]), z = tonumber(list[3])}
end

Role.GetNpcShapeRecord = function(self)
  -- function num : 0_46
  return self._shapeRecord
end

Role.GetNpcShapeScale = function(self)
  -- function num : 0_47 , upvalues : _ENV
  return tonumber((self._shapeRecord).scalerole)
end

Role.GetHandbookShapeScale = function(self)
  -- function num : 0_48 , upvalues : _ENV
  return tonumber((self._shapeRecord).scale)
end

Role.GetNpcShapeScaleFriend = function(self)
  -- function num : 0_49 , upvalues : _ENV
  return tonumber((self._shapeRecord).scalefriend)
end

Role.GetBattleWinNpcShapePosition = function(self)
  -- function num : 0_50 , upvalues : _ENV
  local list = (string.split)((self._shapeRecord).positionBattle, ",")
  return {x = tonumber(list[1]), y = tonumber(list[2]), z = tonumber(list[3])}
end

Role.GetBattleWinNpcShapeScale = function(self)
  -- function num : 0_51 , upvalues : _ENV
  return tonumber((self._shapeRecord).scaleBattle)
end

Role.GetGachaPosition = function(self)
  -- function num : 0_52 , upvalues : _ENV
  local list = (string.split)((self._shapeRecord).positiongacha, ",")
  return {x = tonumber(list[1]), y = tonumber(list[2]), z = tonumber(list[3])}
end

Role.GetGachaScale = function(self)
  -- function num : 0_53 , upvalues : _ENV
  return tonumber((self._shapeRecord).scalegacha)
end

Role.GetRarityId = function(self)
  -- function num : 0_54
  return (self._roleConfigRecord).rarity
end

Role.GetYardPrefab = function(self)
  -- function num : 0_55
  return {assetBundleName = (self._shapeRecord).assetBundleName, prefabName = (self._shapeRecord).yardPrefabName}
end

Role.GetCabinPrefab = function(self)
  -- function num : 0_56
  return {assetBundleName = (self._shapeRecord).assetBundleName, prefabName = (self._shapeRecord).dormPrefabName}
end

Role.GetPrefab = function(self)
  -- function num : 0_57
  return {assetBundleName = (self._shapeRecord).assetBundleName, prefabName = (self._shapeRecord).prefabName}
end

Role.IsAttacker = function(self)
  -- function num : 0_58
  do return (self._roleConfigRecord).hitornothit == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Role.GetProportion = function(self)
  -- function num : 0_59
  return {Hit = (self._roleConfigRecord).hitproportion, Rest = (self._roleConfigRecord).slackoffproportion}
end

Role.GetBigRarityImageRecord = function(self)
  -- function num : 0_60 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._roleRarityRecord).imgbigid) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetRoleInfoRarityImageRecord = function(self)
  -- function num : 0_61 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._roleRarityRecord).imgroleid) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetRarityImageRecord = function(self)
  -- function num : 0_62 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._roleRarityRecord).imgid) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetRarityBackRecord = function(self)
  -- function num : 0_63 , upvalues : CImagePathTable, _ENV
  if not self:IsUnlockUniqueEquip() then
    if not CImagePathTable:GetRecorder((self._roleRarityRecord).frameid) then
      do return DataCommon.DefaultImageAsset end
      if not CImagePathTable:GetRecorder((self._roleRarityRecord).UEframeid) then
        do return DataCommon.DefaultImageAsset end
      end
    end
  end
end

Role.GetRarityBottomBackRecord = function(self)
  -- function num : 0_64 , upvalues : CImagePathTable, _ENV
  if not self:IsUnlockUniqueEquip() then
    if not CImagePathTable:GetRecorder((self._roleRarityRecord).downback) then
      do return DataCommon.DefaultImageAsset end
      if not CImagePathTable:GetRecorder((self._roleRarityRecord).UEdownback) then
        do return DataCommon.DefaultImageAsset end
      end
    end
  end
end

Role.GetRarityDownBackRecord = function(self)
  -- function num : 0_65 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._roleRarityRecord).triangle) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetSmallRarityBackRecord = function(self)
  -- function num : 0_66 , upvalues : CImagePathTable, _ENV
  if not self:IsUnlockUniqueEquip() then
    if not CImagePathTable:GetRecorder((self._roleRarityRecord).frameidsmall) then
      do return DataCommon.DefaultImageAsset end
      if not CImagePathTable:GetRecorder((self._roleRarityRecord).UEframeidsmall) then
        do return DataCommon.DefaultImageAsset end
      end
    end
  end
end

Role.GetSmallRarityFrameRecord = function(self)
  -- function num : 0_67 , upvalues : CImagePathTable, _ENV
  if not self:IsUnlockUniqueEquip() then
    if not CImagePathTable:GetRecorder((self._roleRarityRecord).charframesmall) then
      do return DataCommon.DefaultImageAsset end
      if not CImagePathTable:GetRecorder((self._roleRarityRecord).UEcharframesmall) then
        do return DataCommon.DefaultImageAsset end
      end
    end
  end
end

Role.GetRarityFrameRecord = function(self)
  -- function num : 0_68 , upvalues : CImagePathTable, _ENV
  if not self:IsUnlockUniqueEquip() then
    if not CImagePathTable:GetRecorder((self._roleRarityRecord).charframe) then
      do return DataCommon.DefaultImageAsset end
      if not CImagePathTable:GetRecorder((self._roleRarityRecord).UEcharframe) then
        do return DataCommon.DefaultImageAsset end
      end
    end
  end
end

Role.GetTeamRarityImageRecord = function(self)
  -- function num : 0_69 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._roleRarityRecord).rankllarge) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetRarityRankDownRecord = function(self)
  -- function num : 0_70 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._roleRarityRecord).trianglelarge) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetTeamRarityBackRecord = function(self)
  -- function num : 0_71 , upvalues : CImagePathTable, _ENV
  if not self:IsUnlockUniqueEquip() then
    if not CImagePathTable:GetRecorder((self._roleRarityRecord).charcelllarge) then
      do return DataCommon.DefaultImageAsset end
      if not CImagePathTable:GetRecorder((self._roleRarityRecord).UEcharcelllarge) then
        do return DataCommon.DefaultImageAsset end
      end
    end
  end
end

Role.GetRarityDownRecord = function(self)
  -- function num : 0_72 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._roleRarityRecord).yardCell) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetRarityEvolutionEffect = function(self)
  -- function num : 0_73
  return (self._roleRarityRecord).evolutionEffect
end

Role.GetCurBreakFrame1ImageRecord = function(self)
  -- function num : 0_74 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._roleRarityRecord).breakLevelBackTriangle) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetCurBreakFrame2ImageRecord = function(self)
  -- function num : 0_75 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((self._roleRarityRecord).breakLevelBackPolygon) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetExploreSkillId = function(self)
  -- function num : 0_76
  return (self._roleConfigRecord).exploreskillid
end

Role.GetVocationSkillIdList = function(self)
  -- function num : 0_77
  return (self._roleConfigRecord).vocationskillid
end

Role.GetIsLeader = function(self)
  -- function num : 0_78
  do return self._isLeader == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Role.SetBreakLv = function(self, breakLv)
  -- function num : 0_79
  self._breakLv = breakLv
  local recorder = (self._allBreakRecords)[self._breakLv - 1]
  if recorder then
    self._preBreakRecord = recorder
  end
  recorder = (self._allBreakRecords)[self._breakLv]
  if recorder then
    self._roleBreakRecord = recorder
  end
  recorder = (self._allBreakRecords)[self._breakLv + 1]
  if recorder then
    self._nextBreakRecord = recorder
  end
end

Role.GetPreBreakLv = function(self)
  -- function num : 0_80
  if self._preBreakRecord then
    return (self._preBreakRecord).breaklv
  else
    return nil
  end
end

Role.GetBreakLv = function(self)
  -- function num : 0_81
  return self._breakLv
end

Role.GetNextBreakLv = function(self)
  -- function num : 0_82
  if self._nextBreakRecord then
    return (self._nextBreakRecord).breaklv
  else
    return nil
  end
end

Role.GetMaxBreakLv = function(self)
  -- function num : 0_83 , upvalues : _ENV
  local maxBreakLv = self._breakLv
  for breaklv,_ in pairs(self._allBreakRecords) do
    if maxBreakLv < breaklv then
      maxBreakLv = breaklv
    end
  end
  return maxBreakLv
end

Role.GetBreakType = function(self)
  -- function num : 0_84
  return (self._roleConfigRecord).breakType
end

local breakImage = {[0] = 12450, [1] = 12451, [2] = 12452, [3] = 12453, [4] = 12454}
Role.GetBreakImageRecord = function(self, breakLV)
  -- function num : 0_85 , upvalues : CImagePathTable, breakImage, _ENV
  if not CImagePathTable:GetRecorder(breakImage[breakLV]) then
    return DataCommon.DefaultImageAsset
  end
end

Role.GetPreBreakImageRecord = function(self)
  -- function num : 0_86
  local preBreakLV = self:GetPreBreakLv()
  if preBreakLV then
    return self:GetBreakImageRecord(preBreakLV)
  end
end

Role.GetCurBreakImageRecord = function(self)
  -- function num : 0_87
  return self:GetBreakImageRecord(self:GetBreakLv())
end

Role.GetNextBreakImageRecord = function(self)
  -- function num : 0_88
  local nextBreakLV = self:GetNextBreakLv()
  if nextBreakLV then
    return self:GetBreakImageRecord(nextBreakLV)
  end
end

Role.GetLevelMaxByBreakRecord = function(self, recorder)
  -- function num : 0_89
  if recorder then
    if self:IsUnlockUniqueEquip() then
      return recorder.unlocklevelmax
    else
      return recorder.levelmax
    end
  end
end

Role.GetBreakLvAndShowLvByRoleLv = function(self, lv)
  -- function num : 0_90 , upvalues : _ENV
  for i,recorder in ipairs(self._allBreakRecordList) do
    if lv <= self:GetLevelMaxByBreakRecord(recorder) then
      return recorder.breaklv, lv - recorder.levelmin
    end
  end
end

Role.GetBreakRecordList = function(self)
  -- function num : 0_91
  return self._allBreakRecordList
end

Role.GetBreakRecords = function(self)
  -- function num : 0_92
  return self._allBreakRecords
end

Role.GetShowLv = function(self)
  -- function num : 0_93
  local preBreakMaxLv = self:GetPreBreakMaxLevel()
  local realLevel = self:GetLevel()
  if preBreakMaxLv then
    return realLevel - preBreakMaxLv
  end
  return realLevel
end

Role.GetShowMaxBreakLv = function(self)
  -- function num : 0_94
  local preBreakMaxLv = self:GetPreBreakMaxLevel()
  local realMaxBreakLevel = self:GetMaxLevelIgnorePlayerLv()
  if preBreakMaxLv then
    return realMaxBreakLevel - preBreakMaxLv
  end
  return realMaxBreakLevel
end

Role.GetUnlockLive2DSkinIdByCurBreak = function(self)
  -- function num : 0_95
  if self._preBreakRecord and (self._preBreakRecord).skinID ~= 0 then
    return (self._preBreakRecord).skinID
  end
end

Role.GetUnlockLive2DSkinIdByNextBreak = function(self)
  -- function num : 0_96
  if self._roleBreakRecord and (self._roleBreakRecord).skinID ~= 0 then
    return (self._roleBreakRecord).skinID
  end
end

Role.SetLevel = function(self, lv)
  -- function num : 0_97 , upvalues : CRoleLevelCfgTable
  self._lv = lv
  self._roleLevelRecord = CRoleLevelCfgTable:GetRecorder(self._lv)
end

Role.GetLevel = function(self)
  -- function num : 0_98
  return self._lv
end

Role.SetExp = function(self, exp)
  -- function num : 0_99
  self._exp = exp
end

Role.GetExp = function(self)
  -- function num : 0_100
  return self._exp
end

Role.SetIsLock = function(self, lock)
  -- function num : 0_101
  self._lock = lock
end

Role.GetIsLock = function(self)
  -- function num : 0_102
  do return self._lock == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Role.SetProperties = function(self, properties)
  -- function num : 0_103 , upvalues : _ENV
  for k,v in pairs(properties) do
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

    if k ~= 10 and k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
      do
        (self._properties)[k] = v
        -- DECOMPILER ERROR at PC21: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC21: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
end

Role.GetProperties = function(self)
  -- function num : 0_104 , upvalues : _ENV
  local properties = {}
  for k,v in pairs(self._properties) do
    if k ~= 10 then
      properties[k] = v
    end
  end
  return properties
end

Role.GetCurrentHp = function(self)
  -- function num : 0_105 , upvalues : AttrTypeEnum
  return (self._properties)[AttrTypeEnum.HP]
end

Role.GetMaxHp = function(self)
  -- function num : 0_106 , upvalues : AttrTypeEnum
  return (self._properties)[AttrTypeEnum.MAX_HP]
end

Role.GetDefend = function(self)
  -- function num : 0_107 , upvalues : AttrTypeEnum
  return (self._properties)[AttrTypeEnum.DEFEND]
end

Role.GetMagDefend = function(self)
  -- function num : 0_108 , upvalues : AttrTypeEnum
  return (self._properties)[AttrTypeEnum.MAGIC_DEFEND]
end

Role.GetAttack = function(self)
  -- function num : 0_109 , upvalues : AttrTypeEnum
  return (self._properties)[AttrTypeEnum.ATTACK]
end

Role.GetMagAttack = function(self)
  -- function num : 0_110 , upvalues : AttrTypeEnum
  return (self._properties)[AttrTypeEnum.MAGIC_ATTACK]
end

Role.SetSupportSkill = function(self, supportSkill)
  -- function num : 0_111
  self._supportSkill = supportSkill
end

Role.GetSupportSkillId = function(self)
  -- function num : 0_112 , upvalues : _ENV
  if self._supportSkill then
    return (self._supportSkill).skillLevel
  else
    LogError("Role", "supportSkill is nil")
  end
end

Role.GetSupportSkillItemId = function(self)
  -- function num : 0_113 , upvalues : _ENV
  if self._supportSkill then
    return (self._supportSkill).skillItemId
  else
    LogError("Role", "supportSkill is nil")
  end
end

Role.SetWeapon = function(self, weapon)
  -- function num : 0_114
  self._weapon = weapon
end

Role.GetWeapon = function(self)
  -- function num : 0_115
  return self._weapon
end

Role.SetArmor = function(self, armor)
  -- function num : 0_116
  self._armor = armor
end

Role.GetArmor = function(self)
  -- function num : 0_117
  return self._armor
end

Role.SetJewelry = function(self, jewelry)
  -- function num : 0_118
  self._jewelry = jewelry
end

Role.GetJewelry = function(self)
  -- function num : 0_119
  return self._jewelry
end

Role.GetEquipKeyList = function(self)
  -- function num : 0_120 , upvalues : EquipTypeEnum
  return {[EquipTypeEnum.WEAPON] = self._weapon, [EquipTypeEnum.ARMOR] = self._armor, [EquipTypeEnum.JEWELRY] = self._jewelry}
end

Role.SetPreSetWeapon = function(self, weapon)
  -- function num : 0_121
  self._preSetWeapon = weapon
end

Role.GetPreSetWeapon = function(self)
  -- function num : 0_122
  return self._preSetWeapon
end

Role.SetPreSetArmor = function(self, armor)
  -- function num : 0_123
  self._preSetarmor = armor
end

Role.GetPreSetArmor = function(self)
  -- function num : 0_124
  return self._preSetarmor
end

Role.SetPreSetJewelry = function(self, jewelry)
  -- function num : 0_125
  self._preSetJewelry = jewelry
end

Role.GetPreSetJewelry = function(self)
  -- function num : 0_126
  return self._preSetJewelry
end

Role.GetPreSetEquipKeyList = function(self)
  -- function num : 0_127 , upvalues : EquipTypeEnum
  return {[EquipTypeEnum.WEAPON] = self._preSetWeapon, [EquipTypeEnum.ARMOR] = self._preSetarmor, [EquipTypeEnum.JEWELRY] = self._preSetJewelry}
end

Role.IsPreSetEquipListExist = function(self)
  -- function num : 0_128
  do return self._preSetarmor ~= 0 or self._preSetJewelry ~= 0 or self._preSetWeapon ~= 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Role.GetDeadTime = function(self)
  -- function num : 0_129
  return self._reviveTime - self._repairTime
end

Role.SetHurtExtent = function(self, hurtExtent)
  -- function num : 0_130
  self._hurtExtent = hurtExtent
end

Role.GetHurtExtent = function(self)
  -- function num : 0_131
  return self._hurtExtent
end

Role.SetReviveTime = function(self, reviveTime)
  -- function num : 0_132
  self._reviveTime = reviveTime
end

Role.GetReviveTime = function(self)
  -- function num : 0_133
  return self._reviveTime
end

Role.SetRepairTime = function(self, repairTime)
  -- function num : 0_134
  self._repairTime = repairTime
end

Role.GetRepairTime = function(self)
  -- function num : 0_135
  return self._repairTime
end

Role.GetMaxLevel = function(self)
  -- function num : 0_136 , upvalues : _ENV, CPlayerLevel
  local levelMax = self:GetMaxLevelIgnorePlayerLv()
  if levelMax then
    local userLevel = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).userlevel
    if userLevel < DataCommon.MaxPlayerLevel then
      local maxLevel = (CPlayerLevel:GetRecorder(userLevel)).roleMaxLv
      if maxLevel < levelMax then
        return maxLevel
      end
      return levelMax
    else
      do
        do return levelMax end
      end
    end
  end
end

Role.GetMaxLevelIgnorePlayerLv = function(self)
  -- function num : 0_137
  if self._roleBreakRecord then
    if self:IsUnlockUniqueEquip() then
      return (self._roleBreakRecord).unlocklevelmax
    else
      return (self._roleBreakRecord).levelmax
    end
  end
end

Role.GetMinLevel = function(self)
  -- function num : 0_138
  if self._roleBreakRecord then
    return (self._roleBreakRecord).levelmin
  end
end

Role.GetPreBreakMinLevel = function(self)
  -- function num : 0_139
  if self._preBreakRecord then
    return (self._preBreakRecord).levelmin
  end
end

Role.GetPreBreakMaxLevel = function(self)
  -- function num : 0_140
  if self._preBreakRecord then
    return self:GetLevelMaxByBreakRecord(self._preBreakRecord)
  end
end

Role.GetNextBreakMinLevel = function(self)
  -- function num : 0_141
  if self._nextBreakRecord then
    return (self._nextBreakRecord).levelmin
  end
end

Role.GetNextBreakMaxLevel = function(self)
  -- function num : 0_142
  if self._nextBreakRecord then
    return self:GetLevelMaxByBreakRecord(self._nextBreakRecord)
  end
end

Role.GetBreakSoul = function(self)
  -- function num : 0_143
  if self._roleBreakRecord then
    return (self._roleBreakRecord).goldcost
  end
end

Role.GetBreakItemList = function(self)
  -- function num : 0_144 , upvalues : _ENV
  local list = {}
  for i,v in ipairs((self._roleBreakRecord).itemId) do
    if v ~= 0 and ((self._roleBreakRecord).itemNum)[i] then
      local item = {}
      item.itemId = v
      item.itemNum = ((self._roleBreakRecord).itemNum)[i]
      ;
      (table.insert)(list, item)
    end
  end
  return list
end

Role.GetCurLvMaxExp = function(self)
  -- function num : 0_145
  if self:GetRarityId() == 1 then
    return (self._roleLevelRecord).Rexp
  end
  if self:GetRarityId() == 2 then
    return (self._roleLevelRecord).SRexp
  end
  if self:GetRarityId() == 3 then
    return (self._roleLevelRecord).SSRexp
  end
  if self:GetRarityId() == 4 then
    return (self._roleLevelRecord).URexp
  end
  if self:GetRarityId() == 5 then
    return (self._roleLevelRecord).EXexp
  end
end

Role.SetEvolution = function(self, evolution)
  -- function num : 0_146 , upvalues : _ENV, CRoleEvolutionCfg
  self._evolution = evolution
  self._roleEvolutionCfg = nil
  local evolutionType = (self._roleConfigRecord).evolutionType
  for _,id in ipairs(CRoleEvolutionCfg:GetAllIds()) do
    local record = CRoleEvolutionCfg:GetRecorder(id)
    if record.evolutionType == evolutionType and self._evolution + 1 == record.evolutionLevel then
      self._roleEvolutionCfg = record
      break
    end
  end
end

Role.GetEvolution = function(self)
  -- function num : 0_147
  return self._evolution
end

Role.GetEvolutionLimit = function(self)
  -- function num : 0_148
  return (self._roleConfigRecord).evolutionLimit
end

Role.SetCurLvBasePro = function(self, curLvBasePro)
  -- function num : 0_149 , upvalues : _ENV
  for k,v in pairs(self._curLvBasePro) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R7 in 'UnsetPending'

    (self._curLvBasePro)[k] = nil
  end
  for k,v in pairs(curLvBasePro) do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R7 in 'UnsetPending'

    if k ~= 10 and k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
      do
        (self._curLvBasePro)[k] = v
        -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
end

Role.GetCurLvBasePro = function(self)
  -- function num : 0_150
  return self._curLvBasePro
end

Role.SetNextLvBasePro = function(self, nextLvBasePro)
  -- function num : 0_151 , upvalues : _ENV
  for k,v in pairs(self._nextLvBasePro) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R7 in 'UnsetPending'

    (self._nextLvBasePro)[k] = nil
  end
  for k,v in pairs(nextLvBasePro) do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R7 in 'UnsetPending'

    if k ~= 10 and k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
      do
        (self._nextLvBasePro)[k] = v
        -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
end

Role.GetNextLvBasePro = function(self)
  -- function num : 0_152
  return self._nextLvBasePro
end

Role.SetBreakLvRange = function(self, breakLvRange)
  -- function num : 0_153 , upvalues : _ENV
  if self._breakLvRange == nil then
    self._breakLvRange = {}
  end
  for k,_ in pairs(self._breakLvRange) do
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R7 in 'UnsetPending'

    (self._breakLvRange)[k] = nil
  end
  for k,v in pairs(breakLvRange) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

    (self._breakLvRange)[k] = v
  end
end

Role.GetBreakLvRange = function(self)
  -- function num : 0_154
  return self._breakLvRange
end

Role.GetNextEvolutionLvBasePro = function(self)
  -- function num : 0_155
end

Role.IsInTeams = function(self, teamId)
  -- function num : 0_156 , upvalues : _ENV
  if teamId then
    local teamInfo = ((NekoData.BehaviorManager).BM_Team):GetTeamRoles(teamId)
    for station,roleKey in pairs(teamInfo) do
      if roleKey == self._roleId then
        return true
      end
    end
  else
    do
      local teamList = ((NekoData.BehaviorManager).BM_Team):GetTeamsInfo()
      for lineUpId,teamInfo in pairs(teamList) do
        for station,roleKey in pairs(teamInfo.roles) do
          if roleKey == self._roleId then
            return true
          end
        end
      end
      teamList = ((NekoData.BehaviorManager).BM_Team):GetTowerTeamsInfo()
      for lineUpId,teamInfo in pairs(teamList) do
        for station,roleKey in pairs(teamInfo.roles) do
          if roleKey == self._roleId then
            return true
          end
        end
      end
      teamList = ((NekoData.BehaviorManager).BM_Team):GetBossTeamsInfo()
      for lineUpId,teamInfo in pairs(teamList) do
        for station,roleKey in pairs(teamInfo.roles) do
          if roleKey == self._roleId then
            return true
          end
        end
      end
      teamList = ((NekoData.BehaviorManager).BM_Team):GetDefendRecoverTeamsInfo()
      for lineUpId,teamInfo in pairs(teamList) do
        for station,roleKey in pairs(teamInfo.roles) do
          if roleKey == self._roleId then
            return true
          end
        end
      end
      teamList = ((NekoData.BehaviorManager).BM_Team):GetAssassinDamageTeamsInfo()
      for lineUpId,teamInfo in pairs(teamList) do
        for station,roleKey in pairs(teamInfo.roles) do
          if roleKey == self._roleId then
            return true
          end
        end
      end
      teamList = ((NekoData.BehaviorManager).BM_Team):GetMagicImpairTeamsInfo()
      for lineUpId,teamInfo in pairs(teamList) do
        for station,roleKey in pairs(teamInfo.roles) do
          if roleKey == self._roleId then
            return true
          end
        end
      end
      teamList = ((NekoData.BehaviorManager).BM_Team):GetUndecidedRoadTeamsInfo()
      for lineUpId,teamInfo in pairs(teamList) do
        for station,roleKey in pairs(teamInfo.roles) do
          if roleKey == self._roleId then
            return true
          end
        end
      end
      do
        return false
      end
    end
  end
end

Role.IsInAlternativeTeams = function(self, teamId)
  -- function num : 0_157 , upvalues : _ENV, LineUpStation
  if teamId then
    local teamInfo = ((NekoData.BehaviorManager).BM_Team):GetTeamRoles(teamId)
    for station,roleKey in pairs(teamInfo) do
      if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
        return true
      end
    end
  else
    do
      local teamList = ((NekoData.BehaviorManager).BM_Team):GetTeamsInfo()
      for lineUpId,teamInfo in pairs(teamList) do
        for station,roleKey in pairs(teamInfo.roles) do
          if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
            return true
          end
        end
      end
      teamList = ((NekoData.BehaviorManager).BM_Team):GetTowerTeamsInfo()
      for lineUpId,teamInfo in pairs(teamList) do
        for station,roleKey in pairs(teamInfo.roles) do
          if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
            return true
          end
        end
      end
      teamList = ((NekoData.BehaviorManager).BM_Team):GetBossTeamsInfo()
      for lineUpId,teamInfo in pairs(teamList) do
        for station,roleKey in pairs(teamInfo.roles) do
          if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
            return true
          end
        end
      end
      teamList = ((NekoData.BehaviorManager).BM_Team):GetDefendRecoverTeamsInfo()
      for lineUpId,teamInfo in pairs(teamList) do
        for station,roleKey in pairs(teamInfo.roles) do
          if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
            return true
          end
        end
      end
      teamList = ((NekoData.BehaviorManager).BM_Team):GetAssassinDamageTeamsInfo()
      for lineUpId,teamInfo in pairs(teamList) do
        for station,roleKey in pairs(teamInfo.roles) do
          if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
            return true
          end
        end
      end
      teamList = ((NekoData.BehaviorManager).BM_Team):GetMagicImpairTeamsInfo()
      for lineUpId,teamInfo in pairs(teamList) do
        for station,roleKey in pairs(teamInfo.roles) do
          if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
            return true
          end
        end
      end
      teamList = ((NekoData.BehaviorManager).BM_Team):GetUndecidedRoadTeamsInfo()
      for lineUpId,teamInfo in pairs(teamList) do
        for station,roleKey in pairs(teamInfo.roles) do
          if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
            return true
          end
        end
      end
      do
        return false
      end
    end
  end
end

Role.GetTeamStation = function(self, teamId)
  -- function num : 0_158 , upvalues : _ENV
  local roleList = ((NekoData.BehaviorManager).BM_Team):GetTeamRoles(teamId)
  for station,roleKey in pairs(roleList) do
    if roleKey == self._roleId then
      return station
    end
  end
end

Role.SetRolePower = function(self, power)
  -- function num : 0_159
  self._power = power
end

Role.GetRolePower = function(self)
  -- function num : 0_160
  return self._power
end

Role.GetSoulSkillScore = function(self)
  -- function num : 0_161
end

Role.GetTalentPage = function(self)
  -- function num : 0_162
  return self._talentPage
end

Role.GetTalentRow = function(self)
  -- function num : 0_163
  return self._talentRow
end

Role.GetTalentInRowList = function(self)
  -- function num : 0_164
  return self._talentInRowList
end

Role.SetTalentPage = function(self, page)
  -- function num : 0_165
  self._talentPage = page
end

Role.SetTalentRow = function(self, row)
  -- function num : 0_166
  self._talentRow = row
end

Role.SetTalentInRowList = function(self, list)
  -- function num : 0_167
  self._talentInRowList = list
end

Role.GetVictoryTalk = function(self)
  -- function num : 0_168 , upvalues : _ENV
  if self:CanPlayVoice() then
    return (TextManager.GetText)((self._soundLinesRecord).Victory)
  end
end

Role.GetYardSkillList = function(self)
  -- function num : 0_169
  return (self._roleConfigRecord).yardskillid
end

Role.GetEnergy = function(self)
  -- function num : 0_170 , upvalues : _ENV
  return self._energy / DataCommon.RoleEnergyRatio
end

Role.SetBuildingId = function(self, buildingId)
  -- function num : 0_171
  self._buildingId = buildingId
end

Role.GetBuildingId = function(self)
  -- function num : 0_172
  return self._buildingId
end

Role.GetDamageType = function(self)
  -- function num : 0_173
  return (self._roleConfigRecord).damagetype
end

Role.GetEvolutionExclusiveItem = function(self)
  -- function num : 0_174
  if self._roleEvolutionCfg then
    return (self._roleEvolutionCfg).exclusiveItem
  end
end

Role.GetMaxEvolutionNeedItemCount = function(self)
  -- function num : 0_175 , upvalues : _ENV, CRoleEvolutionCfg
  local count = 0
  local evolutionType = (self._roleConfigRecord).evolutionType
  for _,id in ipairs(CRoleEvolutionCfg:GetAllIds()) do
    local record = CRoleEvolutionCfg:GetRecorder(id)
    if record.evolutionType == evolutionType and self._evolution < record.evolutionLevel then
      local data = (string.split)(record.exclusiveItem, "_")
      count = count + tonumber(data[2])
    end
  end
  return count
end

Role.GetEvolutionLevelRecords = function(self)
  -- function num : 0_176
  return self._evolutionLevelRecords
end

Role.GetEvolutionCurrentItem = function(self)
  -- function num : 0_177
  if self._roleEvolutionCfg then
    return (self._roleEvolutionCfg).currentItem
  end
end

Role.GetEvolutionChangeProName = function(self)
  -- function num : 0_178 , upvalues : _ENV, CAttreffectIdName
  if self._roleEvolutionCfg then
    for _,id in ipairs(CAttreffectIdName:GetAllIds()) do
      local record = CAttreffectIdName:GetRecorder(id)
      if record.ablEffctId == (self._roleEvolutionCfg).addProperty then
        return (TextManager.GetText)(record.classnameTextID)
      end
    end
  end
end

Role.GetEvolutionAddProOriginalValue = function(self)
  -- function num : 0_179 , upvalues : _ENV, CAttreffectIdName
  if self._roleEvolutionCfg then
    for _,id in ipairs(CAttreffectIdName:GetAllIds()) do
      local record = CAttreffectIdName:GetRecorder(id)
      if record.ablEffctId == (self._roleEvolutionCfg).addProperty then
        return (self:GetCurLvBasePro())[id]
      end
    end
  end
end

Role.GetEvolutionNewProValue = function(self)
  -- function num : 0_180 , upvalues : _ENV
  if self._roleEvolutionCfg and self._evolution < (self._roleConfigRecord).evolutionLimit then
    return (math.floor)(self:GetEvolutionAddProOriginalValue() + (self._roleEvolutionCfg).addPropertyValue)
  end
end

Role.CheckCanEvolutionByExclusiveItem = function(self)
  -- function num : 0_181 , upvalues : _ENV
  if not self._roleEvolutionCfg then
    self._canEvolution = false
    return 
  end
  local data = (string.split)((self._roleEvolutionCfg).exclusiveItem, "_")
  local exclusiveItemId = tonumber(data[1])
  local count = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(exclusiveItemId)
  self._canEvolution = tonumber(data[2]) <= count
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Role.CanEvolutionByExclusiveItem = function(self)
  -- function num : 0_182
  return self._canEvolution
end

Role.SetNewState = function(self, isNew)
  -- function num : 0_183
  self._isNew = isNew
end

Role.IsNew = function(self)
  -- function num : 0_184
  return self._isNew
end

Role.SetRelationLevel = function(self, lv)
  -- function num : 0_185
  self._relationLevel = lv
end

Role.GetRelationLevel = function(self)
  -- function num : 0_186
  return self._relationLevel
end

Role.GetRelationStage = function(self)
  -- function num : 0_187 , upvalues : _ENV, CFavourExp
  return (math.floor)((CFavourExp:GetRecorder(self._relationLevel)).heartnum / 10)
end

Role.SetRelationProgress = function(self, progress)
  -- function num : 0_188
  self._relationProgress = progress
end

Role.GetRelationProgress = function(self)
  -- function num : 0_189
  return self._relationProgress
end

Role.SetRelationReceiveMap = function(self, relationLv)
  -- function num : 0_190
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._relationReceiveMap)[relationLv] = true
end

Role.GetRelationReceiveMap = function(self)
  -- function num : 0_191
  return self._relationReceiveMap
end

Role.IsShowRelationRedDot = function(self)
  -- function num : 0_192 , upvalues : _ENV
  local rewardList = self:GetRelationRewardList()
  for i,v in ipairs(rewardList) do
    local favourLv = v.favourLv
    if self._relationLevel < favourLv then
      return false
    else
      if not (self._relationReceiveMap)[favourLv] then
        return true
      end
    end
  end
end

Role.GetRelationRewardList = function(self)
  -- function num : 0_193 , upvalues : _ENV
  local receiveMap = self:GetRelationReceiveMap()
  local list = {}
  for i,v in ipairs((self._relationPresentRecord).levelRewardType) do
    (table.insert)(list, {favourLv = i, rewardType = v, rewardId = ((self._relationPresentRecord).levelRewardID)[i], received = receiveMap[i]})
  end
  return list
end

Role.GetRelationMaxLevel = function(self)
  -- function num : 0_194
  return (self._relationPresentRecord).lvlmax
end

Role.GetRelationMaxProgress = function(self)
  -- function num : 0_195 , upvalues : CFavourExp
  local favourExpRecord = CFavourExp:GetRecorder(self._relationLevel)
  if self:GetRarityId() == 1 then
    return favourExpRecord.Rfavourexp
  end
  if self:GetRarityId() == 2 then
    return favourExpRecord.SRfavourexp
  end
  if self:GetRarityId() == 3 then
    return favourExpRecord.SSRfavourexp
  end
  if self:GetRarityId() == 4 then
    return favourExpRecord.URfavourexp
  end
  if self:GetRarityId() == 5 then
    return favourExpRecord.EXfavourexp
  end
end

Role.GetFavourGiftType = function(self)
  -- function num : 0_196
  return (self._roleConfigRecord).favourgift
end

Role.GetVocationId = function(self)
  -- function num : 0_197
  return (self._roleConfigRecord).vocation
end

Role.SetFashionId = function(self, fashionId)
  -- function num : 0_198
  self._defaultFashionId = fashionId
  self:UpdateShape()
  self:UpdateSoundLines()
end

Role.UpdateShape = function(self, fashionId)
  -- function num : 0_199 , upvalues : CSkin, CNpcShapeTable
  if fashionId and fashionId > 0 then
    self._defaultFashionId = fashionId
  end
  if self._defaultFashionId and self._defaultFashionId > 0 then
    local skin = CSkin:GetRecorder(self._defaultFashionId)
    self._shapeRecord = CNpcShapeTable:GetRecorder(skin.shapeID)
  end
end

Role.UpdateSoundLines = function(self)
  -- function num : 0_200 , upvalues : CSoundLines_skin, CSoundLines
  local soundLinesRecord = nil
  if self._defaultFashionId > 0 then
    soundLinesRecord = CSoundLines_skin:GetRecorder(self._defaultFashionId)
  end
  if not soundLinesRecord then
    soundLinesRecord = CSoundLines:GetRecorder(self._roleId)
  end
  self._soundLinesRecord = soundLinesRecord
end

Role.UpdateFashion = function(self, skins)
  -- function num : 0_201 , upvalues : _ENV
  if not skins then
    return 
  end
  for k,v in pairs(skins) do
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

    (self._fashions)[k] = {roleId = self._roleId, skinID = v.skinID, hasGotten = v.skinStatus > 0, isSelling = v.isInSelling > 0, index = 0}
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

Role.GetDefaultFashion = function(self)
  -- function num : 0_202
  return self._defaultFashionId
end

Role.GetFashionData = function(self)
  -- function num : 0_203 , upvalues : _ENV
  local fashions = {default = 0, 
list = {}
}
  for k,v in ipairs((self._roleSkinRecord).skinID) do
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R7 in 'UnsetPending'

    if (self._fashions)[v] then
      ((self._fashions)[v]).index = k
      ;
      (table.insert)(fashions.list, (self._fashions)[v])
      if self._defaultFashionId == 0 and k == 1 then
        self._defaultFashionId = v
      end
    else
      warn(">> nil value: ", v, k, self._roleId)
    end
  end
  fashions.default = self._defaultFashionId
  return fashions
end

Role.SetSkinRedDot = function(self, skinRecorder, showRedDot)
  -- function num : 0_204
  if not self._skinRedDot then
    self._skinRedDot = {}
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  if showRedDot then
    (self._skinRedDot)[skinRecorder.id] = skinRecorder
  else
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._skinRedDot)[skinRecorder.id] = nil
  end
end

Role.IsShowSkinRedDot = function(self)
  -- function num : 0_205 , upvalues : _ENV
  if not self._skinRedDot then
    return false
  end
  local tag = false
  for k,v in pairs(self._skinRedDot) do
    tag = true
    do break end
  end
  do
    if not tag then
      return false
    else
      return self._skinRedDot
    end
  end
end

Role.IsBoost = function(self)
  -- function num : 0_206 , upvalues : _ENV
  if self._eventBoostRecord then
    for k,v in pairs(self._eventBoostRecord) do
      -- DECOMPILER ERROR at PC62: Unhandled construct in 'MakeBoolean' P3

      -- DECOMPILER ERROR at PC62: Unhandled construct in 'MakeBoolean' P3

      if ((DialogManager.GetDialog)("activity.starmirage.selectlevelmaindialog") and v.eventid == (DataCommon.Activities).StarMirage) or not (DialogManager.GetDialog)("activity.swimsuitechoes.swimsuitmaindialog") or (DialogManager.GetDialog)("activity.swimsuitechoes.challenge.maindialog") or not (DialogManager.GetDialog)("activity.swimsuit.swimsuitmaindialog") or (DialogManager.GetDialog)("activity.starmirage1.maindialog") and v.eventid == (DataCommon.Activities).StarMirageCopy then
        local characterLargeCellStr = ""
        local changeTeamRoleCellStr = ""
        if v.eventid == (DataCommon.Activities).StarMirage then
          characterLargeCellStr = (string.gsub)((TextManager.GetText)(1900579), "%$parameter1%$", v.boostpercentage)
          changeTeamRoleCellStr = (TextManager.GetText)(1900578)
        else
          if v.eventid == (DataCommon.Activities).StarMirageCopy then
            local dialog = (DialogManager.GetDialog)("activity.starmirage1.maindialog")
            local str1Id = 2122
            local str2Id = 2123
            if dialog._tabType == ((dialog._TypeEnum).Type).Hard then
              str1Id = 2131
              str2Id = 2132
            end
            characterLargeCellStr = ((NekoData.BehaviorManager).BM_Message):GetString(str1Id, {v.boostpercentage})
            changeTeamRoleCellStr = ((NekoData.BehaviorManager).BM_Message):GetString(str2Id)
          else
            do
              do
                if v.eventid == (DataCommon.Activities).SummerEchoes then
                  characterLargeCellStr = ((NekoData.BehaviorManager).BM_Message):GetString(2180, {v.boostpercentage})
                  changeTeamRoleCellStr = ((NekoData.BehaviorManager).BM_Message):GetString(2181)
                else
                  if v.eventid == (DataCommon.Activities).SwimSuit then
                    characterLargeCellStr = ((NekoData.BehaviorManager).BM_Message):GetString(2184, {v.boostpercentage})
                    changeTeamRoleCellStr = ((NekoData.BehaviorManager).BM_Message):GetString(2185)
                  end
                end
                do return {activityId = v.eventid, characterLargeCellStr = characterLargeCellStr, changeTeamRoleCellStr = changeTeamRoleCellStr} end
                -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC176: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
end

Role.GetShowSkillDataByIndex = function(self, index)
  -- function num : 0_207
  return (self._showSkillList)[index]
end

Role.GetShowSkillData = function(self)
  -- function num : 0_208
  return self._showSkillList
end

Role.GetUnlockSkillNodes = function(self)
  -- function num : 0_209
  return self._unlockSkillNodes
end

Role.GetAllSkillNodes = function(self)
  -- function num : 0_210
  return self._allSkillNodes
end

Role.GetFirstSelectNodeId = function(self)
  -- function num : 0_211 , upvalues : _ENV
  local unlockNodes = self:GetUnlockSkillNodes()
  ;
  (self:GetAllSkillNodes())
  local allNodes = nil
  local nodeId, lastNodeId = nil, nil
  for k,v in pairs(allNodes) do
    if not unlockNodes[k] and (not nodeId or k < nodeId) then
      nodeId = k
    end
    if not lastNodeId or lastNodeId < k then
      lastNodeId = k
    end
  end
  do
    return nodeId or lastNodeId
  end
end

Role.AddLeaderSkill = function(self, skillItem)
  -- function num : 0_212 , upvalues : _ENV
  local data = {}
  data.skillId = skillItem.skillLevel
  data.selected = skillItem.selected == 1
  data.skillItemId = skillItem.skillItemId
  ;
  (table.insert)(self._notPassiveSkills, data)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Role.RefreshLeaderSkills = function(self, changedSkills)
  -- function num : 0_213 , upvalues : _ENV, Skill
  local deleteIndexList = {}
  for i,v in ipairs(self._showSkillList) do
    if not v.isPassive then
      (table.insert)(deleteIndexList, i)
    end
  end
  do
    while deleteIndexList[#deleteIndexList] do
      (table.remove)(self._showSkillList, deleteIndexList[#deleteIndexList])
      ;
      (table.remove)(deleteIndexList, deleteIndexList[#deleteIndexList])
    end
    local index = 1
    for i,v in ipairs(self._notPassiveSkills) do
      local skill = (Skill.Create)(v.skillId, v.skillItemId)
      v.selected = changedSkills[v.skillItemId] == 1
      if v.selected then
        (table.insert)(self._showSkillList, index, {skillId = v.skillId, skillItemId = v.skillItemId, unlock = true})
        index = index + 1
      end
    end
    for i = index + 1, 2 do
      if i == 1 then
        local skillItemId = (self._roleConfigRecord).contractskillid
        local skill = (Skill.Create)(skillItemId)
        ;
        (table.insert)(self._showSkillList, 1, {skillId = skill:GetSkillId(), skillItemId = skillItemId, unlock = false})
      elseif i == 2 then
        local skillItemId = (self._roleConfigRecord).contractskillid2
        local skill = (Skill.Create)(skillItemId)
        ;
        (table.insert)(self._showSkillList, 2, {skillId = skill:GetSkillId(), skillItemId = skillItemId, unlock = false})
      end
    end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

Role.GetActiveSkillList = function(self)
  -- function num : 0_214
  return self._notPassiveSkills
end

Role.GetSelectActiveSkillList = function(self)
  -- function num : 0_215 , upvalues : _ENV
  local list = {}
  for i,v in ipairs(self._notPassiveSkills) do
    if v.selected then
      (table.insert)(list, v.skillItemId)
    end
  end
  return list
end

Role.InitShowSkillsByOtherWays = function(self, contractSkill, passiveskill)
  -- function num : 0_216 , upvalues : _ENV, Skill
  self._showSkillList = {}
  for i,v in ipairs(contractSkill) do
    local data = {}
    data.skillId = v.skillLevel
    data.selected = v.selected == 1
    data.skillItemId = v.skillItemId
    if data.selected then
      (table.insert)(self._showSkillList, {skillId = data.skillId, skillItemId = data.skillItemId, unlock = true})
    end
  end
  local num = #self._showSkillList
  for i = num + 1, 2 do
    if i == 1 then
      local skillItemId = (self._roleConfigRecord).contractskillid
      local skill = (Skill.Create)(skillItemId)
      ;
      (table.insert)(self._showSkillList, {skillId = skill:GetSkillId(), skillItemId = skillItemId, unlock = false})
    elseif i == 2 then
      local skillItemId = (self._roleConfigRecord).contractskillid2
      local skill = (Skill.Create)(skillItemId)
      ;
      (table.insert)(self._showSkillList, {skillId = skill:GetSkillId(), skillItemId = skillItemId, unlock = false})
    end
  end
  for i,v in ipairs(passiveskill) do
    local skill = (Skill.Create)(v.id, true)
    if skill:GetType() == (Skill.Type).Passive then
      (table.insert)(self._showSkillList, {skillId = v.id, unlock = true, isPassive = true})
    end
  end
  num = #self._showSkillList
  if num < 3 then
    (table.insert)(self._showSkillList, {skillId = (self._roleConfigRecord).contractskillid3, unlock = false, isPassive = true})
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

Role.IsShowSkillRedDot = function(self)
  -- function num : 0_217 , upvalues : _ENV
  local unlockNodes = self:GetUnlockSkillNodes()
  local allNodes = self:GetAllSkillNodes()
  for k,nodeRecord in pairs(allNodes) do
    if nodeRecord.serverUnlock == 0 then
      local isSpecialUnlock = unlockNodes[k]
      if nodeRecord.roleSkill > self:GetLevel() then
        local roleLvEnough = isSpecialUnlock
        if roleLvEnough then
          local frontNodesUnlock = true
          local frontList = nil
          if nodeRecord.frontNode ~= "-1" then
            frontList = (string.split)(nodeRecord.frontNode, ";")
          end
          if frontList then
            for _,nodeId in ipairs(frontList) do
              if not unlockNodes[tonumber(nodeId)] then
                frontNodesUnlock = false
                break
              end
            end
          end
          local costEnough = true
          if frontNodesUnlock then
            local mana = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.ManaID)
            if mana < nodeRecord.money then
              costEnough = false
            end
            if costEnough then
              for i,v in ipairs(nodeRecord.itemID) do
                local num = (nodeRecord.itemNum)[i]
                if costEnough then
                  local haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(v)
                  costEnough = num <= haveNum
                end
              end
            end
            if costEnough then
              return true
            end
          end
        end
        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_STMT

        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC94: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  do return false end
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

Role.GetRoleEquipSuitMap = function(self)
  -- function num : 0_218 , upvalues : _ENV
  local suitIDs = {}
  local equips = (self:GetEquipKeyList())
  -- DECOMPILER ERROR at PC3: Overwrote pending register: R3 in 'AssignReg'

  local temp = .end
  for k,v in pairs(equips) do
    if v and v > 0 then
      temp = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(v)
      suitIDs[temp:GetEquipType()] = temp:GetEquipSuitId()
    end
  end
  return suitIDs
end

Role.GetSuitSkillsMap = function(self)
  -- function num : 0_219
  return self._suitSkillsMap
end

Role.GetPreSetRoleEquipSuitMap = function(self)
  -- function num : 0_220 , upvalues : _ENV
  local suitIDs = {}
  local equips = (self:GetPreSetEquipKeyList())
  -- DECOMPILER ERROR at PC3: Overwrote pending register: R3 in 'AssignReg'

  local temp = .end
  for k,v in pairs(equips) do
    if v and v > 0 then
      temp = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(v)
      suitIDs[temp:GetEquipType()] = temp:GetEquipSuitId()
    end
  end
  return suitIDs
end

Role.GetPreSetSuitSkillsMap = function(self)
  -- function num : 0_221 , upvalues : _ENV
  local suitIDs = {}
  local equips = (self:GetPreSetEquipKeyList())
  -- DECOMPILER ERROR at PC3: Overwrote pending register: R3 in 'AssignReg'

  local temp = .end
  for k,v in pairs(equips) do
    if v and v > 0 then
      temp = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(v)
      local id = temp:GetEquipSuitId()
      if suitIDs[id] then
        suitIDs[id] = suitIDs[id] + 1
      else
        suitIDs[id] = 1
      end
    end
  end
  local skillsMap = {}
  local CEquipSuit = (BeanManager.GetTableByName)("equip.cequipsuit")
  for k,v in pairs(suitIDs) do
    local suitRecorder = CEquipSuit:GetRecorder(k)
    if suitRecorder then
      for i,skillId in ipairs(suitRecorder.suitSkillID) do
        if i <= v and skillId ~= 0 then
          if skillsMap[k] then
            (table.insert)((skillsMap[k]).skillIds, skillId)
          else
            skillsMap[k] = {
skillIds = {skillId}
}
          end
        end
      end
    end
  end
  return skillsMap
end

Role.GetElement = function(self)
  -- function num : 0_222
  return (self._roleConfigRecord).element
end

Role.GetElementName = function(self)
  -- function num : 0_223 , upvalues : CElementCfgTable, _ENV
  local record = CElementCfgTable:GetRecorder((self._roleConfigRecord).element)
  if record then
    return (TextManager.GetText)(record.nameid)
  else
    LogErrorFormat("Role", "wrong elementid %s with roleid %s", (self._roleConfigRecord).element, self._roleId)
  end
end

Role.GetElementImageRecord = function(self)
  -- function num : 0_224 , upvalues : CElementCfgTable, CImagePathTable, _ENV
  local record = CElementCfgTable:GetRecorder((self._roleConfigRecord).element)
  if record then
    if not CImagePathTable:GetRecorder(record.image) then
      do return DataCommon.DefaultImageAsset end
      LogErrorFormat("Role", "wrong elementid %s with roleid %s", (self._roleConfigRecord).element, self._roleId)
    end
  end
end

Role.GetUniqueEquipId = function(self)
  -- function num : 0_225
  if (self._roleConfigRecord).uniqueequipid ~= 0 and self._uniqueEquipLevel and self._uniqueEquipLevel > -1 then
    return (self._roleConfigRecord).uniqueequipid
  end
end

Role.SetUniqueEquipLevel = function(self, lv)
  -- function num : 0_226
  self._uniqueEquipLevel = lv
end

Role.GetUniqueEquipLevel = function(self)
  -- function num : 0_227
  return self._uniqueEquipLevel
end

Role.IsUnlockUniqueEquip = function(self)
  -- function num : 0_228
  do return not self:GetUniqueEquipId() or not self:GetUniqueEquipLevel() or self:GetUniqueEquipLevel() > 0 end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

Role.SetUniqueEquipAttrs = function(self, data)
  -- function num : 0_229 , upvalues : _ENV
  LogInfoFormat("SetUniqueEquipAttrs", "roleId = %s, uniqueEquipLevel = %s", self._roleId, data.specialWeaponLevel)
  self._uniqueEquipLevel = data.specialWeaponLevel
  if not self._uniqueEquipCurLvAttrs then
    self._uniqueEquipCurLvAttrs = {}
  end
  for k,v in pairs(self._uniqueEquipCurLvAttrs) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

    (self._uniqueEquipCurLvAttrs)[k] = nil
  end
  for k,v in pairs(data.specialWeaponProperties) do
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

    (self._uniqueEquipCurLvAttrs)[k] = v
    LogInfoFormat("SetUniqueEquipAttrs", "cur:  k = %s, v = %s", k, v)
  end
  if not self._uniqueEquipNextLvAttrs then
    self._uniqueEquipNextLvAttrs = {}
  end
  for k,v in pairs(self._uniqueEquipNextLvAttrs) do
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

    (self._uniqueEquipNextLvAttrs)[k] = nil
  end
  for k,v in pairs(data.specialWeaponPropertiesForNextLevel) do
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R7 in 'UnsetPending'

    (self._uniqueEquipNextLvAttrs)[k] = v
    LogInfoFormat("SetUniqueEquipAttrs", "next:  k = %s, v = %s", k, v)
  end
end

Role.SetUniqueEquipSkillOpen = function(self, value)
  -- function num : 0_230 , upvalues : _ENV
  local SSpecialWeaponSkillSwitch = require("protocols.def.protocol.item.sspecialweaponskillswitch")
  self._skillOpen = value == SSpecialWeaponSkillSwitch.OPEN
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Role.GetUniqueEquipCurAttrs = function(self)
  -- function num : 0_231 , upvalues : _ENV
  local map = {}
  if self._uniqueEquipCurLvAttrs then
    for k,v in pairs(self._uniqueEquipCurLvAttrs) do
      map[k] = v
    end
  end
  do
    return map
  end
end

Role.GetUniqueEquipNextAttrs = function(self)
  -- function num : 0_232 , upvalues : _ENV
  local map = {}
  if self._uniqueEquipNextLvAttrs then
    for k,v in pairs(self._uniqueEquipNextLvAttrs) do
      map[k] = v
    end
  end
  do
    return map
  end
end

Role.IsOpenUniqueEquipSkill = function(self)
  -- function num : 0_233
  return self._skillOpen
end

Role.SetBaseProAddPercent = function(self, addPercent)
  -- function num : 0_234
  self._baseProAddPercent = addPercent
end

Role.GetBaseProAddPercent = function(self)
  -- function num : 0_235
  return self._baseProAddPercent
end

Role.IsShowSkillRedDotById = function(self, skillNodeId)
  -- function num : 0_236 , upvalues : _ENV
  local unlockNodes = self:GetUnlockSkillNodes()
  local allNodes = self:GetAllSkillNodes()
  local nodeRecord = allNodes[skillNodeId]
  if nodeRecord.serverUnlock == 0 then
    local isSpecialUnlock = not nodeRecord or unlockNodes[skillNodeId]
    if nodeRecord.roleSkill > self:GetLevel() then
      local roleLvEnough = isSpecialUnlock
      if roleLvEnough then
        local frontNodesUnlock = true
        local frontList = nil
        if nodeRecord.frontNode ~= "-1" then
          frontList = (string.split)(nodeRecord.frontNode, ";")
        end
        if frontList then
          for _,nodeId in ipairs(frontList) do
            if not unlockNodes[tonumber(nodeId)] then
              frontNodesUnlock = false
              break
            end
          end
        end
        local costEnough = true
        if frontNodesUnlock then
          local mana = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.ManaID)
          if mana < nodeRecord.money then
            costEnough = false
          end
          if costEnough then
            for i,v in ipairs(nodeRecord.itemID) do
              local num = (nodeRecord.itemNum)[i]
              if costEnough then
                local haveNum = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(v)
                costEnough = num <= haveNum
              end
            end
          end
          if costEnough then
            return true
          end
        end
      end
      -- DECOMPILER ERROR: 10 unprocessed JMP targets
    end
  end
end

Role.IsShowEvolutionRedDotByLv = function(self, lv)
  -- function num : 0_237 , upvalues : _ENV
  if not self._roleEvolutionCfg or lv ~= self._evolution + 1 then
    return false
  end
  local record = (self._evolutionLevelRecords)[lv]
  if record then
    local data = (string.split)(record.exclusiveItem, "_")
    local exclusiveItemId = tonumber(data[1])
    local count = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(exclusiveItemId)
    return tonumber(data[2]) <= count
  else
    LogError("Role", "lv is greater than EvolutionLimit")
    return false
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

Role.IsShowSkinRedDotById = function(self, skinID)
  -- function num : 0_238
  if not self._skinRedDot then
    return false
  end
  return (self._skinRedDot)[skinID]
end

Role.GetSkinIDList = function(self)
  -- function num : 0_239
  return (self._roleSkinRecord).skinID
end

Role.IsShowBreakRedDotByLv = function(self, breakLv)
  -- function num : 0_240 , upvalues : _ENV
  if breakLv <= self:GetBreakLv() or self:GetBreakLv() == self:GetMaxBreakLv() then
    return false
  end
  local breakRecord = (self._allBreakRecordList)[breakLv]
  if breakRecord.levelmax <= self:GetLevel() then
    if breakRecord.goldcost > ((NekoData.BehaviorManager).BM_Currency):GetMoney() then
      do
        local tag = not breakRecord
        if tag then
          for i,v in ipairs(breakRecord.itemId) do
            if v ~= 0 and (breakRecord.itemNum)[i] then
              local count = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(v)
              if count < (breakRecord.itemNum)[i] then
                return false
              end
            end
          end
        end
        do return tag end
        do return false end
        LogError("Role", "lv is greater than MaxBreakLv")
        do return false end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
end

Role.SetRuneLevel = function(self, runeLevel)
  -- function num : 0_241
  self._runeLevel = runeLevel
end

Role.GetRuneLevel = function(self)
  -- function num : 0_242
  return self._runeLevel
end

return Role

