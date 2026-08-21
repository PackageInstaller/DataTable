local class = require("utils.component.middle_class")
local LuaComponent = require("utils.component.lua_component")
local LuaComponentTest = class("LuaBehaviourTest", LuaComponent)
LuaComponentTest:AddDefineList({
  {
    name = "colorValue",
    type = CS.UnityEngine.Color
  },
  {
    name = "textCmp",
    type = CS.UnityEngine.UI.Text
  },
  {
    name = "rectCmp",
    type = CS.UnityEngine.RectTransform
  },
  {
    name = "int32Value",
    type = CS.System.Int32
  },
  {
    name = "DoubleValue",
    type = CS.System.Double
  },
  {
    name = "boolValue",
    type = CS.System.Boolean
  },
  {
    name = "vector3Value",
    type = CS.UnityEngine.Vector3
  },
  {
    name = "curve",
    type = CS.UnityEngine.AnimationCurve
  },
  {
    name = "Objs",
    type = CS.System.Collections.Generic.List(CS.UnityEngine.GameObject)
  }
})
if ExecuteInEditorScript then
  return LuaComponentTest
end

function LuaComponentTest:initialize()
  LuaComponent.initialize(LuaComponentTest)
  for key, value in pairs(LuaComponentTest) do
    print("key : " .. key .. ", value : " .. tostring(value))
  end
  LuaComponentTest.updateTextTime = CS.UnityEngine.Time.time
  LuaComponentTest.stringIndex = 0
end

function LuaComponentTest:OnEnable()
  Log.Error("-------OnEnable")
end

function LuaComponentTest:OnDisable()
  Log.Error("-------OnDisable")
end

function LuaComponentTest:OnDestroy()
  Log.Error("-------OnDestroy")
end

return LuaComponentTest
