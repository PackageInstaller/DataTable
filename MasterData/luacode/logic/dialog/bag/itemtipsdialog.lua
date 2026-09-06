local Item = require("logic.manager.experimental.types.item")
local UniqueEquip = require("logic.manager.experimental.types.uniqueequip")
local UIManager = CS.PixelNeko.UI.UIManager
local UIRootOffsetMax = UIManager.GetUiRootOffsetMax()
local TableFrame = require("framework.ui.frame.table.tableframe")
local ItemTipsDialog = class("ItemTipsDialog", Dialog)
ItemTipsDialog.AssetBundleName = "ui/layouts.bag"
ItemTipsDialog.AssetName = "ItemTipsNew"
local SecToDay = 86400
local SecToHour = 3600
local SecToMin = 60

local function GetDelTimeStr(ms)
  local sec = ms // 1000
  local str
  if sec > SecToDay * 3 then
    str = TextManager.GetText(700685)
    str = string.gsub(str, "%$parameter1%$", math.floor(os.date("!%d", sec) - 1))
    str = string.gsub(str, "%$parameter2%$", os.date("!%H", sec))
  elseif sec > SecToDay then
    str = TextManager.GetText(700695)
    str = string.gsub(str, "%$parameter1%$", math.floor(os.date("!%d", sec) - 1))
    str = string.gsub(str, "%$parameter2%$", os.date("!%H", sec))
  elseif sec > SecToHour then
    str = TextManager.GetText(700686)
    str = string.gsub(str, "%$parameter1%$", os.date("!%H", sec))
    str = string.gsub(str, "%$parameter2%$", os.date("!%M", sec))
  elseif sec > SecToMin then
    str = TextManager.GetText(700687)
    str = string.gsub(str, "%$parameter1%$", os.date("!%M", sec))
  else
    str = TextManager.GetText(700688)
  end
  return str
end

local function GetDelTimeStr2(ms)
  local sec = ms // 1000
  local min = sec // 60
  local hour = min // 60
  local day = hour // 24
  local str
  if sec > SecToDay * 3 then
    str = TextManager.GetText(700685)
    str = string.gsub(str, "%$parameter1%$", tostring(day))
    str = string.gsub(str, "%$parameter2%$", tostring(hour - day * 24))
  elseif sec > SecToDay then
    str = TextManager.GetText(700695)
    str = string.gsub(str, "%$parameter1%$", tostring(day))
    str = string.gsub(str, "%$parameter2%$", tostring(hour - day * 24))
  elseif sec > SecToHour then
    str = TextManager.GetText(700686)
    str = string.gsub(str, "%$parameter1%$", tostring(hour))
    str = string.gsub(str, "%$parameter2%$", tostring(min - hour * 60))
  elseif sec > SecToMin then
    str = TextManager.GetText(700687)
    str = string.gsub(str, "%$parameter1%$", tostring(min))
  else
    str = TextManager.GetText(700688)
  end
  return str
end

function ItemTipsDialog:Ctor(...)
  ItemTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._downDataList = {}
  self._delTime = nil
  self.itemKey = nil
  self._canJump = true
  self._inCourtYard = ""
end

function ItemTipsDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._icon = self:GetChild("Back/ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("Back/ItemCell/_BackGround/Frame")
  self._Select = self:GetChild("Back/ItemCell/_BackGround/Select")
  self._count = self:GetChild("Back/ItemCell/_Count")
  self._itemName = self:GetChild("Back/ItemName")
  self._itemTypeName = self:GetChild("Back/ItemType")
  self._num = self:GetChild("Back/Num/Num")
  self._panel = self:GetChild("Back/Frame")
  self._itemBG = self:GetChild("Back/ItemBack")
  self._time = self:GetChild("Back/time")
  self._timeRemainTxt = self:GetChild("Back/time/TimeRemain")
  self._explanationTxt = self:GetChild("Back/time/explanation")
  self._frame = TableFrame.Create(self._panel, self, true, true, false)
  self._frame:SetMargin(15, 0)
  self._Select:SetActive(false)
  self._count:SetActive(false)
  self._width, self._height = self:GetRootWindow():GetRectSize()
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  LuaNotificationCenter.AddObserver(self, self.ItemRemove, Common.n_ItemRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.OnItemNumModify, Common.n_ItemNumModify, nil)
  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCity" then
    self._canJump = false
    local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
    if controller and controller._baseMainFSM and controller._responseMouseClick then
      self._canJump = true
    end
  end
  if self._canJump then
    local dialog = DialogManager.GetDialog("dungeon.dungeonaccountdialog") or DialogManager.GetDialog("bag.itemaccountdialog") or DialogManager.GetDialog("dungeon.dungeonfirstawarddialog") or DialogManager.GetDialog("dungeon.dungeonconquestdialog") or DialogManager.GetDialog("alchemy.productaccountdialog") or DialogManager.GetDialog("resonance.resonancedialog")
    if not dialog then
      if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "CourtYard" then
        self._inCourtYard = GlobalGameFSM:GetCurrentState()
      elseif GlobalGameFSM and GlobalGameFSM:GetCurrentState() ~= "MainCity" then
        self._canJump = false
      end
    else
      self._canJump = false
    end
  end
end

function ItemTipsDialog:OnDestroy()
  self._frame:Destroy()
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function ItemTipsDialog:Init(data, bFromBagCell)
  local imageRecord = data.item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = data.item:GetPinJiImage()
  self._itemFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local id = data.item:GetID()
  if string.sub(id, 1, 2) == "35" then
    if id == DataCommon.AgCoinID then
      self._num:SetNumber(NekoData.BehaviorManager.BM_Activity:GetManager(2):GetDreamCoins(), true)
    elseif id == DataCommon.TimeCrystal then
      self._num:SetNumber(NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID):GetDreamCoins(), true)
    else
      self._num:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(id), true)
    end
  else
    self._num:SetNumber(NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(id), true)
  end
  imageRecord = data.item:GetItemTipBackGroudImg()
  self._itemBG:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._itemName:SetText(data.item:GetName())
  self._itemTypeName:SetText(data.item:GetTypeName())
  self._downDataList = {}
  local ways = data.item:GetGainWays()
  if ways and 0 < #ways then
    table.insert(self._downDataList, {tag = "Gain", value = ways})
  end
  if data.item:IsUniqueEquip() then
    local uniqueEquipItem = UniqueEquip.Create(id)
    table.insert(self._downDataList, {
      tag = "UniqueEquipSkill",
      value = NekoData.BehaviorManager.BM_Message:GetUniqueEquipSkillDescribe(uniqueEquipItem:GetCurShowSkillIdByLevel(1))
    })
    local initAttrs = uniqueEquipItem:GetInitAttrs()
    local list = {}
    for k, v in pairs(initAttrs) do
      table.insert(list, {attrId = k, attrValue = v})
    end
    table.insert(self._downDataList, {
      tag = "UniqueEquipAttr",
      value = list
    })
  else
    table.insert(self._downDataList, {
      tag = "Describe",
      value = data.item:GetDestribe()
    })
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
  if bFromBagCell then
    self._item = data.item
    self.itemKey = self._item:GetKey()
  end
  if self._task then
    ServerGameTimer.RemoveTask(self._task)
    self._task = nil
  end
  if data.item:GetTermTime() and 0 < data.item:GetTermTime() then
    self._time:SetActive(true)
    if self._item then
      self._delTime = data.item:GetDelTime()
      self._task = ServerGameTimer.AddTask(0, 1, function()
        self:SetTime(self._item)
      end, nil)
    else
      local str = TextManager.GetText(700694)
      local termTime = data.item:GetTermTime()
      termTime = math.floor(os.date("!%j", termTime))
      str = string.gsub(str, "%$parameter1%$", termTime)
      self._timeRemainTxt:SetText(str)
    end
    self._explanationTxt:SetActive(data.item:GetID() ~= DataCommon.SpriteEvidence)
  else
    self._time:SetActive(false)
  end
end

function ItemTipsDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function ItemTipsDialog:OnBackBtnClicked()
  self:Destroy()
end

function ItemTipsDialog:SetTipsPosition(cell_width, cell_height, cellScreenPosition)
end

function ItemTipsDialog:UpdatePosition(anchored)
end

function ItemTipsDialog:SetTime(item)
  local time = self._delTime - ServerGameTimer.GetServerTime()
  if 0 < time then
    if item and item:GetID() == DataCommon.SpriteEvidence then
      self._timeRemainTxt:SetText(GetDelTimeStr2(time))
    else
      self._timeRemainTxt:SetText(GetDelTimeStr(time))
    end
  else
  end
end

function ItemTipsDialog:ShouldLengthChange()
  return true
end

function ItemTipsDialog:NumberOfCell(frame, index)
  return #self._downDataList
end

function ItemTipsDialog:CellAtIndex(frame, index)
  if self._downDataList[index].tag == "Describe" then
    return "bag.itemtipsdescribecell"
  elseif self._downDataList[index].tag == "Gain" then
    return "bag.itemtipsgaincell"
  elseif self._downDataList[index].tag == "UniqueEquipSkill" then
    return "bag.itemtipsuniqueequipskillcell"
  elseif self._downDataList[index].tag == "UniqueEquipAttr" then
    return "bag.itemtipsuniqueequipattrpanelcell"
  end
end

function ItemTipsDialog:DataAtIndex(frame, index)
  return self._downDataList[index]
end

function ItemTipsDialog:ReloadGainCell(tag)
  for i, v in ipairs(self._downDataList) do
    if v.tag == tag then
      self._frame:ReloadCellsAtIndex({i})
      break
    end
  end
end

function ItemTipsDialog:OnItemNumModify(notification)
  if self._item:GetKey() == notification.userInfo.itemKey then
    self._delTime = self._item:GetDelTime()
    local id = self._item:GetID()
    if string.sub(id, 1, 2) == "35" then
      self._num:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(id), true)
    else
      self._num:SetNumber(NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(id), true)
    end
    if self._task then
      ServerGameTimer.RemoveTask(self._task)
      self._task = nil
    end
    if self._item:GetTermTime() > 0 then
      self._time:SetActive(true)
      if self._item then
        self._task = ServerGameTimer.AddTask(0, 1, function()
          self:SetTime(self._item)
        end, nil)
      else
        local str = TextManager.GetText(700694)
        local termTime = self._item:GetTermTime()
        termTime = math.floor(os.date("!%j", termTime))
        str = string.gsub(str, "%$parameter1%$", termTime)
        self._timeRemainTxt:SetText(str)
      end
    else
      self._time:SetActive(false)
    end
  end
end

function ItemTipsDialog:ItemRemove(notification)
  if self.itemKey == notification.userInfo.itemKey then
    NekoData.BehaviorManager.BM_Message:AddConfirmDialog(TextManager.GetText(700689), nil)
    self:Destroy()
  end
end

return ItemTipsDialog
