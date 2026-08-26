-- chunkname: @modules/logic/sp02/paomian/guessme/view/Sp02_GuessMeTaskItem.lua

module("modules.logic.sp02.paomian.guessme.view.Sp02_GuessMeTaskItem", package.seeall)

local Sp02_GuessMeTaskItem = class("Sp02_GuessMeTaskItem", LuaCompBase)

function Sp02_GuessMeTaskItem:init(go)
	self.go = go
	self._goSelect = gohelper.findChild(self.go, "#go_Selected")
	self._goUnselect = gohelper.findChild(self.go, "#go_UnSelected")
	self._goLock = gohelper.findChild(self.go, "image_Locked")
	self._txtSelectDay = gohelper.findChildText(self.go, "#go_Selected/txt_DateSelected")
	self._txtUnselectDay = gohelper.findChildText(self.go, "#go_UnSelected/txt_DateUnSelected")
	self._txtLockedDay = gohelper.findChildText(self.go, "image_Locked/txt_DateLocked")
	self._goReddot = gohelper.findChild(self.go, "#go_reddot")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_click")
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
end

function Sp02_GuessMeTaskItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Sp02_GuessMeTaskItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Sp02_GuessMeTaskItem:_btnClickOnClick()
	if self._isSelect then
		return
	end

	if self._status == Sp02_GuessMeEnum.TaskStatus.Lock then
		GameFacade.showToast(ToastEnum.SP02GuessMeLock)

		return
	end

	AudioMgr.instance:trigger(AudioEnum3_10.PaoMian.GuessMeSwitchDay)
	Sp02_PaoMianController.instance:dispatchEvent(Sp02_GuessMeEvent.OnSelectGuessMeDay, self._index)
end

function Sp02_GuessMeTaskItem:onUpdateMO(index, config, isSelect)
	self._index = index
	self._config = config
	self._activityId = config and config.activityId
	self._id = config and config.id
	self._preIsSelect = self._isSelect
	self._isSelect = isSelect
	self._signMo = Sp02_GuessMeModel.instance:getSignInfo(self._activityId, self._id)
	self._preStatus = self._status
	self._status = self._signMo and self._signMo:getStatus() or Sp02_GuessMeEnum.TaskStatus.Lock
	self._activityCo = ActivityConfig.instance:getActivityCo(self._activityId)
	self._redDotId = self._activityCo and self._activityCo.redDotId

	self:refreshUI()
	self:playSelectAnim()
end

function Sp02_GuessMeTaskItem:refreshUI()
	RedDotController.instance:addRedDot(self._goReddot, self._redDotId, self._id)

	local dayStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_guessmeview_day"), self._index)

	self._txtSelectDay.text = dayStr
	self._txtUnselectDay.text = dayStr
	self._txtLockedDay.text = dayStr

	gohelper.setActive(self._goSelect, self._isSelect)
	gohelper.setActive(self._goUnselect, not self._isSelect and self._status ~= Sp02_GuessMeEnum.TaskStatus.Lock)
	gohelper.setActive(self._goLock, self._status == Sp02_GuessMeEnum.TaskStatus.Lock)

	if self._preStatus == Sp02_GuessMeEnum.TaskStatus.Lock and self._status ~= Sp02_GuessMeEnum.TaskStatus.Lock then
		gohelper.setActive(self._goLock, true)
		self._animator:Play("unlock", 0, 0)
	end
end

function Sp02_GuessMeTaskItem:playSelectAnim()
	if self._preIsSelect == self._isSelect then
		return
	end

	if self._isSelect then
		self._animator:Play("select", 0, 0)
	end
end

return Sp02_GuessMeTaskItem
