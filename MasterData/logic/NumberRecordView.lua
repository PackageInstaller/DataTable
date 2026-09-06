-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberRecordView.lua

module("logic.extensions.numberbomb.view.NumberRecordView", package.seeall)

local NumberRecordView = class("NumberRecordView", TableViewComponent)

function NumberRecordView:ctor()
	NumberRecordView.super.ctor(self)
end

function NumberRecordView:bindEvents()
	NumberRecordView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function NumberRecordView:unbindEvents()
	NumberRecordView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function NumberRecordView:onExit()
	NumberRecordView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataGameAnnalList, self._updataRecordListSR, self)
end

function NumberRecordView:destroyUI()
	NumberRecordView.super.destroyUI(self)
end

function NumberRecordView:buildUI()
	NumberRecordView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._emptyGo = self:getGo("emptyGo")

	self._emptyGo:SetActive(false)
end

function NumberRecordView:onEnter()
	NumberRecordView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataGameAnnalList, self._updataRecordListSR, self)
	self:_updataRecordListSR()
	NumberGameController.instance:csGetGameAnnalListReq()
end

function NumberRecordView:_updataRecordListSR()
	self._curViewDatas = NumberGameModel.instance:getGameAnnalList()

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		self._emptyGo:SetActive(true)
	else
		self._emptyGo:SetActive(false)
	end

	self._tableview:ReloadData()
end

function NumberRecordView:_getPath()
	return {
		cellPath = "recordItem",
		viewPath = "recordListSR"
	}
end

function NumberRecordView:_cellSize()
	return 514, 186
end

function NumberRecordView:_updateCell(view, cell, data)
	local rankIma = goutil.findChildComponent(cell, "rankIma", "UIImageSpriteChange")
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local timeTxt = goutil.findChildTextComponent(cell, "timeTxt")
	local noNamesTxt = goutil.findChildTextComponent(cell, "noNamesTxt")
	local namesGo = goutil.findChild(cell, "namesGo")
	local oneNameTxt = goutil.findChildTextComponent(namesGo, "oneGo/oneNameTxt")
	local twoNameTxt = goutil.findChildTextComponent(namesGo, "twoGo/twoNameTxt")
	local threeNameTxt = goutil.findChildTextComponent(namesGo, "threeGo/threeNameTxt")
	local fourNameTxt = goutil.findChildTextComponent(namesGo, "fourGo/fourNameTxt")

	if data.myNO > 3 then
		rankIma.gameObject:SetActive(false)

		rankTxt.text = tostring(data.myNO)
	else
		rankIma.gameObject:SetActive(true)

		rankTxt.text = ""

		rankIma:SetState(data.myNO - 1)
	end

	timeTxt.text = GameUtil.formatTimeStamp("%Y-%m-%d %H:%M:%S", data.gameTimeMillis / 1000)

	local names = data.playerNames

	if names == nil or string.nilorempty(names[1]) then
		oneNameTxt.text = ""
		twoNameTxt.text = ""
		threeNameTxt.text = ""
		fourNameTxt.text = ""

		namesGo:SetActive(false)

		noNamesTxt.text = "该场游戏还未结束，结束后出结果！"
	else
		noNamesTxt.text = ""

		namesGo:SetActive(true)

		oneNameTxt.text = data.myNO == 1 and string.format("<color=#20B376FF>%s</color>", names[1]) or names[1]
		twoNameTxt.text = data.myNO == 2 and string.format("<color=#20B376FF>%s</color>", names[2]) or names[2]
		threeNameTxt.text = data.myNO == 3 and string.format("<color=#20B376FF>%s</color>", names[3]) or names[3]
		fourNameTxt.text = data.myNO == 4 and string.format("<color=#20B376FF>%s</color>", names[4]) or names[4]
	end
end

return NumberRecordView
