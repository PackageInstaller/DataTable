local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CWordColor = BeanManager.GetTableByName("message.cwordcolor")
local CVocationCfgTable = BeanManager.GetTableByName("role.cvocationcfg")
local UIManager = CS.PixelNeko.UI.UIManager
local CharacterJobDialog = class("CharacterJobDialog", Dialog)
CharacterJobDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterJobDialog.AssetName = "JobDetail"

function CharacterJobDialog:Ctor(...)
  CharacterJobDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function CharacterJobDialog:OnCreate()
  self._field = self:GetChild("Back/Frame")
  self._back = self:GetChild("Back")
  self._frame = GridFrame.Create(self._field, self, true, 2, false)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

function CharacterJobDialog:OnDestroy()
  self._frame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function CharacterJobDialog:SetData(jobId)
  self._data = {}
  for _, id in ipairs(CVocationCfgTable:GetAllIds()) do
    local record = CVocationCfgTable:GetRecorder(id)
    if jobId == id then
      local wordcolor = CWordColor:GetRecorder(34).wordcolor
      local str = TextManager.GetText(CStringRes:GetRecorder(1115).msgTextID)
      str = string.gsub(str, "%$parameter1%$", tostring(wordcolor))
      table.insert(self._data, {
        imageId = record.imgDescribeBlue,
        text = string.gsub(str, "%$parameter2%$", TextManager.GetText(record.nameTextID)),
        detail = string.gsub(str, "%$parameter2%$", TextManager.GetText(record.vocationDescribeTextID))
      })
    else
      table.insert(self._data, {
        imageId = record.imgDescribe,
        text = TextManager.GetText(record.nameTextID),
        detail = TextManager.GetText(record.vocationDescribeTextID)
      })
    end
  end
  self._frame:ReloadAllCell()
end

function CharacterJobDialog:NumberOfCell(frame, index)
  return #self._data
end

function CharacterJobDialog:CellAtIndex(frame, index)
  return "character.characterjobcell"
end

function CharacterJobDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function CharacterJobDialog:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function CharacterJobDialog:OnBackBtnClicked()
  self:Destroy()
end

return CharacterJobDialog
