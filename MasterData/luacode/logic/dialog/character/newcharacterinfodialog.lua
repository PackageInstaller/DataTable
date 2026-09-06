local Item = require("logic.manager.experimental.types.item")
local Skill = require("logic.manager.experimental.types.skill")
local UniqueEquip = require("logic.manager.experimental.types.uniqueequip")
local CharLevelUpPart = require("logic.dialog.character.newcharleveluppart")
local CharBreakPart = require("logic.dialog.character.newcharbreakpart")
local CharEquipPart = require("logic.dialog.character.newcharequippart")
local CharEvolvePart = require("logic.dialog.character.newcharevolvepart")
local CharFashionPart = require("logic.dialog.character.newcharfashionpart")
local EquipTypeEnum = LuaNetManager.GetBeanDef("protocol.item.equiptype")
local CSkin = BeanManager.GetTableByName("role.cskin")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local AttrTypeEnum = LuaNetManager.GetBeanDef("protocol.login.attrtype")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CSkillTable = BeanManager.GetTableByName("skill.cskill")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local timeofword = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(88).Value)
local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local ShowByModalDialogs = {
  "equip.equipchangenewdialog",
  "handbook.roledetailinfodialog",
  "equip.presetequipdialog",
  "character.quicklevelup.quicklevelupmaindialog"
}
local NewCharacterInfoDialog = class("NewCharacterInfoDialog", Dialog)
NewCharacterInfoDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
NewCharacterInfoDialog.AssetName = "BaseCharacterDetail"
local Tag = {
  Nothing = 1,
  Prop = 2,
  Break = 3,
  LevelUp = 4,
  Evolve = 5,
  Skill = 6,
  Talent = 7,
  Equip = 8,
  Fashion = 9
}
local ProgressFullMaxTotalTime = 2
local SkillLevelTag = {CurLevel = 1, NextLevel = 2}

local function FinishGuide(self)
  if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(25, 4) then
    LuaNotificationCenter.RemoveObserver(self, Common.n_GuideResponseClick)
    NekoData.BehaviorManager.BM_Guide:FinishGuide(25)
  end
end

local function HandleGuideStatusChanged(self, notification)
  local guideId = notification.userInfo.guideID
  if guideId == 25 and notification.userInfo.guideStatus == "Start" then
    LuaNotificationCenter.AddObserver(self, FinishGuide, Common.n_GuideResponseClick, nil)
  elseif guideId == 2 and notification.userInfo.guideStatus == "Finish" then
    if self._tag == Tag.LevelUp then
      CS.PixelNeko.UI.UIManager.CancelTouch(self._levelup_levelUpBtn._uiObject)
    end
  elseif guideId == 67 and notification.userInfo.guideStatus == "Finish" then
    LuaNotificationCenter.RemoveObserver(self, Common.n_Update)
  end
end

local function OnUpdate(self)
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
end

function NewCharacterInfoDialog:Ctor(...)
  NewCharacterInfoDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._data = nil
  self._lockTag = false
  self._dragHandler = nil
  self._endDragHandler = nil
  self._cancelDragHandler = nil
  self._tag = Tag.Nothing
  self._effectHandlers = {}
  self._effectHandler2 = 0
  self._levelup_task1 = {}
  self._progressFullTime = ProgressFullMaxTotalTime
  self._breakItemList = {}
  self._currentCanWearWeaponList = {}
  self._currentCanWearArmorList = {}
  self._currentCanWearJewelryList = {}
  self._skillItemList = {}
  self._skill_improveReceive = true
  self._skill_tag_which = 1
  self._skill_tag_level = SkillLevelTag.CurLevel
  self._break_canRefresh = true
  self._evolve_canRefresh = true
  self._clickRandoms = {}
  self._touchSoundLines = {}
  self._once = nil
end

