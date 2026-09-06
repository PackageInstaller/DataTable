local Role = require("logic.manager.experimental.types.role")
local Skill = require("logic.manager.experimental.types.skill")
local Equip = require("logic.manager.experimental.types.equip")
local UniqueEquip = require("logic.manager.experimental.types.uniqueequip")
local AttrTypeEnum = LuaNetManager.GetBeanDef("protocol.login.attrtype")
local EquipTypeEnum = LuaNetManager.GetBeanDef("protocol.item.equiptype")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CSkillTable = BeanManager.GetTableByName("skill.cskill")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CItemPinJiTable = BeanManager.GetTableByName("item.citempinji")
local CEquipItemTable = BeanManager.GetTableByName("item.cequipitem")
local CheckOtherRoleInfoDialog = class("CheckOtherRoleInfoDialog", Dialog)
CheckOtherRoleInfoDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CheckOtherRoleInfoDialog.AssetName = "BaseCharacterOthers"
CheckOtherRoleInfoDialog.ShowType = {
  BossRushRank = 1,
  FriendShow = 2,
  BaseLevelInfo = 3,
  PVP = 4,
  CompleteLineup = 5
}
CheckOtherRoleInfoDialog.TagType = {GachaResult = 1}

function CheckOtherRoleInfoDialog:Ctor(...)
  CheckOtherRoleInfoDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._dragHandler = nil
  self._endDragHandler = nil
  self._cancelDragHandler = nil
end

