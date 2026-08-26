-- chunkname: @modules/logic/necrologiststory/game/v3a5/V3A5_RoleStoryBulletView.lua

module("modules.logic.necrologiststory.game.v3a5.V3A5_RoleStoryBulletView", package.seeall)

local V3A5_RoleStoryBulletView = class("V3A5_RoleStoryBulletView", BaseView)

function V3A5_RoleStoryBulletView:onInitView()
	self.btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A5_RoleStoryBulletView:addEvents()
	self.addClickCb(self, self.btnClick, self.onClickBtnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

function V3A5_RoleStoryBulletView:removeEvents()
	self:removeClickCb(self.btnClick)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

function V3A5_RoleStoryBulletView:_editableInitView()
	return
end

function V3A5_RoleStoryBulletView:onClickBtnClick()
	return
end

function V3A5_RoleStoryBulletView:onOpen()
	self:refreshParam()
	self:refreshView()
	GameUtil.setActiveUIBlock(self.viewName, true, false)
end

function V3A5_RoleStoryBulletView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function V3A5_RoleStoryBulletView:refreshParam()
	self.beforeBulletCount = self.viewParam.beforeBulletCount
	self.bulletCount = self.viewParam.bulletCount
	self.nodeId = self.viewParam.nodeId
	self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(NecrologistStoryEnum.RoleStoryId.V3A5)
end

function V3A5_RoleStoryBulletView:refreshView()
	self.curBulletCount = self.beforeBulletCount

	self:refreshBullet()

	if self.bulletCount > self.beforeBulletCount then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_bfz_yishi_bullet_load)
	else
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_bfz_yishi_bullet_take)
	end

	TaskDispatcher.runDelay(self.nextRefreshBullet, self, 1)
end

function V3A5_RoleStoryBulletView:nextRefreshBullet()
	if self.bulletCount == self.beforeBulletCount then
		GameFacade.showToast(ToastEnum.V3A5NecrologistStoryTips1)
	end

	self.curBulletCount = self.bulletCount

	self:refreshBullet()
	self:playAnim()
	TaskDispatcher.runDelay(self.playStory, self, 1.6)
end

function V3A5_RoleStoryBulletView:playAnim()
	if self.bulletCount == self.beforeBulletCount then
		return
	end

	local isIn = self.bulletCount > self.beforeBulletCount

	if isIn then
		local unfilGO = self.unfilBulletList[7 - self.bulletCount]

		gohelper.setActive(unfilGO, true)

		local filGO = self.bulletList[self.bulletCount]

		self.outGO = gohelper.findChild(unfilGO, "go_bullet1")
		self.outAnim = self.outGO:GetComponent(typeof(UnityEngine.Animator))
		self.inGO = filGO
		self.inAnim = filGO:GetComponent(typeof(UnityEngine.Animator))
	else
		local unfilGO = self.unfilBulletList[6 - self.bulletCount]

		gohelper.setActive(unfilGO, true)

		local filGO = self.bulletList[self.bulletCount + 1]

		self.outGO = filGO
		self.outAnim = filGO:GetComponent(typeof(UnityEngine.Animator))
		self.inGO = gohelper.findChild(unfilGO, "go_bullet1")
		self.inAnim = self.inGO:GetComponent(typeof(UnityEngine.Animator))
	end

	gohelper.setActive(self.inGO, false)
	gohelper.setActive(self.outGO, true)
	self.outAnim:Play("out", 0, 0)
	TaskDispatcher.runDelay(self.playInAnim, self, 0.167)
end

function V3A5_RoleStoryBulletView:playInAnim()
	gohelper.setActive(self.inGO, true)
	self.inAnim:Play("in", 0, 0)
end

function V3A5_RoleStoryBulletView:playStory()
	local config = NecrologistStoryV3A5Config.instance:getBaseConfig(self.nodeId)

	if config.storyId > 0 then
		if self.gameBaseMO:isStoryFinish(config.storyId) then
			NecrologistStoryController.instance:openStoryView(config.storyId)
		else
			NecrologistStoryController.instance:openStoryView(config.storyId, self.gameBaseMO.id)
		end
	else
		self:closeThis()
	end
end

function V3A5_RoleStoryBulletView:_onOpenViewFinish(viewName)
	if viewName == ViewName.NecrologistStoryView then
		self:closeThis()
	end
end

function V3A5_RoleStoryBulletView:refreshBullet()
	if not self.bulletList then
		self.bulletList = {}
		self.unfilBulletList = {}

		local unfillGOItem = gohelper.findChild(self.viewGO, "bullet/go_bullet")

		gohelper.setActive(unfillGOItem, false)

		for i = 1, 6 do
			local go = gohelper.findChild(self.viewGO, string.format("filled/%s", i))

			table.insert(self.bulletList, go)

			local unfillGO = gohelper.cloneInPlace(unfillGOItem, tostring(i))

			table.insert(self.unfilBulletList, unfillGO)
		end
	end

	local isOut = self.bulletCount < self.beforeBulletCount
	local bulletCount = self.curBulletCount

	for i = 1, 6 do
		gohelper.setActive(self.bulletList[i], i <= bulletCount)
		gohelper.setActive(self.unfilBulletList[i], i <= 6 - bulletCount)
	end

	if isOut then
		local unfilGO = self.unfilBulletList[6 - self.bulletCount]

		gohelper.setActive(unfilGO, true)

		local inGO = gohelper.findChild(unfilGO, "go_bullet1")

		gohelper.setActive(inGO, false)
	end
end

function V3A5_RoleStoryBulletView:onDestroyView()
	GameUtil.setActiveUIBlock(self.viewName, false, false)
	TaskDispatcher.cancelTask(self.nextRefreshBullet, self)
	TaskDispatcher.cancelTask(self.playStory, self)
	TaskDispatcher.cancelTask(self.playInAnim, self)
end

return V3A5_RoleStoryBulletView
