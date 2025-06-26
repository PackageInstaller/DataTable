-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/layers.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Layers = {}
local CSLayers = ((CS.PixelNeko).P1).Layers
Layers.Init = function()
  -- function num : 0_0 , upvalues : Layers, CSLayers
  Layers.ObstacleColliderLayerID = CSLayers.ObstacleColliderLayerID
  Layers.SceneObjectClickLayerID = CSLayers.SceneObjectClickLayerID
  Layers.YardCharacterLayerID = CSLayers.YardCharacterLayerID
  Layers.FurnitureLayerID = CSLayers.FurnitureLayerID
  Layers.InvisibleLayerID = CSLayers.InvisibleLayerID
  Layers.NewDemoFighterLayerID = CSLayers.NewDemoFighterLayerID
end

return Layers

