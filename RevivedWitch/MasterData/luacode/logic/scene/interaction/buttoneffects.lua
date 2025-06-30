-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/interaction/buttoneffects.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ButtonEffects = {}
ButtonEffects[5] = require("logic.scene.interaction.buttoneffect.5")
ButtonEffects[7] = ButtonEffects[5]
ButtonEffects[8] = ButtonEffects[5]
ButtonEffects[9] = ButtonEffects[5]
ButtonEffects[10] = require("logic.scene.interaction.buttoneffect.10")
ButtonEffects[14] = require("logic.scene.interaction.buttoneffect.14")
ButtonEffects[15] = ButtonEffects[14]
ButtonEffects[20] = require("logic.scene.interaction.buttoneffect.20")
ButtonEffects[24] = require("logic.scene.interaction.buttoneffect.24")
return ButtonEffects