function NewCharacterInfoDialog:OnCreate()
  self._rolePanel = self:GetChild("Role")
  self._photo = self:GetChild("Role/Photo")
  self._photo_black = self:GetChild("Role/BlackPhoto")
  self._live2D = self:GetChild("Role/Live2D")
  self._lockToggle = self:GetChild("BackGround/UI/LockToggle")
  self._chatBtn = self:GetChild("BackGround/UI/CharName/ChatBtn")
  self._charTitle = self:GetChild("BackGround/UI/CharName/CharTitle")
  self._name = self:GetChild("BackGround/UI/CharName/Back/Name")
  self._rank = self:GetChild("BackGround/UI/CharName/Rank")
  self._jobImg = self:GetChild("BackGround/UI/CharName/JobImg")
  self._jobTxt = self:GetChild("BackGround/UI/CharName/JobTxt")
  self._cvLabel = self:GetChild("BackGround/UI/CharName/CV")
  self._cvName = self:GetChild("BackGround/UI/CharName/CVName")
  self._elementImg = self:GetChild("BackGround/UI/CharName/Element")
  self._leftArrow = self:GetChild("BackGround/LeftArrow")
  self._rightArrow = self:GetChild("BackGround/RightArrow")
  self._rightArrowEffect = self:GetChild("BackGround/RightArrow/Effect")
  self._rightArrowGuideTipText = self:GetChild("BackGround/RightArrow/GuideTxt")
  self._rightArrowGuideBack = self:GetChild("BackGround/RightArrow/GuideBack")
  self._moneyPanel = self:GetChild("BackGround/TopGroup")
  self._manaBtn = self:GetChild("BackGround/TopGroup/Num1")
  self._manaTxt = self:GetChild("BackGround/TopGroup/Num1/Text")
  self._diamondBtn = self:GetChild("BackGround/TopGroup/Num2")
  self._diamondTxt = self:GetChild("BackGround/TopGroup/Num2/Text")
  self._diamondAddBtn = self:GetChild("BackGround/TopGroup/Num2/Add")
  self._dialogPanel = self:GetChild("BackGround/Dialog")
  self._dialogPanel_txt = self:GetChild("BackGround/Dialog/Text")
  self._dialogPanel_width, self._dialogPanel_height = self._dialogPanel:GetDeltaSize()
  self._dialogPanel_txt_width, self._dialogPanel_txt_height = self._dialogPanel_txt:GetDeltaSize()
  self._dialogPanel:SetActive(false)
  self._dialogPanel:Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  LuaNotificationCenter.AddObserver(self, self.OnCuePlayEnd, Common.n_CuePlayEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnCuePlayEnd, Common.n_CuePlayStop, nil)
  self._dragPanel = self:GetChild("Click")
  self._dragPanel:Subscribe_PointerClickEvent(function()
    self:OnLiHuiClicked()
  end, self)
  self._lockToggle:Subscribe_ValueChangedEvent(self.OnValueChanged, self)
  self._chatBtn:Subscribe_PointerClickEvent(self.OnChatBtnPointerClick, self)
  self._leftArrow:Subscribe_PointerClickEvent(self.OnLeftArrowClick, self)
  self._rightArrow:Subscribe_PointerClickEvent(self.OnRightArrowClick, self)
  self._manaBtn:Subscribe_PointerClickEvent(self.OnManaBtnClick, self)
  self._diamondBtn:Subscribe_PointerClickEvent(self.OnDiamondBtnClick, self)
  self._diamondAddBtn:Subscribe_PointerClickEvent(self.OnDiamondAddBtnClick, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnMouseClicked, self)
  self._dragHandler = self._dragPanel:Subscribe_DragEvent(self.OnDrag, self)
  self._endDragHandler = self._dragPanel:Subscribe_EndDragEvent(self.OnEndDrag, self)
  self._cancelDragHandler = self._dragPanel:Subscribe_CancelDragEvent(self.OnEndDrag, self)
  self._rolePanel:Subscribe_StateExitEvent(self.OnRoleChangeStateExit, self)
  self:GetRootWindow():Subscribe_AnimationEvent("CharEquip", self.OnAnimationEvent, self)
  self:GetRootWindow():Subscribe_AnimationEvent("CharLevelUp", self.OnAnimationEvent, self)
  self:GetRootWindow():Subscribe_AnimationEvent("CharDetail", self.OnAnimationEvent, self)
  self:GetRootWindow():Subscribe_AnimationEvent("CharBreak", self.OnAnimationEvent, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnAnimationEnd, self)
  self._propPanel = self:GetChild("BackGround/UI/Prop")
  self._propBackShort = self:GetChild("BackGround/UI/Prop/Back")
  self._propBackLong = self:GetChild("BackGround/UI/Prop/BackLong")
  self._propBack = self._propBackShort
  self._propHeartImg = self:GetChild("BackGround/UI/Prop/Heart/Image")
  self._propHeartShort = self:GetChild("BackGround/UI/Prop/Heart/Num")
  self._propHeartLong = self:GetChild("BackGround/UI/Prop/Heart/LongNum")
  self._propHeart = self._propHeartShort
  self._propAtkImg = self:GetChild("BackGround/UI/Prop/Atk/Image")
  self._propAtkShort = self:GetChild("BackGround/UI/Prop/Atk/Num")
  self._propAtkLong = self:GetChild("BackGround/UI/Prop/Atk/LongNum")
  self._propAtk = self._propAtkShort
  self._propPhyDefImg = self:GetChild("BackGround/UI/Prop/PhyDef/Image")
  self._propPhyDefShort = self:GetChild("BackGround/UI/Prop/PhyDef/Num")
  self._propPhyDefLong = self:GetChild("BackGround/UI/Prop/PhyDef/LongNum")
  self._propPhyDef = self._propPhyDefShort
  self._propMagDefImg = self:GetChild("BackGround/UI/Prop/MagDef/Image")
  self._propMagDefShort = self:GetChild("BackGround/UI/Prop/MagDef/Num")
  self._propMagDefLong = self:GetChild("BackGround/UI/Prop/MagDef/LongNum")
  self._propMagDef = self._propMagDefShort
  self._levelUpPanel = self:GetChild("BackGround/RightPanel/LevelUp")
  self._levelTxt = self:GetChild("BackGround/RightPanel/LevelUp/LevelBack/LevelNum")
  self._expTxt = self:GetChild("BackGround/RightPanel/LevelUp/EXPNum")
  self._levelMax = self:GetChild("BackGround/RightPanel/LevelUp/LevelMax")
  self._breakPanel = self:GetChild("BackGround/RightPanel/BreakBtn")
  self._breakPoint = self:GetChild("BackGround/RightPanel/BreakBtn/BreakPoint")
  self._breakRedDot = self:GetChild("BackGround/RightPanel/BreakBtn/EvolveRedDot")
  self._breakRedDot:SetActive(false)
  self._evolvePanel = self:GetChild("BackGround/RightPanel/EvolveBtn")
  self._evolvePoint = self:GetChild("BackGround/RightPanel/EvolveBtn/BreakPoint")
  self._evolveRedIcon = self:GetChild("BackGround/RightPanel/EvolveBtn/EvolveRedDot")
  self._skillPanel = self:GetChild("BackGround/RightPanel/Skill")
  self._skillDevelopBtn = self:GetChild("BackGround/RightPanel/Skill/SkillLevelUpBtn")
  self._skillDevelopBtn_redDot = self:GetChild("BackGround/RightPanel/Skill/SkillLevelUpBtn/RedDot")
  self._skillChangeBtn = self:GetChild("BackGround/RightPanel/Skill/ChangeSkillBtn")
  self._skillPanel_skills = {}
  for i = 1, 3 do
    self._skillPanel_skills[i] = {}
    self._skillPanel_skills[i].cell = DialogManager.CreateDialog("skill.skillcell", self:GetChild("BackGround/RightPanel/Skill/SkillBack" .. i)._uiObject)
    self._skillPanel_skills[i].cell._rootWindow:Subscribe_PointerClickEvent(function()
      self:OnSkillClick(i)
    end)
  end
  self._equipPanel = self:GetChild("BackGround/RightPanel/Equip")
  self._suitEffect = self:GetChild("BackGround/RightPanel/Equip/SuitEffect")
  self._equipSmallPanel1 = self:GetChild("BackGround/RightPanel/Equip/Equip1")
  self._equipSmallPanel1RedDot = self:GetChild("BackGround/RightPanel/Equip/Equip1/Dot")
  self._equipSmallPanel2RedDot = self:GetChild("BackGround/RightPanel/Equip/Equip2/Dot")
  self._equipSmallPanel3RedDot = self:GetChild("BackGround/RightPanel/Equip/Equip3/Dot")
  self._equipSmallPanel1RedDot:SetActive(false)
  self._equipSmallPanel2RedDot:SetActive(false)
  self._equipSmallPanel3RedDot:SetActive(false)
  self._equipCell1 = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell")
  self._equipCell1Frame = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell/BackGround/Frame")
  self._equipCell1Icon = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell/BackGround/Icon")
  self._equipCell1Suit = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell/BackGround/Suit")
  self._equipCell1SuitGrey = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell/BackGround/SuitGrey")
  self._equipCell1SpecialFMImage = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell/BackGround/FuMo")
  self._equipCell1_animator = self:GetChild("BackGround/RightPanel/Equip/Equip1"):GetUIObject():GetComponent("Animator")
  self._equipCell1PinJiStat = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell/BackGround/BreakPoint")
  self._equipCell1Empty = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCellEmpty")
  self._equip1LockImg = self:GetChild("BackGround/RightPanel/Equip/Equip1/Lock")
  self._equipCell1Lv = self:GetChild("BackGround/RightPanel/Equip/Equip1/EquipCell/BackGround/Level/Num")
  self._equipSmallPanel2 = self:GetChild("BackGround/RightPanel/Equip/Equip2")
  self._equipCell2 = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell")
  self._equipCell2Frame = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell/BackGround/Frame")
  self._equipCell2Icon = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell/BackGround/Icon")
  self._equipCell2Suit = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell/BackGround/Suit")
  self._equipCell2SuitGrey = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell/BackGround/SuitGrey")
  self._equipCell2SpecialFMImage = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell/BackGround/FuMo")
  self._equipCell2_animator = self:GetChild("BackGround/RightPanel/Equip/Equip2"):GetUIObject():GetComponent("Animator")
  self._equipCell2PinJiStat = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell/BackGround/BreakPoint")
  self._equipCell2Empty = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCellEmpty")
  self._equip2LockImg = self:GetChild("BackGround/RightPanel/Equip/Equip2/Lock")
  self._equipCell2Lv = self:GetChild("BackGround/RightPanel/Equip/Equip2/EquipCell/BackGround/Level/Num")
  self._equipSmallPanel3 = self:GetChild("BackGround/RightPanel/Equip/Equip3")
  self._equipCell3 = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell")
  self._equipCell3Frame = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell/BackGround/Frame")
  self._equipCell3Icon = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell/BackGround/Icon")
  self._equipCell3Suit = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell/BackGround/Suit")
  self._equipCell3SuitGrey = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell/BackGround/SuitGrey")
  self._equipCell3SpecialFMImage = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell/BackGround/FuMo")
  self._equipCell3_animator = self:GetChild("BackGround/RightPanel/Equip/Equip3"):GetUIObject():GetComponent("Animator")
  self._equipCell3PinJiStat = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell/BackGround/BreakPoint")
  self._equipCell3Empty = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCellEmpty")
  self._equip3LockImg = self:GetChild("BackGround/RightPanel/Equip/Equip3/Lock")
  self._equipCell3Lv = self:GetChild("BackGround/RightPanel/Equip/Equip3/EquipCell/BackGround/Level/Num")
  self._uniqueEquipPanel = self:GetChild("BackGround/RightPanel/ExclusiveEquip/Equip")
  self._uniqueEquipPanel_unlock = self:GetChild("BackGround/RightPanel/ExclusiveEquip/Equip/EquipCell")
  self._uniqueEquipPanel_unlock_frame = self:GetChild("BackGround/RightPanel/ExclusiveEquip/Equip/EquipCell/BackGround/Frame")
  self._uniqueEquipPanel_unlock_icon = self:GetChild("BackGround/RightPanel/ExclusiveEquip/Equip/EquipCell/BackGround/Icon")
  self._uniqueEquipPanel_unlock_lv = self:GetChild("BackGround/RightPanel/ExclusiveEquip/Equip/EquipCell/BackGround/Level/Num")
  self._uniqueEquipPanel_lock = self:GetChild("BackGround/RightPanel/ExclusiveEquip/Equip/EquipCellEmpty")
  self._uniqueEquipPanel_no = self:GetChild("BackGround/RightPanel/ExclusiveEquip/Equip/Lock")
  self._heartBtn = self:GetChild("BackGround/UI/RelationBtn")
  self._heartNum = self:GetChild("BackGround/UI/RelationBtn/Num")
  self._heartRedDot = self:GetChild("BackGround/UI/RelationBtn/RedDot")
  self._jobClick = self:GetChild("BackGround/UI/CharName/Click")
  self._fashionBtn = self:GetChild("BackGround/UI/ClothesBtn")
  self._fashionBtn_redDot = self:GetChild("BackGround/UI/ClothesBtn/RedDot")
  self:GetChild("BackGround/RightPanel/Equip/CharUpgrade/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1986))
  self._charUpgradeBtn = self:GetChild("BackGround/RightPanel/Equip/CharUpgrade")
  self._charUpgradeBtn_LvText = self:GetChild("BackGround/RightPanel/Equip/CharUpgrade/Lv")
  self._propPanel:Subscribe_PointerClickEvent(self.OnPropPanelClick, self)
  self._levelUpPanel:Subscribe_PointerClickEvent(self.OnLevelUpPanelClick, self)
  self._breakPanel:Subscribe_PointerClickEvent(self.OnBreakPanelClick, self)
  self._evolvePanel:Subscribe_PointerClickEvent(self.OnEvolvePanelClick, self)
  self._equipSmallPanel1:Subscribe_PointerClickEvent(self.OnEquipPanel1Click, self)
  self._equipSmallPanel2:Subscribe_PointerClickEvent(self.OnEquipPanel2Click, self)
  self._equipSmallPanel3:Subscribe_PointerClickEvent(self.OnEquipPanel3Click, self)
  self._heartBtn:Subscribe_PointerClickEvent(self.OnHeartBtnClicked, self)
  self._jobClick:Subscribe_PointerClickEvent(self.OnJobClick, self)
  self._elementImg:Subscribe_PointerClickEvent(self.OnElementImgClick, self)
  self._fashionBtn:Subscribe_PointerClickEvent(self.OnfashionBtnClicked, self)
  self._skillDevelopBtn:Subscribe_PointerClickEvent(self.OnSkillDevelopBtnClicked, self)
  self._skillChangeBtn:Subscribe_PointerClickEvent(self.OnSkillChangeBtnClicked, self)
  self._suitEffect:Subscribe_PointerClickEvent(self.OnSuitEffectClicked, self)
  self._fashionBtn:SetActive(not GlobalGameFSM or GlobalGameFSM:GetCurrentState() ~= "Dungeon")
  self._uniqueEquipPanel:Subscribe_PointerClickEvent(self.OnUniqueEquipPanelClick, self)
  self._charUpgradeBtn:Subscribe_PointerClickEvent(self.OnCharUpGradeClick, self)
  CharLevelUpPart.OnCreate(self)
  CharBreakPart.OnCreate(self)
  CharEvolvePart.OnCreate(self)
  CharEquipPart.OnCreate(self)
  CharFashionPart.OnCreate(self)
  self._backBtn = self:GetChild("BackBtn")
  self._backBtnGuide = self:GetChild("BackBtn/Text")
  self._menuBtn = self:GetChild("MenuBtn")
  self._menuBtn:SetActive(GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCity")
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._roleEvaluationBtn = self:GetChild("BackGround/UI/AppraiseBtn")
  self._roleEvaluationBtn:Subscribe_PointerClickEvent(self.OnRoleEvaluationBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnRoleUpdateProperties, Common.n_UpdateProperties, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRoleInfoChange, Common.n_RoleInfoChange, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRoleInfoChange, Common.n_RoleLocked, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAPChange, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRoleGood, Common.n_RefreshRoleGood, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRoleGood, Common.n_RoleGoodReceiveAward, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDungeonEquipRedDot, Common.n_DungeonEquipRedDot, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  LuaNotificationCenter.AddObserver(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSkillUnlock, Common.n_ImproveSkill, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshWitchSkills, Common.n_RefreshWitchSkills, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRole, Common.n_RoleEnergyChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRedPointNumChanged, Common.n_RedPointNumChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshEquip, Common.n_EnchantEquip, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshEquip, Common.n_EquipBreak, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshEquip, Common.n_EquipLevelUp, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUniqueEquipLevelUp, Common.n_UniqueEquipLevelUp, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshUniqueEquipPanel, Common.n_UniqueEquipAvailable, nil)
  self._inDungeon = GlobalGameFSM:GetCurrentState() == "Dungeon"
  local dialog = DialogManager.GetDialog("battle.battleaccount.battlelosetextdialog")
  if dialog then
    self._tagFromBattleLoseDialog = dialog._selectGuideType.tag
  end
  if self._tagFromBattleLoseDialog then
    self._fashionBtn:SetActive(false)
    self._roleEvaluationBtn:SetActive(false)
  end
  if self._inDungeon or self._tagFromBattleLoseDialog then
    self._menuBtn:SetActive(false)
    self._diamondAddBtn:SetActive(false)
  end
  self:SetArrowActive()
  self:SwitchPropBackLength(false)
  self._quickSetBtn = self:GetChild("BackGround/RightPanel/Equip/QuickSet")
  self._quickSetBtn:Subscribe_PointerClickEvent(self.OnQuickSetBtnClicked, self)
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(67) then
    LuaNotificationCenter.AddObserver(self, OnUpdate, Common.n_Update, nil)
  end
end

function NewCharacterInfoDialog:OnDestroy()
  CharLevelUpPart.OnDestroy()
  CharEquipPart.OnDestroy()
  CharBreakPart.OnDestroy()
  CharEvolvePart.OnDestroy()
  CharFashionPart.OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  local dialog = DialogManager.GetDialog("character.basecharacterlistalldialog")
  if dialog then
    dialog:OnRefresh()
  end
  if self._inDungeon then
    local dlg = DialogManager.GetDialog("dungeon.rockerdialog")
    if dlg then
      dlg:UnMute()
    end
  end
  self._break_frame:Destroy()
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  DialogManager.DestroySingletonDialog("character.newpropertytipsdialog")
  DialogManager.DestroySingletonDialog("character.newpassiveskilltipsdialog")
  DialogManager.DestroySingletonDialog("equip.equipchangenewdialog")
  DialogManager.DestroySingletonDialog("handbook.roledetailinfodialog")
  DialogManager.DestroySingletonDialog("character.characterjobdialog")
  DialogManager.DestroySingletonDialog("uniqueequip.uniqueequipdialog")
  DialogManager.DestroySingletonDialog("equip.presetequipdialog")
  DialogManager.DestroySingletonDialog("character.quicklevelup.quicklevelupmaindialog")
  if self._voiceId then
    NekoData.BehaviorManager.BM_Voice:StopVoice(self._voiceId)
    self._voiceId = nil
  end
  if self._contentTimer then
    GameTimer.RemoveTask(self._contentTimer)
    self._contentTimer = nil
  end
  if self._data then
    NekoData.BehaviorManager.BM_RedPoint:ClearAllRedPointsByRoleId(self._data:GetRoleId())
  end
end

function NewCharacterInfoDialog:SwitchPropBackLength(showLong)
  self._propBackShort:SetActive(not showLong)
  self._propBackLong:SetActive(showLong)
  self._propHeartShort:SetActive(not showLong)
  self._propHeartLong:SetActive(showLong)
  self._propAtkShort:SetActive(not showLong)
  self._propAtkLong:SetActive(showLong)
  self._propPhyDefShort:SetActive(not showLong)
  self._propPhyDefLong:SetActive(showLong)
  self._propMagDefShort:SetActive(not showLong)
  self._propMagDefLong:SetActive(showLong)
  if showLong then
    self._propBack = self._propBackLong
    self._propHeart = self._propHeartLong
    self._propAtk = self._propAtkLong
    self._propPhyDef = self._propPhyDefLong
    self._propMagDef = self._propMagDefLong
  else
    self._propBack = self._propBackShort
    self._propHeart = self._propHeartShort
    self._propAtk = self._propAtkShort
    self._propPhyDef = self._propPhyDefShort
    self._propMagDef = self._propMagDefShort
  end
end

function NewCharacterInfoDialog:OnRoleUpdateProperties(notification)
  if notification and notification.userInfo then
    local key = self._data:GetRoleId()
    if key == notification.userInfo.roleId then
      self._data = NekoData.BehaviorManager.BM_AllRoles:GetRole(key)
      if self._inDungeon then
        self:SwitchPropBackLength(true)
        self._propHeart:SetText(tostring(self._data:GetCurrentHp()) .. "/" .. tostring(self._data:GetProperties()[AttrTypeEnum.MAX_HP]))
      else
        self:SwitchPropBackLength(false)
        self._propHeart:SetText(self._data:GetCurrentHp())
      end
      self._propAtk:SetText(self._data:GetAttack())
      self._propPhyDef:SetText(self._data:GetDefend())
      self._propMagDef:SetText(self._data:GetMagDefend())
    end
  end
end

function NewCharacterInfoDialog:OnRoleInfoChange(notification)
  if notification and notification.userInfo then
    local key = self._data:GetRoleId()
    self._data = NekoData.BehaviorManager.BM_AllRoles:GetRole(key)
    if key == notification.userInfo.key and notification.userInfo.name == "sroleupdatelv" and (self._tag == Tag.LevelUp or self._tag == Tag.Nothing) then
      CharLevelUpPart.RefreshExp(notification.userInfo.levelandexp)
    end
    if notification.userInfo.name == "schangeequipment" then
      self:RefreshEquipPanel()
    end
  end
  if self._tag ~= Tag.LevelUp then
    self:OnRefresh()
  end
end

local function RefreshSkillPanel(self)
  local showSkillData = self._data:GetShowSkillData()
  for i, v in ipairs(self._skillPanel_skills) do
    local data = showSkillData[i]
    local skill = Skill.Create(data.skillId, data.skillItemId or true)
    v.cell:Init(skill, data.unlock)
  end
  self._skillChangeBtn:SetActive((not self._inDungeon or self._tagFromBattleLoseDialog) and self._data:GetIsLeader() and #self._data:GetActiveSkillList() > 2)
end

function NewCharacterInfoDialog:OnSkillUnlock(notification)
  if notification.userInfo.roleId == self._data:GetId() then
    self._data = NekoData.BehaviorManager.BM_AllRoles:GetRole(self._data:GetRoleId())
    RefreshSkillPanel(self)
  end
end

function NewCharacterInfoDialog:OnRefreshWitchSkills()
  if self._data:GetIsLeader() then
    RefreshSkillPanel(self)
  end
end

function NewCharacterInfoDialog:OnRedPointNumChanged(notification)
  if not notification or notification.userInfo.redPointID == 3 and notification.userInfo.redPointParams and notification.userInfo.redPointParams[1] == self._data:GetId() then
    self._skillDevelopBtn_redDot:SetActive((not self._inDungeon or self._tagFromBattleLoseDialog) and NekoData.BehaviorManager.BM_RedPoint:GetRedPointNum(3, {
      self._data:GetId()
    }) > 0)
  end
  if not notification or notification.userInfo.redPointID == 5 and notification.userInfo.redPointParams and notification.userInfo.redPointParams[1] == self._data:GetId() then
    self._evolveRedIcon:SetActive(0 < NekoData.BehaviorManager.BM_RedPoint:GetRedPointNum(5, {
      self._data:GetId()
    }))
  end
  if not notification or notification.userInfo.redPointID == 7 and notification.userInfo.redPointParams and notification.userInfo.redPointParams[1] == self._data:GetId() then
    self._fashionBtn_redDot:SetActive(0 < NekoData.BehaviorManager.BM_RedPoint:GetRedPointNum(7, {
      self._data:GetId()
    }))
  end
  if not notification or notification.userInfo.redPointID == 9 and notification.userInfo.redPointParams and notification.userInfo.redPointParams[1] == self._data:GetId() then
    self._heartRedDot:SetActive(0 < NekoData.BehaviorManager.BM_RedPoint:GetRedPointNum(9, {
      self._data:GetId()
    }))
  end
  if not notification or notification.userInfo.redPointID == 11 and notification.userInfo.redPointParams and notification.userInfo.redPointParams[1] == self._data:GetId() then
    self._breakRedDot:SetActive(0 < NekoData.BehaviorManager.BM_RedPoint:GetRedPointNum(11, {
      self._data:GetId()
    }))
  end
end

function NewCharacterInfoDialog:RefreshUniqueEquipPanel()
  local uniqueEquipId = self._data:GetUniqueEquipId()
  if uniqueEquipId then
    local lv = self._data:GetUniqueEquipLevel()
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
end

function NewCharacterInfoDialog:OnUniqueEquipLevelUp(notification)
  if notification.userInfo.roleId == self._data:GetRoleId() then
    self:RefreshUniqueEquipPanel()
    if notification.userInfo.specialWeaponLevel == 1 then
      self:OnRefreshRole()
    end
  end
end

function NewCharacterInfoDialog:OnBackBtnClicked()
  if self._tag == Tag.LevelUp and not self._canChangeRole then
    return
  end
  if not (self._tag ~= Tag.Nothing and self._tag ~= Tag.Talent and self._tag ~= Tag.Prop and (not self._tagFromBattleLoseDialog or NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(25))) or self._once then
    if NekoData.BehaviorManager.BM_Guide:CanPlayGuide(54) then
      NekoData.BehaviorManager.BM_Guide:FinishGuide(54)
    end
    self:Destroy()
  else
    if self._tag == Tag.LevelUp then
      CS.PixelNeko.UI.UIManager.CancelTouch(self._levelup_levelUpBtn._uiObject)
    end
    self:GetRootWindow():SetAnimatorInteger("state", 1)
    self._tag = Tag.Nothing
    self._levelup_task1 = {}
    self._progressFullTime = ProgressFullMaxTotalTime
    self._breakItemList = {}
    self._currentCanWearWeaponList = {}
    self._currentCanWearArmorList = {}
    self._currentCanWearJewelryList = {}
    self._skillItemList = {}
    self._skill_improveReceive = true
    self._skill_tag_which = 1
    self._skill_tag_level = SkillLevelTag.CurLevel
    self._break_canRefresh = true
    self._evolve_canRefresh = true
    if self._voiceId then
      self._dialogPanel:SetActive(true)
    end
    CharFashionPart.Clear()
    self:Refresh(NekoData.BehaviorManager.BM_AllRoles:GetRole(self._data:GetRoleId()), true)
  end
end

function NewCharacterInfoDialog:OnMenuBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function NewCharacterInfoDialog:GetRoleKey()
  return self._data:GetRoleId()
end

function NewCharacterInfoDialog:OnRefresh()
  if self._tag == Tag.LevelUp then
    CharLevelUpPart.RefreshLevelUpInfo()
  elseif self._tag == Tag.Break and self._break_canRefresh then
    CharBreakPart.RefreshBreakInfo()
  elseif self._tag == Tag.Equip then
  elseif self._tag == Tag.Evolve and self._evolve_canRefresh then
    local result = CharEvolvePart.RefreshEvolveInfo()
    if result == -1 then
      self._evolve_haveReachMaxLevel = true
    else
      self._evolve_haveReachMaxLevel = false
    end
  end
end

function NewCharacterInfoDialog:SetLive2D(data, fashionData, blackPhoto)
  if not data and not fashionData then
    return
  end
  local theRoleID = data:GetId()
  local theFashionID = data:GetDefaultFashion()
  local record = data:GetShapeLive2DRecord()
  local IsFashionLive2D = data:IsFashionLive2D()
  if fashionData then
    local shapeId = fashionData.shapeID
    record = CNpcShapeTable:GetRecorder(shapeId)
    IsFashionLive2D = fashionData.shapeType == 2
    theRoleID = fashionData.roleid
    theFashionID = fashionData.id
  end
  self._picTouchData = {
    NekoData.BehaviorManager.BM_RoleTouch:GetPicTouchInfo(theRoleID, theFashionID)
  }
  self._rolePanel:SetAnimatorTrigger("loadReady")
  if self._handler then
    self._live2D:Release(self._handler)
    self._handler = nil
  end
  self._photo_black:SetActive(blackPhoto)
  if IsFashionLive2D and Live2DManager.CanUse() and record.live2DAssetBundleName and record.live2DAssetBundleName ~= "" and record.live2DPrefabName and record.live2DPrefabName ~= "" and not blackPhoto then
    self._photo:SetActive(false)
    self._handler = self._live2D:AddLive2D(record.live2DAssetBundleName, record.live2DPrefabName, record.live2DScale)
    self._live2D:SetLive2DAnimatorInteger(self._handler, "isLoop", 1)
    if not self._live2D:OnlyFor0916Func() then
      self._dragPanel:SetActive(true)
    else
      local touchRecordList = NekoData.BehaviorManager.BM_RoleTouch:GetLive2DTouchInfo(theRoleID, theFashionID)
      if 0 < #touchRecordList then
        self._live2D:AddPointerDownListener(self._handler, function(_, posName)
          self:OnLive2DPointerDown(posName, theRoleID, theFashionID, touchRecordList)
        end, self)
        self._dragPanel:SetActive(false)
      else
        self._dragPanel:SetActive(true)
      end
    end
  else
    self._photo:SetActive(not blackPhoto)
    self._dragPanel:SetActive(true)
    if blackPhoto then
      local recorder = CImagePathTable:GetRecorder(record.lihuiID)
      self._photo_black:SetSprite(recorder.assetBundle, recorder.assetName)
      local phtotScale = record.photoScale
      self._photo_black:SetLocalScale(phtotScale, phtotScale, phtotScale)
      self._photo_black:SetAnchoredPosition(record.photoLocation[1], record.photoLocation[2])
    elseif fashionData then
      local recorder = CImagePathTable:GetRecorder(record.lihuiID)
      self._photo:SetSprite(recorder.assetBundle, recorder.assetName)
      local phtotScale = record.photoScale
      self._photo:SetLocalScale(phtotScale, phtotScale, phtotScale)
      self._photo:SetAnchoredPosition(record.photoLocation[1], record.photoLocation[2])
    else
      local recorder = data:GetShapeLiHuiImageRecord()
      self._photo:SetSprite(recorder.assetBundle, recorder.assetName)
      local phtotScale = data:GetPhotoScale()
      self._photo:SetLocalScale(phtotScale, phtotScale, phtotScale)
      local photoPosition = data:GetPhotoPosition()
      self._photo:SetAnchoredPosition(photoPosition[1], photoPosition[2])
    end
  end
end

function NewCharacterInfoDialog:Refresh(data, dontSetLive2D)
  if data:IsNew() then
    NekoData.DataManager.DM_AllRoles:RefreshRoleNewState(data:GetRoleId(), false)
    if NekoData.DataManager.DM_AllRoles:CheckNewRoleRed() then
      LuaNotificationCenter.PostNotification(Common.n_RefreshNewRole, nil)
    end
  end
  self._moneyPanel:SetActive(true)
  self._manaTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID))
  self._diamondTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.DiamodID))
  self._data = NekoData.BehaviorManager.BM_AllRoles:GetRole(data:GetRoleId())
  if self._tag == Tag.Nothing or self._tag == Tag.Prop or self._tag == Tag.Talent then
    self._heartBtn:SetInteractable(true)
    self._roleEvaluationBtn:SetInteractable(true)
  else
    self._heartBtn:SetInteractable(false)
    self._roleEvaluationBtn:SetInteractable(false)
  end
  if self._tag == Tag.LevelUp then
    CharLevelUpPart.RefreshLevelUpInfo(true)
  elseif self._tag == Tag.Break then
    CharBreakPart.RefreshBreakInfo()
  elseif self._tag == Tag.Fashion then
    local cmd = LuaNetManager.CreateProtocol("protocol.item.cgetroleskin")
    cmd.roleId = self._data:GetId()
    cmd:Send()
  end
  local result = CharEvolvePart.RefreshEvolveInfo()
  if result ~= -1 then
    self._evolve_haveReachMaxLevel = false
  else
    self._evolve_haveReachMaxLevel = true
  end
  self._charUpgradeBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Guild))
  self._charUpgradeBtn_LvText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1287, {
    self._data:GetRuneLevel()
  }))
  if not dontSetLive2D then
    local fashionId = data:GetDefaultFashion()
    local fashionData
    if 0 < fashionId then
      fashionData = CSkin:GetRecorder(fashionId)
    end
    self:SetLive2D(data, fashionData)
    self:SetVoiceIdNil()
    self:OnLiHuiClicked(true)
  end
  self._jobTxt:SetText(data:GetVocationName())
  self._jobId = data:GetVocationId()
  self._jobImg:SetSprite(data:GetVocationDescribeImageRecord().assetBundle, data:GetVocationDescribeImageRecord().assetName)
  self._cvName:SetText(data:GetCvName())
  if not data:GetIsLeader() then
    self._rank:SetActive(true)
    self._rank:SetSprite(data:GetRoleInfoRarityImageRecord().assetBundle, data:GetRoleInfoRarityImageRecord().assetName)
    self._name:SetActive(true)
    self._name:SetText(data:GetRoleName())
    self._charTitle:SetActive(true)
    self._charTitle:SetText(data:GetTitleName())
    self._heartBtn:SetActive(true)
  else
    self._rank:SetActive(false)
    self._name:SetText(TextManager.GetText(1300007))
    self._charTitle:SetActive(false)
    self._heartBtn:SetActive(false)
  end
  self._elementImg:SetSprite(data:GetElementImageRecord().assetBundle, data:GetElementImageRecord().assetName)
  if self._lockToggle:GetIsOnType() == data:GetIsLock() then
    self._lockTag = true
  else
    self._lockTag = false
    self._lockToggle:SetIsOnType(data:GetIsLock())
  end
  local record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAX_HP)
  local imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._propHeartImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if self._inDungeon then
    self:SwitchPropBackLength(true)
    self._propHeart:SetText(tostring(data:GetCurrentHp()) .. "/" .. tostring(data:GetProperties()[AttrTypeEnum.MAX_HP]))
    self._heartBtn:SetActive(false)
    self._charUpgradeBtn:SetActive(false)
    self._roleEvaluationBtn:SetActive(false)
  else
    self:SwitchPropBackLength(false)
    self._propHeart:SetText(data:GetMaxHp())
  end
  if data:GetDamageType() == 1 then
    record = CAttrNameTable:GetRecorder(AttrTypeEnum.ATTACK)
  else
    record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAGIC_ATTACK)
  end
  imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._propAtkImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._propAtk:SetText(data:GetAttack())
  record = CAttrNameTable:GetRecorder(AttrTypeEnum.DEFEND)
  imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._propPhyDefImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._propPhyDef:SetText(data:GetDefend())
  record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAGIC_DEFEND)
  imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._propMagDefImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._propMagDef:SetText(data:GetMagDefend())
  self._levelTxt:SetText(data:GetShowLv())
  local str = CStringRes:GetRecorder(1111).msgTextID
  str = TextManager.GetText(str)
  str = string.gsub(str, "%$parameter1%$", tostring(data:GetExp()))
  str = string.gsub(str, "%$parameter2%$", tostring(data:GetCurLvMaxExp()))
  self._expTxt:SetText(str)
  self._levelMax:SetText(data:GetShowMaxBreakLv())
  local curLv = self._data:GetBreakLv()
  local maxLv = self._data:GetMaxBreakLv()
  str = ""
  for i = 1, maxLv do
    if i <= curLv then
      str = str .. "1"
    else
      str = str .. "0"
    end
  end
  self._breakPoint:SetText(str)
  curLv = self._data:GetEvolution()
  maxLv = self._data:GetEvolutionLimit()
  str = ""
  for i = 1, maxLv do
    if i <= curLv then
      str = str .. "1"
    else
      str = str .. "0"
    end
  end
  self._evolvePoint:SetText(str)
  RefreshSkillPanel(self)
  self:OnRedPointNumChanged()
  self.lock = not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Equip_Unlock)
  self._quickSetBtn:SetActive(not self.lock)
  self._equip1LockImg:SetActive(self.lock)
  self._equip2LockImg:SetActive(self.lock)
  self._equip3LockImg:SetActive(self.lock)
  self:RefreshEquipPanel()
  self._heartNum:SetText(self._data:GetRelationLevel())
  self:OnDungeonEquipRedDot()
  if not NekoData.BehaviorManager.BM_Guide:HasFinished(25) then
    local roleBreakRecord = self._data:GetBreakRecords()[self._data:GetBreakLv() + 1]
    if not self._levelup_hasTriggerGuideTag1 and roleBreakRecord and self._data:GetLevel() == roleBreakRecord.levelmax then
      self._levelup_hasTriggerGuideTag1 = true
      LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
    end
  end
  if self._tagFromBattleLoseDialog then
    self._heartBtn:SetActive(false)
  end
  self:RefreshUniqueEquipPanel()
