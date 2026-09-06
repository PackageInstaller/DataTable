local LevelStateEnum = LuaNetManager.GetBeanDef("protocol.battle.activitybattlenode")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CAnniversarylevel = BeanManager.GetTableByName("dungeonselect.canniversarylevel")
local FirstLevelId = CAnniversarylevel:GetAllIds()[1]
local EffectRecord = BeanManager.GetTableByName("dungeonselect.canniversaryspecialcfg"):GetRecorder(2)
local LevelCell = class("LevelCell", Dialog)
LevelCell.AssetBundleName = "ui/layouts.activity1yearanniversary"
LevelCell.AssetName = "Activity1YearAnniversaryCell"

function LevelCell:Ctor(...)
  LevelCell.super.Ctor(self, ...)
  self._bm = NekoData.BehaviorManager.BM_Anniversary
end

function LevelCell:OnCreate()
  self:GetChild("1"):SetActive(true)
  self._normal = self:GetChild("1/LevelBack")
  self._normal_icon = self:GetChild("1/LevelBack/LevelIn")
  self._normal_name = self:GetChild("1/LevelBack/Back/Name")
  self._select = self:GetChild("1/SelectBack")
  self._select_icon = self:GetChild("1/SelectBack/LevelIn")
  self._select_name = self:GetChild("1/SelectBack/Back/Name")
  self._limit = self:GetChild("1/Lock")
  self._limit_txt = self:GetChild("1/Lock/Txt")
  self._new = self:GetChild("1/New")
  self._title = self:GetChild("1/Title")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function LevelCell:OnDestroy()
  if self._handler then
    NekoData.BehaviorManager.BM_Game:DestroyGuideClickEffectDialog(self._handler)
    self._handler = nil
  end
end

function LevelCell:SetData(delegate, data)
  self._delegate = delegate
  self._data = data
  self._levelId = data.data.levelId
  self._status = data.data.status
  if self._status == LevelStateEnum.LOCK then
    self._normal:SetActive(true)
    self._select:SetActive(false)
    self._limit:SetActive(false)
    self._new:SetActive(false)
  else
    if self._levelId == self._delegate._selectLevelId then
      self._normal:SetActive(false)
      self._select:SetActive(true)
    else
      self._normal:SetActive(true)
      self._select:SetActive(false)
    end
    self._limit:SetActive(false)
    if self._status ~= LevelStateEnum.PASSED then
      self._new:SetActive(true)
      if self._status == LevelStateEnum.UNSTART then
        self._limit:SetActive(true)
        local levelStartStr = string.sub(data.record.levelstart, 6, 16)
        local monthStr = string.sub(levelStartStr, 1, 2)
        local dayStr = string.sub(levelStartStr, 4, 5)
        local hourStr = string.sub(levelStartStr, 7, -1)
        local str = string.gsub(TextManager.GetText(1900882), "%$parameter1%$", tonumber(monthStr))
        str = string.gsub(str, "%$parameter2%$", tonumber(dayStr))
        str = string.gsub(str, "%$parameter3%$", hourStr)
        self._limit_txt:SetText(str)
      end
    else
      self._new:SetActive(false)
    end
  end
  self._title:SetText(TextManager.GetText(data.record.leveltitle))
  self._normal_name:SetText(TextManager.GetText(data.record.levelname))
  self._select_name:SetText(TextManager.GetText(data.record.levelname))
  local imageRecord = CImagePathTable:GetRecorder(data.record.levelpicselect) or DataCommon.DefaultImageAsset
  self._select_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = CImagePathTable:GetRecorder(data.record.levelpicgrey) or DataCommon.DefaultImageAsset
  self._normal_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if self._bm:IsPlayGuideClickEffect() and self._levelId == FirstLevelId then
    if not self._handler and EffectRecord and EffectRecord.type ~= "" and EffectRecord.type ~= "0" then
      self._handler = NekoData.BehaviorManager.BM_Game:CreateGuideClickEffectDialog(self._rootWindow, tonumber(EffectRecord.type))
    end
  elseif self._handler then
    NekoData.BehaviorManager.BM_Game:DestroyGuideClickEffectDialog(self._handler)
    self._handler = nil
  end
end

function LevelCell:OnCellClicked()
  self._delegate:SelectLevelById(self._levelId)
end

function LevelCell:OnEvent(eventName)
  if eventName == "SetSelected" then
    if self._levelId == self._delegate._selectLevelId then
      self._normal:SetActive(false)
      self._select:SetActive(true)
      self:PlayAnimation()
    else
      self._normal:SetActive(true)
      self._select:SetActive(false)
    end
  end
end

function LevelCell:PlayAnimation()
  local nodeStr = tostring(self._data.record.levelanim)
  self._rootWindow:PlayAnimation("ActivityStarCell1")
end

return LevelCell
