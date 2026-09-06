-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettimemachine/view/PettimemachinepopView.lua

module("logic.extensions.pettimemachine.view.PettimemachinepopView", package.seeall)

local PettimemachinepopView = class("PettimemachinepopView", ViewComponent)

function PettimemachinepopView:ctor()
	PettimemachinepopView.super.ctor(self)
end

function PettimemachinepopView:buildUI()
	PettimemachinepopView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnSure = self:getGo("btnSure")
	self.btnCancel = self:getGo("btnCancel")
	self.txtTip = self:getTxt("txtTip")
	self.txt = self:getTxt("txt")
	self.items = {}

	for i = 1, 4 do
		local item = self:getGo("item_" .. i)

		table.insert(self.items, item)
	end

	self.txt.text = lang("已有等级的星神，超出的经验和金币，将在提升后100%返还")
end

function PettimemachinepopView:bindEvents()
	PettimemachinepopView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnCancel, self.close, self)
	GameUtil.addClickHandler(self.btnSure, self.onBtnSureClick, self)
end

function PettimemachinepopView:unbindEvents()
	PettimemachinepopView.super.unbindEvents(self)
end

function PettimemachinepopView:destroyUI()
	PettimemachinepopView.super.destroyUI(self)
end

function PettimemachinepopView:onEnter()
	PettimemachinepopView.super.onEnter(self)

	local params = self:getOpenParam()
	local list = params[2]

	self.onOkCallBack = params[3]
	self.txtTip.text = params[1]

	for i = 1, #self.items do
		local item = self.items[i]

		if list and list[i] then
			GameUtil.SetActive(item, true)

			local txtOld = goutil.findChildTextComponent(item, "txtOld")
			local txtNew = goutil.findChildTextComponent(item, "txtNew")

			txtOld.text = list[i].txtOld
			txtNew.text = list[i].txtNew
		else
			GameUtil.SetActive(item, false)
		end
	end
end

function PettimemachinepopView:onEnterFinished()
	PettimemachinepopView.super.onEnterFinished(self)
end

function PettimemachinepopView:onExit()
	PettimemachinepopView.super.onExit(self)
end

function PettimemachinepopView:onExitFinished()
	PettimemachinepopView.super.onExitFinished(self)
end

function PettimemachinepopView:onBtnSureClick()
	GameUtil.callBack(self.onOkCallBack)
	self:close()
end

return PettimemachinepopView
