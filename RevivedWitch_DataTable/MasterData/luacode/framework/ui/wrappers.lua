-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/wrappers.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Wrappers = {Button = require("framework.ui.wrapper.button"), Image = require("framework.ui.wrapper.image"), InputField = require("framework.ui.wrapper.inputfield"), TextMeshProUGUI = require("framework.ui.wrapper.textmeshprougui"), Text = require("framework.ui.wrapper.text"), TwoValueProgressBar = require("framework.ui.wrapper.twovalueprogressbar"), Window = require("framework.ui.wrapper.window"), NekoToggle = require("framework.ui.wrapper.nekotoggle"), Scrollbar = require("framework.ui.wrapper.scrollbar"), GroupButton = require("framework.ui.wrapper.groupbutton"), NekoButton = require("framework.ui.wrapper.nekobutton"), Effect = require("framework.ui.wrapper.effect"), Live2D = require("framework.ui.wrapper.live2d"), Model = require("framework.ui.wrapper.model"), Mesh = require("framework.ui.wrapper.mesh"), Video = require("framework.ui.wrapper.video"), CurrencyText = require("framework.ui.wrapper.currencytext"), CurrencyTextMeshProUGUI = require("framework.ui.wrapper.currencytextmeshprougui"), RawImage = require("framework.ui.wrapper.rawimage")}
return Wrappers

