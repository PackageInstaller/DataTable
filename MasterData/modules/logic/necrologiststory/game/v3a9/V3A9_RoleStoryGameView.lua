-- chunkname: @modules/logic/necrologiststory/game/v3a9/V3A9_RoleStoryGameView.lua

module("modules.logic.necrologiststory.game.v3a9.V3A9_RoleStoryGameView", package.seeall)

local V3A9_RoleStoryGameView = class("V3A9_RoleStoryGameView", BaseView)

function V3A9_RoleStoryGameView:onInitView()
	self.btnGoto = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_goto")
	self.txtProgress = gohelper.findChildTextMesh(self.viewGO, "Middle/#btn_goto/#txt_progress")
	self.goLevelItem = gohelper.findChild(self.viewGO, "Middle/pos/#go_levelitem")

	gohelper.setActive(self.goLevelItem, false)

	self.itemList = {}
	self.goCompleted = gohelper.findChild(self.viewGO, "Middle/completed")

	gohelper.setActive(self.goCompleted, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A9_RoleStoryGameView:addEvents()
	self.addClickCb(self, self.btnGoto, self.onClickGoto, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V3A9_RoleStoryGameView:removeEvents()
	self:removeClickCb(self.btnGoto)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function V3A9_RoleStoryGameView:_editableInitView()
	return
end

function V3A9_RoleStoryGameView:onClickGoto()
	ViewMgr.instance:openView(ViewName.V3A9_RoleStoryClueView, {
		roleStoryId = self.heroStoryId
	})
end

function V3A9_RoleStoryGameView:onClickLevelItem(item)
	local config = item.config

	if not config then
		return
	end

	local plotConfig = NecrologistStoryConfig.instance:getPlotGroupCo(config.storyId)

	if not plotConfig then
		return
	end

	local isFinish = self.gameBaseMO:isStoryFinish(plotConfig.id)

	NecrologistStoryController.instance:openStoryView(plotConfig.id, not isFinish and self.gameBaseMO.id)
end

function V3A9_RoleStoryGameView:_onCloseViewFinish(viewName)
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if not isTop then
		return
	end

	self:refreshView()
end

function V3A9_RoleStoryGameView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function V3A9_RoleStoryGameView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function V3A9_RoleStoryGameView:onOpenFinish()
	self:refreshCompleted()
end

function V3A9_RoleStoryGameView:refreshParam()
	if not self.viewParam then
		local viewParam = {}
		local storyId = viewParam.roleStoryId

		self.heroStoryId = storyId

		if storyId then
			self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
		end
	end
end

function V3A9_RoleStoryGameView:refreshData()
	return
end

function V3A9_RoleStoryGameView:refreshView()
	self:refreshData()
	self:refreshLevel()

	local cur, total = self.gameBaseMO:getProgress()

	self.txtProgress.text = string.format("<#FF7A33>%s</color>/%s", cur, total)
end

function V3A9_RoleStoryGameView:refreshLevel()
	self.isCompleted = true

	local list = NecrologistStoryV3A9Config.instance:getBaseList()

	for i = 1, math.max(#list, #self.itemList) do
		local config = list[i]
		local item = self:getLevelItem(i)

		self:refreshLevelItem(item, config)
	end

	self:refreshCompleted()
end

function V3A9_RoleStoryGameView:getLevelItem(index)
	local item = self.itemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.index = index

		local goParent = gohelper.findChild(self.viewGO, string.format("Middle/pos/pos_%d", index))

		item.go = gohelper.clone(self.goLevelItem, goParent, tostring(index))

		recthelper.setAnchor(item.go.transform, 0, 0)

		item.simage = gohelper.findChildSingleImage(item.go, "#simage_level")
		item.txtName = gohelper.findChildTextMesh(item.go, "#txt_name")
		item.txtIndex = gohelper.findChildTextMesh(item.go, "index/#txt_index")
		item.goCurrent = gohelper.findChild(item.go, "#go_current")
		item.btnClick = gohelper.findChildButtonWithAudio(item.go, "click")

		self.addClickCb(self, item.btnClick, self.onClickLevelItem, self, item)

		item.anim = item.go:GetComponent(typeof(UnityEngine.Animator))
		self.itemList[index] = item
	end

	return item
end

function V3A9_RoleStoryGameView:refreshLevelItem(item, config)
	item.config = config

	if not config then
		gohelper.setActive(item.go, false)

		return
	end

	item.txtIndex.text = tostring(item.index)
	item.txtName.text = config.name

	item.simage:LoadImage(ResUrl.getRoleStoryIcon(string.format("3054/%s", config.pic)))

	local baseState = self.gameBaseMO:getBaseState(config.id)
	local hide = baseState == NecrologistStoryEnum.V3A2BaseState.Hide or baseState == NecrologistStoryEnum.V3A2BaseState.Lock

	gohelper.setActive(item.go, not hide)

	if not hide then
		gohelper.setActive(item.goCurrent, baseState == NecrologistStoryEnum.V3A2BaseState.Normal)
	end

	local isNormal = baseState == NecrologistStoryEnum.V3A2BaseState.Normal
	local isNeedPlayUnlock = item.isNormal == false and isNormal

	if isNeedPlayUnlock then
		item.anim:Play("open", 0, 0)
	end

	item.isNormal = isNormal

	if baseState ~= NecrologistStoryEnum.V3A2BaseState.Finish then
		self.isCompleted = false
	end
end

function V3A9_RoleStoryGameView:refreshCompleted()
	if not self.viewContainer:isOpenFinish() then
		return
	end

	gohelper.setActive(self.goCompleted, self.isCompleted)
end

function V3A9_RoleStoryGameView:onDestroyView()
	for k, v in pairs(self.itemList) do
		v.simage:UnLoadImage()
		self:removeClickCb(v.btnClick)
	end
end

return V3A9_RoleStoryGameView