function CheckOtherRoleInfoDialog:OnCreate()
  self._rolePanel = self:GetChild("Role")
  self._rolePanel_scaleX, self._rolePanel_scaleY, self._rolePanel_scaleZ = self._rolePanel:GetLocalScale()
  self._photo = self:GetChild("Role/Photo")
  self._live2D = self:GetChild("Role/Live2D")
  self._charName = self:GetChild("BackGround/UI/CharName")
  self._name = self:GetChild("BackGround/UI/CharName/Back/Name")
  self._charTitle = self:GetChild("BackGround/UI/CharName/CharTitle")
  self._rank = self:GetChild("BackGround/UI/CharName/Rank")
  self._jobImg = self:GetChild("BackGround/UI/CharName/JobImg")
  self._jobTxt = self:GetChild("BackGround/UI/CharName/JobTxt")
  self._cvName = self:GetChild("BackGround/UI/CharName/CVName")
  self._elementImg = self:GetChild("BackGround/UI/CharName/Element")
  self._leftArrow = self:GetChild("BackGround/UI/LeftArrow")
  self._rightArrow = self:GetChild("BackGround/UI/RightArrow")
  self._leftArrow:Subscribe_PointerClickEvent(self.OnLeftArrowClick, self)
  self._rightArrow:Subscribe_PointerClickEvent(self.OnRightArrowClick, self)
  self._dragHandler = self:GetRootWindow():Subscribe_DragEvent(self.OnDrag, self)
  self._endDragHandler = self:GetRootWindow():Subscribe_EndDragEvent(self.OnEndDrag, self)
  self._cancelDragHandler = self:GetRootWindow():Subscribe_CancelDragEvent(self.OnEndDrag, self)
  self._rolePanel:Subscribe_StateExitEvent(self.OnRoleChangeStateExit, self)
  self._propPanel = self:GetChild("BackGround/UI/Prop")
  self._propHeartImg = self:GetChild("BackGround/UI/Prop/Heart/Image")
  self._propHeart = self:GetChild("BackGround/UI/Prop/Heart/Num")
  self._propAtkImg = self:GetChild("BackGround/UI/Prop/Atk/Image")
  self._propAtk = self:GetChild("BackGround/UI/Prop/Atk/Num")
  self._propPhyDefImg = self:GetChild("BackGround/UI/Prop/PhyDef/Image")
  self._propPhyDef = self:GetChild("BackGround/UI/Prop/PhyDef/Num")
  self._propMagDefImg = self:GetChild("BackGround/UI/Prop/MagDef/Image")
  self._propMagDef = self:GetChild("BackGround/UI/Prop/MagDef/Num")
  self._levelTxt = self:GetChild("BackGround/RightPanel/LevelUp/LevelBack/LevelNum")
  self._levelMax = self:GetChild("BackGround/RightPanel/LevelUp/LevelMax")
  self._breakPoint = self:GetChild("BackGround/RightPanel/BreakBtn/BreakPoint")
  self._evolvePoint = self:GetChild("BackGround/RightPanel/EvolveBtn/BreakPoint")
  self._skillPanel = self:GetChild("BackGround/RightPanel/Skill")
  self._skillPanel_skills = {}
  for i = 1, 3 do
    self._skillPanel_skills[i] = {}
    self._skillPanel_skills[i].cell = DialogManager.CreateDialog("skill.skillcell", self:GetChild("BackGround/RightPanel/Skill/SkillBack" .. i)._uiObject)
    self._skillPanel_skills[i].cell._rootWindow:Subscribe_PointerClickEvent(function()
      self:OnSkillClick(i)
    end)
  end
  self._equipPanel = self:GetChild("BackGround/RightPanel/Equip")
  self._equipSmallPanel1 = self:GetChild("BackGround/RightPanel/Equip/Equip1")
  self._equipCell1 = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell")
  self._equipCell1Frame = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell/BackGround/Frame")
  self._equipCell1Icon = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell/BackGround/Icon")
  self._equipCell1Empty = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCellEmpty")
  self._equipCell1Suit = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell/BackGround/Suit")
  self._equipCell1SuitGrey = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell/BackGround/SuitGrey")
  self._equipCell1SpecialFMImage = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell/BackGround/FuMo")
  self._equipCell1_animator = self:GetChild("BackGround/RightPanel/Equip/Equip1"):GetUIObject():GetComponent("Animator")
  self._equipCell1PinJiStat = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell/BackGround/BreakPoint")
  self._equipCell1Lv = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell/BackGround/Level/Num")
  self._equipSmallPanel2 = self:GetChild("BackGround/RightPanel/Equip/Equip2")
  self._equipCell2 = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell")
  self._equipCell2Frame = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell/BackGround/Frame")
  self._equipCell2Icon = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell/BackGround/Icon")
  self._equipCell2Empty = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCellEmpty")
  self._equipCell2Suit = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell/BackGround/Suit")
  self._equipCell2SuitGrey = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell/BackGround/SuitGrey")
  self._equipCell2SpecialFMImage = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell/BackGround/FuMo")
  self._equipCell2_animator = self:GetChild("BackGround/RightPanel/Equip/Equip2"):GetUIObject():GetComponent("Animator")
  self._equipCell2PinJiStat = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell/BackGround/BreakPoint")
  self._equipCell2Lv = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell/BackGround/Level/Num")
  self._equipSmallPanel3 = self:GetChild("BackGround/RightPanel/Equip/Equip3")
  self._equipCell3 = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell")
  self._equipCell3Frame = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell/BackGround/Frame")
  self._equipCell3Icon = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell/BackGround/Icon")
  self._equipCell3Empty = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCellEmpty")
  self._equipCell3Suit = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell/BackGround/Suit")
  self._equipCell3SuitGrey = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell/BackGround/SuitGrey")
  self._equipCell3SpecialFMImage = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell/BackGround/FuMo")
  self._equipCell3_animator = self:GetChild("BackGround/RightPanel/Equip/Equip3"):GetUIObject():GetComponent("Animator")
  self._equipCell3PinJiStat = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell/BackGround/BreakPoint")
  self._equipCell3Lv = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell/BackGround/Level/Num")
  self._uniqueEquipPanel = self:GetChild("BackGround/RightPanel/ExclusiveEquip")
  self._uniqueEquipPanel_unlock = self:GetChild("BackGround/RightPanel/ExclusiveEquip/Equip/EquipCell")
  self._uniqueEquipPanel_unlock_frame = self:GetChild("BackGround/RightPanel/ExclusiveEquip/Equip/EquipCell/BackGround/Frame")
  self._uniqueEquipPanel_unlock_icon = self:GetChild("BackGround/RightPanel/ExclusiveEquip/Equip/EquipCell/BackGround/Icon")
  self._uniqueEquipPanel_unlock_lv = self:GetChild("BackGround/RightPanel/ExclusiveEquip/Equip/EquipCell/BackGround/Level/Num")
  self._uniqueEquipPanel_lock = self:GetChild("BackGround/RightPanel/ExclusiveEquip/Equip/EquipCellEmpty")
  self._uniqueEquipPanel_no = self:GetChild("BackGround/RightPanel/ExclusiveEquip/Equip/Lock")
  self._suitEffect = self:GetChild("BackGround/RightPanel/SuitEffect")
  self._backBtn = self:GetChild("BackBtn")
  self._fightPanel = self:GetChild("BackGround/UI/Fight")
  self._fightNum = self:GetChild("BackGround/UI/Fight/Num")
  self._jobClick = self:GetChild("BackGround/UI/CharName/Click")
  self._propPanel:Subscribe_PointerClickEvent(self.OnPropPanelClick, self)
  self._equipSmallPanel1:Subscribe_PointerClickEvent(self.OnEquipPanel1Click, self)
  self._equipSmallPanel2:Subscribe_PointerClickEvent(self.OnEquipPanel2Click, self)
  self._equipSmallPanel3:Subscribe_PointerClickEvent(self.OnEquipPanel3Click, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._jobClick:Subscribe_PointerClickEvent(self.OnJobClick, self)
  self._elementImg:Subscribe_PointerClickEvent(self.OnElementImgClick, self)
  self._suitEffect:Subscribe_PointerClickEvent(self.OnSuitEffectClicked, self)
  self:GetChild("BackGround/UI/CharName/CharUpgrade/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1986))
  self._charUpgradeBtn = self:GetChild("BackGround/UI/CharName/CharUpgrade")
  self._charUpgradeBtn:SetActive(true)
  self._charUpgradeBtn_LvText = self:GetChild("BackGround/UI/CharName/CharUpgrade/Lv")
end

function CheckOtherRoleInfoDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("character.characterjobdialog")
end

local function HideNodeBeforeClookCardBaseAttr(self, value)
  self._rolePanel:SetActive(value)
  self._propPanel:SetActive(value)
  self._charName:SetActive(value)
  self._levelTxt:SetActive(value)
  self._levelMax:SetActive(value)
  self._breakPoint:SetActive(value)
  self._evolvePoint:SetActive(value)
  for i, v in ipairs(self._skillPanel_skills) do
    v.cell:SetActive(value)
  end
end

function CheckOtherRoleInfoDialog:SetRoleBaseAttr(roleData)
  if self._checkIndexByProtocol then
    HideNodeBeforeClookCardBaseAttr(self, true)
    self._roleInfoList[self._checkIndexByProtocol] = roleData
    self._checkIndexByProtocol = nil
    self:Refresh(self._roleInfoList[self._roleIndex])
  end
end

function CheckOtherRoleInfoDialog:CheckBossRushRankArrowStatus(dataIndex)
  if #self._rankAllData == 1 then
    self._leftArrow:SetActive(false)
    self._rightArrow:SetActive(false)
  elseif dataIndex == 1 then
    self._leftArrow:SetActive(false)
    self._rightArrow:SetActive(true)
  elseif dataIndex == #self._rankAllData then
    self._rightArrow:SetActive(false)
    self._leftArrow:SetActive(true)
  else
    self._rightArrow:SetActive(true)
    self._leftArrow:SetActive(true)
  end
end

function CheckOtherRoleInfoDialog:SetSelectRoleInfo(index)
  self._curIndex = index
  local data = self._rankAllData[index]
  if not data then
    return
  end
  self._userId = data.userId
  self._bossId = data.bossRushId
  self._roleId = data.roleId
  self._userName = data.userName
end

function CheckOtherRoleInfoDialog:RefreshRoleInfo()
  for _, role in pairs(self._roleInfoList) do
    if role.id == self._roleId then
      self:Refresh(role)
    end
  end
end

function CheckOtherRoleInfoDialog:Init(data, type, tag)
  self._type = type
  self._tag = tag
  if type == CheckOtherRoleInfoDialog.ShowType.BossRushRank then
    local idx = data.dataIndex
    self._rankAllData = data.allRoleData
    self:SetSelectRoleInfo(idx)
    self:CheckBossRushRankArrowStatus(idx)
  elseif type == CheckOtherRoleInfoDialog.ShowType.FriendShow then
    self._roleInfoList = data.roleList
    self._roleId = self._roleInfoList[data.index].id
    self:RefreshBefore(self._roleInfoList)
  elseif type == CheckOtherRoleInfoDialog.ShowType.BaseLevelInfo then
    self._roleInfoList = {}
    self._roleIdList = data.roleIdList
    self._cfgIdList = data.cfgIdList
    self._roleIndex = data.index
    if #self._roleIdList > 1 then
      self:SetArrowActive(true)
    else
      self:SetArrowActive(false)
    end
    self._equipPanel:SetActive(false)
    self._fightPanel:SetActive(false)
    self._checkIndexByProtocol = self._roleIndex
    local csend = LuaNetManager.CreateProtocol("protocol.card.clookcardbaseattr")
    csend.roleId = self._roleIdList[self._roleIndex]
    csend.cfgId = self._cfgIdList[self._roleIndex]
    csend:Send()
    HideNodeBeforeClookCardBaseAttr(self, false)
  elseif type == CheckOtherRoleInfoDialog.ShowType.PVP then
    self._roleInfoList = data.roleList
    self._roleId = self._roleInfoList[data.index].id
    self:RefreshBefore(self._roleInfoList)
  elseif type == CheckOtherRoleInfoDialog.ShowType.CompleteLineup then
    self._roleInfoList = data.roleList
    self._roleId = self._roleInfoList[data.index].id
    self:RefreshBefore(self._roleInfoList)
  end
end

function CheckOtherRoleInfoDialog:Refresh(role, dontSetLive2D)
  self._roleId = role.id
  self._roleInfo = role
  local roleIdData = Role.Create(role.id)
  self._role = roleIdData
  roleIdData:SetFashionId(role.skin or 0)
  local record = roleIdData:GetShapeLive2DRecord()
  self._rolePanel:SetActive(true)
  if not dontSetLive2D then
    self._rolePanel:SetAnimatorTrigger("loadReady")
    if self._handler then
      self._live2D:Release(self._handler)
      self._handler = nil
    end
    if (not self._tag or self._tag ~= CheckOtherRoleInfoDialog.TagType.GachaResult) and roleIdData:IsFashionLive2D() and Live2DManager.CanUse() and record.live2DAssetBundleName and record.live2DPrefabName then
      self._rolePanel:SetLocalScale(self._rolePanel_scaleX, self._rolePanel_scaleY, self._rolePanel_scaleZ)
      self._photo:SetActive(false)
      self._handler = self._live2D:AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
    else
      self._photo:SetActive(true)
      self._photo:SetSprite(roleIdData:GetShapeLiHuiImageRecord().assetBundle, roleIdData:GetShapeLiHuiImageRecord().assetName)
      local scale = roleIdData:GetPhotoScale()
      self._photo:SetLocalScale(scale, scale, scale)
      local photoPos = roleIdData:GetPhotoPosition()
      self._photo:SetAnchoredPosition(photoPos[1], photoPos[2])
    end
  end
  self._jobId = roleIdData:GetVocationId()
  self._jobTxt:SetText(roleIdData:GetVocationName())
  self._jobImg:SetSprite(roleIdData:GetVocationDescribeImageRecord().assetBundle, roleIdData:GetVocationDescribeImageRecord().assetName)
  self._cvName:SetText(roleIdData:GetCvName())
  self._rank:SetSprite(roleIdData:GetRoleInfoRarityImageRecord().assetBundle, roleIdData:GetRoleInfoRarityImageRecord().assetName)
  if role.id == 1 then
    self._name:SetActive(false)
    self._charTitle:SetActive(false)
    self._rank:SetActive(false)
  else
    self._rank:SetActive(true)
    self._name:SetActive(true)
    self._charTitle:SetActive(true)
    local str = ""
    if role.id == 1 then
      str = self._userName
    else
      str = roleIdData:GetRoleName()
    end
    self._charTitle:SetText(roleIdData:GetTitleName())
    self._name:SetText(str)
  end
  self._elementImg:SetSprite(roleIdData:GetElementImageRecord().assetBundle, roleIdData:GetElementImageRecord().assetName)
  record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAX_HP)
  local imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._propHeartImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if self._type ~= CheckOtherRoleInfoDialog.ShowType.BaseLevelInfo then
    self._propHeart:SetText(role.properties[AttrTypeEnum.HP])
  else
    self._propHeart:SetText(role.properties[AttrTypeEnum.MAX_HP])
  end
  self._propAtk:SetText(role.properties[AttrTypeEnum.ATTACK])
  if roleIdData:GetDamageType() == 1 then
    record = CAttrNameTable:GetRecorder(AttrTypeEnum.ATTACK)
  else
    record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAGIC_ATTACK)
  end
  imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._propAtkImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  record = CAttrNameTable:GetRecorder(AttrTypeEnum.DEFEND)
  imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._propPhyDefImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._propPhyDef:SetText(role.properties[AttrTypeEnum.DEFEND])
  record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAGIC_DEFEND)
  imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._propMagDefImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._propMagDef:SetText(role.properties[AttrTypeEnum.MAGIC_DEFEND])
  roleIdData:SetRuneLevel(role.runeLevel)
  self._charUpgradeBtn_LvText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1287, {
    roleIdData:GetRuneLevel()
  }))
  roleIdData:SetLevel(role.lv)
  roleIdData:SetBreakLv(role.breakLv)
  self._levelTxt:SetText(roleIdData:GetShowLv())
  local curLv = roleIdData:GetBreakLv()
  local maxLv = roleIdData:GetMaxBreakLv()
  str = ""
  for i = 1, maxLv do
    if i <= curLv then
      str = str .. "1"
    else
      str = str .. "0"
    end
  end
  self._breakPoint:SetText(str)
  local curLv = role.evolution
  local maxLv = RoleConfigTable:GetRecorder(role.id).evolutionLimit
  local str = ""
  for i = 1, maxLv do
    if i <= curLv then
      str = str .. "1"
    else
      str = str .. "0"
    end
  end
  self._evolvePoint:SetText(str)
  roleIdData:InitShowSkillsByOtherWays(role.contractSkill, role.passiveskill)
  local showSkillData = roleIdData:GetShowSkillData()
  for i, v in ipairs(self._skillPanel_skills) do
    local data = showSkillData[i]
    local skill = Skill.Create(data.skillId, data.skillItemId or true)
    v.cell:Init(skill, data.unlock)
  end
  self:RefreshEquipPanel()
  if self._type ~= CheckOtherRoleInfoDialog.ShowType.BaseLevelInfo then
    self._fightNum:SetText(role.power)
  end
  local roleTmp = clone(role)
  setmetatable(roleTmp, {
    __index = function(table, key)
      for k, v in pairs(table.__debug__variables) do
        if k == key then
          return v
        end
      end
    end
  })
  if roleTmp.specialWeaponLevel then
    self._uniqueEquipPanel:SetActive(true)
    roleIdData:SetUniqueEquipLevel(roleTmp.specialWeaponLevel)
    local uniqueEquipId = roleIdData:GetUniqueEquipId()
    if uniqueEquipId then
      local lv = roleTmp.specialWeaponLevel
      self._uniqueEquipPanel_no:SetActive(false)
      if 0 < lv then
        self._uniqueEquipPanel_lock:SetActive(false)
        self._uniqueEquipPanel_unlock:SetActive(true)
        self._uniqueEquipPanel_unlock_lv:SetText(lv)
        local uniqueEquipItem = UniqueEquip.Create(uniqueEquipId)
        local image = uniqueEquipItem:GetPinJiImage()
        self._uniqueEquipPanel_unlock_frame:SetSprite(image.assetBundle, image.assetName)
        image = uniqueEquipItem:GetIcon()
        self._uniqueEquipPanel_unlock_icon:SetSprite(image.assetBundle, image.assetName)
      else
        self._uniqueEquipPanel_lock:SetActive(true)
        self._uniqueEquipPanel_unlock:SetActive(false)
      end
    else
      self._uniqueEquipPanel_no:SetActive(true)
      self._uniqueEquipPanel_lock:SetActive(false)
      self._uniqueEquipPanel_unlock:SetActive(false)
    end
  else
    self._uniqueEquipPanel:SetActive(false)
  end
