-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/storyeditor/StoryEditorMediator.lua

require("dm.gameplay.storyeditor.StoryDownloader")
require("dm.gameplay.story.all")

local buttonImage = "debug/pic_dm_debug_tab_normal.png"

StoryEditorMediator = class("StoryEditorMediator", DmSceneMediator, _M)

function StoryEditorMediator:initialize()
	super.initialize(self)

	self._storyDownloader = StoryDownloader:new()
end

function StoryEditorMediator:dispose()
	super.dispose(self)
end

function StoryEditorMediator:onRegister()
	super.onRegister(self)
end

function StoryEditorMediator:onRemove()
	super.onRemove(self)

	if self._path and self._path ~= "" then
		package.path = self._path
	end
end

function StoryEditorMediator:enterWithData(data)
	self._path = package.path

	self._storyDownloader:setUrl(data.storyUpdateUrl)

	local searchPath = cc.FileUtils:getInstance():getWritablePath() .. "?.lua;"

	package.path = searchPath .. package.path
	self.storyDirector = self:getInjector():getInstance(story.StoryDirector)

	local injector = self:getInjector()
	local gameContext = injector:getInstance("GameContext")

	require("dm.assets.init")
	require("dm.base.all")
	gameContext:loadModuleByName("launch")
	gameContext:loadModuleByName("gameplay")
	self:initUI()
end

function StoryEditorMediator:initUI()
	self:createMenuUI()
	self:createButton("同步", function()
		if self._storyDownloader:getIsRunning() then
			self:dispatch(ShowTipEvent({
				tip = "正在同步中..."
			}))

			return
		end

		self._storyDownloader:run(function()
			self:refreshFileList()
			self:dispatch(ShowTipEvent({
				tip = "同步完成"
			}))
		end)
	end)
	self:createButton("中断", function()
		self:dispatch(ShowTipEvent({
			tip = "中断运行"
		}))
		self.storyDirector:stop()
	end)
	self:createButton("删除缓存", function()
		cc.FileUtils:getInstance():removeDirectory(cc.FileUtils:getInstance():getWritablePath() .. "stories")
		self:dispatch(ShowTipEvent({
			tip = "删除缓存完成"
		}))
	end)
	self:createButton("退出剧情编辑", function()
		self.storyDirector:stop()
		REBOOT()
	end)
end

function StoryEditorMediator:createButton(str, func)
	local button = ccui.Button:create()

	button:loadTextureNormal(buttonImage)
	self.listView:pushBackCustomItem(button)
	button:setTitleText(str)
	button:setTitleColor(cc.c3b(255, 0, 0))
	button:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended and func then
			func()
		end
	end)
end

function StoryEditorMediator:runStory(name)
	name = string.gsub(name, ".lua", "")

	self.storyDirector:stop()

	package.loaded["stories." .. name] = nil

	local storyAgent = self.storyDirector:getStoryAgent()

	storyAgent:trigger(name, nil, function()
		self:dispatch(ShowTipEvent({
			tip = "剧情完成"
		}))
	end)
end

function StoryEditorMediator:createMenuUI()
	self._menubutton = ccui.Button:create()

	self._menubutton:setLocalZOrder(65535)

	local visibleSize = cc.Director:getInstance():getVisibleSize()

	self._menubutton:setPosition(cc.p(100, visibleSize.height - 30))
	self._menubutton:loadTextureNormal(buttonImage)
	self._menubutton:setTitleText("菜单")
	self._menubutton:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._uiLayer:setVisible(not self._uiLayer:isVisible())
		end
	end)
	self._view:addChild(self._menubutton)

	self._uiLayer = cc.Layer:create()

	self._menubutton:addChild(self._uiLayer)
	self._uiLayer:setVisible(false)

	self.listView = ccui.ListView:create()

	self.listView:setContentSize(cc.size(450, 50))
	self._uiLayer:addChild(self.listView)
	self.listView:setBackGroundColorType(1)
	self.listView:setBackGroundColor(cc.c3b(255, 198, 0))
	self.listView:setPosition(cc.p(80, 0))
	self.listView:setAnchorPoint(cc.p(0, 0))
	self.listView:setScrollBarEnabled(false)
	self.listView:setItemsMargin(20)
	self.listView:setDirection(ccui.ListViewDirection.horizontal)
	self:createFileListView()
end

function StoryEditorMediator:createFileListView()
	self.filelistView = ccui.ListView:create()

	self.filelistView:setContentSize(cc.size(200, 300))
	self._uiLayer:addChild(self.filelistView)
	self.filelistView:setBackGroundColorType(1)
	self.filelistView:setBackGroundColor(cc.c3b(255, 198, 0))
	self.filelistView:setPosition(cc.p(0, -300))
	self.filelistView:setAnchorPoint(cc.p(0, 0))
	self.filelistView:setScrollBarEnabled(false)
	self.filelistView:setItemsMargin(20)
	self.filelistView:setDirection(ccui.ListViewDirection.vertical)
end

function StoryEditorMediator:refreshFileList()
	self.filelistView:removeAllItems()

	local fileList = self._storyDownloader:getFileList()

	for _, v in pairs(fileList) do
		local text = ccui.Text:create()

		text:setContentSize(cc.size(200, 28))
		text:setString(tostring(v))

		local button = ccui.Button:create()

		button:loadTextureNormal(buttonImage)
		button:setScale(0.5)
		button:setTitleText("运行")
		button:setPosition(cc.p(text:getContentSize().width, 0))
		button:setAnchorPoint(cc.p(0, 0.5))
		button:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self.storyDirector:stop()
				self:runStory(tostring(v))
			end
		end)
		text:addChild(button)
		self.filelistView:pushBackCustomItem(text)
	end
end
