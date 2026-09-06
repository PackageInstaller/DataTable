local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CVocationCfgTable = BeanManager.GetTableByName("role.cvocationcfg")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CRoleRarityCfgTable = BeanManager.GetTableByName("role.croleraritycfg")
local CRoleLevelCfgTable = BeanManager.GetTableByName("role.crolelevelcfg")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CRoleBreakCfgTable = BeanManager.GetTableByName("role.crolebreakcfg")
local CRoleItemTable = BeanManager.GetTableByName("item.croleitem")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CTalentPageCfg = BeanManager.GetTableByName("role.ctalentpagecfg")
local CTalentCfg = BeanManager.GetTableByName("role.ctalentcfg")
local CRoleEvolutionCfg = BeanManager.GetTableByName("role.croleevolutioncfg")
local CRoleSkin = BeanManager.GetTableByName("role.croleskin")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CPlayerLevel = BeanManager.GetTableByName("role.cplayerlevel")
local CAttreffectIdName = BeanManager.GetTableByName("role.cattreffectidname")
local CSoundLines = BeanManager.GetTableByName("sound.csoundlines")
local CSoundLines_skin = BeanManager.GetTableByNameWithLanguage("sound.csoundlines_skin")
local CElementCfgTable = BeanManager.GetTableByName("role.celementcfg")
local CCardRoleConfig_HandBook = BeanManager.GetTableByName("handbook.ccardroleconfig_handbook")
local CFavourPresent = BeanManager.GetTableByName("role.cfavourpresent")
local CFavourExp = BeanManager.GetTableByName("role.cfavourexp")
local AttrTypeEnum = LuaNetManager.GetBeanDef("protocol.login.attrtype")
local EquipTypeEnum = LuaNetManager.GetBeanDef("protocol.item.equiptype")
local SlotEnum = LuaNetManager.GetBeanDef("protocol.yard.task")
local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
local CEventBoostRole = BeanManager.GetTableByName("activity.ceventboostrole")
local Skill = require("logic.manager.experimental.types.skill")
local CSkillMapTable = BeanManager.GetTableByName("skill.cskillmap")
local Role = strictclass("Role")

function Role:Ctor(id, roleInfo, isBase)
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
      if record.roleID == self._roleId then
        self._allSkillNodes[record.id] = record
      end
    end
    self._allBreakRecords = {}
    allIds = CRoleBreakCfgTable:GetAllIds()
    for i = 1, #allIds do
      local recorder = CRoleBreakCfgTable:GetRecorder(allIds[i])
      if recorder.breakType == self:GetBreakType() then
        self._allBreakRecords[recorder.breaklv] = recorder
      end
    end
    self._allBreakRecordList = {}
    for k, v in pairs(self._allBreakRecords) do
      table.insert(self._allBreakRecordList, v)
    end
    table.sort(self._allBreakRecordList, function(a, b)
      return a.breaklv < b.breaklv
    end)
    self._evolutionLevelRecords = {}
    local evolutionType = self._roleConfigRecord.evolutionType
    for _, id in ipairs(CRoleEvolutionCfg:GetAllIds()) do
      local record = CRoleEvolutionCfg:GetRecorder(id)
      if record.evolutionType == evolutionType then
        table.insert(self._evolutionLevelRecords, record)
      end
    end
    table.sort(self._evolutionLevelRecords, function(a, b)
      return a.evolutionLevel < b.evolutionLevel
    end)
    self._eventBoostRecord = {}
    allIds = CEventBoostRole:GetAllIds()
    len = #allIds
    for i = 1, len do
      local record = CEventBoostRole:GetRecorder(allIds[i])
      if record.roleid == self._roleId then
        self._eventBoostRecord[record.id] = record
      end
    end
  end
  if self._roleConfigRecord then
    self._shapeRecord = CNpcShapeTable:GetRecorder(self._roleConfigRecord.shapeID)
  else
    LogErrorFormat("Role", "role id %s is wrong", id)
  end
  self:RefreshByRoleInfo(roleInfo, isBase)
  if self._roleConfigRecord then
    self._vocationRecord = CVocationCfgTable:GetRecorder(self._roleConfigRecord.vocation)
    self._roleRarityRecord = CRoleRarityCfgTable:GetRecorder(self._roleConfigRecord.rarity)
    self._vocationName = TextManager.GetText(self._vocationRecord.nameTextID)
  end
end