end

function NewCharacterInfoDialog:OnMouseClicked()
end

function NewCharacterInfoDialog:OnManaBtnClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.ManaID)
    })
    local width, height = self._manaBtn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._manaBtn:GetLocalPointInUiRootPanel())
  end
end

function NewCharacterInfoDialog:OnDiamondBtnClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.DiamodID)
    })
    local width, height = self._diamondBtn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._diamondBtn:GetLocalPointInUiRootPanel())
  end
end

function NewCharacterInfoDialog:OnDiamondAddBtnClick()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Shop) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100192)
  else
    local baseSceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if baseSceneController then
      DialogManager.GetGroup("Modal"):ReturnModalDialog()
      NekoData.DataManager.DM_Shop:ClientSetOpenShopID(4)
      baseSceneController:SetCameraAnimatorState(0)
      local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
      if protocol then
        protocol:Send()
      end
    end
  end
end

function NewCharacterInfoDialog:OnValueChanged()
  if self._lockToggle:GetIsOnType() then
  else
  end
  if self._lockTag then
    local croleLock = LuaNetManager.CreateProtocol("protocol.login.crolelock")
    if croleLock then
      croleLock.roleId = self._data:GetRoleId()
      croleLock:Send()
    end
  else
    self._lockTag = true
  end
