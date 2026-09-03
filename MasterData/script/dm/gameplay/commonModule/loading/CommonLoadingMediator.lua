-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/commonModule/loading/CommonLoadingMediator.lua

CommonLoadingMediator = class("CommonLoadingMediator", DmAreaViewMediator, _M)

function CommonLoadingMediator:initialize()
	super.initialize(self)
end

function CommonLoadingMediator:dispose()
	super.dispose(self)
end

function CommonLoadingMediator:onRegister()
	super.onRegister(self)
	self:initView()
end

function CommonLoadingMediator:initView()
	local view = self:getView()

	self._bg = cc.Sprite:create("asset/scene/bg_jiazaiyemianimage.png")

	self._bg:setAnchorPoint(cc.p(0.5, 0.5))
	self._bg:addTo(view, -1):setName("backgroundBG")

	self._anim = cc.MovieClip:create("zongdh_jiazaiyemian")

	self._anim:addTo(view)

	self._loadBar = cc.MovieClip:create("bar_jiazaiyemian")

	self._loadBar:addTo(view):center(view:getContentSize())
	self._loadBar:gotoAndStop(1)

	self._progText = cc.Label:createWithTTF("0%", TTF_FONT_FZYH_M, 20)

	self._progText:addTo(self._loadBar):center(self._loadBar:getContentSize())
	self._progText:enableOutline(cc.c4b(0, 0, 0, 127.5), 2)
	self._progText:setRotationSkewX(15)
end

function CommonLoadingMediator:enterWithData(data)
	self._loadingTask = data.loadingTask
	self._onCompleted = data.onCompleted

	self:start()
end

function CommonLoadingMediator:start()
	local loadingTask = self._loadingTask
	local onCompleted = self._onCompleted
	local outSelf = self
	local taskListener = timesharding.TaskListener:new()

	function taskListener:onProgress(task, progress)
		outSelf:setProgress(progress)
	end

	function taskListener:onError(task, err)
		return
	end

	function taskListener:onCompleted(task)
		if onCompleted then
			delayCallByTime(0, onCompleted)
		end
	end

	function taskListener:onAbort(task)
		return
	end

	loadingTask:setTaskListener(taskListener)
	loadingTask:start()
end

function CommonLoadingMediator:setProgress(progress)
	self._loadBar:gotoAndStop(progress * 100 * self._scale)
	self._progText:setString(math.floor(progress * 100) .. "%")
end
