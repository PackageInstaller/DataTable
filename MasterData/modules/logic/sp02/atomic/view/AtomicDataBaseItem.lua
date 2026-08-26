-- chunkname: @modules/logic/sp02/atomic/view/AtomicDataBaseItem.lua

module("modules.logic.sp02.atomic.view.AtomicDataBaseItem", package.seeall)

local AtomicDataBaseItem = class("AtomicDataBaseItem", ListScrollCellExtend)

function AtomicDataBaseItem:onInitView()
	self.simageBg = gohelper.findChildSingleImage(self.viewGO, "#image_bg")
	self.goLock = gohelper.findChild(self.viewGO, "#go_empty")
	self.goNew = gohelper.findChild(self.viewGO, "#image_new")
	self.goNameBg = gohelper.findChild(self.viewGO, "namebg")
	self.txtName = gohelper.findChildTextMesh(self.viewGO, "#txt_name")
	self.btnClick = gohelper.findButtonWithAudio(self.viewGO, AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self.anim = gohelper.findComponentAnim(self.viewGO)
	self.__openAnimLen = 0.333
end

function AtomicDataBaseItem:addEvents()
	self.addClickCb(self, self.btnClick, self._onClickBtnClick, self)
end

function AtomicDataBaseItem:removeEvents()
	self:removeClickCb(self.btnClick)
end

function AtomicDataBaseItem:_onClickBtnClick()
	if not self._mo then
		return
	end

	local config = self._mo.config

	if not config then
		return
	end

	local dataId = config.id
	local isUnlock = AtomicDataBaseViewModel.instance:isLibraryUnlock(dataId)

	if not isUnlock then
		AtomicDataBaseController.instance:dispatchEvent(AtomicEvent.DataBaseShowLocked, luaLang("sp02_atomic_database_locktips"))

		return
	end

	local param = {}

	param.id = dataId
	param.dataList = AtomicDataBaseViewModel.instance:getList()

	AtomicController.instance:openDataBaseInfoView(param)
end

function AtomicDataBaseItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshView()
end

function AtomicDataBaseItem:refreshView()
	if not self._mo then
		return
	end

	local config = self._mo.config
	local dataId = config.id
	local isUnlock = AtomicDataBaseViewModel.instance:isLibraryUnlock(dataId)

	self:setIsUnlock(isUnlock)

	local isNew = AtomicDataBaseViewModel.instance:isLibraryNew(dataId)

	gohelper.setActive(self.goNew, isUnlock and isNew)

	self.txtName.text = config.title

	TaskDispatcher.cancelTask(self.playUnlockAnim, self)

	if isUnlock and not AtomicDataBaseViewModel.instance:isPlayedUnlockAnim(dataId) then
		self:setIsUnlock(false)
		TaskDispatcher.runDelay(self.playUnlockAnim, self, self.__openAnimLen)
	end
end

function AtomicDataBaseItem:setIsUnlock(isUnlock)
	gohelper.setActive(self.goLock, not isUnlock)
	gohelper.setActive(self.simageBg.gameObject, isUnlock)
	gohelper.setActive(self.goNameBg, isUnlock)
	gohelper.setActive(self.txtName, isUnlock)

	if isUnlock then
		self.simageBg:LoadImage(string.format("singlebg/sp02_atomicforyou/%s.png", self._mo.config.res))
	end
end

function AtomicDataBaseItem:playUnlockAnim()
	AtomicDataBaseViewModel.instance:setPlayedUnlockAnim(self._mo.config.id)
	self:setIsUnlock(true)
	self.anim:Play("unlock", 0, 0)
end

function AtomicDataBaseItem:getAnimator()
	return self.anim
end

function AtomicDataBaseItem:onDestroyView()
	if self.simageBg then
		self.simageBg:UnLoadImage()
	end

	TaskDispatcher.cancelTask(self.playUnlockAnim, self)
end

return AtomicDataBaseItem