end

function CheckOtherRoleInfoDialog:OnLeftArrowClick()
  if self._type == CheckOtherRoleInfoDialog.ShowType.BossRushRank then
    if self._curIndex == 1 then
      return
    end
    self._curIndex = self._curIndex - 1
    self:SetSelectRoleInfo(self._curIndex)
    self:CheckBossRushRankArrowStatus(self._curIndex)
    self:RefreshRoleInfo()
  elseif self._canChangeRole then
    self._canChangeRole = false
    if self._type == CheckOtherRoleInfoDialog.ShowType.FriendShow or self._type == CheckOtherRoleInfoDialog.ShowType.PVP then
      if 1 < #self._rolePosList then
        local pos
        for i, index in ipairs(self._rolePosList) do
          if self._roleInfoList[index].id == self._roleId then
            pos = i - 1
            break
          end
        end
        if pos then
          if pos <= 0 then
            pos = pos + #self._rolePosList
          end
          self:Refresh(self._roleInfoList[self._rolePosList[pos]])
        end
      end
    elseif self._type == CheckOtherRoleInfoDialog.ShowType.CompleteLineup then
      if 1 < #self._rolePosList then
        local pos
        for i, index in pairs(self._rolePosList) do
          if self._roleInfoList[index].id == self._roleId then
            pos = i + 1
            break
          end
        end
        if pos then
          if pos > #self._rolePosList then
            pos = pos - #self._rolePosList
          end
          self:Refresh(self._roleInfoList[self._rolePosList[pos]])
        end
      end
    elseif self._type == CheckOtherRoleInfoDialog.ShowType.BaseLevelInfo then
      local len = #self._roleIdList
      self._roleIndex = self._roleIndex - 1
      if self._roleIndex == 0 then
        self._roleIndex = len
      end
      if not self._roleInfoList[self._roleIndex] then
        self._checkIndexByProtocol = self._roleIndex
        local csend = LuaNetManager.CreateProtocol("protocol.card.clookcardbaseattr")
        csend.roleId = self._roleIdList[self._roleIndex]
        csend.cfgId = self._cfgIdList[self._roleIndex]
        csend:Send()
      else
        self:Refresh(self._roleInfoList[self._roleIndex])
      end
    end
  end