function Role:RefreshByRoleInfo(roleInfo, isBase)
  if roleInfo then
    self._isLeader = roleInfo.isLeader
    self._birthday = roleInfo.birthday
    self._breakLv = roleInfo.breakLv
    self._lv = roleInfo.lv
    self._exp = roleInfo.exp
    self._lock = roleInfo.lock
    self._properties = roleInfo.properties
    self._isNew = roleInfo.redDot == 1
    for k, v in pairs(self._properties) do
      if k ~= 10 and k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
        self._properties[k] = nil
      end
    end
    if self._showSkillList then
      while self._showSkillList[#self._showSkillList] do
        table.remove(self._showSkillList, #self._showSkillList)
      end
    else
      self._showSkillList = {}
    end
    if self._notPassiveSkills then
      while self._notPassiveSkills[#self._notPassiveSkills] do
        table.remove(self._notPassiveSkills, #self._notPassiveSkills)
      end
    else
      self._notPassiveSkills = {}
    end
    for i, v in ipairs(roleInfo.contractSkill) do
      local data = {}
      data.skillId = v.skillLevel
      data.skillItemId = v.skillItemId
      data.selected = v.selected == 1
      table.insert(self._notPassiveSkills, data)
      if data.selected then
        table.insert(self._showSkillList, {
          skillId = data.skillId,
          skillItemId = data.skillItemId,
          unlock = true
        })
      end
    end
    local num = #self._showSkillList
    for i = num + 1, 2 do
      if i == 1 then
        local skillItemId = self._roleConfigRecord.contractskillid
        local skill = Skill.Create(skillItemId)
        table.insert(self._showSkillList, {
          skillId = skill:GetSkillId(),
          skillItemId = skillItemId,
          unlock = false
        })
      elseif i == 2 then
        local skillItemId = self._roleConfigRecord.contractskillid2
        local skill = Skill.Create(skillItemId)
        table.insert(self._showSkillList, {
          skillId = skill:GetSkillId(),
          skillItemId = skillItemId,
          unlock = false
        })
      end
    end
    if self._passiveSkills then
      while self._passiveSkills[#self._passiveSkills] do
        table.remove(self._passiveSkills, #self._passiveSkills)
      end
    else
      self._passiveSkills = {}
    end
    for i, v in ipairs(roleInfo.passiveskill) do
      table.insert(self._passiveSkills, v.id)
      local skill = Skill.Create(v.id, true)
      if skill:GetType() == Skill.Type.Passive then
        table.insert(self._showSkillList, {
          skillId = v.id,
          unlock = true,
          isPassive = true
        })
      end
    end
    num = #self._showSkillList
    if num < 3 then
      table.insert(self._showSkillList, {
        skillId = self._roleConfigRecord.contractskillid3,
        unlock = false,
        isPassive = true
      })
    end
    if self._unlockSkillNodes then
      for k, v in pairs(self._unlockSkillNodes) do
        self._unlockSkillNodes[k] = nil
      end
    else
      self._unlockSkillNodes = {}
    end
    for _, v in ipairs(roleInfo.unlockedNode) do
      self._unlockSkillNodes[v] = true
    end
    self._weapon = roleInfo.equips[EquipTypeEnum.WEAPON]
    self._armor = roleInfo.equips[EquipTypeEnum.ARMOR]
    self._jewelry = roleInfo.equips[EquipTypeEnum.JEWELRY]
    self._preSetWeapon = roleInfo.preSetEquips[EquipTypeEnum.WEAPON]
    self._preSetarmor = roleInfo.preSetEquips[EquipTypeEnum.ARMOR]
    self._preSetJewelry = roleInfo.preSetEquips[EquipTypeEnum.JEWELRY]
    self._hurtExtent = 0
    self._reviveTime = 0
    self._repairTime = 0
    self._evolution = roleInfo.evolution
    self._curLvBasePro = roleInfo.curLvBasePro
    for k, v in pairs(self._curLvBasePro) do
      if k ~= 10 and k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
        self._curLvBasePro[k] = nil
      end
    end
    self._nextLvBasePro = roleInfo.nextLvBasePro
    for k, v in pairs(self._nextLvBasePro) do
      if k ~= 10 and k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
        self._nextLvBasePro[k] = nil
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
    local recorder = self._allBreakRecords[self._breakLv - 1]
    if recorder then
      self._preBreakRecord = recorder
    end
    recorder = self._allBreakRecords[self._breakLv]
    if recorder then
      self._roleBreakRecord = recorder
    end
    recorder = self._allBreakRecords[self._breakLv + 1]
    if recorder then
      self._nextBreakRecord = recorder
    end
    self._roleLevelRecord = CRoleLevelCfgTable:GetRecorder(self._lv)
    self._energy = roleInfo.energy
    self._relationLevel = roleInfo.relationLevel
    self._relationProgress = roleInfo.goodProgress
    if self._relationReceiveMap then
      for k, v in pairs(self._relationReceiveMap) do
        self._relationReceiveMap[k] = nil
      end
    else
      self._relationReceiveMap = {}
    end
    for _, v in ipairs(roleInfo.receiveList) do
      self._relationReceiveMap[v] = true
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
    if not isBase and self._evolution then
      local evolutionType = self._roleConfigRecord.evolutionType
      for _, id in ipairs(CRoleEvolutionCfg:GetAllIds()) do
        local record = CRoleEvolutionCfg:GetRecorder(id)
        if record.evolutionType == evolutionType and self._evolution + 1 == record.evolutionLevel then
          self._roleEvolutionCfg = record
          break
        end
      end
      self:CheckCanEvolutionByExclusiveItem()
    end
    self:UpdateShape()
  else
    LogErrorFormat("Role", "role id %s is wrong", id)
  end
end

function Role:Clone()
  return clone(self)
end

function Role:GetRoleId()
  return self._roleId
end

function Role:GetId()
  return self._roleId
end

function Role:GetRoleConfig()
  return self._roleConfigRecord
end

function Role:GetItemId()
  for k, v in pairs(CRoleItemTable:GetAllIds()) do
    local recorder = CRoleItemTable:GetRecorder(v)
    if recorder.roleid == self._roleId then
      return recorder.id
    end
  end
end

function Role:CanResolve()
  local record = CItemAttrTable:GetRecorder(self:GetItemId())
  if record then
    return record.resolvegetitem and #record.resolvegetitem > 0 and 0 < record.resolvegetitem[1]
  end
  return false
end

function Role:GetBirthDay()
  return self._birthday
end

function Role:GetRoleName()
  local name = TextManager.GetText(self._roleConfigRecord.nameTextID)
  return string.gsub(name, "%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username)
end

function Role:GetTitleName()
  return TextManager.GetText(self._roleConfigRecord.titleTextID)
end

function Role:GetCvName()
  return self._roleConfigRecord.cv
end

function Role:GetTitle()
  return TextManager.GetText(self._roleConfigRecord.titleTextID)
end

function Role:GetArtistName()
  return self._roleConfigRecord.artist
end

function Role:GetRoleHeight()
  return self._roleConfigRecord.height
end

function Role:GetRoleWeight()
  return self._roleConfigRecord.weight
end

function Role:GetRoleBloodType()
  return self._roleConfigRecord.bloodtype
end

function Role:GetRoleHobby()
  return self._roleConfigRecord.hobby
end

function Role:GetRoleAttribute()
  return self._roleConfigRecord.attribute
end

function Role:GetRoleBackStory()
  return self._roleConfigRecord.backstory
end

function Role:CanPlayVoice()
  local record = CCardRoleConfig_HandBook:GetRecorder(self._roleId)
  if not record then
    LogErrorFormat("Role", "record with roleid %s is not exist in ccardroleconfig_handbook", self._roleId)
    return
  end
  return record.vocal and record.vocal == 1
end

function Role:GetRoleEquipTypeList()
  local str = self._roleConfigRecord.roleEquipType
  local list = {}
  if str and str ~= "" then
    list = string.split(str, ";")
  end
  return list
end

function Role:GetVocationId()
  return self._vocationRecord.id
end

function Role:GetVocationName()
  return self._vocationName
end

function Role:GetVocationNameId()
  return self._vocationRecord.nameTextID
end

function Role:GetVocationImageRecord()
  if self:GetRarityId() == 1 then
    return CImagePathTable:GetRecorder(self._vocationRecord.imgR) or DataCommon.DefaultImageAsset
  end
  if self:GetRarityId() == 2 then
    return CImagePathTable:GetRecorder(self._vocationRecord.imgSR) or DataCommon.DefaultImageAsset
  end
  if self:GetRarityId() == 3 then
    return CImagePathTable:GetRecorder(self._vocationRecord.imgSSR) or DataCommon.DefaultImageAsset
  end
  if self:GetRarityId() == 4 then
    return CImagePathTable:GetRecorder(self._vocationRecord.imgUR) or DataCommon.DefaultImageAsset
  end
  if self:GetRarityId() == 5 then
    return CImagePathTable:GetRecorder(self._vocationRecord.imgEX) or DataCommon.DefaultImageAsset
  end
end

function Role:GetVocationDescribeImageRecord()
  return CImagePathTable:GetRecorder(self._vocationRecord.imgDescribe) or DataCommon.DefaultImageAsset
end

function Role:GetVocationImgDrawRecord()
  return CImagePathTable:GetRecorder(self._vocationRecord.imgDraw) or DataCommon.DefaultImageAsset
end

function Role:GetVocationBackgroundImgRecord()
  return CImagePathTable:GetRecorder(self._vocationRecord.imgBackground) or DataCommon.DefaultImageAsset
end

function Role:GetShapeBustImageRecord()
  return CImagePathTable:GetRecorder(self._shapeRecord.bustID) or DataCommon.DefaultImageAsset
end

function Role:GetShapeBigBustImageRecord()
  return CImagePathTable:GetRecorder(self._shapeRecord.bigbustID) or DataCommon.DefaultImageAsset
end

function Role:GetShapeLiHuiImageRecord()
  return CImagePathTable:GetRecorder(self._shapeRecord.lihuiID) or DataCommon.DefaultImageAsset
end

function Role:GetShapeHeadImageRecord()
  return CImagePathTable:GetRecorder(self._shapeRecord.headID) or DataCommon.DefaultImageAsset
end

function Role:GetShapeLittleHeadImageRecord()
  if self._shapeRecord.littleHeadID ~= 0 then
    return CImagePathTable:GetRecorder(self._shapeRecord.littleHeadID) or DataCommon.DefaultImageAsset
  end
  return DataCommon.DefaultImageAsset
end

function Role:GetDiamondHeadImageRecord()
  return CImagePathTable:GetRecorder(self._shapeRecord.DiamondHeadID) or DataCommon.DefaultImageAsset
end

function Role:GetGachaRoleImageRecord()
  return CImagePathTable:GetRecorder(self._shapeRecord.drawShowID) or DataCommon.DefaultImageAsset
end

function Role:GetModelRecord()
  local data = {}
  data.assetBundle = self._shapeRecord.assetBundleName
  data.assetName = self._shapeRecord.prefabNameUI
  return data
end

function Role:IsFashionLive2D()
  local skin = CSkin:GetRecorder(self._defaultFashionId)
  if skin then
    return skin.shapeType == 2
  else
    return false
  end
end

function Role:GetShapeLive2DRecord()
  local t = {}
  if self._shapeRecord.live2DPrefabName ~= "" and self._shapeRecord.live2DAssetBundleName ~= "" then
    t.live2DPrefabName = self._shapeRecord.live2DPrefabName
    t.live2DAssetBundleName = self._shapeRecord.live2DAssetBundleName
    t.live2DScale = self._shapeRecord.live2DScale
  end
  return t
end

function Role:GetPhotoScale()
  return self._shapeRecord.photoScale
end

function Role:GetPhotoPosition()
  return self._shapeRecord.photoLocation
end

function Role:GetBattleEmotion()
  return tonumber(self._shapeRecord.battleEmotion)
end

function Role:GetSkillHeadImageRecord()
  return CImagePathTable:GetRecorder(self._shapeRecord.skillHeadID) or DataCommon.DefaultImageAsset
end

function Role:GetNpcShapePosition()
  local list = string.split(self._shapeRecord.positionrole, ",")
  return {
    x = tonumber(list[1]),
    y = tonumber(list[2]),
    z = tonumber(list[3])
  }
end

function Role:GetHandbookShapePosition()
  local list = string.split(self._shapeRecord.position, ",")
  return {
    x = tonumber(list[1]),
    y = tonumber(list[2]),
    z = tonumber(list[3])
  }
end

function Role:GetNpcShapePositionFriend()
  local list = string.split(self._shapeRecord.positionfriend, ",")
  return {
    x = tonumber(list[1]),
    y = tonumber(list[2]),
    z = tonumber(list[3])
  }
end

function Role:GetNpcShapeRecord()
  return self._shapeRecord
end

function Role:GetNpcShapeScale()
  return tonumber(self._shapeRecord.scalerole)
end

function Role:GetHandbookShapeScale()
  return tonumber(self._shapeRecord.scale)
end

function Role:GetNpcShapeScaleFriend()
  return tonumber(self._shapeRecord.scalefriend)
end

function Role:GetBattleWinNpcShapePosition()
  local list = string.split(self._shapeRecord.positionBattle, ",")
  return {
    x = tonumber(list[1]),
    y = tonumber(list[2]),
    z = tonumber(list[3])
  }
end

function Role:GetBattleWinNpcShapeScale()
  return tonumber(self._shapeRecord.scaleBattle)
end

function Role:GetGachaPosition()
  local list = string.split(self._shapeRecord.positiongacha, ",")
  return {
    x = tonumber(list[1]),
    y = tonumber(list[2]),
    z = tonumber(list[3])
  }
end

function Role:GetGachaScale()
  return tonumber(self._shapeRecord.scalegacha)
end

function Role:GetRarityId()
  return self._roleConfigRecord.rarity
end

function Role:GetYardPrefab()
  return {
    assetBundleName = self._shapeRecord.assetBundleName,
    prefabName = self._shapeRecord.yardPrefabName
  }
end

function Role:GetCabinPrefab()
  return {
    assetBundleName = self._shapeRecord.assetBundleName,
    prefabName = self._shapeRecord.dormPrefabName
  }
end

function Role:GetPrefab()
  return {
    assetBundleName = self._shapeRecord.assetBundleName,
    prefabName = self._shapeRecord.prefabName
  }
end

function Role:IsAttacker()
  return self._roleConfigRecord.hitornothit == 1
end

function Role:GetProportion()
  return {
    Hit = self._roleConfigRecord.hitproportion,
    Rest = self._roleConfigRecord.slackoffproportion
  }
end

function Role:GetBigRarityImageRecord()
  return CImagePathTable:GetRecorder(self._roleRarityRecord.imgbigid) or DataCommon.DefaultImageAsset
end

function Role:GetRoleInfoRarityImageRecord()
  return CImagePathTable:GetRecorder(self._roleRarityRecord.imgroleid) or DataCommon.DefaultImageAsset
end

function Role:GetRarityImageRecord()
  return CImagePathTable:GetRecorder(self._roleRarityRecord.imgid) or DataCommon.DefaultImageAsset
end

function Role:GetRarityBackRecord()
  if not self:IsUnlockUniqueEquip() then
    return CImagePathTable:GetRecorder(self._roleRarityRecord.frameid) or DataCommon.DefaultImageAsset
  else
    return CImagePathTable:GetRecorder(self._roleRarityRecord.UEframeid) or DataCommon.DefaultImageAsset
  end
end

function Role:GetRarityBottomBackRecord()
  if not self:IsUnlockUniqueEquip() then
    return CImagePathTable:GetRecorder(self._roleRarityRecord.downback) or DataCommon.DefaultImageAsset
  else
    return CImagePathTable:GetRecorder(self._roleRarityRecord.UEdownback) or DataCommon.DefaultImageAsset
  end
end

function Role:GetRarityDownBackRecord()
  return CImagePathTable:GetRecorder(self._roleRarityRecord.triangle) or DataCommon.DefaultImageAsset
end

function Role:GetSmallRarityBackRecord()
  if not self:IsUnlockUniqueEquip() then
    return CImagePathTable:GetRecorder(self._roleRarityRecord.frameidsmall) or DataCommon.DefaultImageAsset
  else
    return CImagePathTable:GetRecorder(self._roleRarityRecord.UEframeidsmall) or DataCommon.DefaultImageAsset
  end
end

function Role:GetSmallRarityFrameRecord()
  if not self:IsUnlockUniqueEquip() then
    return CImagePathTable:GetRecorder(self._roleRarityRecord.charframesmall) or DataCommon.DefaultImageAsset
  else
    return CImagePathTable:GetRecorder(self._roleRarityRecord.UEcharframesmall) or DataCommon.DefaultImageAsset
  end
end

function Role:GetRarityFrameRecord()
  if not self:IsUnlockUniqueEquip() then
    return CImagePathTable:GetRecorder(self._roleRarityRecord.charframe) or DataCommon.DefaultImageAsset
  else
    return CImagePathTable:GetRecorder(self._roleRarityRecord.UEcharframe) or DataCommon.DefaultImageAsset
  end
end

function Role:GetTeamRarityImageRecord()
  return CImagePathTable:GetRecorder(self._roleRarityRecord.rankllarge) or DataCommon.DefaultImageAsset
end

function Role:GetRarityRankDownRecord()
  return CImagePathTable:GetRecorder(self._roleRarityRecord.trianglelarge) or DataCommon.DefaultImageAsset
end

function Role:GetTeamRarityBackRecord()
  if not self:IsUnlockUniqueEquip() then
    return CImagePathTable:GetRecorder(self._roleRarityRecord.charcelllarge) or DataCommon.DefaultImageAsset
  else
    return CImagePathTable:GetRecorder(self._roleRarityRecord.UEcharcelllarge) or DataCommon.DefaultImageAsset
  end
end

function Role:GetRarityDownRecord()
  return CImagePathTable:GetRecorder(self._roleRarityRecord.yardCell) or DataCommon.DefaultImageAsset
end

function Role:GetRarityEvolutionEffect()
  return self._roleRarityRecord.evolutionEffect
end

function Role:GetCurBreakFrame1ImageRecord()
  return CImagePathTable:GetRecorder(self._roleRarityRecord.breakLevelBackTriangle) or DataCommon.DefaultImageAsset
end

function Role:GetCurBreakFrame2ImageRecord()
  return CImagePathTable:GetRecorder(self._roleRarityRecord.breakLevelBackPolygon) or DataCommon.DefaultImageAsset
end

function Role:GetExploreSkillId()
  return self._roleConfigRecord.exploreskillid
end

function Role:GetVocationSkillIdList()
  return self._roleConfigRecord.vocationskillid
end

function Role:GetIsLeader()
  return self._isLeader == 1
end

function Role:SetBreakLv(breakLv)
  self._breakLv = breakLv
  local recorder = self._allBreakRecords[self._breakLv - 1]
  if recorder then
    self._preBreakRecord = recorder
  end
  recorder = self._allBreakRecords[self._breakLv]
  if recorder then
    self._roleBreakRecord = recorder
  end
  recorder = self._allBreakRecords[self._breakLv + 1]
  if recorder then
    self._nextBreakRecord = recorder
  end
end

function Role:GetPreBreakLv()
  if self._preBreakRecord then
    return self._preBreakRecord.breaklv
  else
    return nil
  end
end

function Role:GetBreakLv()
  return self._breakLv
end

function Role:GetNextBreakLv()
  if self._nextBreakRecord then
    return self._nextBreakRecord.breaklv
  else
    return nil
  end
end

function Role:GetMaxBreakLv()
  local maxBreakLv = self._breakLv
  for breaklv, _ in pairs(self._allBreakRecords) do
    if breaklv > maxBreakLv then
      maxBreakLv = breaklv
    end
  end
  return maxBreakLv
end

function Role:GetBreakType()
  return self._roleConfigRecord.breakType
end

local breakImage = {
  [0] = 12450,
  [1] = 12451,
  [2] = 12452,
  [3] = 12453,
  [4] = 12454
}

function Role:GetBreakImageRecord(breakLV)
  return CImagePathTable:GetRecorder(breakImage[breakLV]) or DataCommon.DefaultImageAsset
end

function Role:GetPreBreakImageRecord()
  local preBreakLV = self:GetPreBreakLv()
  if preBreakLV then
    return self:GetBreakImageRecord(preBreakLV)
  end
end

function Role:GetCurBreakImageRecord()
  return self:GetBreakImageRecord(self:GetBreakLv())
end

function Role:GetNextBreakImageRecord()
  local nextBreakLV = self:GetNextBreakLv()
  if nextBreakLV then
    return self:GetBreakImageRecord(nextBreakLV)
  end
end

function Role:GetLevelMaxByBreakRecord(recorder)
  if recorder then
    if self:IsUnlockUniqueEquip() then
      return recorder.unlocklevelmax
    else
      return recorder.levelmax
    end
  end
end

function Role:GetBreakLvAndShowLvByRoleLv(lv)
  for i, recorder in ipairs(self._allBreakRecordList) do
    if lv <= self:GetLevelMaxByBreakRecord(recorder) then
      return recorder.breaklv, lv - recorder.levelmin
    end
  end
end

function Role:GetBreakRecordList()
  return self._allBreakRecordList
end

function Role:GetBreakRecords()
  return self._allBreakRecords
end

function Role:GetShowLv()
  local preBreakMaxLv = self:GetPreBreakMaxLevel()
  local realLevel = self:GetLevel()
  if preBreakMaxLv then
    return realLevel - preBreakMaxLv
  end
  return realLevel
end

function Role:GetShowMaxBreakLv()
  local preBreakMaxLv = self:GetPreBreakMaxLevel()
  local realMaxBreakLevel = self:GetMaxLevelIgnorePlayerLv()
  if preBreakMaxLv then
    return realMaxBreakLevel - preBreakMaxLv
  end
  return realMaxBreakLevel
end

function Role:GetUnlockLive2DSkinIdByCurBreak()
  if self._preBreakRecord and self._preBreakRecord.skinID ~= 0 then
    return self._preBreakRecord.skinID
  end
end

function Role:GetUnlockLive2DSkinIdByNextBreak()
  if self._roleBreakRecord and self._roleBreakRecord.skinID ~= 0 then
    return self._roleBreakRecord.skinID
  end
end

function Role:SetLevel(lv)
  self._lv = lv
  self._roleLevelRecord = CRoleLevelCfgTable:GetRecorder(self._lv)
end

function Role:GetLevel()
  return self._lv
end

function Role:SetExp(exp)
  self._exp = exp
end

function Role:GetExp()
  return self._exp
end

function Role:SetIsLock(lock)
  self._lock = lock
end

function Role:GetIsLock()
  return self._lock == 1
end

function Role:SetProperties(properties)
  for k, v in pairs(properties) do
    if k ~= 10 and k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
    else
      self._properties[k] = v
    end
  end
end

function Role:GetProperties()
  local properties = {}
  for k, v in pairs(self._properties) do
    if k ~= 10 then
      properties[k] = v
    end
  end
  return properties
end

function Role:GetCurrentHp()
  return self._properties[AttrTypeEnum.HP]
end

function Role:GetMaxHp()
  return self._properties[AttrTypeEnum.MAX_HP]
end

function Role:GetDefend()
  return self._properties[AttrTypeEnum.DEFEND]
end

function Role:GetMagDefend()
  return self._properties[AttrTypeEnum.MAGIC_DEFEND]
end

function Role:GetAttack()
  return self._properties[AttrTypeEnum.ATTACK]
end

function Role:GetMagAttack()
  return self._properties[AttrTypeEnum.MAGIC_ATTACK]
end

function Role:SetSupportSkill(supportSkill)
  self._supportSkill = supportSkill
end

function Role:GetSupportSkillId()
  if self._supportSkill then
    return self._supportSkill.skillLevel
  else
    LogError("Role", "supportSkill is nil")
  end
end

function Role:GetSupportSkillItemId()
  if self._supportSkill then
    return self._supportSkill.skillItemId
  else
    LogError("Role", "supportSkill is nil")
  end
end

function Role:SetWeapon(weapon)
  self._weapon = weapon
end

function Role:GetWeapon()
  return self._weapon
end

function Role:SetArmor(armor)
  self._armor = armor
end

function Role:GetArmor()
  return self._armor
end

function Role:SetJewelry(jewelry)
  self._jewelry = jewelry
end

function Role:GetJewelry()
  return self._jewelry
end

function Role:GetEquipKeyList()
  return {
    [EquipTypeEnum.WEAPON] = self._weapon,
    [EquipTypeEnum.ARMOR] = self._armor,
    [EquipTypeEnum.JEWELRY] = self._jewelry
  }
end

function Role:SetPreSetWeapon(weapon)
  self._preSetWeapon = weapon
end

function Role:GetPreSetWeapon()
  return self._preSetWeapon
end

function Role:SetPreSetArmor(armor)
  self._preSetarmor = armor
end

function Role:GetPreSetArmor()
  return self._preSetarmor
end

function Role:SetPreSetJewelry(jewelry)
  self._preSetJewelry = jewelry
end

function Role:GetPreSetJewelry()
  return self._preSetJewelry
end

function Role:GetPreSetEquipKeyList()
  return {
    [EquipTypeEnum.WEAPON] = self._preSetWeapon,
    [EquipTypeEnum.ARMOR] = self._preSetarmor,
    [EquipTypeEnum.JEWELRY] = self._preSetJewelry
  }
end

function Role:IsPreSetEquipListExist()
  return self._preSetarmor ~= 0 or self._preSetJewelry ~= 0 or self._preSetWeapon ~= 0
end

function Role:GetDeadTime()
  return self._reviveTime - self._repairTime
end

function Role:SetHurtExtent(hurtExtent)
  self._hurtExtent = hurtExtent
end

function Role:GetHurtExtent()
  return self._hurtExtent
end

function Role:SetReviveTime(reviveTime)
  self._reviveTime = reviveTime
end

function Role:GetReviveTime()
  return self._reviveTime
end

function Role:SetRepairTime(repairTime)
  self._repairTime = repairTime
end

function Role:GetRepairTime()
  return self._repairTime
end

function Role:GetMaxLevel()
  local levelMax = self:GetMaxLevelIgnorePlayerLv()
  if levelMax then
    local userLevel = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userlevel
    if userLevel < DataCommon.MaxPlayerLevel then
      local maxLevel = CPlayerLevel:GetRecorder(userLevel).roleMaxLv
      if levelMax > maxLevel then
        return maxLevel
      end
      return levelMax
    else
      return levelMax
    end
  end
end

function Role:GetMaxLevelIgnorePlayerLv()
  if self._roleBreakRecord then
    if self:IsUnlockUniqueEquip() then
      return self._roleBreakRecord.unlocklevelmax
    else
      return self._roleBreakRecord.levelmax
    end
  end
end

function Role:GetMinLevel()
  if self._roleBreakRecord then
    return self._roleBreakRecord.levelmin
  end
end

function Role:GetPreBreakMinLevel()
  if self._preBreakRecord then
    return self._preBreakRecord.levelmin
  end
end

function Role:GetPreBreakMaxLevel()
  if self._preBreakRecord then
    return self:GetLevelMaxByBreakRecord(self._preBreakRecord)
  end
end

function Role:GetNextBreakMinLevel()
  if self._nextBreakRecord then
    return self._nextBreakRecord.levelmin
  end
end

function Role:GetNextBreakMaxLevel()
  if self._nextBreakRecord then
    return self:GetLevelMaxByBreakRecord(self._nextBreakRecord)
  end
end

function Role:GetBreakSoul()
  if self._roleBreakRecord then
    return self._roleBreakRecord.goldcost
  end
end

function Role:GetBreakItemList()
  local list = {}
  for i, v in ipairs(self._roleBreakRecord.itemId) do
    if v ~= 0 and self._roleBreakRecord.itemNum[i] then
      local item = {}
      item.itemId = v
      item.itemNum = self._roleBreakRecord.itemNum[i]
      table.insert(list, item)
    end
  end
  return list
end

function Role:GetCurLvMaxExp()
  if self:GetRarityId() == 1 then
    return self._roleLevelRecord.Rexp
  end
  if self:GetRarityId() == 2 then
    return self._roleLevelRecord.SRexp
  end
  if self:GetRarityId() == 3 then
    return self._roleLevelRecord.SSRexp
  end
  if self:GetRarityId() == 4 then
    return self._roleLevelRecord.URexp
  end
  if self:GetRarityId() == 5 then
    return self._roleLevelRecord.EXexp
  end
end

function Role:SetEvolution(evolution)
  self._evolution = evolution
  self._roleEvolutionCfg = nil
  local evolutionType = self._roleConfigRecord.evolutionType
  for _, id in ipairs(CRoleEvolutionCfg:GetAllIds()) do
    local record = CRoleEvolutionCfg:GetRecorder(id)
    if record.evolutionType == evolutionType and self._evolution + 1 == record.evolutionLevel then
      self._roleEvolutionCfg = record
      break
    end
  end
end

function Role:GetEvolution()
  return self._evolution
end

function Role:GetEvolutionLimit()
  return self._roleConfigRecord.evolutionLimit
end

function Role:SetCurLvBasePro(curLvBasePro)
  for k, v in pairs(self._curLvBasePro) do
    self._curLvBasePro[k] = nil
  end
  for k, v in pairs(curLvBasePro) do
    if k ~= 10 and k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
    else
      self._curLvBasePro[k] = v
    end
  end
end

function Role:GetCurLvBasePro()
  return self._curLvBasePro
end

function Role:SetNextLvBasePro(nextLvBasePro)
  for k, v in pairs(self._nextLvBasePro) do
    self._nextLvBasePro[k] = nil
  end
  for k, v in pairs(nextLvBasePro) do
    if k ~= 10 and k ~= 20 and k ~= 30 and k ~= 50 and k ~= 60 and k ~= 130 and k ~= 140 then
    else
      self._nextLvBasePro[k] = v
    end
  end
end

function Role:GetNextLvBasePro()
  return self._nextLvBasePro
end

function Role:SetBreakLvRange(breakLvRange)
  if self._breakLvRange == nil then
    self._breakLvRange = {}
  end
  for k, _ in pairs(self._breakLvRange) do
    self._breakLvRange[k] = nil
  end
  for k, v in pairs(breakLvRange) do
    self._breakLvRange[k] = v
  end
end

function Role:GetBreakLvRange()
  return self._breakLvRange
end

function Role:GetNextEvolutionLvBasePro()
end

function Role:IsInTeams(teamId)
  if teamId then
    local teamInfo = NekoData.BehaviorManager.BM_Team:GetTeamRoles(teamId)
    for station, roleKey in pairs(teamInfo) do
      if roleKey == self._roleId then
        return true
      end
    end
  else
    local teamList = NekoData.BehaviorManager.BM_Team:GetTeamsInfo()
    for lineUpId, teamInfo in pairs(teamList) do
      for station, roleKey in pairs(teamInfo.roles) do
        if roleKey == self._roleId then
          return true
        end
      end
    end
    teamList = NekoData.BehaviorManager.BM_Team:GetTowerTeamsInfo()
    for lineUpId, teamInfo in pairs(teamList) do
      for station, roleKey in pairs(teamInfo.roles) do
        if roleKey == self._roleId then
          return true
        end
      end
    end
    teamList = NekoData.BehaviorManager.BM_Team:GetBossTeamsInfo()
    for lineUpId, teamInfo in pairs(teamList) do
      for station, roleKey in pairs(teamInfo.roles) do
        if roleKey == self._roleId then
          return true
        end
      end
    end
    teamList = NekoData.BehaviorManager.BM_Team:GetDefendRecoverTeamsInfo()
    for lineUpId, teamInfo in pairs(teamList) do
      for station, roleKey in pairs(teamInfo.roles) do
        if roleKey == self._roleId then
          return true
        end
      end
    end
    teamList = NekoData.BehaviorManager.BM_Team:GetAssassinDamageTeamsInfo()
    for lineUpId, teamInfo in pairs(teamList) do
      for station, roleKey in pairs(teamInfo.roles) do
        if roleKey == self._roleId then
          return true
        end
      end
    end
    teamList = NekoData.BehaviorManager.BM_Team:GetMagicImpairTeamsInfo()
    for lineUpId, teamInfo in pairs(teamList) do
      for station, roleKey in pairs(teamInfo.roles) do
        if roleKey == self._roleId then
          return true
        end
      end
    end
    teamList = NekoData.BehaviorManager.BM_Team:GetUndecidedRoadTeamsInfo()
    for lineUpId, teamInfo in pairs(teamList) do
      for station, roleKey in pairs(teamInfo.roles) do
        if roleKey == self._roleId then
          return true
        end
      end
    end
  end
  return false
end

function Role:IsInAlternativeTeams(teamId)
  if teamId then
    local teamInfo = NekoData.BehaviorManager.BM_Team:GetTeamRoles(teamId)
    for station, roleKey in pairs(teamInfo) do
      if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
        return true
      end
    end
  else
    local teamList = NekoData.BehaviorManager.BM_Team:GetTeamsInfo()
    for lineUpId, teamInfo in pairs(teamList) do
      for station, roleKey in pairs(teamInfo.roles) do
        if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
          return true
        end
      end
    end
    teamList = NekoData.BehaviorManager.BM_Team:GetTowerTeamsInfo()
    for lineUpId, teamInfo in pairs(teamList) do
      for station, roleKey in pairs(teamInfo.roles) do
        if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
          return true
        end
      end
    end
    teamList = NekoData.BehaviorManager.BM_Team:GetBossTeamsInfo()
    for lineUpId, teamInfo in pairs(teamList) do
      for station, roleKey in pairs(teamInfo.roles) do
        if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
          return true
        end
      end
    end
    teamList = NekoData.BehaviorManager.BM_Team:GetDefendRecoverTeamsInfo()
    for lineUpId, teamInfo in pairs(teamList) do
      for station, roleKey in pairs(teamInfo.roles) do
        if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
          return true
        end
      end
    end
    teamList = NekoData.BehaviorManager.BM_Team:GetAssassinDamageTeamsInfo()
    for lineUpId, teamInfo in pairs(teamList) do
      for station, roleKey in pairs(teamInfo.roles) do
        if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
          return true
        end
      end
    end
    teamList = NekoData.BehaviorManager.BM_Team:GetMagicImpairTeamsInfo()
    for lineUpId, teamInfo in pairs(teamList) do
      for station, roleKey in pairs(teamInfo.roles) do
        if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
          return true
        end
      end
    end
    teamList = NekoData.BehaviorManager.BM_Team:GetUndecidedRoadTeamsInfo()
    for lineUpId, teamInfo in pairs(teamList) do
      for station, roleKey in pairs(teamInfo.roles) do
        if roleKey == self._roleId and (station == LineUpStation.ALTERNATE_FRONT_ROW or station == LineUpStation.ALTERNATE_MIDDLE_ROW or station == LineUpStation.ALTERNATE_BACK_ROW) then
          return true
        end
      end
    end
  end
  return false
end

function Role:GetTeamStation(teamId)
  local roleList = NekoData.BehaviorManager.BM_Team:GetTeamRoles(teamId)
  for station, roleKey in pairs(roleList) do
    if roleKey == self._roleId then
      return station
    end
  end
end

function Role:SetRolePower(power)
  self._power = power
end

function Role:GetRolePower()
  return self._power
end

function Role:GetSoulSkillScore()
end

function Role:GetTalentPage()
  return self._talentPage
end

function Role:GetTalentRow()
  return self._talentRow
end

function Role:GetTalentInRowList()
  return self._talentInRowList
end

function Role:SetTalentPage(page)
  self._talentPage = page
end

function Role:SetTalentRow(row)
  self._talentRow = row
end

function Role:SetTalentInRowList(list)
  self._talentInRowList = list
end

function Role:GetVictoryTalk()
  if self:CanPlayVoice() then
    return TextManager.GetText(self._soundLinesRecord.Victory)
  end
end

function Role:GetYardSkillList()
  return self._roleConfigRecord.yardskillid
end

function Role:GetEnergy()
  return self._energy / DataCommon.RoleEnergyRatio
end

function Role:SetBuildingId(buildingId)
  self._buildingId = buildingId
end

function Role:GetBuildingId()
  return self._buildingId
end

function Role:GetDamageType()
  return self._roleConfigRecord.damagetype
end

function Role:GetEvolutionExclusiveItem()
  if self._roleEvolutionCfg then
    return self._roleEvolutionCfg.exclusiveItem
  end
end

function Role:GetMaxEvolutionNeedItemCount()
  local count = 0
  local evolutionType = self._roleConfigRecord.evolutionType
  for _, id in ipairs(CRoleEvolutionCfg:GetAllIds()) do
    local record = CRoleEvolutionCfg:GetRecorder(id)
    if record.evolutionType == evolutionType and self._evolution < record.evolutionLevel then
      local data = string.split(record.exclusiveItem, "_")
      count = count + tonumber(data[2])
    end
  end
  return count
end

function Role:GetEvolutionLevelRecords()
  return self._evolutionLevelRecords
end

function Role:GetEvolutionCurrentItem()
  if self._roleEvolutionCfg then
    return self._roleEvolutionCfg.currentItem
  end
end

function Role:GetEvolutionChangeProName()
  if self._roleEvolutionCfg then
    for _, id in ipairs(CAttreffectIdName:GetAllIds()) do
      local record = CAttreffectIdName:GetRecorder(id)
      if record.ablEffctId == self._roleEvolutionCfg.addProperty then
        return TextManager.GetText(record.classnameTextID)
      end
    end
  end
end

function Role:GetEvolutionAddProOriginalValue()
  if self._roleEvolutionCfg then
    for _, id in ipairs(CAttreffectIdName:GetAllIds()) do
      local record = CAttreffectIdName:GetRecorder(id)
      if record.ablEffctId == self._roleEvolutionCfg.addProperty then
        return self:GetCurLvBasePro()[id]
      end
    end
  end
end

function Role:GetEvolutionNewProValue()
  if self._roleEvolutionCfg and self._evolution < self._roleConfigRecord.evolutionLimit then
    return math.floor(self:GetEvolutionAddProOriginalValue() + self._roleEvolutionCfg.addPropertyValue)
  end
end

function Role:CheckCanEvolutionByExclusiveItem()
  if not self._roleEvolutionCfg then
    self._canEvolution = false
    return
  end
  local data = string.split(self._roleEvolutionCfg.exclusiveItem, "_")
  local exclusiveItemId = tonumber(data[1])
  local count = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(exclusiveItemId)
  self._canEvolution = count >= tonumber(data[2])
end

function Role:CanEvolutionByExclusiveItem()
  return self._canEvolution
end

function Role:SetNewState(isNew)
  self._isNew = isNew
end

function Role:IsNew()
  return self._isNew
end

function Role:SetRelationLevel(lv)
  self._relationLevel = lv
end

function Role:GetRelationLevel()
  return self._relationLevel
end

function Role:GetRelationStage()
  return math.floor(CFavourExp:GetRecorder(self._relationLevel).heartnum / 10)
end

function Role:SetRelationProgress(progress)
  self._relationProgress = progress
end

function Role:GetRelationProgress()
  return self._relationProgress
end

function Role:SetRelationReceiveMap(relationLv)
  self._relationReceiveMap[relationLv] = true
end

function Role:GetRelationReceiveMap()
  return self._relationReceiveMap
end

function Role:IsShowRelationRedDot()
  local rewardList = self:GetRelationRewardList()
  for i, v in ipairs(rewardList) do
    local favourLv = v.favourLv
    if favourLv > self._relationLevel then
      return false
    elseif not self._relationReceiveMap[favourLv] then
      return true
    end
  end
end

function Role:GetRelationRewardList()
  local receiveMap = self:GetRelationReceiveMap()
  local list = {}
  for i, v in ipairs(self._relationPresentRecord.levelRewardType) do
    table.insert(list, {
      favourLv = i,
      rewardType = v,
      rewardId = self._relationPresentRecord.levelRewardID[i],
      received = receiveMap[i]
    })
  end
  return list
end

function Role:GetRelationMaxLevel()
  return self._relationPresentRecord.lvlmax
end

function Role:GetRelationMaxProgress()
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

function Role:GetFavourGiftType()
  return self._roleConfigRecord.favourgift
end

function Role:GetVocationId()
  return self._roleConfigRecord.vocation
end

function Role:SetFashionId(fashionId)
  self._defaultFashionId = fashionId
  self:UpdateShape()
  self:UpdateSoundLines()
end

function Role:UpdateShape(fashionId)
  if fashionId and 0 < fashionId then
    self._defaultFashionId = fashionId
  end
  if self._defaultFashionId and 0 < self._defaultFashionId then
    local skin = CSkin:GetRecorder(self._defaultFashionId)
    self._shapeRecord = CNpcShapeTable:GetRecorder(skin.shapeID)
  end
end

function Role:UpdateSoundLines()
  local soundLinesRecord
  if self._defaultFashionId > 0 then
    soundLinesRecord = CSoundLines_skin:GetRecorder(self._defaultFashionId)
  end
  soundLinesRecord = soundLinesRecord or CSoundLines:GetRecorder(self._roleId)
  self._soundLinesRecord = soundLinesRecord
end

function Role:UpdateFashion(skins)
  if not skins then
    return
  end
  for k, v in pairs(skins) do
    self._fashions[k] = {
      roleId = self._roleId,
      skinID = v.skinID,
      hasGotten = v.skinStatus > 0,
      isSelling = 0 < v.isInSelling,
      index = 0
    }
  end
end

function Role:GetDefaultFashion()
  return self._defaultFashionId
end

function Role:GetFashionData()
  local fashions = {
    default = 0,
    list = {}
  }
  for k, v in ipairs(self._roleSkinRecord.skinID) do
    if self._fashions[v] then
      self._fashions[v].index = k
      table.insert(fashions.list, self._fashions[v])
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

function Role:SetSkinRedDot(skinRecorder, showRedDot)
  if not self._skinRedDot then
    self._skinRedDot = {}
  end
  if showRedDot then
    self._skinRedDot[skinRecorder.id] = skinRecorder
  else
    self._skinRedDot[skinRecorder.id] = nil
  end
end

function Role:IsShowSkinRedDot()
  if not self._skinRedDot then
    return false
  end
  local tag = false
  for k, v in pairs(self._skinRedDot) do
    tag = true
    break
  end
  if not tag then
    return false
  else
    return self._skinRedDot
  end
end

function Role:IsBoost()
  if self._eventBoostRecord then
    for k, v in pairs(self._eventBoostRecord) do
      if DialogManager.GetDialog("activity.starmirage.selectlevelmaindialog") and v.eventid == DataCommon.Activities.StarMirage or not (not DialogManager.GetDialog("activity.swimsuitechoes.swimsuitmaindialog") or DialogManager.GetDialog("activity.swimsuitechoes.challenge.maindialog")) and v.eventid == DataCommon.Activities.SummerEchoes or DialogManager.GetDialog("activity.swimsuit.swimsuitmaindialog") and v.eventid == DataCommon.Activities.SwimSuit or DialogManager.GetDialog("activity.starmirage1.maindialog") and v.eventid == DataCommon.Activities.StarMirageCopy then
        local characterLargeCellStr = ""
        local changeTeamRoleCellStr = ""
        if v.eventid == DataCommon.Activities.StarMirage then
          characterLargeCellStr = string.gsub(TextManager.GetText(1900579), "%$parameter1%$", v.boostpercentage)
          changeTeamRoleCellStr = TextManager.GetText(1900578)
        elseif v.eventid == DataCommon.Activities.StarMirageCopy then
          local dialog = DialogManager.GetDialog("activity.starmirage1.maindialog")
          local str1Id = 2122
          local str2Id = 2123
          if dialog._tabType == dialog._TypeEnum.Type.Hard then
            str1Id = 2131
            str2Id = 2132
          end
          characterLargeCellStr = NekoData.BehaviorManager.BM_Message:GetString(str1Id, {
            v.boostpercentage
          })
          changeTeamRoleCellStr = NekoData.BehaviorManager.BM_Message:GetString(str2Id)
        elseif v.eventid == DataCommon.Activities.SummerEchoes then
          characterLargeCellStr = NekoData.BehaviorManager.BM_Message:GetString(2180, {
            v.boostpercentage
          })
          changeTeamRoleCellStr = NekoData.BehaviorManager.BM_Message:GetString(2181)
        elseif v.eventid == DataCommon.Activities.SwimSuit then
          characterLargeCellStr = NekoData.BehaviorManager.BM_Message:GetString(2184, {
            v.boostpercentage
          })
          changeTeamRoleCellStr = NekoData.BehaviorManager.BM_Message:GetString(2185)
        end
        return {
          activityId = v.eventid,
          characterLargeCellStr = characterLargeCellStr,
          changeTeamRoleCellStr = changeTeamRoleCellStr
        }
      end
    end
  end
end

function Role:GetShowSkillDataByIndex(index)
  return self._showSkillList[index]
end

function Role:GetShowSkillData()
  return self._showSkillList
end

function Role:GetUnlockSkillNodes()
  return self._unlockSkillNodes
end

function Role:GetAllSkillNodes()
  return self._allSkillNodes
end

function Role:GetFirstSelectNodeId()
  local unlockNodes = self:GetUnlockSkillNodes()
  local allNodes = self:GetAllSkillNodes()
  local nodeId, lastNodeId
  for k, v in pairs(allNodes) do
    if not unlockNodes[k] and (not nodeId or k < nodeId) then
      nodeId = k
    end
    if not lastNodeId or k > lastNodeId then
      lastNodeId = k
    end
  end
  return nodeId or lastNodeId
end

function Role:AddLeaderSkill(skillItem)
  local data = {}
  data.skillId = skillItem.skillLevel
  data.selected = skillItem.selected == 1
  data.skillItemId = skillItem.skillItemId
  table.insert(self._notPassiveSkills, data)
end

function Role:RefreshLeaderSkills(changedSkills)
  local deleteIndexList = {}
  for i, v in ipairs(self._showSkillList) do
    if not v.isPassive then
      table.insert(deleteIndexList, i)
    end
  end
  while deleteIndexList[#deleteIndexList] do
    table.remove(self._showSkillList, deleteIndexList[#deleteIndexList])
    table.remove(deleteIndexList, deleteIndexList[#deleteIndexList])
  end
  local index = 1
  for i, v in ipairs(self._notPassiveSkills) do
    local skill = Skill.Create(v.skillId, v.skillItemId)
    v.selected = changedSkills[v.skillItemId] == 1
    if v.selected then
      table.insert(self._showSkillList, index, {
        skillId = v.skillId,
        skillItemId = v.skillItemId,
        unlock = true
      })
      index = index + 1
    end
  end
  for i = index + 1, 2 do
    if i == 1 then
      local skillItemId = self._roleConfigRecord.contractskillid
      local skill = Skill.Create(skillItemId)
      table.insert(self._showSkillList, 1, {
        skillId = skill:GetSkillId(),
        skillItemId = skillItemId,
        unlock = false
      })
    elseif i == 2 then
      local skillItemId = self._roleConfigRecord.contractskillid2
      local skill = Skill.Create(skillItemId)
      table.insert(self._showSkillList, 2, {
        skillId = skill:GetSkillId(),
        skillItemId = skillItemId,
        unlock = false
      })
    end
  end
end

function Role:GetActiveSkillList()
  return self._notPassiveSkills
end

function Role:GetSelectActiveSkillList()
  local list = {}
  for i, v in ipairs(self._notPassiveSkills) do
    if v.selected then
      table.insert(list, v.skillItemId)
    end
  end
  return list
end

function Role:InitShowSkillsByOtherWays(contractSkill, passiveskill)
  self._showSkillList = {}
  for i, v in ipairs(contractSkill) do
    local data = {}
    data.skillId = v.skillLevel
    data.selected = v.selected == 1
    data.skillItemId = v.skillItemId
    if data.selected then
      table.insert(self._showSkillList, {
        skillId = data.skillId,
        skillItemId = data.skillItemId,
        unlock = true
      })
    end
  end
  local num = #self._showSkillList
  for i = num + 1, 2 do
    if i == 1 then
      local skillItemId = self._roleConfigRecord.contractskillid
      local skill = Skill.Create(skillItemId)
      table.insert(self._showSkillList, {
        skillId = skill:GetSkillId(),
        skillItemId = skillItemId,
        unlock = false
      })
    elseif i == 2 then
      local skillItemId = self._roleConfigRecord.contractskillid2
      local skill = Skill.Create(skillItemId)
      table.insert(self._showSkillList, {
        skillId = skill:GetSkillId(),
        skillItemId = skillItemId,
        unlock = false
      })
    end
  end
  for i, v in ipairs(passiveskill) do
    local skill = Skill.Create(v.id, true)
    if skill:GetType() == Skill.Type.Passive then
      table.insert(self._showSkillList, {
        skillId = v.id,
        unlock = true,
        isPassive = true
      })
    end
  end
  num = #self._showSkillList
  if num < 3 then
    table.insert(self._showSkillList, {
      skillId = self._roleConfigRecord.contractskillid3,
      unlock = false,
      isPassive = true
    })
  end
end

function Role:IsShowSkillRedDot()
  local unlockNodes = self:GetUnlockSkillNodes()
  local allNodes = self:GetAllSkillNodes()
  for k, nodeRecord in pairs(allNodes) do
    if not unlockNodes[k] then
      local isSpecialUnlock = nodeRecord.serverUnlock ~= 0
      if not isSpecialUnlock then
        local roleLvEnough = self:GetLevel() >= nodeRecord.roleSkill
        if roleLvEnough then
          local frontNodesUnlock = true
          local frontList
          if nodeRecord.frontNode ~= "-1" then
            frontList = string.split(nodeRecord.frontNode, ";")
          end
          if frontList then
            for _, nodeId in ipairs(frontList) do
              if not unlockNodes[tonumber(nodeId)] then
                frontNodesUnlock = false
                break
              end
            end
          end
          local costEnough = true
          if frontNodesUnlock then
            local mana = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID)
            if mana < nodeRecord.money then
              costEnough = false
            end
            if costEnough then
              for i, v in ipairs(nodeRecord.itemID) do
                local num = nodeRecord.itemNum[i]
                if costEnough then
                  local haveNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(v)
                  costEnough = num <= haveNum
                end
              end
            end
            if costEnough then
              return true
            end
          end
        end
      end
    end
  end
  return false
end

function Role:GetRoleEquipSuitMap()
  local suitIDs = {}
  local equips = self:GetEquipKeyList()
  local temp
  for k, v in pairs(equips) do
    if v and 0 < v then
      temp = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(v)
      suitIDs[temp:GetEquipType()] = temp:GetEquipSuitId()
    end
  end
  return suitIDs
end

function Role:GetSuitSkillsMap()
  return self._suitSkillsMap
end

function Role:GetPreSetRoleEquipSuitMap()
  local suitIDs = {}
  local equips = self:GetPreSetEquipKeyList()
  local temp
  for k, v in pairs(equips) do
    if v and 0 < v then
      temp = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(v)
      suitIDs[temp:GetEquipType()] = temp:GetEquipSuitId()
    end
  end
  return suitIDs
end

function Role:GetPreSetSuitSkillsMap()
  local suitIDs = {}
  local equips = self:GetPreSetEquipKeyList()
  local temp
  for k, v in pairs(equips) do
    if v and 0 < v then
      temp = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(v)
      local id = temp:GetEquipSuitId()
      if suitIDs[id] then
        suitIDs[id] = suitIDs[id] + 1
      else
        suitIDs[id] = 1
      end
    end
  end
  local skillsMap = {}
  local CEquipSuit = BeanManager.GetTableByName("equip.cequipsuit")
  for k, v in pairs(suitIDs) do
    local suitRecorder = CEquipSuit:GetRecorder(k)
    if suitRecorder then
      for i, skillId in ipairs(suitRecorder.suitSkillID) do
        if i <= v and skillId ~= 0 then
          if skillsMap[k] then
            table.insert(skillsMap[k].skillIds, skillId)
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

function Role:GetElement()
  return self._roleConfigRecord.element
end

function Role:GetElementName()
  local record = CElementCfgTable:GetRecorder(self._roleConfigRecord.element)
  if record then
    return TextManager.GetText(record.nameid)
  else
    LogErrorFormat("Role", "wrong elementid %s with roleid %s", self._roleConfigRecord.element, self._roleId)
  end
end

function Role:GetElementImageRecord()
  local record = CElementCfgTable:GetRecorder(self._roleConfigRecord.element)
  if record then
    return CImagePathTable:GetRecorder(record.image) or DataCommon.DefaultImageAsset
  else
    LogErrorFormat("Role", "wrong elementid %s with roleid %s", self._roleConfigRecord.element, self._roleId)
  end
end

function Role:GetUniqueEquipId()
  if self._roleConfigRecord.uniqueequipid ~= 0 and self._uniqueEquipLevel and self._uniqueEquipLevel > -1 then
    return self._roleConfigRecord.uniqueequipid
  end
end

function Role:SetUniqueEquipLevel(lv)
  self._uniqueEquipLevel = lv
end

function Role:GetUniqueEquipLevel()
  return self._uniqueEquipLevel
end

function Role:IsUnlockUniqueEquip()
  return self:GetUniqueEquipId() and self:GetUniqueEquipLevel() and self:GetUniqueEquipLevel() > 0
end

function Role:SetUniqueEquipAttrs(data)
  LogInfoFormat("SetUniqueEquipAttrs", "roleId = %s, uniqueEquipLevel = %s", self._roleId, data.specialWeaponLevel)
  self._uniqueEquipLevel = data.specialWeaponLevel
  if not self._uniqueEquipCurLvAttrs then
    self._uniqueEquipCurLvAttrs = {}
  end
  for k, v in pairs(self._uniqueEquipCurLvAttrs) do
    self._uniqueEquipCurLvAttrs[k] = nil
  end
  for k, v in pairs(data.specialWeaponProperties) do
    self._uniqueEquipCurLvAttrs[k] = v
    LogInfoFormat("SetUniqueEquipAttrs", "cur:  k = %s, v = %s", k, v)
  end
  if not self._uniqueEquipNextLvAttrs then
    self._uniqueEquipNextLvAttrs = {}
  end
  for k, v in pairs(self._uniqueEquipNextLvAttrs) do
    self._uniqueEquipNextLvAttrs[k] = nil
  end
  for k, v in pairs(data.specialWeaponPropertiesForNextLevel) do
    self._uniqueEquipNextLvAttrs[k] = v
    LogInfoFormat("SetUniqueEquipAttrs", "next:  k = %s, v = %s", k, v)
  end
end

function Role:SetUniqueEquipSkillOpen(value)
  local SSpecialWeaponSkillSwitch = require("protocols.def.protocol.item.sspecialweaponskillswitch")
  self._skillOpen = value == SSpecialWeaponSkillSwitch.OPEN
end

function Role:GetUniqueEquipCurAttrs()
  local map = {}
  if self._uniqueEquipCurLvAttrs then
    for k, v in pairs(self._uniqueEquipCurLvAttrs) do
      map[k] = v
    end
  end
  return map
end

function Role:GetUniqueEquipNextAttrs()
  local map = {}
  if self._uniqueEquipNextLvAttrs then
    for k, v in pairs(self._uniqueEquipNextLvAttrs) do
      map[k] = v
    end
  end
  return map
end

function Role:IsOpenUniqueEquipSkill()
  return self._skillOpen
end

function Role:SetBaseProAddPercent(addPercent)
  self._baseProAddPercent = addPercent
end

function Role:GetBaseProAddPercent()
  return self._baseProAddPercent
end

function Role:IsShowSkillRedDotById(skillNodeId)
  local unlockNodes = self:GetUnlockSkillNodes()
  local allNodes = self:GetAllSkillNodes()
  local nodeRecord = allNodes[skillNodeId]
  if nodeRecord and not unlockNodes[skillNodeId] then
    local isSpecialUnlock = nodeRecord.serverUnlock ~= 0
    if not isSpecialUnlock then
      local roleLvEnough = self:GetLevel() >= nodeRecord.roleSkill
      if roleLvEnough then
        local frontNodesUnlock = true
        local frontList
        if nodeRecord.frontNode ~= "-1" then
          frontList = string.split(nodeRecord.frontNode, ";")
        end
        if frontList then
          for _, nodeId in ipairs(frontList) do
            if not unlockNodes[tonumber(nodeId)] then
              frontNodesUnlock = false
              break
            end
          end
        end
        local costEnough = true
        if frontNodesUnlock then
          local mana = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID)
          if mana < nodeRecord.money then
            costEnough = false
          end
          if costEnough then
            for i, v in ipairs(nodeRecord.itemID) do
              local num = nodeRecord.itemNum[i]
              if costEnough then
                local haveNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(v)
                costEnough = num <= haveNum
              end
            end
          end
          if costEnough then
            return true
          end
        end
      end
    end
  end
end

function Role:IsShowEvolutionRedDotByLv(lv)
  if not self._roleEvolutionCfg or lv ~= self._evolution + 1 then
    return false
  end
  local record = self._evolutionLevelRecords[lv]
  if record then
    local data = string.split(record.exclusiveItem, "_")
    local exclusiveItemId = tonumber(data[1])
    local count = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(exclusiveItemId)
    return count >= tonumber(data[2])
  else
    LogError("Role", "lv is greater than EvolutionLimit")
    return false
  end
end

function Role:IsShowSkinRedDotById(skinID)
  if not self._skinRedDot then
    return false
  end
  return self._skinRedDot[skinID]
end

function Role:GetSkinIDList()
  return self._roleSkinRecord.skinID
end

function Role:IsShowBreakRedDotByLv(breakLv)
  if breakLv <= self:GetBreakLv() or self:GetBreakLv() == self:GetMaxBreakLv() then
    return false
  end
  local breakRecord = self._allBreakRecordList[breakLv]
  if breakRecord then
    if self:GetLevel() >= breakRecord.levelmax then
      local tag = NekoData.BehaviorManager.BM_Currency:GetMoney() >= breakRecord.goldcost
      if tag then
        for i, v in ipairs(breakRecord.itemId) do
          if v ~= 0 and breakRecord.itemNum[i] then
            local count = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(v)
            if count < breakRecord.itemNum[i] then
              return false
            end
          end
        end
      end
      return tag
    else
      return false
    end
  else
    LogError("Role", "lv is greater than MaxBreakLv")
    return false
  end
end

function Role:SetRuneLevel(runeLevel)
  self._runeLevel = runeLevel
end

function Role:GetRuneLevel()
  return self._runeLevel
end

return Role
