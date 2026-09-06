local NpcUIDialog = class("NpcUIDialog", Dialog)
NpcUIDialog.AssetBundleName = "ui/layouts.npc"
NpcUIDialog.AssetName = "NPC"

function NpcUIDialog:Ctor(...)
  NpcUIDialog.super.Ctor(self, ...)
  self._groupName = "Default"
  self._childs = {}
end

function NpcUIDialog:OnCreate()
end

function NpcUIDialog:OnDestroy()
  for _, v in ipairs(self._childs) do
    v.dialog:Destroy()
  end
  self._childs = {}
end

function NpcUIDialog:OnUpdate()
end

function NpcUIDialog:CreateChild(dialogName, sceneId, npcId)
  local dialog = DialogManager.CreateDialog(dialogName, self:GetRootWindow()._uiObject)
  dialog:SetData(sceneId, npcId)
  local temp = {}
  temp.dialog = dialog
  temp.sceneId = sceneId
  temp.npcId = npcId
  table.insert(self._childs, temp)
end

function NpcUIDialog:UpdateChild(sceneId, npcId)
  for _, v in ipairs(self._childs) do
    if sceneId then
      if v.sceneId == sceneId then
        if npcId then
          if v.npcId == npcId then
            v.dialog:Refresh()
          end
        else
          v.dialog:Refresh()
        end
      end
    else
      v.dialog:Refresh()
    end
  end
end

return NpcUIDialog
