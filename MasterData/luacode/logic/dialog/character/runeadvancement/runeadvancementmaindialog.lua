local AttrTypeEnum = LuaNetManager.GetBeanDef("protocol.login.attrtype")
local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CRoleAdvancedBaseCfg = BeanManager.GetTableByName("role.croleadvancedbase")
local CRoleAdvancedRunesCfg = BeanManager.GetTableByName("role.croleadvancedrunes")
local Num = 4
local entryNum = 3
local RuneAdvancementMainDialog = class("RuneAdvancementMainDialog", Dialog)
RuneAdvancementMainDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
RuneAdvancementMainDialog.AssetName = "CharUpgradeMain"

function RuneAdvancementMainDialog:Ctor(...)
  RuneAdvancementMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._which = 1
end

function RuneAdvancementMainDialog:InitCfg()
  self._specialRunesCfg = {}
  for i, v in ipairs(CRoleAdvancedRunesCfg:GetAllIds()) do
    local record = CRoleAdvancedRunesCfg:GetRecorder(v)
    if record then
      local type = record.runesType
      if self._specialRunesCfg[type] == nil then
        self._specialRunesCfg[type] = {}
      end
      self._specialRunesCfg[type][record.runeslv] = {
        lv = record.runeslv,
        addtion = record.heraldryAttributeUP,
        icon = record.runesImg,
        name = record.runesName,
        effectTextId = record.runesSkillTxt
      }
    else
      LogErrorFormat("RuneAdvancementMainDialog", "CRoleAdvancedRunesCfg Not Exist ID:%s", v)
    end
  end
  self._normalRunesCfg = {}
  for i, v in ipairs(CRoleAdvancedBaseCfg:GetAllIds()) do
    local record = CRoleAdvancedBaseCfg:GetRecorder(v)
    if record then
      local type = record.heraldryPoint
      if self._normalRunesCfg[type] == nil then
        self._normalRunesCfg[type] = {}
      end
      self._normalRunesCfg[type][record.heraldrylv] = {
        lv = record.heraldrylv,
        property = record.heraldryAttribute,
        addtion = record.heraldryNum,
        icon = record.heraldryImg,
        name = record.heraldryName,
        costItem = record.runesUpItem,
        costItemNum = record.runesUpItemNum,
        type = type
      }
    else
      LogErrorFormat("RuneAdvancementMainDialog", "CRoleAdvancedBaseCfg Not Exist ID:%s", v)
    end
  end
end

