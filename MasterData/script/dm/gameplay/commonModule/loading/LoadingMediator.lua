-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/commonModule/loading/LoadingMediator.lua

LoadingMediator = class("LoadingMediator", DmAreaViewMediator, _M)

function LoadingMediator:initialize()
	super.initialize(self)
end

function LoadingMediator:dispose()
	if self._loadingWidget then
		self._loadingWidget:dispose()

		self._loadingWidget = nil
	end

	if self._anim then
		self._anim:removeFromParent(true)

		self._anim = nil
	end

	super.dispose(self)
end

function LoadingMediator:onRegister()
	super.onRegister(self)
end

function LoadingMediator:enterWithData(data)
	self._loadingWidget = data.loadingWidget
	self._loadingTask = data.loadingTask
	self._onCompleted = data.onCompleted
	self._loadingId = data.loadingId
	self._loadingType = data.loadingType

	self._loadingWidget:getView():addTo(self:getView())
	self._loadingWidget:setupView(data)

	if not data.hideAnim then
		self:initAnim()
		self:enterAnim()
	end

	if data.bgAnim then
		local bg = self._loadingWidget:getView():getChildByFullName("bottom.bg")
		local bgAnim = data.bgAnim

		bgAnim:changeParent(bg):center(bg:getContentSize())
	end

	self:start()
end

function LoadingMediator:leaveWithData()
	print("LoadingMediator:leaveWithData ...... ")
end

function LoadingMediator:initAnim()
	local mc = cc.MovieClip:create("mengjingbbb_mingzi")

	mc:setPosition(cc.p(1030, 140))
	mc:setScale(0.8)
	mc:addTo(self:getView())
	mc:addCallbackAtFrame(40, function()
		mc:stop()
	end)
	mc:addEndCallback(function()
		mc:stop()
	end)

	self._anim = mc
	self._actionView1 = self._loadingWidget:getView():getChildByFullName("bottom.Node_1.img1")
	self._actionView2 = self._loadingWidget:getView():getChildByFullName("bottom.Node_2.img2")
	self._actionView3 = self._loadingWidget:getView():getChildByFullName("bottom.Node_3.img3")
	self._actionView4 = self._loadingWidget:getView():getChildByFullName("bottom.Node_4.img4")
	self._actionView5 = self._loadingWidget:getView():getChildByFullName("bottom.Node_5.img5")
	self._actionView6 = self._loadingWidget:getView():getChildByFullName("bottom.Node_6.img6")
	self._actionView7 = self._loadingWidget:getView():getChildByFullName("bottom.Node_7.img7")
end

function LoadingMediator:enterAnim()
	CommonUtils.runActionEffect(self._actionView1, "Node_1.huawen_jiazaiimage_10", "loadingEffect", "animation0")
	CommonUtils.runActionEffect(self._actionView2, "Node_2.ta_jiazaiimage_4", "loadingEffect", "animation0")
	CommonUtils.runActionEffect(self._actionView3, "Node_3.tb_jiazaiimage_5", "loadingEffect", "animation0")
	CommonUtils.runActionEffect(self._actionView4, "Node_4.tc_jiazaiimage_6", "loadingEffect", "animation0")
	CommonUtils.runActionEffect(self._actionView5, "Node_5.zc_jiazaiimage_9", "loadingEffect", "animation0")
	CommonUtils.runActionEffect(self._actionView6, "Node_6.zb_jiazaiimage_8", "loadingEffect", "animation0")
	CommonUtils.runActionEffect(self._actionView7, "Node_7.za_jiazaiimage_7", "loadingEffect", "animation0")
end

function LoadingMediator:start()
	local loadingWidget = self._loadingWidget
	local loadingTask = self._loadingTask
	local onCompleted = self._onCompleted
	local taskListener = timesharding.TaskListener:new()

	function taskListener:onProgress(task, progress)
		if loadingWidget then
			loadingWidget:onProgress(task, progress)
		end
	end

	function taskListener:onError(task, err, level)
		if loadingWidget then
			loadingWidget:onError(task, err, level)
		end
	end

	function taskListener:onCompleted(task)
		if loadingWidget then
			loadingWidget:onCompleted(task)
		end

		if onCompleted then
			delayCallByTime(0, onCompleted)
		end
	end

	function taskListener:onAbort(task)
		if loadingWidget then
			loadingWidget:onAbort(task)
		end
	end

	loadingTask:setTaskListener(taskListener)
	loadingTask:start()
end

function LoadingMediator:close()
	self:dismiss()
end

EnterLoadingMediator = class("EnterLoadingMediator", LoadingMediator, _M)

function EnterLoadingMediator:initialize()
	super.initialize(self)
end

function EnterLoadingMediator:initAnim()
	return
end

function EnterLoadingMediator:enterAnim()
	return
end
