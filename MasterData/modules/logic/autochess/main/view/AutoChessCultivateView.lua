-- chunkname: @modules/logic/autochess/main/view/AutoChessCultivateView.lua

module("modules.logic.autochess.main.view.AutoChessCultivateView", package.seeall)

local AutoChessCultivateView = class("AutoChessCultivateView", BaseView)

function AutoChessCultivateView:onInitView()
	self._goWarning = gohelper.findChild(self.viewGO, "root/#go_Warning")
	self._btnBoss = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Boss")
	self._btnCollection = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Collection")
	self._btnTask = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Task")
	self._btnCardpack = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Cardpack")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessCultivateView:addEvents()
	self._btnBoss:AddClickListener(self._btnBossOnClick, self)
	self._btnCollection:AddClickListener(self._btnCollectionOnClick, self)
	self._btnTask:AddClickListener(self._btnTaskOnClick, self)
	self._btnCardpack:AddClickListener(self._btnCardpackOnClick, self)
end

function AutoChessCultivateView:removeEvents()
	self._btnBoss:RemoveClickListener()
	self._btnCollection:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnCardpack:RemoveClickListener()
end

function AutoChessCultivateView:_btnBossOnClick()
	AutoChessController.instance:statButtonClick(self.viewName, "_btnBossOnClick")
	ViewMgr.instance:openView(ViewName.AutoChessBossBookView)
end

function AutoChessCultivateView:_btnCollectionOnClick()
	AutoChessController.instance:statButtonClick(self.viewName, "_btnCollectionOnClick")
	ViewMgr.instance:openView(ViewName.AutoChessSpecialBookView)
end

function AutoChessCultivateView:_btnTaskOnClick()
	AutoChessController.instance:statButtonClick(self.viewName, "_btnTaskOnClick")
	ViewMgr.instance:openView(ViewName.AutoChessTaskView)
end

function AutoChessCultivateView:_btnCardpackOnClick()
	AutoChessController.instance:statButtonClick(self.viewName, "_btnCardpackOnClick")
	ViewMgr.instance:openView(ViewName.AutoChessCardpackView, AutoChessCardpackView.OpenType.Book)
end

function AutoChessCultivateView:_editableInitView()
	self.actMo = Activity182Model.instance:getActMo()

	local goReddot = gohelper.findChild(self._btnBoss.gameObject, "go_reddot")

	self.bossReddot = RedDotController.instance:addNotEventRedDot(goReddot, self._checkBossReddot, self)
	goReddot = gohelper.findChild(self._btnCollection.gameObject, "go_reddot")
	self.collectionReddot = RedDotController.instance:addNotEventRedDot(goReddot, self._checkCollectionReddot, self)
	goReddot = gohelper.findChild(self._btnTask.gameObject, "go_reddot")

	RedDotController.instance:addRedDot(goReddot, RedDotEnum.DotNode.V2a5_AutoChess)

	goReddot = gohelper.findChild(self._btnCardpack.gameObject, "go_reddot")
	self.cardpackReddot = RedDotController.instance:addNotEventRedDot(goReddot, self._checkCardpackReddot, self)
end

function AutoChessCultivateView:onOpen()
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.updateCultivateReddot, self.onUpdateReddot, self)

	local go = self:getResInst(AutoChessStrEnum.ResPath.WarningItem, self._goWarning)
	local warningItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessWarningItem)

	warningItem:refresh()
end

function AutoChessCultivateView:_checkBossReddot()
	return self.actMo:checkBossReddot()
end

function AutoChessCultivateView:_checkCollectionReddot()
	return self.actMo:checkCollectionReddot()
end

function AutoChessCultivateView:_checkCardpackReddot()
	return self.actMo:checkCardpackReddot()
end

function AutoChessCultivateView:onUpdateReddot()
	self.bossReddot:refreshRedDot()
	self.collectionReddot:refreshRedDot()
	self.cardpackReddot:refreshRedDot()
end

return AutoChessCultivateView