function RuneAdvancementMainDialog:OnCreate()
  self:GetChild("Title"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1986))
  self:GetChild("Back/RunesFrame/NameBack/Name"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2028))
  self:GetChild("Back/RunesFrame/TextList/Dot/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1995))
  self:GetChild("Back/RunesFrame/CaptionTxt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1994))
  self:GetChild("Back/NormalFrame/Cost/Dot/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2029))
  self:GetChild("Back/NormalFrame/UnLock/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1992))
  self:GetChild("Back/NormalFrame/GreyBtn/_Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2030))
  self:GetChild("Back/NormalFrame/Btn/_Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2030))
  self:GetChild("Back/NormalFrame/NameBack/Name"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2028))
  self:GetChild("Frame/MixBtn/_Text"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2047))
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._tipBtn = self:GetChild("TipBtn")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._tipBtn:Subscribe_PointerClickEvent(self.OnTipBtnClicked, self)
  self._specialRunes = {
    panel = self:GetChild("Frame/RunesIcon"),
    select = self:GetChild("Frame/RunesIcon/Select"),
    icon = self:GetChild("Frame/RunesIcon/Icon"),
    lvTxt = self:GetChild("Frame/RunesIcon/Lv"),
    nameTxt = self:GetChild("Frame/RunesIcon/NameTxt"),
    backFull = self:GetChild("Frame/RunesIcon/BackFull"),
    redDot = self:GetChild("Frame/RunesIcon/RedDot"),
    levelUpEffect = self:GetChild("Frame/RunesIcon/RunesEffectUp"),
    effect = {}
  }
  self:GetChild("Frame/RunesIcon/RunesEffectLv"):SetActive(true)
  for i = 1, 5 do
    self._specialRunes.effect[i] = self:GetChild("Frame/RunesIcon/RunesEffectLv/RunesEffectLv" .. i)
    self._specialRunes.effect[i]:SetActive(false)
  end
  self._specialRunes.icon:Subscribe_PointerClickEvent(function()
    self:OnSelectWhich(5)
  end, self)
  self._specialRunes.redDot:SetActive(false)
  self._normalRunes = {}
  for i = 1, Num do
    self._normalRunes[i] = {
      panel = self:GetChild("Frame/NormalIcon" .. i),
      select = self:GetChild("Frame/NormalIcon" .. i .. "/Select"),
      icon = self:GetChild("Frame/NormalIcon" .. i .. "/Icon"),
      lvTxt = self:GetChild("Frame/NormalIcon" .. i .. "/Lv"),
      nameTxt = self:GetChild("Frame/NormalIcon" .. i .. "/NameTxt"),
      redDot = self:GetChild("Frame/NormalIcon" .. i .. "/RedDot")
    }
    self._normalRunes[i].icon:Subscribe_PointerClickEvent(function()
      self:OnSelectWhich(i)
    end, self)
    self._normalRunes[i].redDot:SetActive(false)
  end
  self._specialRunesDetail = {
    panel = self:GetChild("Back/RunesFrame"),
    runes = {
      panel = self:GetChild("Back/RunesFrame/RunesIcon"),
      select = self:GetChild("Back/RunesFrame/RunesIcon/Select"),
      icon = self:GetChild("Back/RunesFrame/RunesIcon/Icon"),
      lvTxt = self:GetChild("Back/RunesFrame/RunesIcon/Lv"),
      nameTxt = self:GetChild("Back/RunesFrame/RunesIcon/NameTxt"),
      backFull = self:GetChild("Back/RunesFrame/RunesIcon/BackFull")
    },
    effectTxt = self:GetChild("Back/RunesFrame/NameBack/Txt"),
    ibtn = self:GetChild("Back/RunesFrame/Ibtn"),
    entry = {}
  }
  for i = 1, entryNum do
    self._specialRunesDetail.entry[i] = {
      normal = {
        nameTxt = self:GetChild("Back/RunesFrame/TextList/Lv" .. i .. "/NameTxt"),
        panel = self:GetChild("Back/RunesFrame/TextList/Lv" .. i .. "")
      },
      grey = {
        nameTxt = self:GetChild("Back/RunesFrame/TextList/Lv" .. i .. "Grey/NameTxt"),
        panel = self:GetChild("Back/RunesFrame/TextList/Lv" .. i .. "Grey")
      }
    }
  end
  self._specialRunesDetail.ibtn:Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  self._normalRunesDetail = {
    panel = self:GetChild("Back/NormalFrame"),
    runes = {
      panel = self:GetChild("Back/NormalFrame/NormalIcon"),
      select = self:GetChild("Back/NormalFrame/NormalIcon/Select"),
      icon = self:GetChild("Back/NormalFrame/NormalIcon/Icon"),
      lvTxt = self:GetChild("Back/NormalFrame/NormalIcon/Lv"),
      nameTxt = self:GetChild("Back/NormalFrame/NormalIcon/NameTxt"),
      effectUp = self:GetChild("Back/NormalFrame/NormalIcon/NormalEffectUp")
    },
    ibtn = self:GetChild("Back/NormalFrame/Ibtn"),
    property = {
      leftNum = self:GetChild("Back/NormalFrame/Property/Num"),
      rightNum = self:GetChild("Back/NormalFrame/Property/Num2"),
      icon = self:GetChild("Back/NormalFrame/Property/Image"),
      name = self:GetChild("Back/NormalFrame/Property/Name"),
      arrow = self:GetChild("Back/NormalFrame/Property/Arrow2")
    },
    maxLevel = self:GetChild("Back/NormalFrame/UnLock"),
    cost = {
      panel = self:GetChild("Back/NormalFrame/Cost/CostItem"),
      num = self:GetChild("Back/NormalFrame/Cost/CostItem/_Count/Num"),
      needNum = self:GetChild("Back/NormalFrame/Cost/CostItem/_Count/Max"),
      redNum = self:GetChild("Back/NormalFrame/Cost/CostItem/_Count/NumRed"),
      icon = self:GetChild("Back/NormalFrame/Cost/CostItem/_BackGround/Icon")
    },
    levelUpbtn = self:GetChild("Back/NormalFrame/Btn"),
    greylevelUpBtn = self:GetChild("Back/NormalFrame/GreyBtn")
  }
  self._topGroup = self:GetChild("TopGroup")
  self._topGroup:SetActive(false)
  self._mixBtn = self:GetChild("Frame/MixBtn")
  self._mixBtn:Subscribe_PointerClickEvent(self.OnMixBtnClicked, self)
  self._normalRunesDetail.ibtn:Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  self._normalRunesDetail.levelUpbtn:Subscribe_PointerClickEvent(self.OnLevelUpbtnClicked, self)
  self._normalRunesDetail.cost.icon:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self._normalRunesDetail.greylevelUpBtn:Subscribe_PointerClickEvent(self.OnGreylevelUpBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, function()
    self:OnRefresh()
  end, Common.n_ItemNumModify, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRoleInfoChange, Common.n_RoleInfoChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_OnSOpenruneAdvanced, nil)
  local type = DataCommon.LocalTips.GuideOpenInstructionDialog_RuneAdvancement
  if NekoData.BehaviorManager.BM_Game:GetLocalTipsState(type) == type.Default then
    NekoData.BehaviorManager.BM_Game:SetLocalTipsNew(type)
  end
  if NekoData.BehaviorManager.BM_Game:ShowLocalTips(type) then
    NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(type)
    self:OnIBtnClicked()
  end
  if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(67, 2) then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(67)
  end
end

function RuneAdvancementMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._effectHandler1 ~= nil then
    self._normalRunesDetail.runes.effectUp:ReleaseEffect(self._effectHandler1)
  end
  if self._effectHandler2 ~= nil then
    self._specialRunes.levelUpEffect:ReleaseEffect(self._effectHandler2)
  end
end

function RuneAdvancementMainDialog:SetData(protocol)
  self:InitCfg()
  self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(protocol.roleId)
  self._levelData = protocol.baseRune
  self:OnSelectWhich(self._which, true)
  self:RefreshRunes()
end

function RuneAdvancementMainDialog:OnRefresh(notification)
  if notification then
    local oldLevel = self._levelData[self._levelInfo.type]
    local newLevel = notification.userInfo.baseRune[self._levelInfo.type]
    if oldLevel < newLevel then
      if self._effectHandler1 ~= nil then
        self._normalRunesDetail.runes.effectUp:ReleaseEffect(self._effectHandler1)
      end
      self._effectHandler1 = self._normalRunesDetail.runes.effectUp:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1164))
    end
    self._levelData = notification.userInfo.baseRune
    self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(notification.userInfo.roleId)
  end
  self:OnSelectWhich(self._which, true)
  self:RefreshRunes()
end

function RuneAdvancementMainDialog:OnRoleInfoChange(notification)
  if notification.userInfo.name == "sprofessionrune" then
    if self._effectHandler2 ~= nil then
      self._specialRunes.levelUpEffect:ReleaseEffect(self._effectHandler2)
    end
    self._effectHandler2 = self._specialRunes.levelUpEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1165))
    self:RefreshRunes()
    if self._which == 5 then
      self:RefreshSpecialRunesDetail()
    end
  end
