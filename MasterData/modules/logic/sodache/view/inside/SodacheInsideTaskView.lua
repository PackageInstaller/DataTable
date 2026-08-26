-- chunkname: @modules/logic/sodache/view/inside/SodacheInsideTaskView.lua

module("modules.logic.sodache.view.inside.SodacheInsideTaskView", package.seeall)

local SodacheInsideTaskView = class("SodacheInsideTaskView", BaseView)

function SodacheInsideTaskView:onInitView()
	self._goTask = gohelper.findChild(self.viewGO, "Left/#scroll_task/Viewport/#go_taskContent/#go_Task")
	self._btnFold = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#scroll_task/Viewport/#go_taskContent/#go_Task/#go_fold/#btn_fold")
	self._goUnfold = gohelper.findChild(self.viewGO, "Left/#scroll_task/Viewport/#go_taskContent/#go_unfold")
	self._btnUnfold = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#scroll_task/Viewport/#go_taskContent/#go_unfold/#btn_unfold")
	self._goTaskItem = gohelper.findChild(self.viewGO, "Left/#scroll_task/Viewport/#go_taskContent/#go_Task/#go_TaskItem")
	self._buffContent = gohelper.findChild(self.viewGO, "Left/#scroll_task/Viewport/#go_taskContent/#go_buff/#scroll_buff/viewport/content")
	self._buffContent2 = gohelper.findChild(self.viewGO, "Left/#scroll_task/Viewport/#go_taskContent/#go_buff/#go_grid")
	self._goBuffItem = gohelper.findChild(self.viewGO, "Left/#scroll_task/Viewport/#go_taskContent/#go_buff/go_buffitem")
	self._goscroll = gohelper.findChild(self.viewGO, "Left/#scroll_task/Viewport/#go_taskContent/#go_buff/#scroll_buff")
	self._anim = gohelper.findChildAnim(self.viewGO, "Left/#scroll_task/Viewport/#go_taskContent")
	self._anim.keepAnimatorStateOnDisable = true

	gohelper.setActive(self._goBuffItem, false)
end

function SodacheInsideTaskView:addEvents()
	self._btnFold:AddClickListener(self.onFoldClick, self)
	self._btnUnfold:AddClickListener(self.onUnfoldClick, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnBagUpdate, self._refreshBuff, self)
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnTaskChange, self._refreshTask, self)
end

function SodacheInsideTaskView:removeEvents()
	self._btnFold:RemoveClickListener()
	self._btnUnfold:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnBagUpdate, self._refreshBuff, self)
	self.removeEventCb(self, SodacheController.instance, SodacheEvent.OnTaskChange, self._refreshTask, self)
end

function SodacheInsideTaskView:onOpen()
	self._isFolder = false

	gohelper.setActive(self._goUnfold, false)
	gohelper.setActive(self._goTask, true)
	self:setBuffFolder(false)
	self._anim:Play("expand", 0, 1)
	self:_refreshTask()
	self:_refreshBuff()
end

function SodacheInsideTaskView:onUnfoldClick()
	self._isFolder = false

	self._anim:Play("switch", 0, 0)
	UIBlockHelper.instance:startBlock("SodacheInsideTaskView_FoldAnim", 0.25)
	TaskDispatcher.runDelay(self._delayRefresh, self, 0.25)
end

function SodacheInsideTaskView:onFoldClick()
	self._isFolder = true

	self._anim:Play("switch", 0, 0)
	UIBlockHelper.instance:startBlock("SodacheInsideTaskView_FoldAnim", 0.25)
	TaskDispatcher.runDelay(self._delayRefresh, self, 0.25)
end

function SodacheInsideTaskView:_delayRefresh()
	gohelper.setActive(self._goUnfold, self._isFolder)
	gohelper.setActive(self._goTask, not self._isFolder)
	self:setBuffFolder(self._isFolder)
end

function SodacheInsideTaskView:setBuffFolder(isFold)
	recthelper.setWidth(self._goscroll.transform, isFold and 256 or 556.5745)
end

function SodacheInsideTaskView:openTaskView()
	ViewMgr.instance:openView(ViewName.SodacheTaskView)
end

function SodacheInsideTaskView:_refreshTask()
	local tasks = SodacheModel.instance:getOutsideMo().taskBox:getInsideTasks()

	if #tasks > 0 then
		gohelper.setActive(self._buffContent, true)
		gohelper.setActive(self._buffContent2, false)
		gohelper.CreateObjList(self, self._createTask, tasks, nil, self._goTaskItem, nil, nil, nil, 1)
	else
		gohelper.setActive(self._buffContent, false)
		gohelper.setActive(self._buffContent2, true)
		gohelper.setActive(self._goUnfold, false)
		gohelper.setActive(self._goTask, false)
		recthelper.setWidth(self._goscroll.transform, 256)
	end
end

function SodacheInsideTaskView:_createTask(obj, data, index)
	local sub = gohelper.findChild(obj, "bg/go_sub")
	local main = gohelper.findChild(obj, "bg/go_main")
	local txtDesc = gohelper.findChildTextMesh(obj, "txt_taskDesc")
	local btn = gohelper.findChildButtonWithAudio(obj, "#btn_click")

	gohelper.setActive(main, data.config.type == SodacheEnum.TaskType.Main)
	gohelper.setActive(sub, data.config.type == SodacheEnum.TaskType.Branch)

	txtDesc.text = data.state == SodacheEnum.TaskState.Processing and string.format("%s(%s/%s)", data.config.desc, data.progress, data.config.maxProgress) or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sodache_inside_taskdesc"), data.config.desc)

	self.addClickCb(self, btn, self.openTaskView, self)
end

function SodacheInsideTaskView:_refreshBuff()
	local buffCards = {}
	local dict = {}
	local cards = SodacheUtil.getItemsByCardType(SodacheEnum.CardType.Status, SodacheEnum.BagType.Inside)

	for i, v in ipairs(cards) do
		if v.itemCo.disappear ~= 1 then
			if not dict[v.configId] then
				dict[v.configId] = SodacheCardMo.Create(v.configId, v.count)

				table.insert(buffCards, dict[v.configId])
			else
				dict[v.configId].serverMo.count = dict[v.configId].serverMo.count + v.count
			end
		end
	end

	gohelper.CreateObjList(self, self._createBuff, buffCards, self._buffContent, self._goBuffItem)
	gohelper.CreateObjList(self, self._createBuff, buffCards, self._buffContent2, self._goBuffItem)
end

function SodacheInsideTaskView:_createBuff(obj, data, index)
	local btn = gohelper.findButtonWithAudio(obj)
	local simage = gohelper.findChildSingleImage(obj, "#simage_buff")
	local num = gohelper.findChild(obj, "num")
	local txtNum = gohelper.findChildTextMesh(obj, "num/#txt_num")

	simage:LoadImage(ResUrl.getSodacheSingleBg(data.serverMo.itemCo.icon .. "_1", "bufficon"))
	gohelper.setActive(num, data.serverMo.count > 1)

	if data.serverMo.count > 1 then
		txtNum.text = tostring(data.serverMo.count)
	end

	self:removeClickCb(btn)
	self.addClickCb(self, btn, self._onBuffClick, self, data)
end

function SodacheInsideTaskView:_onBuffClick(cardMo)
	ViewMgr.instance:openView(ViewName.SodacheCardDetailView, {
		cardMo = cardMo
	})
end

function SodacheInsideTaskView:onClose()
	TaskDispatcher.cancelTask(self._delayRefresh, self)
end

return SodacheInsideTaskView
