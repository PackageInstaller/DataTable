-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreVictoryMediator.lua

ExploreVictoryMediator = class("ExploreVictoryMediator", DmPopupViewMediator, _M)

ExploreVictoryMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
ExploreVictoryMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function ExploreVictoryMediator:initialize()
	super.initialize(self)
end

function ExploreVictoryMediator:dispose()
	super.dispose(self)
end

function ExploreVictoryMediator:onRegister()
	super.onRegister(self)
	self:bindWidgets()
	self:mapButtonHandlersClick(kBtnHandlers)

	self._finishBtn = self:bindWidget("main.finishPanel.finishBtn", OneLevelMainButton, {
		ignoreAddKerning = true,
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickFinish, self)
		}
	})
	self._continueBtn = self:bindWidget("main.finishPanel.continueBtn", OneLevelViceButton, {
		ignoreAddKerning = true,
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickSure, self)
		}
	})
end

function ExploreVictoryMediator:bindWidgets()
	return
end

function ExploreVictoryMediator:mapEventListeners()
	return
end

function ExploreVictoryMediator:enterWithData(data)
	self:mapEventListeners()
	self:initData(data)
	self:setupView()
	self:initFinishView()
end

function ExploreVictoryMediator:initData(data)
	self._callback = data.callback
	self._pointData = data.pointData
	self._taskData = self._pointData:getMainTask()
	self._taskId = self._taskData:getId()
	self._taskStatus = self._taskData:getStatus()

	local maoObjPorData = self._pointData:getMapObjProgress()
	local totalPro = maoObjPorData[2]

	self._progressNum = math.floor(totalPro[1] / totalPro[2] * 100)
end

function ExploreVictoryMediator:setupView()
	self._mainPanel = self:getView():getChildByName("main")
	self._finishPanel = self._mainPanel:getChildByName("finishPanel")

	self._finishPanel:setOpacity(0)

	local animPanel = self._mainPanel:getChildByName("animPanel")
	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:addTo(animPanel)
	anim:setPosition(cc.p(0, -120))
	anim:addCallbackAtFrame(39, function()
		anim:stop()
	end)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")
	local title1 = cc.Label:createWithTTF(Strings:get("EXPLORE_Mubiaodacheng"), CUSTOM_TTF_FONT_1, 50)

	title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	title1:addTo(cnText):offset(0, -3)

	local title2 = cc.Label:createWithTTF(Strings:get("UITitle_EN_Mubiaodacheng"), TTF_FONT_FZYH_M, 18)

	title2:setColor(cc.c3b(150, 160, 255))
	title2:addTo(enText)
	anim:addCallbackAtFrame(9, function()
		self._finishPanel:fadeIn({
			time = 0.2
		})
	end)
	GameStyle:setCommonOutlineEffect(self._finishPanel:getChildByName("title"))
	GameStyle:setCommonOutlineEffect(self._finishPanel:getChildByName("desc"))
	GameStyle:setCommonOutlineEffect(self._finishPanel:getChildByName("text"))
end

function ExploreVictoryMediator:initFinishView()
	local desc = self._finishPanel:getChildByName("desc")

	desc:getVirtualRenderer():setLineSpacing(8)

	local doneMark = self._finishPanel:getChildByName("donemark")
	local todoMark = self._finishPanel:getChildByName("todomark")
	local taskValues = self._taskData:getTaskValueList()
	local currentValue = taskValues[#taskValues].currentValue
	local targetValue = taskValues[#taskValues].targetValue

	if self._taskData:getDesc() ~= "" then
		local var_11_0 = self._taskData:getDesc()

		if not var_11_0 then
			var_11_0 = self._exploreSystem:getTaskDescByCondition(self._taskData:getCondition())

			local taskDesc = var_11_0
			local str = Strings:get("EXPLORE_UI40", {
				task = taskDesc,
				currentValue = currentValue,
				targetValue = targetValue
			})

			self._taskDesc = str

			desc:setString(str)

			local progress1 = self._finishPanel:getChildByFullName("progressPanel.progress")
			local loadingBar = self._finishPanel:getChildByFullName("progressPanel.loadingBar")

			loadingBar:setScale9Enabled(true)
			loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))
			progress1:setString(self._progressNum .. "%")
			loadingBar:setPercent(self._progressNum)
			doneMark:setVisible(self._taskStatus ~= 0)
			todoMark:setVisible(not doneMark:isVisible())
		end
	end
end

function ExploreVictoryMediator:onClickFinish(sender, eventType)
	local curGroupId = self._developSystem:getPlayer():getExplore():getCurGroupId()
	local curPointId = self._pointData:getId()
	local params = {
		curGroupId = curGroupId,
		curPointId = curPointId,
		taskStatus = self._taskStatus,
		progressNum = self._progressNum,
		taskDesc = self._taskDesc
	}

	local function func()
		self._exploreSystem:requestExploreFinish(params)
	end

	if self._taskStatus == 1 or self._taskStatus == 2 then
		if self._progressNum < 100 then
			local outSelf, delegate = self, {}

			function delegate:willClose(popupMediator, data)
				if data.response == "ok" then
					func()
				elseif data.response == "cancel" then
					-- block empty
				elseif data.response == "close" then
					-- block empty
				end
			end

			local data = {
				title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
				content = Strings:get("EXPLORE_UI116"),
				sureBtn = {},
				cancelBtn = {}
			}
			local view = self:getInjector():getInstance("AlertView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data, delegate))
		else
			func()
		end
	else
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				func()
			elseif data.response == "cancel" then
				-- block empty
			elseif data.response == "close" then
				-- block empty
			end
		end

		local data = {
			title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
			content = Strings:get("EXPLORE_UI39"),
			sureBtn = {},
			cancelBtn = {}
		}
		local view = self:getInjector():getInstance("AlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	end
end

function ExploreVictoryMediator:onClickSure(sender, eventType)
	if self._callback then
		self._callback()
	end

	self:close()
end