end

function RuneAdvancementMainDialog:OnSelectWhich(index, refresh)
  if self._which == index and not refresh then
    return
  end
  local isSpecialRunes = index == 5
  self._normalRunesDetail.panel:SetActive(not isSpecialRunes)
  for i = 1, Num do
    self._normalRunes[i].select:SetActive(not isSpecialRunes and i == index)
  end
  self._specialRunesDetail.panel:SetActive(isSpecialRunes)
  self._specialRunes.select:SetActive(isSpecialRunes)
  if isSpecialRunes then
    self:RefreshSpecialRunesDetail()
  else
    self:RefreshNormalRunesInfoDetail(index)
  end
  self._which = index
end

function RuneAdvancementMainDialog:RefreshSpecialRunesDetail()
  local vocationId = self._role:GetVocationId()
  local runeLevel = self._role:GetRuneLevel()
  local cfg = self._specialRunesCfg[vocationId][runeLevel]
  local nextCfg = self._specialRunesCfg[vocationId][runeLevel + 1]
  local image = CImagePathTable:GetRecorder(cfg.icon) or DataCommon.DefaultImageAsset
  self._specialRunesDetail.runes.icon:SetSprite(image.assetBundle, image.assetName)
  self._specialRunesDetail.runes.nameTxt:SetText(TextManager.GetText(cfg.name))
  self._specialRunesDetail.runes.lvTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1287, {
    cfg.lv
  }))
  if not nextCfg then
    self._specialRunesDetail.effectTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2052, {
      cfg.addtion
    }))
  else
    self._specialRunesDetail.effectTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1985, {
      cfg.addtion,
      cfg.lv,
      nextCfg.addtion,
      nextCfg.lv
    }))
  end
  local entryData = {}
  for i, v in ipairs(self._specialRunesCfg[vocationId]) do
    if v.effectTextId > 0 then
      table.insert(entryData, v)
    end
  end
  for i = 1, entryNum do
    if not entryData[i] then
      self._specialRunesDetail.entry[i].normal.panel:SetActive(false)
      self._specialRunesDetail.entry[i].grey.panel:SetActive(false)
      return
    end
    local isUnlock = runeLevel >= entryData[i].lv
    self._specialRunesDetail.entry[i].normal.panel:SetActive(isUnlock)
    self._specialRunesDetail.entry[i].grey.panel:SetActive(not isUnlock)
    if isUnlock then
      self._specialRunesDetail.entry[i].normal.panel:SetText((NekoData.BehaviorManager.BM_Message:GetString(1287, {
        entryData[i].lv
      })))
      self._specialRunesDetail.entry[i].normal.nameTxt:SetText(TextManager.GetText(entryData[i].effectTextId))
    else
      self._specialRunesDetail.entry[i].grey.panel:SetText((NekoData.BehaviorManager.BM_Message:GetString(1287, {
        entryData[i].lv
      })))
      self._specialRunesDetail.entry[i].grey.nameTxt:SetText(TextManager.GetText(entryData[i].effectTextId))
    end
  end
