-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\OfflineApiInit.lua

rawset(_G, "protobuf", {})

local GLDeclare = require("Framework/Global")

GLDeclare("IS_PUBLISH_VERSION", true)
GLDeclare("NO_CSHARP", true)

local _Lang = require("Common/Lang")

if not IsGLDeclared("Lang") or not Lang then
	GLDeclare("Lang", _Lang)
end

rawset(_G, "logerror", print)
rawset(_G, "logwarning", print)
rawset(_G, "error", print)
rawset(_G, "UnityEngine", {
	Time = {}
})

local Class = require("Framework/Class")
local _Const = require("Const")

if not IsGLDeclared("Const") or not Const then
	GLDeclare("Const", _Const)
end

local _BattleConst = require("Common/FrameBattle/BattleConst")

if not IsGLDeclared("BattleConst") or not BattleConst then
	GLDeclare("BattleConst", _BattleConst)
end

require("Framework/Functor")
require("Common/utils")
