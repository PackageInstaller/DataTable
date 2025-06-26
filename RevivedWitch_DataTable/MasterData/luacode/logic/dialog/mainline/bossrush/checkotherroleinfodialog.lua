-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/bossrush/checkotherroleinfodialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local Skill = require("logic.manager.experimental.types.skill")
local Equip = require("logic.manager.experimental.types.equip")
local UniqueEquip = require("logic.manager.experimental.types.uniqueequip")
local AttrTypeEnum = (LuaNetManager.GetBeanDef)("protocol.login.attrtype")
local EquipTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.equiptype")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CSkillTable = (BeanManager.GetTableByName)("skill.cskill")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CItemAttrTable = (BeanManager.GetTableByName)("item.citemattr")
local CItemPinJiTable = (BeanManager.GetTableByName)("item.citempinji")
local CEquipItemTable = (BeanManager.GetTableByName)("item.cequipitem")
local CheckOtherRoleInfoDialog = class("CheckOtherRoleInfoDialog", Dialog)
CheckOtherRoleInfoDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CheckOtherRoleInfoDialog.AssetName = "BaseCharacterOthers"
CheckOtherRoleInfoDialog.ShowType = {BossRushRank = 1, FriendShow = 2, BaseLevelInfo = 3, PVP = 4, CompleteLineup = 5}
CheckOtherRoleInfoDialog.TagType = {GachaResult = 1}
CheckOtherRoleInfoDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CheckOtherRoleInfoDialog
  ((CheckOtherRoleInfoDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._dragHandler = nil
  self._endDragHandler = nil
  self._cancelDragHandler = nil
end

CheckOtherRoleInfoDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._rolePanel = self:GetChild("Role")
  self._rolePanel_scaleX = (self._rolePanel):GetLocalScale()
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
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnLeftArrowClick, self)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnRightArrowClick, self)
  self._dragHandler = (self:GetRootWindow()):Subscribe_DragEvent(self.OnDrag, self)
  self._endDragHandler = (self:GetRootWindow()):Subscribe_EndDragEvent(self.OnEndDrag, self)
  self._cancelDragHandler = (self:GetRootWindow()):Subscribe_CancelDragEvent(self.OnEndDrag, self)
  ;
  (self._rolePanel):Subscribe_StateExitEvent(self.OnRoleChangeStateExit, self)
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
    do
      -- DECOMPILER ERROR at PC158: Confused about usage of register: R5 in 'UnsetPending'

      (self._skillPanel_skills)[i] = {}
      -- DECOMPILER ERROR at PC171: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._skillPanel_skills)[i]).cell = (DialogManager.CreateDialog)("skill.skillcell", (self:GetChild("BackGround/RightPanel/Skill/SkillBack" .. i))._uiObject)
      ;
      ((((self._skillPanel_skills)[i]).cell)._rootWindow):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnSkillClick(i)
  end
)
    end
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
  self._equipCell1_animator = ((self:GetChild("BackGround/RightPanel/Equip/Equip1")):GetUIObject()):GetComponent("Animator")
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
  self._equipCell2_animator = ((self:GetChild("BackGround/RightPanel/Equip/Equip2")):GetUIObject()):GetComponent("Animator")
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
  self._equipCell3_animator = ((self:GetChild("BackGround/RightPanel/Equip/Equip3")):GetUIObject()):GetComponent("Animator")
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
  ;
  (self._propPanel):Subscribe_PointerClickEvent(self.OnPropPanelClick, self)
  ;
  (self._equipSmallPanel1):Subscribe_PointerClickEvent(self.OnEquipPanel1Click, self)
  ;
  (self._equipSmallPanel2):Subscribe_PointerClickEvent(self.OnEquipPanel2Click, self)
  ;
  (self._equipSmallPanel3):Subscribe_PointerClickEvent(self.OnEquipPanel3Click, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._jobClick):Subscribe_PointerClickEvent(self.OnJobClick, self)
  ;
  (self._elementImg):Subscribe_PointerClickEvent(self.OnElementImgClick, self)
  ;
  (self._suitEffect):Subscribe_PointerClickEvent(self.OnSuitEffectClicked, self)
  ;
  (self:GetChild("BackGround/UI/CharName/CharUpgrade/Txt")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1986))
  self._charUpgradeBtn = self:GetChild("BackGround/UI/CharName/CharUpgrade")
  ;
  (self._charUpgradeBtn):SetActive(false)
  self._charUpgradeBtn_LvText = self:GetChild("BackGround/UI/CharName/CharUpgrade/Lv")
