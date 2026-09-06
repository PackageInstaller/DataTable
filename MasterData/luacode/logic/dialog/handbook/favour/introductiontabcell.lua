local CCardRoleBookCfg = BeanManager.GetTableByName("handbook.ccardroleconfig_handbook")
local CRaceCfg = BeanManager.GetTableByName("role.cracecfg")
local CAffiliationCfg = BeanManager.GetTableByName("handbook.caffiliation_handbook")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local IntroductionTabCell = class("IntroductionTabCell", Dialog)
IntroductionTabCell.AssetBundleName = "ui/layouts.tujian"
IntroductionTabCell.AssetName = "CharStoryFrame1"

function IntroductionTabCell:Ctor(...)
  IntroductionTabCell.super.Ctor(self, ...)
  self._dataList = {}
end

function IntroductionTabCell:OnCreate()
  self._frame = TableFrame.Create(self._rootWindow, self, true, true, true)
end

function IntroductionTabCell:OnDestroy()
  self._frame:Destroy()
end

function IntroductionTabCell:RefreshTabCell(refreshData)
  if not self._init or refreshData then
    self._init = true
    while self._dataList[#self._dataList] do
      table.remove(self._dataList, #self._dataList)
    end
    local roleId = self._delegate._delegate._role:GetId()
    local roleBookCfg = CCardRoleBookCfg:GetRecorder(roleId)
    if not roleBookCfg then
      return
    end
    table.insert(self._dataList, {
      title = TextManager.GetText(502723),
      content = TextManager.GetText(roleBookCfg.sexTextID)
    })
    table.insert(self._dataList, {
      title = TextManager.GetText(502724),
      content = roleBookCfg.age
    })
    table.insert(self._dataList, {
      title = TextManager.GetText(502725),
      content = roleBookCfg.height
    })
    table.insert(self._dataList, {
      title = TextManager.GetText(502727),
      content = TextManager.GetText(roleBookCfg.birthday)
    })
    local str
    if roleBookCfg.affiliation == 0 then
      str = TextManager.GetText(CStringRes:GetRecorder(1216).msgTextID)
    else
      local affiliationcfg = CAffiliationCfg:GetRecorder(roleBookCfg.affiliation)
      str = TextManager.GetText(affiliationcfg.nameTextID)
    end
    table.insert(self._dataList, {
      title = TextManager.GetText(502728),
      content = str
    })
    table.insert(self._dataList, {
      title = TextManager.GetText(502729),
      content = TextManager.GetText(roleBookCfg.hobbyTextID)
    })
    self._frame:ReloadAllCell()
  end
  self._frame:MoveToTop()
end

function IntroductionTabCell:NumberOfCell(frame)
  return #self._dataList
end

function IntroductionTabCell:CellAtIndex(frame, index)
  return "handbook.favour.introductioncell"
end

function IntroductionTabCell:DataAtIndex(frame, index)
  return self._dataList[index]
end

function IntroductionTabCell:ShouldLengthChange()
  return true
end

return IntroductionTabCell
