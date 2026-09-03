-- chunkname: @/tmp/or_script/lua_compile/dm/launch/LaunchSceneMediator.lua

LaunchSceneMediator = class("LaunchSceneMediator", DmSceneMediator, _M)

function LaunchSceneMediator:initialize()
	super.initialize(self)
end

function LaunchSceneMediator:dispose()
	super.dispose(self)
end

function LaunchSceneMediator:onRegister()
	super.onRegister(self)

	local function onKeyReleased(keyCode, event)
		if keyCode == cc.KeyCode.KEY_BACK then
			if self:getPopupViewCount() > 0 then
				local popupView = self:getTopPopupView()

				if popupView and popupView.mediator then
					popupView.mediator:leaveWithData()

					return
				end
			end

			local data = {
				noClose = true,
				title = Strings:get("UPDATE_UI7"),
				content = Strings:get("UI_TEXT_EXIT_GAME"),
				sureBtn = {},
				cancelBtn = {}
			}
			local outSelf, delegate = self, {}

			function delegate:willClose(popupMediator, data)
				if data.response == "ok" then
					performWithDelay(outSelf:getView(), function()
						cc.Director:getInstance():endToLua()
					end, 0.1)
				end
			end

			local view = self:getInjector():getInstance("AlertView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				isAreaIndependent = true,
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data, delegate))
		end
	end

	local listener = cc.EventListenerKeyboard:create()

	listener:registerScriptHandler(onKeyReleased, cc.Handler.EVENT_KEYBOARD_RELEASED)
	cc.Director:getInstance():getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self:getView())
end

function LaunchSceneMediator:onRemove()
	super.onRemove(self)
end

function LaunchSceneMediator:switchLoginView()
	self:checkUserState()
end

function LaunchSceneMediator:checkUserState()
	local injector = self:getInjector()

	self:loadBaseRequires()

	local loginView = injector:getInstance("loginView")

	self:dispatch(ViewEvent:new(EVT_SWITCH_VIEW, loginView, {}))
end

function LaunchSceneMediator:loadBaseRequires()
	local injector = self:getInjector()
	local gameContext = injector:getInstance("GameContext")

	gameContext:loadModuleByName("login")
end

function LaunchSceneMediator:enterWithData(data)
	require("dm.assets.init")
	require("dm.base.all")
	require("dm.utils.AudioEngine")
	self:switchLoginView()
	self:initLogger()
end

function LaunchSceneMediator:initLogger()
	if GameConfigs.dpsLoggerEnable then
		StatisticSystem:uploadLogs(LogType.kClient)

		if GameConfigs.dpsLoggerConfig.root == nil then
			local fileUtils = cc.FileUtils:getInstance()

			GameConfigs.dpsLoggerConfig.root = fileUtils:getWritablePath() .. "log"

			if not fileUtils:isDirectoryExist(GameConfigs.dpsLoggerConfig.root) then
				fileUtils:createDirectory(GameConfigs.dpsLoggerConfig.root)
			end
		end

		DpsLogger:clear()
		DpsLogger:init(GameConfigs.dpsLoggerConfig.root)
		DpsLogger:enable()

		for _, category in ipairs(GameConfigs.dpsLoggerConfig.category) do
			local appenders = {}

			for _, appender in ipairs(category.appender) do
				if appender == "File" then
					appenders[#appenders + 1] = {
						fmtfunc = FileFormat,
						filename = category.name
					}
				elseif appender == "Stat" then
					appenders[#appenders + 1] = {
						fmtfunc = JsonFormat,
						filename = category.name
					}
					category.pattern = "%message\n"
				else
					appenders[#appenders + 1] = {
						fmtfunc = DumpFormat
					}
				end
			end

			DpsLogger:addLogger(category.name, category.level, appenders, category.pattern)
		end
	end
end