end

CheckOtherRoleInfoDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("character.characterjobdialog")
end

local HideNodeBeforeClookCardBaseAttr = function(self, value)
  -- function num : 0_3 , upvalues : _ENV
  (self._rolePanel):SetActive(value)
  ;
  (self._propPanel):SetActive(value)
  ;
  (self._charName):SetActive(value)
  ;
  (self._levelTxt):SetActive(value)
  ;
  (self._levelMax):SetActive(value)
  ;
  (self._breakPoint):SetActive(value)
  ;
  (self._evolvePoint):SetActive(value)
  for i,v in ipairs(self._skillPanel_skills) do
    (v.cell):SetActive(value)
  end
end

CheckOtherRoleInfoDialog.SetRoleBaseAttr = function(self, roleData)
  -- function num : 0_4 , upvalues : HideNodeBeforeClookCardBaseAttr
  if self._checkIndexByProtocol then
    HideNodeBeforeClookCardBaseAttr(self, true)
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._roleInfoList)[self._checkIndexByProtocol] = roleData
    self._checkIndexByProtocol = nil
    self:Refresh((self._roleInfoList)[self._roleIndex])
  end
end

CheckOtherRoleInfoDialog.CheckBossRushRankArrowStatus = function(self, dataIndex)
  -- function num : 0_5
  if #self._rankAllData == 1 then
    (self._leftArrow):SetActive(false)
    ;
    (self._rightArrow):SetActive(false)
  else
    if dataIndex == 1 then
      (self._leftArrow):SetActive(false)
      ;
      (self._rightArrow):SetActive(true)
    else
      if dataIndex == #self._rankAllData then
        (self._rightArrow):SetActive(false)
        ;
        (self._leftArrow):SetActive(true)
      else
        ;
        (self._rightArrow):SetActive(true)
        ;
        (self._leftArrow):SetActive(true)
      end
    end
  end
end

CheckOtherRoleInfoDialog.SetSelectRoleInfo = function(self, index)
  -- function num : 0_6
  self._curIndex = index
  local data = (self._rankAllData)[index]
  if not data then
    return 
  end
  self._userId = data.userId
  self._bossId = data.bossRushId
  self._roleId = data.roleId
  self._userName = data.userName
end

CheckOtherRoleInfoDialog.RefreshRoleInfo = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for _,role in pairs(self._roleInfoList) do
    if role.id == self._roleId then
      self:Refresh(role)
    end
  end
end

CheckOtherRoleInfoDialog.Init = function(self, data, type, tag)
  -- function num : 0_8 , upvalues : CheckOtherRoleInfoDialog, _ENV, HideNodeBeforeClookCardBaseAttr
  self._type = type
  self._tag = tag
  if type == (CheckOtherRoleInfoDialog.ShowType).BossRushRank then
    local idx = data.dataIndex
    self._rankAllData = data.allRoleData
    self:SetSelectRoleInfo(idx)
    self:CheckBossRushRankArrowStatus(idx)
  else
    do
      if type == (CheckOtherRoleInfoDialog.ShowType).FriendShow then
        self._roleInfoList = data.roleList
        self._roleId = ((self._roleInfoList)[data.index]).id
        self:RefreshBefore(self._roleInfoList)
      else
        if type == (CheckOtherRoleInfoDialog.ShowType).BaseLevelInfo then
          self._roleInfoList = {}
          self._roleIdList = data.roleIdList
          self._cfgIdList = data.cfgIdList
          self._roleIndex = data.index
          if #self._roleIdList > 1 then
            self:SetArrowActive(true)
          else
            self:SetArrowActive(false)
          end
          ;
          (self._equipPanel):SetActive(false)
          ;
          (self._fightPanel):SetActive(false)
          self._checkIndexByProtocol = self._roleIndex
          local csend = (LuaNetManager.CreateProtocol)("protocol.card.clookcardbaseattr")
          csend.roleId = (self._roleIdList)[self._roleIndex]
          csend.cfgId = (self._cfgIdList)[self._roleIndex]
          csend:Send()
          HideNodeBeforeClookCardBaseAttr(self, false)
        else
          do
            if type == (CheckOtherRoleInfoDialog.ShowType).PVP then
              self._roleInfoList = data.roleList
              self._roleId = ((self._roleInfoList)[data.index]).id
              self:RefreshBefore(self._roleInfoList)
            else
              if type == (CheckOtherRoleInfoDialog.ShowType).CompleteLineup then
                self._roleInfoList = data.roleList
                self._roleId = ((self._roleInfoList)[data.index]).id
                self:RefreshBefore(self._roleInfoList)
              end
            end
          end
        end
      end
    end
  end
