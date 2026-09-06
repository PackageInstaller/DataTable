-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexiuerclg/view/DivineXiuErClgNorSureView.lua

module("logic.extensions.divinexiuerclg.view.DivineXiuErClgNorSureView", package.seeall)

local DivineXiuErClgNorSureView = class("DivineXiuErClgNorSureView", ViewComponent)

function DivineXiuErClgNorSureView:buildUI()
	DivineXiuErClgNorSureView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._sucValueCol = goutil.findChild(self.mainGO, "sucValueCol")
	self._sucValueCol_txtOldValue = goutil.findChildTextComponent(self.mainGO, "sucValueCol/txtOldValue")
	self._sucValueCol_txtNewValue = goutil.findChildTextComponent(self.mainGO, "sucValueCol/txtNewValue")
	self._failValueCol = goutil.findChild(self.mainGO, "failValueCol")
	self._failValueCol_txtValue = goutil.findChildTextComponent(self.mainGO, "failValueCol/txtValue")
end

function DivineXiuErClgNorSureView:bindEvents()
	DivineXiuErClgNorSureView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function DivineXiuErClgNorSureView:unbindEvents()
	DivineXiuErClgNorSureView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineXiuErClgNorSureView:onEnter()
	DivineXiuErClgNorSureView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	if not params[1] then
		local info = {}

		self._isUp = checkbool(info.isUp)
		self._sureCallBack = info.sureCallBack
		self._oldValue = checknumber(info.oldValue)
		self._newValue = checknumber(info.newValue)
		self._curValue = checknumber(info.curValue)
		self._desc = tostring(info.desc)

		if self._isUp then
			self._sucValueCol_txtOldValue.text = self._oldValue
			self._sucValueCol_txtNewValue.text = self._newValue
		else
			self._failValueCol_txtValue.text = self._curValue
		end

		GameUtil.SetActive(self._sucValueCol, self._isUp)
		GameUtil.SetActive(self._failValueCol, not self._isUp)

		self._txtDesc.text = self._desc
	end
end

function DivineXiuErClgNorSureView:onExit()
	DivineXiuErClgNorSureView.super.onExit(self)
end

function DivineXiuErClgNorSureView:_onClickBtnSure()
	GameUtil.callBack(self._sureCallBack)
	self:close()
end

return DivineXiuErClgNorSureView
