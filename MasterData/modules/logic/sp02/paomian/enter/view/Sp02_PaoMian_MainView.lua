-- chunkname: @modules/logic/sp02/paomian/enter/view/Sp02_PaoMian_MainView.lua

module("modules.logic.sp02.paomian.enter.view.Sp02_PaoMian_MainView", package.seeall)

local Sp02_PaoMian_MainView = class("Sp02_PaoMian_MainView", BaseView)

function Sp02_PaoMian_MainView:onInitView()
	self._goMarcus = gohelper.findChild(self.viewGO, "root/activityentry1")
	self._goGuessMe = gohelper.findChild(self.viewGO, "root/activityentry2")
	self._goStore = gohelper.findChild(self.viewGO, "root/activitystore")
	self._txtTime = gohelper.findChildText(self.viewGO, "root/activitytime/#txt_time")
	self._goHeroContainer = gohelper.findChild(self.viewGO, "#go_HeroContainer")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Sp02_PaoMian_MainView:addEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.refreshUI, self)
	self.addEventCb(self, Sp02_PaoMianController.instance, Sp02_GuessMeEvent.OnUpdateGuessMe, self.refreshUI, self)
	self.addEventCb(self, Sp02_PaoMianController.instance, Sp02_MarcusEvent.OnUpdateMarcus, self.refreshUI, self)
end

function Sp02_PaoMian_MainView:removeEvents()
	return
end

function Sp02_PaoMian_MainView:_editableInitView()
	self._entryItemList = self:getUserDataTb_()

	table.insert(self._entryItemList, Sp02_MarcusEntryItem.Get(self._goMarcus, ActivityEnum.Activity.SP02_PaoMianActivityMarcus))
	table.insert(self._entryItemList, Sp02_GuessMeEntryItem.Get(self._goGuessMe, ActivityEnum.Activity.SP02_PaoMianActivityGuessMe))
	table.insert(self._entryItemList, Sp02_PaoMianShopEntryItem.Get(self._goStore, ActivityEnum.Activity.SP02_PaoMianActivityShop))
end

function Sp02_PaoMian_MainView:onUpdateParam()
	return
end

function Sp02_PaoMian_MainView:onOpen()
	self._actId = self.viewParam and self.viewParam.actId
	self._activityMo = ActivityModel.instance:getActMO(self._actId)
	self._activityCo = ActivityConfig.instance:getActivityCo(self._actId)

	self:initHeroList()
	self:refreshUI()
	TaskDispatcher.cancelTask(self.refreshUI, self)
	TaskDispatcher.runRepeat(self.refreshUI, self, 30)
	AudioMgr.instance:trigger(AudioEnum3_10.PaoMian.EnterMainView)
end

function Sp02_PaoMian_MainView:refreshUI()
	self:refreshAllEntry()
	self:refreshEnterRemainTime()
end

function Sp02_PaoMian_MainView:refreshAllEntry()
	for _, entryItem in ipairs(self._entryItemList) do
		entryItem:onUpdateMO()
	end
end

function Sp02_PaoMian_MainView:refreshEnterRemainTime()
	self._txtTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function Sp02_PaoMian_MainView:initHeroList()
	local heroList = Sp02_GuessMeConfig.instance:getActHeroList(self._actId) or {}

	for i, heroCo in ipairs(heroList) do
		local goHero = gohelper.findChild(self.viewGO, "root/role/clickbtn/#btn_role" .. i)
		local heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(goHero, Sp02_PaoMainEnterHeroItem)

		heroItem:onUpdateMO(i, heroCo, heroList)
	end
end

function Sp02_PaoMian_MainView:onClose()
	TaskDispatcher.cancelTask(self.refreshUI, self)
end

function Sp02_PaoMian_MainView:onDestroyView()
	return
end

return Sp02_PaoMian_MainView