end

CheckOtherRoleInfoDialog.Refresh = function(self, role, dontSetLive2D)
  -- function num : 0_9 , upvalues : Role, CheckOtherRoleInfoDialog, _ENV, CAttrNameTable, AttrTypeEnum, CImagePathTable, RoleConfigTable, Skill
  self._roleId = role.id
  self._roleInfo = role
  local roleIdData = (Role.Create)(role.id)
  self._role = roleIdData
  roleIdData:SetFashionId(role.skin or 0)
  local record = roleIdData:GetShapeLive2DRecord()
  ;
  (self._rolePanel):SetActive(true)
  if not dontSetLive2D then
    (self._rolePanel):SetAnimatorTrigger("loadReady")
    if self._handler then
      (self._live2D):Release(self._handler)
      self._handler = nil
    end
    if (not self._tag or self._tag ~= (CheckOtherRoleInfoDialog.TagType).GachaResult) and roleIdData:IsFashionLive2D() and (Live2DManager.CanUse)() and record.live2DAssetBundleName and record.live2DPrefabName then
      (self._rolePanel):SetLocalScale(self._rolePanel_scaleX, self._rolePanel_scaleY, self._rolePanel_scaleZ)
      ;
      (self._photo):SetActive(false)
      self._handler = (self._live2D):AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
    else
      ;
      (self._photo):SetActive(true)
      ;
      (self._photo):SetSprite((roleIdData:GetShapeLiHuiImageRecord()).assetBundle, (roleIdData:GetShapeLiHuiImageRecord()).assetName)
      local scale = roleIdData:GetPhotoScale()
      ;
      (self._photo):SetLocalScale(scale, scale, scale)
      local photoPos = roleIdData:GetPhotoPosition()
      ;
      (self._photo):SetAnchoredPosition(photoPos[1], photoPos[2])
    end
  end
  do
    self._jobId = roleIdData:GetVocationId()
    ;
    (self._jobTxt):SetText(roleIdData:GetVocationName())
    ;
    (self._jobImg):SetSprite((roleIdData:GetVocationDescribeImageRecord()).assetBundle, (roleIdData:GetVocationDescribeImageRecord()).assetName)
    ;
    (self._cvName):SetText(roleIdData:GetCvName())
    ;
    (self._rank):SetSprite((roleIdData:GetRoleInfoRarityImageRecord()).assetBundle, (roleIdData:GetRoleInfoRarityImageRecord()).assetName)
    if role.id == 1 then
      (self._name):SetActive(false)
      ;
      (self._charTitle):SetActive(false)
      ;
      (self._rank):SetActive(false)
    else
      ;
      (self._rank):SetActive(true)
      ;
      (self._name):SetActive(true)
      ;
      (self._charTitle):SetActive(true)
      local str = ""
      if role.id == 1 then
        str = self._userName
      else
        str = roleIdData:GetRoleName()
      end
      ;
      (self._charTitle):SetText(roleIdData:GetTitleName())
      ;
      (self._name):SetText(str)
    end
    do
      ;
      (self._elementImg):SetSprite((roleIdData:GetElementImageRecord()).assetBundle, (roleIdData:GetElementImageRecord()).assetName)
      record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAX_HP)
      if not CImagePathTable:GetRecorder(record.classIcon) then
        local imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._propHeartImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      if self._type ~= (CheckOtherRoleInfoDialog.ShowType).BaseLevelInfo then
        (self._propHeart):SetText((role.properties)[AttrTypeEnum.HP])
      else
        ;
        (self._propHeart):SetText((role.properties)[AttrTypeEnum.MAX_HP])
      end
      ;
      (self._propAtk):SetText((role.properties)[AttrTypeEnum.ATTACK])
      if roleIdData:GetDamageType() == 1 then
        record = CAttrNameTable:GetRecorder(AttrTypeEnum.ATTACK)
      else
        record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAGIC_ATTACK)
      end
      if not CImagePathTable:GetRecorder(record.classIcon) then
        imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._propAtkImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      record = CAttrNameTable:GetRecorder(AttrTypeEnum.DEFEND)
      if not CImagePathTable:GetRecorder(record.classIcon) then
        imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._propPhyDefImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._propPhyDef):SetText((role.properties)[AttrTypeEnum.DEFEND])
      record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAGIC_DEFEND)
      if not CImagePathTable:GetRecorder(record.classIcon) then
        imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (self._propMagDefImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._propMagDef):SetText((role.properties)[AttrTypeEnum.MAGIC_DEFEND])
      roleIdData:SetRuneLevel(role.runeLevel)
      ;
      (self._charUpgradeBtn_LvText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1287, {roleIdData:GetRuneLevel()}))
      roleIdData:SetLevel(role.lv)
      roleIdData:SetBreakLv(role.breakLv)
      ;
      (self._levelTxt):SetText(roleIdData:GetShowLv())
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
      ;
      (self._breakPoint):SetText(str)
      local curLv = role.evolution
      local maxLv = (RoleConfigTable:GetRecorder(role.id)).evolutionLimit
      local str = ""
      for i = 1, maxLv do
        if i <= curLv then
          str = str .. "1"
        else
          str = str .. "0"
        end
      end
      ;
      (self._evolvePoint):SetText(str)
      roleIdData:InitShowSkillsByOtherWays(role.contractSkill, role.passiveskill)
      local showSkillData = roleIdData:GetShowSkillData()
      for i,v in ipairs(self._skillPanel_skills) do
        local data = showSkillData[i]
        local skill = (Skill.Create)(data.skillId, data.skillItemId or true)
        ;
        (v.cell):Init(skill, data.unlock)
      end
      self:RefreshEquipPanel()
      if self._type ~= (CheckOtherRoleInfoDialog.ShowType).BaseLevelInfo then
        (self._fightNum):SetText(role.power)
      end
    end
  end
