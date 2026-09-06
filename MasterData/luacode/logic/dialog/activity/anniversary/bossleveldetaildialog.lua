local timeutils = require("logic.utils.timeutils")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local ColumnNum = 2
local Num = 4
local CBattleInfoTable = BeanManager.GetTableByName("battle.cbattleinfo")
local CMonsterConfigTable = BeanManager.GetTableByName("npc.cmonsterconfig")
local CAnniversarylevel = BeanManager.GetTableByName("dungeonselect.canniversarylevel")
local CAnniversaryDiffculty = BeanManager.GetTableByName("dungeonselect.canniversarydiffculty")
local CNPCShape = BeanManager.GetTableByName("npc.cnpcshape")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CRoleLevelCfgTable = BeanManager.GetTableByName("role.crolelevelcfg")
local LevelStateEnum = LuaNetManager.GetBeanDef("protocol.battle.activitybattlenode")
local BossLevelDetailDialog = class("BossLevelDetailDialog", Dialog)
BossLevelDetailDialog.AssetBundleName = "ui/layouts.activity1yearanniversary"
BossLevelDetailDialog.AssetName = "Activity1YearAnniversaryBossDetail2"

function BossLevelDetailDialog:Ctor(...)
  BossLevelDetailDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function BossLevelDetailDialog:OnCreate()
  self._nodes = {
    daily = {},
    normal = {}
  }
  for k, v in pairs(self._nodes) do
    local child
    if k == "daily" then
      child = "Left"
      v.leftTimeTxt = self:GetChild("Back/Panel/" .. child .. "/TimeTxt")
      v.leftBlood_txt = self:GetChild("Back/Panel/" .. child .. "/BloodTxt")
      v.leftBlood_progress = self:GetChild("Back/Panel/" .. child .. "/Loading/BackGround/Progress")
      v.leftBlood_num = self:GetChild("Back/Panel/" .. child .. "/Loading/Num")
      v.costSpirit = self:GetChild("Back/Panel/" .. child .. "/CostBack/Txt2")
      v.costSpirit_red = self:GetChild("Back/Panel/" .. child .. "/CostBack/Txt2Red")
      v.awardTxt = self:GetChild("Back/Panel/" .. child .. "/LineTxt")
      v.anchor_x, v.anchor_y = self:GetChild("Back/Panel/" .. child):GetAnchoredPosition()
      self:GetChild("Back/Panel/" .. child .. "/Title"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2019))
      self:GetChild("Back/Panel/" .. child .. "/LineTxt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2021))
      self:GetChild("Back/Panel/" .. child .. "/CostBack/Txt1"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2023))
    elseif k == "normal" then
      child = "Right"
      v.tips = self:GetChild("Back/Panel/" .. child .. "/Tips")
      v.recommendLevel_showLv = self:GetChild("Back/Panel/" .. child .. "/Detail/Txt2")
      v.recommendLevel_breakLvNum = self:GetChild("Back/Panel/" .. child .. "/Detail/BreakNumTxt")
      v.difficultyTxt = self:GetChild("Back/Panel/" .. child .. "/DifficultyLevel")
      self:GetChild("Back/Panel/" .. child .. "/Title"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2020))
      self:GetChild("Back/Panel/" .. child .. "/LineTxt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2022))
      self:GetChild("Back/Panel/" .. child .. "/Tips"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2024))
    end
    v.panel = self:GetChild("Back/Panel/" .. child)
    v.backImage = self:GetChild("Back/Panel/" .. child .. "/BackImage")
    v.title = self:GetChild("Back/Panel/" .. child .. "/Title")
    v.model = self:GetChild("Back/Panel/" .. child .. "/Model")
    v.lineTxt = self:GetChild("Back/Panel/" .. child .. "/LineTxt")
    v.effect = self:GetChild("Back/Panel/" .. child .. "/Effect")
    v.goBtn = self:GetChild("Back/Panel/" .. child .. "/GoBtn")
    v.goBtn_txt = self:GetChild("Back/Panel/" .. child .. "/GoBtn/_Text")
    v.rewardPanel = self:GetChild("Back/Panel/" .. child .. "/CellPanel")
    v.rewardFrame = TableFrame.Create(v.rewardPanel, self, false, false)
    v.rewardFrame_width, v.rewardFrame_height = v.rewardPanel:GetRectSize()
    v.rewardFrame_anchoredx, v.rewardFrame_anchoredy = v.rewardPanel:GetAnchoredPosition()
    v.goBtn:Subscribe_PointerClickEvent(function()
      self:OnGoBtnClicked(k)
    end)
    v.rewardList = {}
  end
  self._closeBtn = self:GetChild("Back/Panel/CloseBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnRootWindowClicked, self)
end

function BossLevelDetailDialog:OnDestroy()
  for k, v in pairs(self._nodes) do
    v.rewardFrame:Destroy()
  end
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function BossLevelDetailDialog:Init(delegate)
  self._delegate = delegate
  for k, v in pairs(self._nodes) do
    while v.rewardList[#v.rewardList] do
      table.remove(v.rewardList, #v.rewardList)
    end
    local hideNormal, record, npcShapeRecorder, diffcultyRecord
    if k == "daily" then
      v.data = NekoData.BehaviorManager.BM_Anniversary:GetBossLevelInfo(self._delegate._type, 1)
      record = CAnniversarylevel:GetRecorder(v.data.levelId)
      npcShapeRecorder = CNPCShape:GetRecorder(record.monsterformid)
      diffcultyRecord = CAnniversaryDiffculty:GetRecorder(record.difficulty)
      local battleRecord = CBattleInfoTable:GetRecorder(record.battleid)
      local monsterRecoder = CMonsterConfigTable:GetRecorder(battleRecord.bossID)
      local totalHp = 0
      for i, hp in ipairs(string.split(monsterRecoder.hpConstant, ";")) do
        totalHp = totalHp + tonumber(hp)
      end
      local strId, par
      local lefttime = v.data.leftTime // 1000
      if lefttime < 3600 then
        strId = 2027
        par = lefttime // 60
      else
        strId = 2026
        par = lefttime // 3600
      end
      v.leftTimeTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(strId, {par}))
      v.leftBlood_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2025))
      v.leftBlood_progress:SetFillAmount(v.data.leftHP / 100)
      v.leftBlood_num:SetText(v.data.leftHP .. "%")
      v.costSpirit:SetText(record.spirit)
      v.costSpirit_red:SetText(record.spirit)
      v.costSpirit:SetActive(record.spirit <= NekoData.BehaviorManager.BM_Currency:GetSpirit())
      v.costSpirit_red:SetActive(record.spirit > NekoData.BehaviorManager.BM_Currency:GetSpirit())
      if 0 >= v.data.leftHP then
        v.goBtn:SetInteractable(false)
        v.goBtn_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2032))
      else
        v.goBtn:SetInteractable(true)
        v.goBtn_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2031))
      end
      if v.data.status == LevelStateEnum.PASSED then
        v.awardTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2021))
        for i, value in ipairs(v.data.normalItems) do
          table.insert(v.rewardList, {tag = "Normal", data = value})
        end
      else
        v.awardTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2022))
        local itemList
        if record.difficulty == DataCommon.Anniversary.Type.Easy then
          itemList = string.split(BeanManager.GetTableByName("dungeonselect.canniversaryspecialcfg"):GetRecorder(5).type, ";")
        else
          itemList = string.split(BeanManager.GetTableByName("dungeonselect.canniversaryspecialcfg"):GetRecorder(6).type, ";")
        end
        for i, itemId in ipairs(itemList) do
          table.insert(v.rewardList, {
            tag = "First",
            data = {
              id = tonumber(itemId)
            }
          })
        end
      end
    elseif k == "normal" then
      v.data = NekoData.BehaviorManager.BM_Anniversary:GetBossLevelInfo(self._delegate._type, 2)
      hideNormal = not v.data
      if hideNormal then
        v.panel:SetActive(false)
        self._nodes.daily.panel:SetAnchoredPosition(0, 0)
      else
        record = CAnniversarylevel:GetRecorder(v.data.levelId)
        npcShapeRecorder = CNPCShape:GetRecorder(record.monsterformid)
        diffcultyRecord = CAnniversaryDiffculty:GetRecorder(record.difficulty)
        self._nodes.daily.panel:SetAnchoredPosition(self._nodes.daily.anchor_x, self._nodes.daily.anchor_y)
        v.panel:SetActive(true)
        v.tips:SetText(TextManager.GetText(diffcultyRecord.bosspagetxt))
        v.difficultyTxt:SetText(NekoData.BehaviorManager.BM_Game:GetBossRushDifficultyColorStr(v.data.bossLevel, "Anniversary"))
        v.goBtn_txt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2031))
        for i, value in ipairs(v.data.firstItems) do
          table.insert(v.rewardList, {tag = "First", data = value})
        end
      end
    end
    if not hideNormal then
      v.rewardFrame:ReloadAllCell()
      local cellPanelWidth = v.rewardFrame_width / Num * #v.rewardList
      local cellPanelHeight = v.rewardFrame:GetTotalLength()
      v.rewardPanel:SetSize(0, cellPanelWidth, 0, cellPanelHeight)
      v.rewardPanel:SetAnchoredPosition(v.rewardFrame_anchoredx, v.rewardFrame_anchoredy)
      v.rewardFrame:ReloadAllCell()
      local image = CImagePathTable:GetRecorder(diffcultyRecord.bosspage) or DataCommon.DefaultImageAsset
      v.backImage:SetSprite(image.assetBundle, image.assetName)
      if v.handler ~= 0 then
        v.model:ReleaseModel(v.handler)
        v.handler = 0
      end
      v.handler = v.model:AddModelSync(npcShapeRecorder.assetBundleName, npcShapeRecorder.prefabNameUI)
    end
  end
end

local function GetNodes(self, frame)
  for k, v in pairs(self._nodes) do
    if v.rewardFrame == frame then
      return v
    end
  end
end

function BossLevelDetailDialog:NumberOfCell(frame, index)
  local nodes = GetNodes(self, frame)
  return #nodes.rewardList
end

function BossLevelDetailDialog:CellAtIndex(frame, index)
  return "activity.anniversary.bossleveldetailrewardcell"
end

function BossLevelDetailDialog:DataAtIndex(frame, index)
  local nodes = GetNodes(self, frame)
  return nodes.rewardList[index]
end

function BossLevelDetailDialog:OnGoBtnClicked(type)
  if self._nodes[type].data then
    self._delegate:OnGoBtnClicked(self._nodes[type].data.levelId)
  end
end

function BossLevelDetailDialog:OnBackBtnClicked()
  self._delegate:SelectLevelById(nil)
end

function BossLevelDetailDialog:OnRootWindowClicked()
end

return BossLevelDetailDialog
