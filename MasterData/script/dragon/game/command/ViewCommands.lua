-- chunkname: @/tmp/or_script/lua_compile/dragon/game/command/ViewCommands.lua

ViewCommand = class("ViewCommand", legs.Command)

ViewCommand:has("_currentSceneMediator", {
	is = "r"
}):injectWith("BaseSceneMediator", "activeScene")

SwitchViewCommand = class("SwitchViewCommand", ViewCommand)

function SwitchViewCommand:execute(event)
	local currentSceneMediator = self:getCurrentSceneMediator()
	local view = event:getView()
	local options = event:getOptions()
	local eventdata = event:getData()

	currentSceneMediator:switchView(view, options, eventdata)
end

PushViewCommand = class("PushViewCommand", ViewCommand)

function PushViewCommand:execute(event)
	local currentSceneMediator = self:getCurrentSceneMediator()
	local view = event:getView()
	local options = event:getOptions()
	local eventdata = event:getData()

	currentSceneMediator:pushView(view, options, eventdata)
end

ShowPopupViewCommand = class("ShowPopupViewCommand", ViewCommand)

function ShowPopupViewCommand:execute(event)
	local currentSceneMediator = self:getCurrentSceneMediator()
	local view = event:getView()
	local options = event:getOptions()
	local eventdata = event:getData()
	local delegate = event:getDelegate()

	currentSceneMediator:showPopup(view, options, eventdata, delegate)
end

ShowToastCommand = class("ShowToastCommand", ViewCommand)

function ShowToastCommand:execute(event)
	local currentSceneMediator = self:getCurrentSceneMediator()
	local toast = event:getToast()
	local options = event:getOptions()

	currentSceneMediator:showToast(toast, options)
end

ShowQueueToastCommand = class("ShowQueueToastCommand", ViewCommand)

function ShowQueueToastCommand:execute(event)
	local currentSceneMediator = self:getCurrentSceneMediator()
	local toast = event:getToast()
	local options = event:getOptions()

	currentSceneMediator:showQueueToast(toast, options)
end

PlayEffectCommand = class("PlayEffectCommand", ViewCommand)

function PlayEffectCommand:execute(event)
	return
end
