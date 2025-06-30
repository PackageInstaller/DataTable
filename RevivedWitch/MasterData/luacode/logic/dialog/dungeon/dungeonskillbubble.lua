-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/dungeon/dungeonskillbubble.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local DungeonSkillBubble = class("DungeonSkillBubble", Dialog)
DungeonSkillBubble.AssetBundleName = "ui/layouts.dungeon"
DungeonSkillBubble.AssetName = "DungeonSkills"
DungeonSkillBubble.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DungeonSkillBubble
  ((DungeonSkillBubble.super).Ctor)(self, ...)
  self._groupName = "Default"
end

DungeonSkillBubble.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, TransformStaticFunctions
  self._image = self:GetChild("Image")
  self._itemSizeX = (self:GetRootWindow()):GetRectSize()
  self._itemSX = (self:GetRootWindow()):GetSize()
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  local actorX, actorY, actorZ = (TransformStaticFunctions.GetPosition)(((controller._sceneRef).actor).object)
end

DungeonSkillBubble.OnDestroy = function(self)
  -- function num : 0_2
end

DungeonSkillBubble.SetData = function(self, eventid, data)
  -- function num : 0_3 , upvalues : _ENV, ImageTable
  local skill = CMapSkill:GetRecorder(data)
  local image = ImageTable:GetRecorder(skill.icon)
  ;
  (self._image):SetSprite(image.assetBundle, image.assetName)
end

return DungeonSkillBubble

