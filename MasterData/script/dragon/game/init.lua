-- chunkname: @/tmp/or_script/lua_compile/dragon/game/init.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

local function export(url)
	return require(__PACKAGE__ .. url)
end

export("model.GameObject")
export("event.ViewEvent")
export("command.SceneCommands")
export("command.ViewCommands")
export("view.ViewTransition")
export("view.BaseViewMediator")
export("view.BaseSceneMediator")
export("view.BaseWidget")
export("view.BaseToast")
export("view.AreaViewMediator")
export("view.PopupViewMediator")
export("GameContext")
export("BaseGame")