end

CheckOtherRoleInfoDialog.OnLeftArrowClick = function(self)
  -- function num : 0_10 , upvalues : CheckOtherRoleInfoDialog, _ENV
  if self._type == (CheckOtherRoleInfoDialog.ShowType).BossRushRank then
    if self._curIndex == 1 then
      return 
    end
    self._curIndex = self._curIndex - 1
    self:SetSelectRoleInfo(self._curIndex)
    self:CheckBossRushRankArrowStatus(self._curIndex)
    self:RefreshRoleInfo()
  else
    if self._canChangeRole then
      self._canChangeRole = false
      -- DECOMPILER ERROR at PC40: Unhandled construct in 'MakeBoolean' P1

      if (self._type == (CheckOtherRoleInfoDialog.ShowType).FriendShow or self._type == (CheckOtherRoleInfoDialog.ShowType).PVP) and #self._rolePosList > 1 then
        local pos = nil
        for i,index in ipairs(self._rolePosList) do
          if ((self._roleInfoList)[index]).id == self._roleId then
            pos = i - 1
            break
          end
        end
        do
          do
            if pos then
              if pos <= 0 then
                pos = pos + #self._rolePosList
              end
              self:Refresh((self._roleInfoList)[(self._rolePosList)[pos]])
            end
            -- DECOMPILER ERROR at PC78: Unhandled construct in 'MakeBoolean' P1

            if self._type == (CheckOtherRoleInfoDialog.ShowType).CompleteLineup and #self._rolePosList > 1 then
              local pos = nil
              for i,index in pairs(self._rolePosList) do
                if ((self._roleInfoList)[index]).id == self._roleId then
                  pos = i + 1
                  break
                end
              end
              do
                do
                  if pos then
                    if #self._rolePosList < pos then
                      pos = pos - #self._rolePosList
                    end
                    self:Refresh((self._roleInfoList)[(self._rolePosList)[pos]])
                  end
                  if self._type == (CheckOtherRoleInfoDialog.ShowType).BaseLevelInfo then
                    local len = #self._roleIdList
                    self._roleIndex = self._roleIndex - 1
                    if self._roleIndex == 0 then
                      self._roleIndex = len
                    end
                    if not (self._roleInfoList)[self._roleIndex] then
                      self._checkIndexByProtocol = self._roleIndex
                      local csend = (LuaNetManager.CreateProtocol)("protocol.card.clookcardbaseattr")
                      csend.roleId = (self._roleIdList)[self._roleIndex]
                      csend.cfgId = (self._cfgIdList)[self._roleIndex]
                      csend:Send()
                    else
                      do
                        self:Refresh((self._roleInfoList)[self._roleIndex])
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
end