end

function CheckOtherRoleInfoDialog:OnRightArrowClick()
  if self._type == CheckOtherRoleInfoDialog.ShowType.BossRushRank then
    if self._curIndex == #self._rankAllData then
      return
    end
    self._curIndex = self._curIndex + 1
    self:SetSelectRoleInfo(self._curIndex)
    self:CheckBossRushRankArrowStatus(self._curIndex)
    self:RefreshRoleInfo()
  elseif self._canChangeRole then
    self._canChangeRole = false
    if self._type == CheckOtherRoleInfoDialog.ShowType.FriendShow or self._type == CheckOtherRoleInfoDialog.ShowType.PVP then
      if 1 < #self._rolePosList then
        local pos
        for i, index in pairs(self._rolePosList) do
          if self._roleInfoList[index].id == self._roleId then
            pos = i + 1
            break
          end
        end
        if pos then
          if pos > #self._rolePosList then
            pos = pos - #self._rolePosList
          end
          self:Refresh(self._roleInfoList[self._rolePosList[pos]])
        end
      end
    elseif self._type == CheckOtherRoleInfoDialog.ShowType.CompleteLineup then
      if 1 < #self._rolePosList then
        local pos
        for i, index in ipairs(self._rolePosList) do
          if self._roleInfoList[index].id == self._roleId then
            pos = i - 1
            break
          end
        end
        if pos then
          if pos <= 0 then
            pos = pos + #self._rolePosList
          end
          self:Refresh(self._roleInfoList[self._rolePosList[pos]])
        end
      end
    elseif self._type == CheckOtherRoleInfoDialog.ShowType.BaseLevelInfo then
      local len = #self._roleIdList
      self._roleIndex = self._roleIndex + 1
      if len < self._roleIndex then
        self._roleIndex = 1
      end
      if not self._roleInfoList[self._roleIndex] then
        self._checkIndexByProtocol = self._roleIndex
        local csend = LuaNetManager.CreateProtocol("protocol.card.clookcardbaseattr")
        csend.roleId = self._roleIdList[self._roleIndex]
        csend.cfgId = self._cfgIdList[self._roleIndex]
        csend:Send()
      else
        self:Refresh(self._roleInfoList[self._roleIndex])
      end
    end
  end
