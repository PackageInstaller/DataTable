-- chunkname: @modules/logic/rouge/map/view/choicebase/RougeMapChoiceBaseItem.lua

module("modules.logic.rouge.map.view.choicebase.RougeMapChoiceBaseItem", package.seeall)

local RougeMapChoiceBaseItem = class("RougeMapChoiceBaseItem", UserDataDispose)

function RougeMapChoiceBaseItem:init(go)
	self:__onInit()

	self.go = go
	self.tr = go:GetComponent(gohelper.Type_RectTransform)

	self:_editableInitView()
end

function RougeMapChoiceBaseItem:_editableInitView()
	self.click = gohelper.getClickWithDefaultAudio(self.go)

	self.click:AddClickListener(self.onClickSelf, self)

	self.animator = self.go:GetComponent(gohelper.Type_Animator)
	self._golocked = gohelper.findChild(self.go, "#go_locked")
	self._txtlocktitle = gohelper.findChildText(self.go, "#go_locked/#txt_locktitle")
	self._txtlockdesc = gohelper.findChildText(self.go, "#go_locked/#txt_lockdesc")
	self._txtlocktip = gohelper.findChildText(self.go, "#go_locked/#txt_locktip")
	self._golockdetail = gohelper.findChild(self.go, "#go_locked/#btn_lockdetail")
	self._golockdetail2 = gohelper.findChild(self.go, "#go_locked/#btn_lockdetail2")
	self.goLockTip = self._txtlocktip.gameObject
	self._gonormal = gohelper.findChild(self.go, "#go_normal")
	self._txtnormaltitle = gohelper.findChildText(self.go, "#go_normal/#txt_normaltitle")
	self._txtnormaldesc = gohelper.findChildText(self.go, "#go_normal/#txt_normaldesc")
	self._txtnormaltip = gohelper.findChildText(self.go, "#go_normal/#txt_normaltip")
	self._gonormaldetail = gohelper.findChild(self.go, "#go_normal/#btn_normaldetail")
	self._gonormaldetail2 = gohelper.findChild(self.go, "#go_normal/#btn_normaldetail2")
	self._goselect = gohelper.findChild(self.go, "#go_select")
	self._txtselecttitle = gohelper.findChildText(self.go, "#go_select/#txt_selecttitle")
	self._txtselectdesc = gohelper.findChildText(self.go, "#go_select/#txt_selectdesc")
	self._txtselecttip = gohelper.findChildText(self.go, "#go_select/#txt_selecttip")
	self._goselectdetail = gohelper.findChild(self.go, "#go_select/#btn_selectdetail")
	self._goselectdetail2 = gohelper.findChild(self.go, "#go_select/#btn_selectdetail2")

	gohelper.setActive(self._golockdetail, false)
	gohelper.setActive(self._golockdetail2, false)
	gohelper.setActive(self._gonormaldetail, false)
	gohelper.setActive(self._goselectdetail, false)
	gohelper.setActive(self._gonormaldetail2, false)
	gohelper.setActive(self._goselectdetail2, false)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onChoiceItemStatusChange, self.onStatusChange, self)
end

function RougeMapChoiceBaseItem:onStatusChange(choiceId)
	return
end

function RougeMapChoiceBaseItem:onClickSelf()
	return
end

function RougeMapChoiceBaseItem:onSelectAnimDone()
	return
end

function RougeMapChoiceBaseItem:update(pos)
	recthelper.setAnchor(self.tr, pos.x, pos.y)
end

function RougeMapChoiceBaseItem:canShowNormalUI()
	return self.status == RougeMapEnum.ChoiceStatus.Normal or self.status == RougeMapEnum.ChoiceStatus.UnSelect
end

function RougeMapChoiceBaseItem:canShowLockUI()
	return self.status == RougeMapEnum.ChoiceStatus.Lock
end

function RougeMapChoiceBaseItem:canShowSelectUI()
	return self.status == RougeMapEnum.ChoiceStatus.Select
end

function RougeMapChoiceBaseItem:refreshUI()
	self:refreshLockUI()
	self:refreshNormalUI()
	self:refreshSelectUI()
end

function RougeMapChoiceBaseItem:refreshLockUI()
	local show = self:canShowLockUI()

	gohelper.setActive(self._golocked, show)

	if show then
		self._txtlocktitle.text = self.title
		self._txtlockdesc.text = self.desc
		self._txtlocktip.text = self.tip

		gohelper.setActive(self.goLockTip, not string.nilorempty(self.tip))
	end
end

function RougeMapChoiceBaseItem:refreshNormalUI()
	local show = self:canShowNormalUI()

	gohelper.setActive(self._gonormal, show)

	if show then
		self._txtnormaltitle.text = self.title
		self._txtnormaldesc.text = self.desc
		self._txtnormaltip.text = self.tip

		if self.status == RougeMapEnum.ChoiceStatus.Normal then
			self.animator:Play("normal", 0, 0)
		else
			self.animator:Play("unselect", 0, 0)
		end
	end
end

function RougeMapChoiceBaseItem:refreshSelectUI()
	local show = self:canShowSelectUI()

	gohelper.setActive(self._goselect, show)

	if show then
		self._txtselecttitle.text = self.title
		self._txtselectdesc.text = self.desc
		self._txtselecttip.text = self.tip
	end
end

function RougeMapChoiceBaseItem:clearCallback()
	if self.callbackId then
		RougeRpc.instance:removeCallbackById(self.callbackId)

		self.callbackId = nil
	end
end

function RougeMapChoiceBaseItem:show()
	gohelper.setActive(self.go, true)
end

function RougeMapChoiceBaseItem:hide()
	gohelper.setActive(self.go, false)
end

function RougeMapChoiceBaseItem:destroy()
	TaskDispatcher.cancelTask(self.onSelectAnimDone, self)
	self.click:RemoveClickListener()
	self:clearCallback()
	self:__onDispose()
end

return RougeMapChoiceBaseItem