CheckOtherRoleInfoDialog.OnRightArrowClick = function(self)
  -- function num : 0_11 , upvalues : CheckOtherRoleInfoDialog, _ENV
  if self._type == (CheckOtherRoleInfoDialog.ShowType).BossRushRank then
    if self._curIndex == #self._rankAllData then
      return 
    end
    self._curIndex = self._curIndex + 1
    self:SetSelectRoleInfo(self._curIndex)
    self:CheckBossRushRankArrowStatus(self._curIndex)
    self:RefreshRoleInfo()
  else
    if self._canChangeRole then
      self._canChangeRole = false
      -- DECOMPILER ERROR at PC42: Unhandled construct in 'MakeBoolean' P1

      if (self._type == (CheckOtherRoleInfoDialog.ShowType).FriendShow or self._type == (CheckOtherRoleInfoDialog.ShowType).PVP) and #self._rolePosList > 1 then
        local pos = nil
        for i,index in pairs(self._rolePosList) do
          if ((self._roleInfoList)[index]).id == self._roleId then
            pos = i + 1
            break
          end
        end
        do
          do
            if pos then
              if #self._rolePosList < pos then
                pos = pos - #self._rolePosList
              end
              self:Refresh((self._roleInfoList)[(self._rolePosList)[pos]])
            end
            -- DECOMPILER ERROR at PC82: Unhandled construct in 'MakeBoolean' P1

            if self._type == (CheckOtherRoleInfoDialog.ShowType).CompleteLineup and #self._rolePosList > 1 then
              local pos = nil
              for i,index in ipairs(self._rolePosList) do
                if ((self._roleInfoList)[index]).id == self._roleId then
                  pos = i - 1
                  break
                end
              end
              do
                do
                  if pos then
                    if pos <= 0 then
                      pos = pos + #self._rolePosList
                    end
                    self:Refresh((self._roleInfoList)[(self._rolePosList)[pos]])
                  end
                  if self._type == (CheckOtherRoleInfoDialog.ShowType).BaseLevelInfo then
                    local len = #self._roleIdList
                    self._roleIndex = self._roleIndex + 1
                    if len < self._roleIndex then
                      self._roleIndex = 1
                    end
                    if not (self._roleInfoList)[self._roleIndex] then
                      self._checkIndexByProtocol = self._roleIndex
                      local csend = (LuaNetManager.CreateProtocol)("protocol.card.clookcardbaseattr")
                      csend.roleId = (self._roleIdList)[self._roleIndex]
                      csend.cfgId = (self._cfgIdList)[self._roleIndex]
                      csend:Send()
                    else
                      do
                        self:Refresh((self._roleInfoList)[self._roleIndex])
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
end

CheckOtherRoleInfoDialog.ShouldLengthChange = function(self, frame, index)
  -- function num : 0_12
  return true
end

CheckOtherRoleInfoDialog.OnPropPanelClick = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if self._roleInfo then
    local dialog = (DialogManager.CreateSingletonDialog)("character.newpropertytipsdialog")
    dialog:Init(self._roleInfo, self, true)
  end
end

CheckOtherRoleInfoDialog.OnSkillClick = function(self, index)
  -- function num : 0_14 , upvalues : _ENV
  if self._role then
    local data = (self._role):GetShowSkillDataByIndex(index)
    if data.unlock then
      ((DialogManager.CreateSingletonDialog)("skill.skilltipsdialog")):SetSkillAndRoleId(data.skillId, data.skillItemId, (self._role):GetRoleId())
    else
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100315)
    end
  end
end

CheckOtherRoleInfoDialog.OnEquipPanel1Click = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if self._weapon then
    local tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
    if tipsDialog then
      tipsDialog:RefreshInfo(self._weapon, true)
      tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_15_0 , upvalues : self
    local width, height = (self._equipSmallPanel1):GetRectSize()
    local pos = (self._equipSmallPanel1):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
    end
  end