end

function NewCharacterInfoDialog:OnChatBtnPointerClick()
end

function NewCharacterInfoDialog:OnLeftArrowClick(value)
  if self._canChangeRole then
    self._canChangeRole = false
    local dialog = DialogManager.GetDialog("character.basecharacterlistalldialog")
    if not dialog and not self._tagFromBattleLoseDialog then
      dialog = DialogManager.GetDialog("dungeon.dungeonhud")
    end
    dialog = dialog or DialogManager.GetDialog("teamedit.changeteamroledialog")
    dialog = dialog or DialogManager.GetDialog("teamedit.teameditprewardialog")
    dialog = dialog or DialogManager.GetDialog("teamedit.springfestivalteameditdialog")
    dialog = dialog or DialogManager.GetDialog("teamedit.teampresetmaindialog")
    if dialog then
      local roleList = dialog:ReturnRoleList()
      local len = #roleList
      local minNum = 1
      local fromRoleDetailInfoDialog = value and type(value) == "boolean"
      if fromRoleDetailInfoDialog then
        minNum = 2
      end
      if len > minNum then
        local pos
        for i, v in pairs(roleList) do
          if v:GetRoleId() == self._data:GetRoleId() then
            pos = i - 1
            break
          end
        end
        if pos then
          if pos <= 0 then
            pos = pos + len
          end
          if fromRoleDetailInfoDialog and roleList[pos]:GetIsLeader() then
            pos = pos - 1
            if pos <= 0 then
              pos = pos + len
            end
          end
          self._break_canRefresh = true
          self._evolve_canRefresh = true
          CharEvolvePart.ClearSelectTag()
          NekoData.BehaviorManager.BM_RedPoint:ClearAllRedPointsByRoleId(self._data:GetRoleId())
          self:Refresh(roleList[pos])
          return true
        end
      end
    end
  end
