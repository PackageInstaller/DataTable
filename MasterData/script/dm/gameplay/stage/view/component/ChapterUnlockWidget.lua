-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/component/ChapterUnlockWidget.lua

ChapterUnlockWidget = class("ChapterUnlockWidget", BaseWidget, _M)

ChapterUnlockWidget:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")

function ChapterUnlockWidget.class:createWidgetNode()
	local resFile = "asset/ui/BlockChapterUnlock.csb"

	return cc.CSLoader:createNode(resFile)
end

function ChapterUnlockWidget:initialize(view, backCallfunc)
	super.initialize(self, view)
	self:initWidget(backCallfunc)
end

function ChapterUnlockWidget:initWidget(func)
	self._onPlayAnim = false
	self._main = self:getView():getChildByName("main")
	self._callFunc = func

	local function callFunc(sender, eventType)
		if self._onPlayAnim then
			self._onPlayAnim = false

			performWithDelay(self._main, function()
				self._main:setVisible(false)

				if func then
					func()
				end

				self:setupClickEnvs()
			end, 0.2)
		end
	end

	mapButtonHandlerClick(nil, self._main, callFunc)
	self:initAnim()
end

function ChapterUnlockWidget:setupView(chapterIndex, stageType)
	if not chapterIndex then
		return
	end

	self._onPlayAnim = false

	local chapterTitleView = self._main:getChildByName("textPanel")

	chapterTitleView:removeAllChildren(true)

	local mapInfo = self._stageSystem:getMapByIndex(chapterIndex, stageType)
	local mapName = Strings:get(mapInfo:getConfig().MapName)
	local str = Strings:get("New_Chapter_Open", {
		fontName = TTF_FONT_FZYH_R,
		num = chapterIndex,
		name = mapName
	})
	local titleText = ccui.RichText:createWithXML(str, {})

	titleText:addTo(chapterTitleView):center(chapterTitleView:getContentSize())
	chapterTitleView:setOpacity(0)

	local fadeWidget1 = self._main:getChildByName("Image_5")

	fadeWidget1:setOpacity(0)

	local fadeWidget2 = self._main:getChildByName("chapterImg")

	fadeWidget2:setOpacity(0)
	self._main:setVisible(true)
	self._mc:addCallbackAtFrame(33, function()
		self._mc:stop()
		fadeWidget1:runAction(cc.FadeIn:create(0.9))
		fadeWidget2:runAction(cc.FadeIn:create(1))
		chapterTitleView:runAction(cc.FadeIn:create(1))

		self._onPlayAnim = true

		performWithDelay(self:getView(), function()
			self._onPlayAnim = false

			self._main:setVisible(false)

			if self._callFunc then
				self._callFunc()
			end

			self:setupClickEnvs()
		end, 2)
	end)
	self._mc:gotoAndPlay(1)
	AudioEngine:getInstance():playEffect("Se_Alert_New_Chapter", false)
end

function ChapterUnlockWidget:initAnim()
	local mc = cc.MovieClip:create("zongdh_xinzhangjiekaiqi")
	local actionPanel = self._main:getChildByName("actionPanel")

	mc:addTo(actionPanel):center(actionPanel:getContentSize())
	mc:stop()

	self._mc = mc
end

function ChapterUnlockWidget:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("exit_ChapterUnlockWidget")
end