end

CheckOtherRoleInfoDialog.OnEquipPanel2Click = function(self)
  -- function num : 0_16 , upvalues : _ENV
  if self._armor then
    local tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
    if tipsDialog then
      tipsDialog:RefreshInfo(self._armor, true)
      tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_16_0 , upvalues : self
    local width, height = (self._equipSmallPanel2):GetRectSize()
    local pos = (self._equipSmallPanel2):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
    end
  end
end

CheckOtherRoleInfoDialog.OnEquipPanel3Click = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if self._jewelry then
    local tipsDialog = (DialogManager.CreateSingletonDialog)("equip.equiptipsdialog")
    if tipsDialog then
      tipsDialog:RefreshInfo(self._jewelry, true)
      tipsDialog:SetTipsParmFunc(function()
    -- function num : 0_17_0 , upvalues : self
    local width, height = (self._equipSmallPanel3):GetRectSize()
    local pos = (self._equipSmallPanel3):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = pos.x, posY = pos.y}
  end
)
    end
  end
end

CheckOtherRoleInfoDialog.OnDrag = function(self, args)
  -- function num : 0_18
  if (args.delta).x ~= 0 then
    self._direction = (args.delta).x
  end
end

CheckOtherRoleInfoDialog.OnEndDrag = function(self, args)
  -- function num : 0_19
  if self._direction then
    if self._direction > 0 then
      self:OnLeftArrowClick()
    else
      if self._direction < 0 then
        self:OnRightArrowClick()
      end
    end
  end
end

CheckOtherRoleInfoDialog.OnRoleChangeStateExit = function(self, arg1, arg2)
  -- function num : 0_20
  if arg2 == "CharChangeRole" then
    self._canChangeRole = true
  end
end

