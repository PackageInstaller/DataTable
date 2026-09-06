local Layers = {}
local CSLayers = CS.PixelNeko.P1.Layers

function Layers.Init()
  Layers.ObstacleColliderLayerID = CSLayers.ObstacleColliderLayerID
  Layers.SceneObjectClickLayerID = CSLayers.SceneObjectClickLayerID
  Layers.YardCharacterLayerID = CSLayers.YardCharacterLayerID
  Layers.FurnitureLayerID = CSLayers.FurnitureLayerID
  Layers.InvisibleLayerID = CSLayers.InvisibleLayerID
  Layers.NewDemoFighterLayerID = CSLayers.NewDemoFighterLayerID
end

return Layers
