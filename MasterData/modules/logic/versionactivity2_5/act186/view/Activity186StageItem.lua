-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186StageItem.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186StageItem", package.seeall)

local Activity186StageItem = class("Activity186StageItem", ListScrollCellExtend)

function Activity186StageItem:onInitView()
	self.goSelect = gohelper.findChild(self.viewGO, "goSelect")
	self.goLock = gohelper.findChild(self.viewGO, "goLock")
	self.goTimeBg = gohelper.findChild(self.viewGO, "goLock/timeBg")
	self.txtTime = gohelper.findChildTextMesh(self.viewGO, "goLock/timeBg/txt")
	self.goEnd = gohelper.findChild(self.viewGO, "goEnd")
	self.btnClick = gohelper.findButtonWithAudio(self.viewGO)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity186StageItem:addEvents()
	self.btnClick:AddClickListener(self.onClickBtn, self)
end

function Activity186StageItem:removeEvents()
	self.btnClick:RemoveClickListener()
end

function Activity186StageItem:_editableInitView()
	return
end

function Activity186StageItem:onClickBtn()
	if not self._mo then
		return
	end

	local curStage = self._mo.actMo.currentStage
	local isSelect = curStage == self._mo.id
	local isLock = curStage < self._mo.id

	if isSelect then
		return
	end

	if isLock then
		local dict = lua_actvity186_stage.configDict[self._mo.actMo.id]
		local stageConfig = dict and dict[self._mo.id]

		if stageConfig then
			local timeStamp = TimeUtil.stringToTimestamp(stageConfig.startTime)
			local leftTime = timeStamp - ServerTime.now()
			local day = math.ceil(leftTime / TimeUtil.OneDaySecond)
			local str = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act186_stagetime"), day)

			GameFacade.showToastString(str)
		end

		return
	end

	GameFacade.showToast(ToastEnum.Act186StageEnd)
end

function Activity186StageItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshView()
end

function Activity186StageItem:refreshView()
	local curStage = self._mo.actMo.currentStage
	local isEnd = curStage > self._mo.id
	local isSelect = curStage == self._mo.id
	local isLock = curStage < self._mo.id

	gohelper.setActive(self.goSelect, isSelect)
	gohelper.setActive(self.goLock, isLock)
	gohelper.setActive(self.goEnd, isEnd)

	local isNext = curStage + 1 == self._mo.id

	if isNext then
		gohelper.setActive(self.goTimeBg, true)
		self:_showDeadline()
	else
		gohelper.setActive(self.goTimeBg, false)
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	end
end

function Activity186StageItem:_showDeadline()
	self:_onRefreshDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
end

function Activity186StageItem:_onRefreshDeadline()
	if not self._mo then
		return
	end

	local dict = lua_actvity186_stage.configDict[self._mo.actMo.id]
	local stageConfig = dict and dict[self._mo.id]

	if not stageConfig then
		return
	end

	local timeStamp = TimeUtil.stringToTimestamp(stageConfig.startTime)
	local leftTime = timeStamp - ServerTime.now()
	local day = math.ceil(leftTime / TimeUtil.OneDaySecond)

	self.txtTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act186_stagetime"), day)
end

function Activity186StageItem:onDestroyView()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
end

return Activity186StageItem