CheckOtherRoleInfoDialog.RefreshEquipPanel = function(self)
  -- function num : 0_21 , upvalues : CheckOtherRoleInfoDialog, EquipTypeEnum, Equip, _ENV, CImagePathTable
  local equipInfo = nil
  if self._type ~= (CheckOtherRoleInfoDialog.ShowType).BaseLevelInfo and self._roleInfo then
    equipInfo = (self._roleInfo).equips
  end
  local record = nil
  local equips = {}
  if equipInfo then
    self._weapon = equipInfo[EquipTypeEnum.WEAPON]
    self._armor = equipInfo[EquipTypeEnum.ARMOR]
    self._jewelry = equipInfo[EquipTypeEnum.JEWELRY]
    local equip1, equip2, equip3 = nil, nil, nil
    if self._weapon then
      equip1 = (Equip.Create)((self._weapon).itemId)
    end
    if self._armor then
      equip2 = (Equip.Create)((self._armor).itemId)
    end
    if self._jewelry then
      equip3 = (Equip.Create)((self._jewelry).itemId)
    end
    equips = {equip1, equip2, equip3}
  end
  do
    local temp = {}
    for i,equip in ipairs(equips) do
      if equip then
        record = equip:GetEquipSuitRecorder()
        -- DECOMPILER ERROR at PC77: Confused about usage of register: R10 in 'UnsetPending'

        if record then
          if temp[record.id] then
            (temp[record.id]).count = (temp[record.id]).count + 1
          else
            temp[record.id] = {count = 1, skillIds = record.suitSkillID}
          end
        end
      end
    end
    local suitMap = {}
    for k,v in pairs(temp) do
      suitMap[k] = {
skillIds = {}
}
      for i = 1, v.count do
        if (v.skillIds)[i] ~= 0 then
          (table.insert)((suitMap[k]).skillIds, (v.skillIds)[i])
        end
      end
    end
    local showSuitEffect = false
    for k,v in pairs(suitMap) do
      if #v.skillIds > 0 then
        showSuitEffect = true
        break
      end
    end
    do
      ;
      (self._suitEffect):SetActive(showSuitEffect)
      self._suitMap = suitMap
      if self._weapon then
        (self._equipCell1):SetActive(true)
        ;
        (self._equipCell1Empty):SetActive(false)
        ;
        (equips[1]):SetStage((self._weapon).stage)
        record = (equips[1]):GetIcon()
        ;
        (self._equipCell1Icon):SetSprite(record.assetBundle, record.assetName)
        record = (equips[1]):GetPinJiImage()
        ;
        (self._equipCell1Frame):SetSprite(record.assetBundle, record.assetName)
        local suitID = (equips[1]):GetEquipSuitId()
        ;
        (self._equipCell1Suit):SetActive(not suitMap[suitID] or #(suitMap[suitID]).skillIds > 0)
        ;
        (self._equipCell1SuitGrey):SetActive(not suitMap[suitID] or #(suitMap[suitID]).skillIds == 0)
        ;
        (self._equipCell1PinJiStat):SetText((equips[1]):GetEquipStarStr())
        if (self._equipCell1Suit):IsActive() then
          record = (equips[1]):GetEquipSuitRecorder()
          if record then
            record = CImagePathTable:GetRecorder(record.suitImg)
          end
          ;
          (self._equipCell1Suit):SetSprite(record.assetBundle, record.assetName)
        end
        if (self._equipCell1SuitGrey):IsActive() then
          record = (equips[1]):GetEquipSuitRecorder()
          if record then
            record = CImagePathTable:GetRecorder(record.suitImg)
          end
          ;
          (self._equipCell1SuitGrey):SetSprite(record.assetBundle, record.assetName)
        end
        ;
        (self._equipCell1Lv):SetText((self._weapon).level)
        ;
        (self._equipCell1SpecialFMImage):SetActive(((self._weapon).finalAttrRandomEntry).randomId ~= 0)
        if ((self._weapon).finalAttrRandomEntry).randomId ~= 0 then
          (self._equipCell1_animator):SetInteger("par", 1)
        else
          (self._equipCell1_animator):SetInteger("par", 0)
        end
      else
        (self._equipCell1):SetActive(false)
        ;
        (self._equipCell1Empty):SetActive(true)
      end
      if self._armor then
        (self._equipCell2):SetActive(true)
        ;
        (self._equipCell2Empty):SetActive(false)
        ;
        (equips[2]):SetStage((self._armor).stage)
        record = (equips[2]):GetIcon()
        ;
        (self._equipCell2Icon):SetSprite(record.assetBundle, record.assetName)
        record = (equips[2]):GetPinJiImage()
        ;
        (self._equipCell2Frame):SetSprite(record.assetBundle, record.assetName)
        local suitID = (equips[2]):GetEquipSuitId()
        ;
        (self._equipCell2Suit):SetActive(not suitMap[suitID] or #(suitMap[suitID]).skillIds > 0)
        ;
        (self._equipCell2SuitGrey):SetActive(not suitMap[suitID] or #(suitMap[suitID]).skillIds == 0)
        ;
        (self._equipCell2PinJiStat):SetText((equips[2]):GetEquipStarStr())
        if (self._equipCell2Suit):IsActive() then
          record = (equips[2]):GetEquipSuitRecorder()
          if record then
            record = CImagePathTable:GetRecorder(record.suitImg)
          end
          ;
          (self._equipCell2Suit):SetSprite(record.assetBundle, record.assetName)
        end
        if (self._equipCell2SuitGrey):IsActive() then
          record = (equips[2]):GetEquipSuitRecorder()
          if record then
            record = CImagePathTable:GetRecorder(record.suitImg)
          end
          ;
          (self._equipCell2SuitGrey):SetSprite(record.assetBundle, record.assetName)
        end
        ;
        (self._equipCell2Lv):SetText((self._armor).level)
        ;
        (self._equipCell2SpecialFMImage):SetActive(((self._armor).finalAttrRandomEntry).randomId ~= 0)
        if ((self._armor).finalAttrRandomEntry).randomId ~= 0 then
          (self._equipCell2_animator):SetInteger("par", 1)
        else
          (self._equipCell2_animator):SetInteger("par", 0)
        end
      else
        (self._equipCell2):SetActive(false)
        ;
        (self._equipCell2Empty):SetActive(true)
      end
      if self._jewelry then
        (self._equipCell3):SetActive(true)
        ;
        (self._equipCell3Empty):SetActive(false)
        ;
        (equips[3]):SetStage((self._jewelry).stage)
        record = (equips[3]):GetIcon()
        ;
        (self._equipCell3Icon):SetSprite(record.assetBundle, record.assetName)
        record = (equips[3]):GetPinJiImage()
        ;
        (self._equipCell3Frame):SetSprite(record.assetBundle, record.assetName)
        local suitID = (equips[3]):GetEquipSuitId()
        ;
        (self._equipCell3Suit):SetActive(not suitMap[suitID] or #(suitMap[suitID]).skillIds > 0)
        ;
        (self._equipCell3SuitGrey):SetActive(not suitMap[suitID] or #(suitMap[suitID]).skillIds == 0)
        ;
        (self._equipCell3PinJiStat):SetText((equips[3]):GetEquipStarStr())
        if (self._equipCell3Suit):IsActive() then
          record = (equips[3]):GetEquipSuitRecorder()
          if record then
            record = CImagePathTable:GetRecorder(record.suitImg)
          end
          ;
          (self._equipCell3Suit):SetSprite(record.assetBundle, record.assetName)
        end
        if (self._equipCell3SuitGrey):IsActive() then
          record = (equips[3]):GetEquipSuitRecorder()
          if record then
            record = CImagePathTable:GetRecorder(record.suitImg)
          end
          ;
          (self._equipCell3SuitGrey):SetSprite(record.assetBundle, record.assetName)
        end
        ;
        (self._equipCell3Lv):SetText((self._jewelry).level)
        ;
        (self._equipCell3SpecialFMImage):SetActive(((self._jewelry).finalAttrRandomEntry).randomId ~= 0)
        if ((self._jewelry).finalAttrRandomEntry).randomId ~= 0 then
          (self._equipCell3_animator):SetInteger("par", 1)
        else
          (self._equipCell3_animator):SetInteger("par", 0)
        end
      else
        (self._equipCell3):SetActive(false)
        ;
        (self._equipCell3Empty):SetActive(true)
      end
      -- DECOMPILER ERROR: 36 unprocessed JMP targets
    end
  end
end

CheckOtherRoleInfoDialog.SetArrowActive = function(self, flag)
  -- function num : 0_22
  (self._leftArrow):SetActive(flag)
  ;
  (self._rightArrow):SetActive(flag)
end

CheckOtherRoleInfoDialog.OnReceiveCheckProtocol = function(self, notification)
  -- function num : 0_23 , upvalues : _ENV
  warn("OnReceiveCheckProtocol: ", (notification.userInfo).userId, self._userId, (notification.userInfo).bossId, self._bossId)
  if (notification.userInfo).userId == self._userId and (notification.userInfo).bossId == self._bossId then
    self:RefreshBefore(((notification.userInfo).lineup).roles)
  end
end

CheckOtherRoleInfoDialog.UpdateProtocol = function(self, notification)
  -- function num : 0_24 , upvalues : _ENV
  warn("UpdateProtocol: ", (notification.userInfo).userId, self._userId, (notification.userInfo).bossId, self._bossId)
  self:RefreshBefore(((notification.userInfo).lineup).roles)
end

CheckOtherRoleInfoDialog.RefreshBefore = function(self, roles)
  -- function num : 0_25 , upvalues : _ENV
  self._roleInfoList = roles
  self._rolePosList = {}
  for i,v in pairs(self._roleInfoList) do
    (table.insert)(self._rolePosList, i)
  end
  ;
  (table.sort)(self._rolePosList, function(a, b)
    -- function num : 0_25_0
    do return a < b end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for _,role in pairs(self._roleInfoList) do
    if role.id == self._roleId then
      self:Refresh(role)
    end
  end
end

CheckOtherRoleInfoDialog.OnJobClick = function(self)
  -- function num : 0_26 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("character.characterjobdialog")):SetData(self._jobId)
end

CheckOtherRoleInfoDialog.OnElementImgClick = function(self)
  -- function num : 0_27 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("character.characterelementinfodialog")):SetData((self._role):GetRoleId())
end

CheckOtherRoleInfoDialog.OnBackBtnClicked = function(self)
  -- function num : 0_28
  self:Destroy()
end

CheckOtherRoleInfoDialog.OnSuitEffectClicked = function(self)
  -- function num : 0_29 , upvalues : _ENV
  local suitMap = self._suitMap
  local showData = {}
  for k,v in pairs(suitMap) do
    if #v.skillIds > 0 then
      (table.insert)(showData, {suitId = k, skillIds = v.skillIds})
    end
  end
  if #showData > 0 then
    ((DialogManager.CreateSingletonDialog)("character.equipsuittipdialog")):SetData(showData)
  else
    ;
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100317)
  end
end

return CheckOtherRoleInfoDialog