end

function CheckOtherRoleInfoDialog:ShouldLengthChange(frame, index)
  return true
end

function CheckOtherRoleInfoDialog:OnPropPanelClick()
  if self._roleInfo then
    local dialog = DialogManager.CreateSingletonDialog("character.newpropertytipsdialog")
    dialog:Init(self._roleInfo, self, true)
  end
end

function CheckOtherRoleInfoDialog:OnSkillClick(index)
  if self._role then
    local data = self._role:GetShowSkillDataByIndex(index)
    if data.unlock then
      DialogManager.CreateSingletonDialog("skill.skilltipsdialog"):SetSkillAndRoleId(data.skillId, data.skillItemId, self._role:GetRoleId())
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100315)
    end
  end
end

function CheckOtherRoleInfoDialog:OnEquipPanel1Click()
  if self._weapon then
    local tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
    if tipsDialog then
      tipsDialog:RefreshInfo(self._weapon, true)
      tipsDialog:SetTipsParmFunc(function()
        local width, height = self._equipSmallPanel1:GetRectSize()
        local pos = self._equipSmallPanel1:GetLocalPointInUiRootPanel()
        return {
          width = width,
          height = height,
          posX = pos.x,
          posY = pos.y
        }
      end)
    end
  end
end

function CheckOtherRoleInfoDialog:OnEquipPanel2Click()
  if self._armor then
    local tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
    if tipsDialog then
      tipsDialog:RefreshInfo(self._armor, true)
      tipsDialog:SetTipsParmFunc(function()
        local width, height = self._equipSmallPanel2:GetRectSize()
        local pos = self._equipSmallPanel2:GetLocalPointInUiRootPanel()
        return {
          width = width,
          height = height,
          posX = pos.x,
          posY = pos.y
        }
      end)
    end
  end