end

function RuneAdvancementMainDialog:RefreshNormalRunesInfoDetail(id)
  local cfg = self._normalRunesCfg[id][self._levelData[id]]
  local image = CImagePathTable:GetRecorder(cfg.icon) or DataCommon.DefaultImageAsset
  self._normalRunesDetail.runes.icon:SetSprite(image.assetBundle, image.assetName)
  self._normalRunesDetail.runes.lvTxt:SetText((NekoData.BehaviorManager.BM_Message:GetString(1287, {
    cfg.lv
  })))
  self._normalRunesDetail.runes.nameTxt:SetText(TextManager.GetText(cfg.name))
  self._levelInfo = cfg
  local isCanLevel = self._normalRunesCfg[id][self._levelData[id] + 1]
  self._normalRunesDetail.maxLevel:SetActive(not isCanLevel)
  self._normalRunesDetail.cost.panel:SetActive(isCanLevel)
  self._normalRunesDetail.cost.needNum:SetText(cfg.costItemNum)
  local bagItemNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(cfg.costItem)
  local item = Item.Create(cfg.costItem)
  self._item = item
  self._normalRunesDetail.cost.icon:SetSprite(item:GetIconAB())
  local hasEnoughItem = bagItemNum >= cfg.costItemNum
  if not hasEnoughItem then
    self._normalRunesDetail.cost.redNum:SetText(bagItemNum)
    self._normalRunesDetail.cost.redNum:SetActive(true)
    self._normalRunesDetail.cost.num:SetActive(false)
  else
    self._normalRunesDetail.cost.num:SetText(bagItemNum)
    self._normalRunesDetail.cost.redNum:SetActive(false)
    self._normalRunesDetail.cost.num:SetActive(true)
  end
  self._normalRunesDetail.levelUpbtn:SetActive(isCanLevel and hasEnoughItem)
  self._normalRunesDetail.greylevelUpBtn:SetActive(isCanLevel and not hasEnoughItem)
  local record = CAttrNameTable:GetRecorder(cfg.property)
  local imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._normalRunesDetail.property.icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._normalRunesDetail.property.name:SetText(TextManager.GetText(record.classnameTextID))
  self._normalRunesDetail.property.leftNum:SetText(cfg.addtion[self._role:GetVocationId()])
  if not isCanLevel then
    self._normalRunesDetail.property.rightNum:SetActive(false)
    self._normalRunesDetail.property.arrow:SetActive(false)
  else
    self._normalRunesDetail.property.arrow:SetActive(true)
    self._normalRunesDetail.property.rightNum:SetActive(true)
    self._normalRunesDetail.property.rightNum:SetText(self._normalRunesCfg[id][self._levelData[id] + 1].addtion[self._role:GetVocationId()])
  end
