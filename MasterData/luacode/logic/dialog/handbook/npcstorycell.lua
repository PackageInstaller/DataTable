local CstringCfg = BeanManager.GetTableByName("message.cstringres")
local CDungeonSelectMainline = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local NpcStoryCell = class("NpcStoryCell", Dialog)
NpcStoryCell.AssetBundleName = "ui/layouts.tujian"
NpcStoryCell.AssetName = "CharBookStoryCell"

function NpcStoryCell:Ctor(...)
  NpcStoryCell.super.Ctor(self, ...)
end

function NpcStoryCell:OnCreate()
  self._storyBack = self:GetChild("Normal")
  self._storyTxt = self:GetChild("Normal/Txt")
  self._title = self:GetChild("Normal/Title")
  self._lockBack = self:GetChild("Lock")
  self._lockTxt = self:GetChild("Lock/Txt")
end

function NpcStoryCell:OnDestroy()
end

function NpcStoryCell:RefreshCell(data)
  if data.floorId == 0 or NekoData.BehaviorManager.BM_Game:GetFloorIsPassWithMainLineId(data.floorId) then
    self._storyBack:SetActive(true)
    self._lockBack:SetActive(false)
    local str = data.backStory
    str = string.gsub(str, "%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username)
    self._storyTxt:SetText(str)
  else
    self._storyBack:SetActive(false)
    self._lockBack:SetActive(true)
    local str = TextManager.GetText(CstringCfg:GetRecorder(1120).msgTextID)
    local stageName = TextManager.GetText(CDungeonSelectMainline:GetRecorder(data.floorId).nameTextID)
    self._lockTxt:SetText(string.gsub(str, "%$parameter1%$", stageName))
  end
end

return NpcStoryCell