end

function NewCharacterInfoDialog:OnRightArrowClick(value)
  if self._canChangeRole then
    self._canChangeRole = false
    local dialog = DialogManager.GetDialog("character.basecharacterlistalldialog")
    if not dialog and not self._tagFromBattleLoseDialog then
      dialog = DialogManager.GetDialog("dungeon.dungeonhud")
    end
    dialog = dialog or DialogManager.GetDialog("teamedit.changeteamroledialog")
    dialog = dialog or DialogManager.GetDialog("teamedit.teameditprewardialog")
    dialog = dialog or DialogManager.GetDialog("teamedit.springfestivalteameditdialog")
    dialog = dialog or DialogManager.GetDialog("teamedit.teampresetmaindialog")
    if dialog then
      local roleList = dialog:ReturnRoleList()
      local len = #roleList
      local minNum = 1
      local fromRoleDetailInfoDialog = value and type(value) == "boolean"
      if fromRoleDetailInfoDialog then
        minNum = 2
      end
      if len > minNum then
        local pos
        for i, v in pairs(roleList) do
          if v:GetRoleId() == self._data:GetRoleId() then
            pos = i + 1
            break
          end
        end
        if pos then
          if len < pos then
            pos = pos - len
          end
          if fromRoleDetailInfoDialog and roleList[pos]:GetIsLeader() then
            pos = pos + 1
            if len < pos then
              pos = pos - len
            end
          end
          self._break_canRefresh = true
          self._evolve_canRefresh = true
          local data = roleList[pos]
          CharEvolvePart.ClearSelectTag()
          NekoData.BehaviorManager.BM_RedPoint:ClearAllRedPointsByRoleId(self._data:GetRoleId())
          self:Refresh(data)
          return true
        end
      end
    end
  end
end

function NewCharacterInfoDialog:ShouldLengthChange(frame, index)
  return true
end

function NewCharacterInfoDialog:OnAPChange()
  self._manaTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID))
  self._diamondTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.DiamodID))
end

