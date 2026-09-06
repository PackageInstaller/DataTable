local TableFrame = require("framework.ui.frame.table.tableframe")
local CEquipSuit = BeanManager.GetTableByName("equip.cequipsuit")
local UIManager = CS.PixelNeko.UI.UIManager
local EquipSuitTipDialog = class("EquipSuitTipDialog", Dialog)
EquipSuitTipDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
EquipSuitTipDialog.AssetName = "EquipSuitTips"

function EquipSuitTipDialog:Ctor(...)
  EquipSuitTipDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function EquipSuitTipDialog:OnCreate()
  self._back = self:GetChild("Back")
  self._panel = self:GetChild("Back/Frame")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function EquipSuitTipDialog:OnDestroy()
  self._frame:Destroy()
end

function EquipSuitTipDialog:SetData(data)
  self._downDataList = {}
  for k, v in ipairs(data) do
    local suitId = v.suitId
    local skillIds = v.skillIds
    local suitRecorder = CEquipSuit:GetRecorder(suitId)
    local temp = {}
    temp.tag = "SuitInfo"
    temp.suitName = suitRecorder.suitName
    temp.suitImg = suitRecorder.suitImg
    table.insert(self._downDataList, temp)
    local skillIDs = suitRecorder.suitSkillID
    for i, v in ipairs(skillIDs) do
      if v ~= 0 then
        temp = {}
        temp.tag = "SuitSkill"
        temp.count = i
        temp.skillID = v
        for i, skillId in ipairs(skillIds) do
          if temp.skillID == skillId then
            temp.takeEffect = true
          end
        end
        table.insert(self._downDataList, temp)
      end
    end
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function EquipSuitTipDialog:NumberOfCell(frame)
  return #self._downDataList
end

function EquipSuitTipDialog:CellAtIndex(frame, index)
  if self._downDataList[index].tag == "SuitInfo" then
    return "character.equipsuittipssuitinfocell"
  elseif self._downDataList[index].tag == "SuitSkill" then
    return "character.equipsuittipssuitskillcell"
  end
end

function EquipSuitTipDialog:DataAtIndex(frame, index)
  return self._downDataList[index]
end

function EquipSuitTipDialog:ShouldLengthChange()
  return true
end

function EquipSuitTipDialog:OnEveryWhereClick(args)
  local x = args.userInfo.eventData.position.x
  local y = args.userInfo.eventData.position.y
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, x, y) then
    self:OnBackBtnClicked()
  end
end

function EquipSuitTipDialog:OnBackBtnClicked()
  self:Destroy()
end

return EquipSuitTipDialog
