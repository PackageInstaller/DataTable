-- chunkname: @modules/logic/defines/UnityLayer.lua

module("modules.logic.defines.UnityLayer", package.seeall)

local UnityLayer = {}

UnityLayer.Default = 0
UnityLayer.TransparentFX = 1
UnityLayer.IgnoreRaycast = 2
UnityLayer.Water = 4
UnityLayer.UI = 5
UnityLayer.UIEffect = 8
UnityLayer.UI3D = 9
UnityLayer.UITop = 10
UnityLayer.Unit = 11
UnityLayer.Scene = 12
UnityLayer.SceneEffect = 13
UnityLayer.SceneOpaque = 15
UnityLayer.UnitOpaque = 18
UnityLayer.EffectMask = 19
UnityLayer.UISecond = 20
UnityLayer.UIThird = 21
UnityLayer.SceneOrthogonal = 22
UnityLayer.Hide = 23
UnityLayer.SceneOrthogonalOpaque = 24
UnityLayer.SceneOpaqueOcclusionClip = 25
UnityLayer.UIFour = 30

return UnityLayer