function NewCharacterInfoDialog:NumberOfCell(frame)
  if frame == self._break_frame then
    return #self._breakItemList
  elseif frame == self._skill_frame then
    return #self._skillItemList
  elseif frame == self._skill_describeFrame then
    return #self._skill_describe
  elseif frame == self._fashionFrame then
    return #self._fashionList
  end
end

function NewCharacterInfoDialog:CellAtIndex(frame)
  if frame == self._break_frame then
    return "character.breakitemcell"
  elseif frame == self._skill_frame then
    return "skill.skillitemcell"
  elseif frame == self._skill_describeFrame then
    return "character.newcharskilldescribecell"
  elseif frame == self._fashionFrame then
    return "character.charfashioncell"
  end
end

function NewCharacterInfoDialog:DataAtIndex(frame, index)
  if frame == self._break_frame then
    return self._breakItemList[index]
  elseif frame == self._skill_frame then
    return self._skillItemList[index]
  elseif frame == self._skill_describeFrame then
    return self._skill_describe[index]
  elseif frame == self._fashionFrame then
    return self._fashionList[index]
  end
end

function NewCharacterInfoDialog:OnPropPanelClick()
  self._tag = Tag.Prop
  local dialog = DialogManager.CreateSingletonDialog("character.newpropertytipsdialog")
  dialog:Init(NekoData.BehaviorManager.BM_AllRoles:GetRole(self._data:GetRoleId()), self)
  dialog:SetDestroyCallBack(function()
    self._tag = Tag.Nothing
  end)
end

function NewCharacterInfoDialog:OnLevelUpPanelClick()
  if self._inDungeon then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100098)
  else
    self._tag = Tag.LevelUp
    self:GetRootWindow():SetAnimatorInteger("state", 2)
    CharLevelUpPart.RefreshLevelUpInfo(true)
    self._heartBtn:SetInteractable(false)
    self._roleEvaluationBtn:SetInteractable(false)
  end
end

function NewCharacterInfoDialog:OnBreakPanelClick()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Role_Break) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100176)
    return
  end
  if self._inDungeon then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100099)
  else
    self._tag = Tag.Break
    self:GetRootWindow():SetAnimatorInteger("state", 3)
    CharBreakPart.RefreshBreakInfo()
    self._heartBtn:SetInteractable(false)
    self._roleEvaluationBtn:SetInteractable(false)
  end
end

function NewCharacterInfoDialog:OnEvolvePanelClick()
  if self._inDungeon then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100100)
  elseif self._evolve_haveReachMaxLevel then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100087)
  else
    self._tag = Tag.Evolve
    self:GetRootWindow():SetAnimatorInteger("state", 4)
    CharEvolvePart.RefreshEvolveInfo()
    CharEvolvePart.SelectSpecialItem()
    self._heartBtn:SetInteractable(false)
    self._roleEvaluationBtn:SetInteractable(false)
  end
end

function NewCharacterInfoDialog:OnSkillClick(index)
  local data = self._data:GetShowSkillDataByIndex(index)
  if data.unlock then
    DialogManager.CreateSingletonDialog("skill.skilltipsdialog"):SetSkillAndRoleId(data.skillId, data.skillItemId, self._data:GetRoleId())
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100315)
  end
end

function NewCharacterInfoDialog:OnEquipPanel1Click()
  local tag = false
  if self._weaponKey then
    tag = true
  else
    tag = CharEquipPart.IsReplaceable(EquipTypeEnum.WEAPON, self._weaponKey)
  end
  if self.lock then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100263)
    return
  end
  if tag then
    local dialog = DialogManager.CreateSingletonDialog("equip.equipchangenewdialog")
    dialog:Init(self._data:GetRoleId(), EquipTypeEnum.WEAPON, self._weaponKey)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100012)
  end
end

function NewCharacterInfoDialog:OnEquipPanel2Click()
  local tag = false
  if self._armorKey then
    tag = true
  else
    tag = CharEquipPart.IsReplaceable(EquipTypeEnum.ARMOR, self._armorKey)
  end
  if self.lock then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100263)
    return
  end
  if tag then
    local dialog = DialogManager.CreateSingletonDialog("equip.equipchangenewdialog")
    dialog:Init(self._data:GetRoleId(), EquipTypeEnum.ARMOR, self._armorKey)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100012)
  end
end

function NewCharacterInfoDialog:OnEquipPanel3Click()
  local tag = false
  if self._jewelryKey then
    tag = true
  else
    tag = CharEquipPart.IsReplaceable(EquipTypeEnum.JEWELRY, self._jewelryKey)
  end
  if self.lock then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100263)
    return
  end
  if tag then
    local dialog = DialogManager.CreateSingletonDialog("equip.equipchangenewdialog")
    dialog:Init(self._data:GetRoleId(), EquipTypeEnum.JEWELRY, self._jewelryKey)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100012)
  end
end

function NewCharacterInfoDialog:OnAnimationEvent(floatValue, intValue, stringValue, obj, clipName)
  self._clipName = clipName
end

function NewCharacterInfoDialog:OnDrag(args)
  if args.delta.x ~= 0 then
    self._direction = args.delta.x
  end
end

function NewCharacterInfoDialog:OnEndDrag(args)
  if self._direction then
    if self._direction > 10 then
      self:OnLeftArrowClick()
    elseif self._direction < -10 then
      self:OnRightArrowClick()
    end
  end
end

function NewCharacterInfoDialog:OnRoleChangeStateExit(arg1, arg2)
  if arg2 == "CharChangeRole" then
    self._canChangeRole = true
  end
end

function NewCharacterInfoDialog:OnHeartBtnClicked()
  if NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(25) then
    return
  end
  if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Signboard) then
    local dialog = DialogManager.CreateSingletonDialog("handbook.roledetailinfodialog")
    if dialog then
      dialog:Refresh(self._data:GetId())
      dialog:OnTabBtnClick(2)
    end
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100312)
  end
end

function NewCharacterInfoDialog:OnRefreshRoleGood()
  local roleId = self._data:GetId()
  self._data = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  self._heartNum:SetText(self._data:GetRelationLevel())
end

function NewCharacterInfoDialog:OnDungeonEquipRedDot()
  self._equipSmallPanel1RedDotTag = false
  self._equipSmallPanel2RedDotTag = false
  self._equipSmallPanel3RedDotTag = false
  local redData = NekoData.BehaviorManager.BM_Dungeon:GetEquipRedData()
  for _, roleValue in ipairs(redData) do
    if self._data:GetRoleId() == roleValue.roleKey then
      for type, v in pairs(roleValue.canEquipList) do
        if type == EquipTypeEnum.WEAPON and #v ~= 0 then
          self._equipSmallPanel1RedDotTag = true
        end
        if type == EquipTypeEnum.ARMOR and #v ~= 0 then
          self._equipSmallPanel2RedDotTag = true
        end
        if type == EquipTypeEnum.JEWELRY and #v ~= 0 then
          self._equipSmallPanel3RedDotTag = true
        end
      end
    end
  end
  if self._equipSmallPanel1RedDotTag then
    self._equipSmallPanel1RedDot:SetActive(true)
  else
    self._equipSmallPanel1RedDot:SetActive(false)
  end
  if self._equipSmallPanel2RedDotTag then
    self._equipSmallPanel2RedDot:SetActive(true)
  else
    self._equipSmallPanel2RedDot:SetActive(false)
  end
  if self._equipSmallPanel3RedDotTag then
    self._equipSmallPanel3RedDot:SetActive(true)
  else
    self._equipSmallPanel3RedDot:SetActive(false)
  end
end

function NewCharacterInfoDialog:OnRefreshRole()
  self:Refresh(NekoData.BehaviorManager.BM_AllRoles:GetRole(self._data:GetRoleId()), true)
end

