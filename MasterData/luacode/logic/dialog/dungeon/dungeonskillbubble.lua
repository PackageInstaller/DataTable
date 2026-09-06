local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local DungeonSkillBubble = class("DungeonSkillBubble", Dialog)
DungeonSkillBubble.AssetBundleName = "ui/layouts.dungeon"
DungeonSkillBubble.AssetName = "DungeonSkills"

function DungeonSkillBubble:Ctor(...)
  DungeonSkillBubble.super.Ctor(self, ...)
  self._groupName = "Default"
end

function DungeonSkillBubble:OnCreate()
  self._image = self:GetChild("Image")
  self._itemSizeX, self._itemsSizeY = self:GetRootWindow():GetRectSize()
  self._itemSX, self._itemSOX, self._itemSY, self._itemSOY = self:GetRootWindow():GetSize()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)
  local actorX, actorY, actorZ = TransformStaticFunctions.GetPosition(controller._sceneRef.actor.object)
end

function DungeonSkillBubble:OnDestroy()
end

function DungeonSkillBubble:SetData(eventid, data)
  local skill = CMapSkill:GetRecorder(data)
  local image = ImageTable:GetRecorder(skill.icon)
  self._image:SetSprite(image.assetBundle, image.assetName)
end

return DungeonSkillBubble
