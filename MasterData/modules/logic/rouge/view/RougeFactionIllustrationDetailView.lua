-- chunkname: @modules/logic/rouge/view/RougeFactionIllustrationDetailView.lua

module("modules.logic.rouge.view.RougeFactionIllustrationDetailView", package.seeall)

local RougeFactionIllustrationDetailView = class("RougeFactionIllustrationDetailView", BaseView)

function RougeFactionIllustrationDetailView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goprogress = gohelper.findChild(self.viewGO, "#go_progress")
	self._goprogressitem = gohelper.findChild(self.viewGO, "#go_progress/#go_progressitem")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "Middle/#scroll_view")
	self._goContent = gohelper.findChild(self.viewGO, "Middle/#scroll_view/Viewport/#go_Content")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_Right")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_Left")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeFactionIllustrationDetailView:addEvents()
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
end

function RougeFactionIllustrationDetailView:removeEvents()
	self._btnRight:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
end

local delayTime = 0.3

function RougeFactionIllustrationDetailView:_btnRightOnClick()
	self._index = self._index + 1

	if self._index > self._num then
		self._index = 1
	end

	TaskDispatcher.cancelTask(self._delayUpdateInfo, self)
	TaskDispatcher.runDelay(self._delayUpdateInfo, self, delayTime)
	self._aniamtor:Play("switch_l", 0, 0)
end

function RougeFactionIllustrationDetailView:_btnLeftOnClick()
	self._index = self._index - 1

	if self._index < 1 then
		self._index = self._num
	end

	TaskDispatcher.cancelTask(self._delayUpdateInfo, self)
	TaskDispatcher.runDelay(self._delayUpdateInfo, self, delayTime)
	self._aniamtor:Play("switch_r", 0, 0)
end

function RougeFactionIllustrationDetailView:_delayUpdateInfo()
	self:_updateInfo(self._list[self._index])
end

function RougeFactionIllustrationDetailView:_editableInitView()
	local path = self.viewContainer:getSetting().otherRes[1]
	local itemGo = self:getResInst(path, self._goContent)

	self._item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, RougeFactionIllustrationDetailItem)

	local list = RougeOutsideModel.instance:getSeasonStyleInfoList()

	self._list = {}

	for i, v in ipairs(list) do
		if v.isUnLocked then
			table.insert(self._list, v.styleCO)
		end
	end

	self._num = #self._list
	self._aniamtor = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

	self:_initProgressItems()
end

function RougeFactionIllustrationDetailView:_initProgressItems()
	self._itemList = self:getUserDataTb_()

	for i = 1, self._num do
		local itemGo = gohelper.cloneInPlace(self._goprogressitem)
		local t = self:getUserDataTb_()

		t.empty = gohelper.findChild(itemGo, "empty")
		t.light = gohelper.findChild(itemGo, "light")

		gohelper.setActive(itemGo, true)

		self._itemList[i] = t
	end
end

function RougeFactionIllustrationDetailView:_showProgressItem(index)
	for i, v in ipairs(self._itemList) do
		gohelper.setActive(v.empty, i ~= index)
		gohelper.setActive(v.light, i == index)
	end
end

function RougeFactionIllustrationDetailView:onUpdateParam()
	return
end

function RougeFactionIllustrationDetailView:onOpen()
	local mo = self.viewParam

	self._index = tabletool.indexOf(self._list, mo) or 1

	self:_updateInfo(mo)
end

function RougeFactionIllustrationDetailView:_updateInfo(mo)
	self._mo = mo

	self._item:onUpdateMO(mo)
	self:_showProgressItem(self._index)
end

function RougeFactionIllustrationDetailView:onClose()
	return
end

function RougeFactionIllustrationDetailView:onDestroyView()
	TaskDispatcher.cancelTask(self._delayUpdateInfo, self)
end

return RougeFactionIllustrationDetailView