function NewCharacterInfoDialog:RefreshEquipPanel()
  local key = self._data:GetRoleId()
  self._data = NekoData.BehaviorManager.BM_AllRoles:GetRole(key)
  local suitMap = self._data:GetSuitSkillsMap()
  local record
  local equipKey = self._data:GetWeapon()
  if equipKey ~= 0 then
    self._weaponKey = equipKey
    self._weapon = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(equipKey)
    self._equipCell1:SetActive(true)
    self._equipCell1Empty:SetActive(false)
    record = self._weapon:GetIcon()
    self._equipCell1Icon:SetSprite(record.assetBundle, record.assetName)
    record = self._weapon:GetPinJiImage()
    self._equipCell1Frame:SetSprite(record.assetBundle, record.assetName)
    self._equipCell1Suit:SetActive(suitMap[self._weapon:GetEquipSuitId()] and 0 < #suitMap[self._weapon:GetEquipSuitId()].skillIds)
    self._equipCell1SuitGrey:SetActive(suitMap[self._weapon:GetEquipSuitId()] and #suitMap[self._weapon:GetEquipSuitId()].skillIds == 0)
    self._equipCell1PinJiStat:SetText(self._weapon:GetEquipStarStr())
    if self._equipCell1Suit:IsActive() then
      record = self._weapon:GetEquipSuitRecorder()
      record = record and CImagePathTable:GetRecorder(record.suitImg)
      self._equipCell1Suit:SetSprite(record.assetBundle, record.assetName)
    end
    if self._equipCell1SuitGrey:IsActive() then
      record = self._weapon:GetEquipSuitRecorder()
      record = record and CImagePathTable:GetRecorder(record.suitImg)
      self._equipCell1SuitGrey:SetSprite(record.assetBundle, record.assetName)
    end
    self._equipCell1Lv:SetText(self._weapon:GetStrengthenLevel())
    self._equipCell1SpecialFMImage:SetActive(self._weapon:GetFinalRandomEntry())
    if self._weapon:GetFinalRandomEntry() then
      AnimationHelper.SetAnimatorInteger2(self._equipSmallPanel1:GetUIObject(), "par", 1)
    else
      AnimationHelper.SetAnimatorInteger2(self._equipSmallPanel1:GetUIObject(), "par", 0)
    end
  else
    self._weaponKey = nil
    self._weapon = nil
    self._equipCell1:SetActive(false)
    self._equipCell1Empty:SetActive(true)
  end
  local suitMap = self._data:GetSuitSkillsMap()
  local showSuitEffect = false
  for k, v in pairs(suitMap) do
    if 0 < #v.skillIds then
      showSuitEffect = true
      break
    end
  end
  self._suitEffect:SetActive(showSuitEffect)
  equipKey = self._data:GetArmor()
  if equipKey ~= 0 then
    self._armorKey = equipKey
    self._armor = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(equipKey)
    self._equipCell2:SetActive(true)
    self._equipCell2Empty:SetActive(false)
    record = self._armor:GetIcon()
    self._equipCell2Icon:SetSprite(record.assetBundle, record.assetName)
    record = self._armor:GetPinJiImage()
    self._equipCell2Frame:SetSprite(record.assetBundle, record.assetName)
    self._equipCell2Suit:SetActive(suitMap[self._armor:GetEquipSuitId()] and 0 < #suitMap[self._armor:GetEquipSuitId()].skillIds)
    self._equipCell2SuitGrey:SetActive(suitMap[self._armor:GetEquipSuitId()] and #suitMap[self._armor:GetEquipSuitId()].skillIds == 0)
    self._equipCell2PinJiStat:SetText(self._armor:GetEquipStarStr())
    if self._equipCell2Suit:IsActive() then
      record = self._armor:GetEquipSuitRecorder()
      record = record and CImagePathTable:GetRecorder(record.suitImg)
      self._equipCell2Suit:SetSprite(record.assetBundle, record.assetName)
    end
    if self._equipCell2SuitGrey:IsActive() then
      record = self._armor:GetEquipSuitRecorder()
      record = record and CImagePathTable:GetRecorder(record.suitImg)
      self._equipCell2SuitGrey:SetSprite(record.assetBundle, record.assetName)
    end
    self._equipCell2Lv:SetText(self._armor:GetStrengthenLevel())
    self._equipCell2SpecialFMImage:SetActive(self._armor:GetFinalRandomEntry())
    if self._armor:GetFinalRandomEntry() then
      AnimationHelper.SetAnimatorInteger2(self._equipSmallPanel2:GetUIObject(), "par", 1)
    else
      AnimationHelper.SetAnimatorInteger2(self._equipSmallPanel2:GetUIObject(), "par", 0)
    end
  else
    self._armorKey = nil
    self._armor = nil
    self._equipCell2:SetActive(false)
    self._equipCell2Empty:SetActive(true)
  end
  equipKey = self._data:GetJewelry()
  if equipKey ~= 0 then
    self._jewelryKey = equipKey
    self._jewelry = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(equipKey)
    self._equipCell3:SetActive(true)
    self._equipCell3Empty:SetActive(false)
    record = self._jewelry:GetIcon()
    self._equipCell3Icon:SetSprite(record.assetBundle, record.assetName)
    record = self._jewelry:GetPinJiImage()
    self._equipCell3Frame:SetSprite(record.assetBundle, record.assetName)
    self._equipCell3Suit:SetActive(suitMap[self._jewelry:GetEquipSuitId()] and 0 < #suitMap[self._jewelry:GetEquipSuitId()].skillIds)
    self._equipCell3SuitGrey:SetActive(suitMap[self._jewelry:GetEquipSuitId()] and #suitMap[self._jewelry:GetEquipSuitId()].skillIds == 0)
    self._equipCell3PinJiStat:SetText(self._jewelry:GetEquipStarStr())
    if self._equipCell3Suit:IsActive() then
      record = self._jewelry:GetEquipSuitRecorder()
      record = record and CImagePathTable:GetRecorder(record.suitImg)
      self._equipCell3Suit:SetSprite(record.assetBundle, record.assetName)
    end
    if self._equipCell3SuitGrey:IsActive() then
      record = self._jewelry:GetEquipSuitRecorder()
      record = record and CImagePathTable:GetRecorder(record.suitImg)
      self._equipCell3SuitGrey:SetSprite(record.assetBundle, record.assetName)
    end
    self._equipCell3Lv:SetText(self._jewelry:GetStrengthenLevel())
    self._equipCell3SpecialFMImage:SetActive(self._jewelry:GetFinalRandomEntry())
    if self._jewelry:GetFinalRandomEntry() then
      AnimationHelper.SetAnimatorInteger2(self._equipSmallPanel3:GetUIObject(), "par", 1)
    else
      AnimationHelper.SetAnimatorInteger2(self._equipSmallPanel3:GetUIObject(), "par", 0)
    end
  else
    self._jewelryKey = nil
    self._jewelry = nil
    self._equipCell3:SetActive(false)
    self._equipCell3Empty:SetActive(true)
  end
  local dialog = DialogManager.GetDialog("equip.equipchangenewdialog")
  if dialog then
    if dialog:GetEquipType() == EquipTypeEnum.WEAPON then
      dialog:Init(self._data:GetRoleId(), EquipTypeEnum.WEAPON, self._weaponKey)
    end
    if dialog:GetEquipType() == EquipTypeEnum.ARMOR then
      dialog:Init(self._data:GetRoleId(), EquipTypeEnum.ARMOR, self._armorKey)
    end
    if dialog:GetEquipType() == EquipTypeEnum.JEWELRY then
      dialog:Init(self._data:GetRoleId(), EquipTypeEnum.JEWELRY, self._jewelryKey)
    end
  end
end

function NewCharacterInfoDialog:SetArrowActive()
  local dialog = DialogManager.GetDialog("character.basecharacterlistalldialog")
  if not dialog and not self._tagFromBattleLoseDialog then
    dialog = DialogManager.GetDialog("dungeon.dungeonhud")
  end
  dialog = dialog or DialogManager.GetDialog("teamedit.teameditprewardialog")
  dialog = dialog or DialogManager.GetDialog("teamedit.teampresetmaindialog")
  if not dialog then
    self._leftArrow:SetActive(false)
    self._rightArrow:SetActive(false)
  end
end

function NewCharacterInfoDialog:OnJobClick()
  DialogManager.CreateSingletonDialog("character.characterjobdialog"):SetData(self._jobId)
end

function NewCharacterInfoDialog:OnElementImgClick()
  DialogManager.CreateSingletonDialog("character.characterelementinfodialog"):SetData(self._data:GetRoleId())
end

function NewCharacterInfoDialog:OnfashionBtnClicked()
  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "Dungeon" then
    return
  end
  if self._tag == Tag.Fashion then
    return
  end
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Clothe) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100210)
  else
    local cmd = LuaNetManager.CreateProtocol("protocol.item.cgetroleskin")
    cmd.roleId = self._data:GetId()
    cmd:Send()
  end
end

function NewCharacterInfoDialog:OnSkillDevelopBtnClicked()
  if self._inDungeon then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100101)
  elseif not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Role_SkillLevelUp) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100323)
  else
    DialogManager.CreateSingletonDialog("character.characterskilldialog"):SetData(self._data:GetId())
  end
end

function NewCharacterInfoDialog:OnSkillChangeBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("character.newcharskillchangedialog")
  if dialog then
    dialog:Init(self._data:GetRoleId())
  end
end

function NewCharacterInfoDialog:OnAnimationEnd()
end

function NewCharacterInfoDialog:RefreshFashionInfo()
  if self._tag == Tag.Break or self._tag == Tag.LevelUp then
    return
  end
  if self._tag ~= Tag.Fashion then
    self:GetRootWindow():SetAnimatorInteger("state", 7)
    self._tag = Tag.Fashion
  end
  CharFashionPart.RefreshFashionInfo()
  self:SelectFashion()
end

function NewCharacterInfoDialog:UpdateLive2D(skinData)
  if not skinData then
    return
  end
  CharFashionPart.UpdateInfo(skinData)
end

function NewCharacterInfoDialog:SetDragEnable(flag)
  if flag then
    if self._dragHandler then
      self._dragPanel:Unsubscribe_DragEvent(self._dragHandler)
      self._dragHandler = nil
    end
    if self._endDragHandler then
      self._dragPanel:Unsubscribe_EndDragEvent(self._endDragHandler)
      self._endDragHandler = nil
    end
    if self._cancelDragHandler then
      self._dragPanel:Unsubscribe_CancelDragEvent(self._cancelDragHandler)
      self._cancelDragHandler = nil
    end
    self._dragHandler = self._dragPanel:Subscribe_DragEvent(self.OnDrag, self)
    self._endDragHandler = self._dragPanel:Subscribe_EndDragEvent(self.OnEndDrag, self)
    self._cancelDragHandler = self._dragPanel:Subscribe_CancelDragEvent(self.OnEndDrag, self)
  else
    if self._dragHandler then
      self._dragPanel:Unsubscribe_DragEvent(self._dragHandler)
      self._dragHandler = nil
    end
    if self._endDragHandler then
      self._dragPanel:Unsubscribe_EndDragEvent(self._endDragHandler)
      self._endDragHandler = nil
    end
    if self._cancelDragHandler then
      self._dragPanel:Unsubscribe_CancelDragEvent(self._cancelDragHandler)
      self._cancelDragHandler = nil
    end
  end
end

function NewCharacterInfoDialog:OnDialogDestroy(notification)
  if notification.userInfo._dialogName == "character.newcharbreaksuccessdialog" then
    self._break_canRefresh = true
    CharBreakPart.RefreshBreakInfo()
  elseif notification.userInfo._dialogName == "character.newcharevolvesuccessdialog" then
    self._evolve_canRefresh = true
    CharEvolvePart.RefreshEvolveInfo()
  elseif notification.userInfo._dialogName == "newbattle.battleteachguidedialog" and NekoData.BehaviorManager.BM_Guide:IsCurrentGuide(2) then
    DialogManager.GetGroup("Guide"):SetObjectActive(true)
  end
end

function NewCharacterInfoDialog:OnRoleEvaluationBtnClicked()
  local protocol = LuaNetManager.CreateProtocol("protocol.card.cgetcomments")
  if protocol then
    protocol.roleId = self._data:GetId()
    protocol.commentType = 1
    protocol.lastIndex = 0
    protocol:Send()
  end
end

function NewCharacterInfoDialog:OnQuickSetBtnClicked()
  DialogManager.CreateSingletonDialog("equip.presetequipdialog"):SetData(self._data)
end

function NewCharacterInfoDialog:SetVoiceAndLines2(roleID, fashionID, tableKey, index, contentId, animation, playHandBook)
  if not self._data:CanPlayVoice() then
    return
  end
  if self._voiceId then
    return
  end
  if playHandBook then
    self._voiceId = NekoData.BehaviorManager.BM_Voice:PlayHandBook(roleID, tableKey, index)
  else
    self._voiceId = NekoData.BehaviorManager.BM_Voice:Play2(roleID, fashionID, tableKey, index)
  end
  if self._voiceId == nil then
    return
  end
  if contentId then
    self._linesText = TextManager.GetText(contentId)
  else
    self._linesText = NekoData.BehaviorManager.BM_Lines:GetLines2(roleID, fashionID, tableKey, index)
  end
  if animation and self._handler then
    local recorder = CEmotion:GetRecorder(animation)
    if recorder then
      self._live2D:PlayLive2DAnimation(recorder.Name, self._handler)
    else
      LogErrorFormat("SetVoiceAndLines2", "No AnimationName Width ID %s", tostring(animation))
    end
  end
  self._dialogPanel:SetActive(true)
  self._dialogPanel:PlayAnimation("CharDataMainDialogShow")
  self._dialogPanel_txt:SetText(self._linesText)
  local _, textheight = self._dialogPanel_txt:GetPreferredSize()
  if textheight > self._dialogPanel_txt_height then
    self._dialogPanel_txt:SetDeltaSize(self._dialogPanel_txt_width, textheight)
    self._dialogPanel:SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height + textheight - self._dialogPanel_txt_height)
  else
    self._dialogPanel_txt:SetDeltaSize(self._dialogPanel_txt_width, self._dialogPanel_txt_height)
    self._dialogPanel:SetDeltaSize(self._dialogPanel_width, self._dialogPanel_height)
  end
  if self._voiceId == 0 then
    local text = string.trim(self._linesText)
    if self._contentTimer then
      GameTimer.RemoveTask(self._contentTimer)
      self._contentTimer = nil
    end
    self._contentTimer = GameTimer.AddTask(utf8.len(text) * timeofword / 1000, -1, function()
      if self._tag ~= Tag.Nothing and not self._dialogPanel:IsActive() then
        self:SetVoiceIdNil(true)
      else
        self._dialogPanel:PlayAnimation("CharDataMainDialogHide")
      end
    end)
  end
