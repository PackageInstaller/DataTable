-- chunkname: @tolua.lua

if jit then
	jit.off()
	jit.flush()
end

if DebugServerIp then
	require("mobdebug").start(DebugServerIp)
end

require("misc.functions")

Mathf = require("UnityEngine.Mathf")
Vector3 = require("UnityEngine.Vector3")
Quaternion = require("UnityEngine.Quaternion")
Vector2 = require("UnityEngine.Vector2")
Vector4 = require("UnityEngine.Vector4")
Color = require("UnityEngine.Color")
Ray = require("UnityEngine.Ray")
Bounds = require("UnityEngine.Bounds")
RaycastHit = require("UnityEngine.RaycastHit")
Touch = require("UnityEngine.Touch")
LayerMask = require("UnityEngine.LayerMask")
Plane = require("UnityEngine.Plane")
Time = reimport("UnityEngine.Time")
list = require("list")
utf8 = require("misc.utf8")

require("event")
require("typeof")
require("slot")
require("System.Timer")
require("System.coroutine")
require("System.ValueType")
require("System.Reflection.BindingFlags")

Rect = require("UnityEngine.Rect")