end

function RuneAdvancementMainDialog:RefreshRunes()
  for i = 1, Num do
    local rune = self._normalRunes[i]
    local cfg = self._normalRunesCfg[i][self._levelData[i]]
    local image = CImagePathTable:GetRecorder(cfg.icon) or DataCommon.DefaultImageAsset
    rune.icon:SetSprite(image.assetBundle, image.assetName)
    rune.lvTxt:SetText((NekoData.BehaviorManager.BM_Message:GetString(1287, {
      cfg.lv
    })))
    rune.nameTxt:SetText(TextManager.GetText(cfg.name))
  end
  local vocationId = self._role:GetVocationId()
  local runeLevel = self._role:GetRuneLevel()
  local cfg = self._specialRunesCfg[vocationId][runeLevel]
  local image = CImagePathTable:GetRecorder(cfg.icon) or DataCommon.DefaultImageAsset
  self._specialRunes.icon:SetSprite(image.assetBundle, image.assetName)
  self._specialRunes.nameTxt:SetText(TextManager.GetText(cfg.name))
  self._specialRunes.lvTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1287, {
    cfg.lv
  }))
  for i = 1, 5 do
    self._specialRunes.effect[i]:SetActive(cfg.lv == i)
  end
end

function RuneAdvancementMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function RuneAdvancementMainDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function RuneAdvancementMainDialog:OnTipBtnClicked()
  NekoData.BehaviorManager.BM_Message:OpenInstructionsTipDialog(7)
end

function RuneAdvancementMainDialog:OnLevelUpbtnClicked()
  local localCache = NekoData.BehaviorManager.BM_Game:GetLocalCache(DataCommon.LocalCache.LastBodyAdvancedDailyReminder)
  if localCache == 0 then
    DialogManager.CreateSingletonDialog("character.runeadvancement.runeadvancementlevelupdialog"):SetData(self._levelInfo, self._role)
  else
    local csend = LuaNetManager.CreateProtocol("protocol.login.crunelevelup")
    csend.roleId = self._role:GetRoleId()
    csend.runeId = self._levelInfo.type
    csend:Send()
  end
end

function RuneAdvancementMainDialog:OnGreylevelUpBtnClicked()
  NekoData.BehaviorManager.BM_Message:SendMessageById(100481)
end

function RuneAdvancementMainDialog:OnIBtnClicked()
  DialogManager.CreateSingletonDialog("newbattle.battleteachguidedialog"):Init(DataCommon.LocalTips.GuideOpenInstructionDialog_RuneAdvancement.guideId)
end

function RuneAdvancementMainDialog:OnItemCellClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
  end
end

function RuneAdvancementMainDialog:OnMixBtnClicked()
  DialogManager.CreateSingletonDialog("character.runeadvancement.runeadvancementmixdialog")
end

return RuneAdvancementMainDialog
