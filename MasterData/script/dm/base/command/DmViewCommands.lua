-- chunkname: @/tmp/or_script/lua_compile/dm/base/command/DmViewCommands.lua

EVT_POP_VIEW = "EVT_POP_VIEW"
EVT_POP_TO_TARGETVIEW = "EVT_POP_TO_TARGETVIEW"

local function findViewByName(scene, viewName)
	local viewStackSize = scene:getViewStackSize()

	for viewIndex = viewStackSize, 1, -1 do
		local name = scene:getViewNameAtIndex(viewIndex)

		if viewName == name then
			return viewIndex
		end
	end
end

DmSwitchViewCommand = class("DmSwitchViewCommand", ViewCommand)

function DmSwitchViewCommand:execute(event)
	local currentSceneMediator = self:getCurrentSceneMediator()
	local view = event:getView()
	local options = event:getOptions()
	local eventdata = event:getData()
	local keepCognominalView = options.keepCognominalView

	if options.replaceViewName then
		options.replaceIndex = findViewByName(currentSceneMediator, options.replaceViewName)

		if not options.replaceIndex and currentSceneMediator.getViewIndexFromHistoryByName then
			options.replaceIndex = currentSceneMediator:getViewIndexFromHistoryByName(options.replaceViewName)

			if options.replaceIndex then
				options.isHistoryReplaceIndex = true
			end
		end
	else
		options.replaceIndex = nil
	end

	if not keepCognominalView and options.replaceIndex == nil then
		options.replaceIndex = findViewByName(currentSceneMediator, view:getViewName())
	end

	currentSceneMediator:switchView(view, options, eventdata)
end

DmPushViewCommand = class("DmPushViewCommand", ViewCommand)

function DmPushViewCommand:execute(event)
	local currentSceneMediator = self:getCurrentSceneMediator()
	local view = event:getView()
	local options = event:getOptions()
	local eventdata = event:getData()
	local removeIndex
	local keepCognominalView = options.keepCognominalView

	if not keepCognominalView then
		removeIndex = findViewByName(currentSceneMediator, view:getViewName())
	end

	currentSceneMediator:pushView(view, options, eventdata)

	if removeIndex then
		currentSceneMediator:removeViewAtIndex(removeIndex)
	end
end

DmPopViewCommand = class("DmPopViewCommand", ViewCommand)

function DmPopViewCommand:execute(event)
	local currentSceneMediator = self:getCurrentSceneMediator()
	local view = event:getView()
	local options = event:getOptions()
	local eventdata = event:getData()

	currentSceneMediator:popView(view, options, eventdata)
end

DmPopToTargetViewCommand = class("DmPopToTargetViewCommand", ViewCommand)

function DmPopToTargetViewCommand:execute(event)
	local data = event:getData() or ""

	if type(data) == "table" then
		if not data.viewName then
			local viewName = data

			if type(data) == "table" then
				if not data.viewData then
					local viewData
					local currentSceneMediator = self:getCurrentSceneMediator()
					local targetIndex = findViewByName(currentSceneMediator, viewName)

					if viewName == "ZERO" then
						targetIndex = 0
					end

					if targetIndex then
						currentSceneMediator:popToIndexView(targetIndex, viewData)
					elseif currentSceneMediator.getViewIndexFromHistoryByName then
						targetIndex = currentSceneMediator:getViewIndexFromHistoryByName(viewName)

						if targetIndex then
							currentSceneMediator:popToIndexViewFromHistory(targetIndex, viewData)
						end
					end
				end
			end
		end
	end
end