end

function CheckOtherRoleInfoDialog:OnEquipPanel3Click()
  if self._jewelry then
    local tipsDialog = DialogManager.CreateSingletonDialog("equip.equiptipsdialog")
    if tipsDialog then
      tipsDialog:RefreshInfo(self._jewelry, true)
      tipsDialog:SetTipsParmFunc(function()
        local width, height = self._equipSmallPanel3:GetRectSize()
        local pos = self._equipSmallPanel3:GetLocalPointInUiRootPanel()
        return {
          width = width,
          height = height,
          posX = pos.x,
          posY = pos.y
        }
      end)
    end
  end
end

function CheckOtherRoleInfoDialog:OnDrag(args)
  if args.delta.x ~= 0 then
    self._direction = args.delta.x
  end
end

function CheckOtherRoleInfoDialog:OnEndDrag(args)
  if self._direction then
    if self._direction > 0 then
      self:OnLeftArrowClick()
    elseif self._direction < 0 then
      self:OnRightArrowClick()
    end
  end
end

function CheckOtherRoleInfoDialog:OnRoleChangeStateExit(arg1, arg2)
  if arg2 == "CharChangeRole" then
    self._canChangeRole = true
  end
end

function CheckOtherRoleInfoDialog:RefreshEquipPanel()
  local equipInfo
  if self._type ~= CheckOtherRoleInfoDialog.ShowType.BaseLevelInfo and self._roleInfo then
    equipInfo = self._roleInfo.equips
  end
  local record
  local equips = {}
  if equipInfo then
    self._weapon = equipInfo[EquipTypeEnum.WEAPON]
    self._armor = equipInfo[EquipTypeEnum.ARMOR]
    self._jewelry = equipInfo[EquipTypeEnum.JEWELRY]
    local equip1, equip2, equip3
    if self._weapon then
      equip1 = Equip.Create(self._weapon.itemId)
    end
    if self._armor then
      equip2 = Equip.Create(self._armor.itemId)
    end
    if self._jewelry then
      equip3 = Equip.Create(self._jewelry.itemId)
    end
    equips = {
      equip1,
      equip2,
      equip3
    }
  end
  local temp = {}
  for i, equip in ipairs(equips) do
    if equip then
      record = equip:GetEquipSuitRecorder()
      if record then
        if temp[record.id] then
          temp[record.id].count = temp[record.id].count + 1
        else
          temp[record.id] = {
            count = 1,
            skillIds = record.suitSkillID
          }
        end
      end
    end
  end
  local suitMap = {}
  for k, v in pairs(temp) do
    suitMap[k] = {
      skillIds = {}
    }
    for i = 1, v.count do
      if v.skillIds[i] ~= 0 then
        table.insert(suitMap[k].skillIds, v.skillIds[i])
      end
    end
  end
  local showSuitEffect = false
  for k, v in pairs(suitMap) do
    if #v.skillIds > 0 then
      showSuitEffect = true
      break
    end
  end
  self._suitEffect:SetActive(showSuitEffect)
  self._suitMap = suitMap
  if self._weapon then
    self._equipCell1:SetActive(true)
    self._equipCell1Empty:SetActive(false)
    equips[1]:SetStage(self._weapon.stage)
    record = equips[1]:GetIcon()
    self._equipCell1Icon:SetSprite(record.assetBundle, record.assetName)
    record = equips[1]:GetPinJiImage()
    self._equipCell1Frame:SetSprite(record.assetBundle, record.assetName)
    local suitID = equips[1]:GetEquipSuitId()
    self._equipCell1Suit:SetActive(suitMap[suitID] and #suitMap[suitID].skillIds > 0)
    self._equipCell1SuitGrey:SetActive(suitMap[suitID] and #suitMap[suitID].skillIds == 0)
    self._equipCell1PinJiStat:SetText(equips[1]:GetEquipStarStr())
    if self._equipCell1Suit:IsActive() then
      record = equips[1]:GetEquipSuitRecorder()
      record = record and CImagePathTable:GetRecorder(record.suitImg)
      self._equipCell1Suit:SetSprite(record.assetBundle, record.assetName)
    end
    if self._equipCell1SuitGrey:IsActive() then
      record = equips[1]:GetEquipSuitRecorder()
      record = record and CImagePathTable:GetRecorder(record.suitImg)
      self._equipCell1SuitGrey:SetSprite(record.assetBundle, record.assetName)
    end
    self._equipCell1Lv:SetText(self._weapon.level)
    self._equipCell1SpecialFMImage:SetActive(self._weapon.finalAttrRandomEntry.randomId ~= 0)
    if self._weapon.finalAttrRandomEntry.randomId ~= 0 then
      self._equipCell1_animator:SetInteger("par", 1)
    else
      self._equipCell1_animator:SetInteger("par", 0)
    end
  else
    self._equipCell1:SetActive(false)
    self._equipCell1Empty:SetActive(true)
  end
  if self._armor then
    self._equipCell2:SetActive(true)
    self._equipCell2Empty:SetActive(false)
    equips[2]:SetStage(self._armor.stage)
    record = equips[2]:GetIcon()
    self._equipCell2Icon:SetSprite(record.assetBundle, record.assetName)
    record = equips[2]:GetPinJiImage()
    self._equipCell2Frame:SetSprite(record.assetBundle, record.assetName)
    local suitID = equips[2]:GetEquipSuitId()
    self._equipCell2Suit:SetActive(suitMap[suitID] and #suitMap[suitID].skillIds > 0)
    self._equipCell2SuitGrey:SetActive(suitMap[suitID] and #suitMap[suitID].skillIds == 0)
    self._equipCell2PinJiStat:SetText(equips[2]:GetEquipStarStr())
    if self._equipCell2Suit:IsActive() then
      record = equips[2]:GetEquipSuitRecorder()
      record = record and CImagePathTable:GetRecorder(record.suitImg)
      self._equipCell2Suit:SetSprite(record.assetBundle, record.assetName)
    end
    if self._equipCell2SuitGrey:IsActive() then
      record = equips[2]:GetEquipSuitRecorder()
      record = record and CImagePathTable:GetRecorder(record.suitImg)
      self._equipCell2SuitGrey:SetSprite(record.assetBundle, record.assetName)
    end
    self._equipCell2Lv:SetText(self._armor.level)
    self._equipCell2SpecialFMImage:SetActive(self._armor.finalAttrRandomEntry.randomId ~= 0)
    if self._armor.finalAttrRandomEntry.randomId ~= 0 then
      self._equipCell2_animator:SetInteger("par", 1)
    else
      self._equipCell2_animator:SetInteger("par", 0)
    end
  else
    self._equipCell2:SetActive(false)
    self._equipCell2Empty:SetActive(true)
  end
  if self._jewelry then
    self._equipCell3:SetActive(true)
    self._equipCell3Empty:SetActive(false)
    equips[3]:SetStage(self._jewelry.stage)
    record = equips[3]:GetIcon()
    self._equipCell3Icon:SetSprite(record.assetBundle, record.assetName)
    record = equips[3]:GetPinJiImage()
    self._equipCell3Frame:SetSprite(record.assetBundle, record.assetName)
    local suitID = equips[3]:GetEquipSuitId()
    self._equipCell3Suit:SetActive(suitMap[suitID] and #suitMap[suitID].skillIds > 0)
    self._equipCell3SuitGrey:SetActive(suitMap[suitID] and #suitMap[suitID].skillIds == 0)
    self._equipCell3PinJiStat:SetText(equips[3]:GetEquipStarStr())
    if self._equipCell3Suit:IsActive() then
      record = equips[3]:GetEquipSuitRecorder()
      record = record and CImagePathTable:GetRecorder(record.suitImg)
      self._equipCell3Suit:SetSprite(record.assetBundle, record.assetName)
    end
    if self._equipCell3SuitGrey:IsActive() then
      record = equips[3]:GetEquipSuitRecorder()
      record = record and CImagePathTable:GetRecorder(record.suitImg)
      self._equipCell3SuitGrey:SetSprite(record.assetBundle, record.assetName)
    end
    self._equipCell3Lv:SetText(self._jewelry.level)
    self._equipCell3SpecialFMImage:SetActive(self._jewelry.finalAttrRandomEntry.randomId ~= 0)
    if self._jewelry.finalAttrRandomEntry.randomId ~= 0 then
      self._equipCell3_animator:SetInteger("par", 1)
    else
      self._equipCell3_animator:SetInteger("par", 0)
    end
  else
    self._equipCell3:SetActive(false)
    self._equipCell3Empty:SetActive(true)
  end
end

function CheckOtherRoleInfoDialog:SetArrowActive(flag)
  self._leftArrow:SetActive(flag)
  self._rightArrow:SetActive(flag)
end

function CheckOtherRoleInfoDialog:OnReceiveCheckProtocol(notification)
  warn("OnReceiveCheckProtocol: ", notification.userInfo.userId, self._userId, notification.userInfo.bossId, self._bossId)
  if notification.userInfo.userId == self._userId and notification.userInfo.bossId == self._bossId then
    self:RefreshBefore(notification.userInfo.lineup.roles)
  end
end

function CheckOtherRoleInfoDialog:UpdateProtocol(notification)
  warn("UpdateProtocol: ", notification.userInfo.userId, self._userId, notification.userInfo.bossId, self._bossId)
  self:RefreshBefore(notification.userInfo.lineup.roles)
end

function CheckOtherRoleInfoDialog:RefreshBefore(roles)
  self._roleInfoList = roles
  self._rolePosList = {}
  for i, v in pairs(self._roleInfoList) do
    table.insert(self._rolePosList, i)
  end
  table.sort(self._rolePosList, function(a, b)
    return a < b
  end)
  for _, role in pairs(self._roleInfoList) do
    if role.id == self._roleId then
      self:Refresh(role)
    end
  end
end

function CheckOtherRoleInfoDialog:OnJobClick()
  DialogManager.CreateSingletonDialog("character.characterjobdialog"):SetData(self._jobId)
end

function CheckOtherRoleInfoDialog:OnElementImgClick()
  DialogManager.CreateSingletonDialog("character.characterelementinfodialog"):SetData(self._role:GetRoleId())
end

function CheckOtherRoleInfoDialog:OnBackBtnClicked()
  self:Destroy()
end

function CheckOtherRoleInfoDialog:OnSuitEffectClicked()
  local suitMap = self._suitMap
  local showData = {}
  for k, v in pairs(suitMap) do
    if #v.skillIds > 0 then
      table.insert(showData, {
        suitId = k,
        skillIds = v.skillIds
      })
    end
  end
  if 0 < #showData then
    DialogManager.CreateSingletonDialog("character.equipsuittipdialog"):SetData(showData)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100317)
  end
end

return CheckOtherRoleInfoDialog