end

function NewCharacterInfoDialog:SetVoiceIdNil(auto)
  if self._voiceId then
    if not auto then
      NekoData.BehaviorManager.BM_Voice:StopVoice(self._voiceId)
    end
    self._voiceId = nil
    self._dialogPanel:SetActive(false)
    if self._contentTimer then
      GameTimer.RemoveTask(self._contentTimer)
      self._contentTimer = nil
    end
  end
end

function NewCharacterInfoDialog:OnAnimationStateExit(handle, stateName, normalizedTime)
  if stateName == "CharDataMainDialogHide" then
    self:SetVoiceIdNil(true)
  end
end

function NewCharacterInfoDialog:OnCuePlayEnd(notification)
  if self._voiceId then
    local cueSheet, cueName = LuaAudioManager.GetCueSheetAndCueNameWithVoiceID(self._voiceId)
    if cueSheet == notification.userInfo.cueSheet and cueName == notification.userInfo.cueName then
      if self._tag ~= Tag.Nothing and not self._dialogPanel:IsActive() then
        self:SetVoiceIdNil(true)
      else
        self._dialogPanel:PlayAnimation("CharDataMainDialogHide")
      end
    end
  end
end

function NewCharacterInfoDialog:OnLiHuiClicked(onInitial)
  if self._tag == Tag.Nothing and not self._data:GetIsLeader() and self._data:CanPlayVoice() then
    local roleID = self._picTouchData[3]
    local fashionID = self._picTouchData[4]
    local thisList
    if onInitial then
      thisList = self._picTouchData[1]
    else
      thisList = self._picTouchData[2]
    end
    local randomForPicTouch = math.random(1, #thisList)
    local thisVal = thisList[randomForPicTouch]
    self:SetVoiceAndLines2(roleID, fashionID, thisVal[1], thisVal[2])
  end
end

function NewCharacterInfoDialog:OnLive2DPointerDown(posName, roleID, fashionID, touchRecordList)
  if self._tag ~= Tag.Nothing or self._data:GetIsLeader() then
    return
  end
  if self._voiceId then
    return
  end
  local touchRecord
  posName = string.trim(posName)
  for _, tempRecord in ipairs(touchRecordList) do
    if string.trim(tempRecord.area) == posName then
      touchRecord = tempRecord
      break
    end
  end
  if touchRecord then
    local ramdomNum = math.random(1, #touchRecord.state)
    local animaState = touchRecord.state[ramdomNum]
    self._live2D:SetLive2DAnimatorTrigger(self._handler, animaState)
    local voiceAndLinesIDSplit = string.split(touchRecord.volume_id[ramdomNum], ",")
    if 1 < #voiceAndLinesIDSplit then
      self:SetVoiceAndLines2(roleID, fashionID, voiceAndLinesIDSplit[1], tonumber(voiceAndLinesIDSplit[2]))
    else
      self:SetVoiceAndLines2(roleID, fashionID, voiceAndLinesIDSplit[1])
    end
  end
end

function NewCharacterInfoDialog:AddNewModal(dialog)
  for k, v in pairs(self._effectHandlers) do
    self._levelUpEffect:ReleaseEffect(k)
    self._effectHandlers[k] = nil
  end
  if self._effectHandler2 and self._effectHandler2 ~= 0 then
    self._levelUpLongPressEffect:ReleaseEffect(self._effectHandler2)
    self._effectHandler2 = 0
  end
  if table.keyof(ShowByModalDialogs, dialog._dialogName) then
    self._rootWindow:SetActive(true)
  else
    self._rootWindow:SetActive(false)
  end
end

function NewCharacterInfoDialog:OnSuitEffectClicked()
  local suitMap = self._data:GetSuitSkillsMap()
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

function NewCharacterInfoDialog:OnRefreshEquip()
  self:RefreshEquipPanel()
end

function NewCharacterInfoDialog:OnUniqueEquipPanelClick()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.UniqueEquip) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100376)
    return
  end
  local uniqueEquipId = self._data:GetUniqueEquipId()
  if uniqueEquipId then
    DialogManager.CreateSingletonDialog("uniqueequip.uniqueequipdialog"):SetData(uniqueEquipId, true)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100369)
  end
end

function NewCharacterInfoDialog:SetOnceClose()
  self._once = true
end

function NewCharacterInfoDialog:JumpAndSetSelectFashion(role, fashionID)
  self:SetOnceClose()
  self:Refresh(role)
  self:OnfashionBtnClicked()
  self._selelctFashionId = fashionID
end

function NewCharacterInfoDialog:SelectFashion()
  if self._selelctFashionId then
    for k, v in ipairs(self._fashionList) do
      if v.skinID == self._selelctFashionId and self._fashionFrame then
        self._fashionFrame:MoveRightToIndex(k)
        local logicCell = self._fashionFrame:GetLogicCell(k)
        if not logicCell._cell then
          self._frame:GetCellDialog(logicCell)
          logicCell._cell._delegate = self
          logicCell._cell._cellData = logicCell._data
          logicCell._cell:RefreshCell(logicCell._data)
        end
        logicCell._cell:OnCellClick()
      end
    end
  end
  self._selelctFashionId = nil
end

function NewCharacterInfoDialog:OnCharUpGradeClick()
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.RuneAdvancement) then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100480)
    return
  end
  local csend = LuaNetManager.CreateProtocol("protocol.login.copenruneadvanced")
  csend.roleId = self._data:GetRoleId()
  csend:Send()
end

return NewCharacterInfoDialog
