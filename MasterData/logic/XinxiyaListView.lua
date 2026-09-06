-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinxiyamirror/view/XinxiyaListView.lua

module("logic.extensions.xinxiyamirror.view.XinxiyaListView", package.seeall)

local XinxiyaListView = class("XinxiyaListView", TableViewComponent)

function XinxiyaListView:ctor()
	XinxiyaListView.super.ctor(self)
end

function XinxiyaListView:bindEvents()
	XinxiyaListView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function XinxiyaListView:unbindEvents()
	XinxiyaListView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function XinxiyaListView:onExit()
	XinxiyaListView.super.onExit(self)

	self._curViewDatas = nil
end

function XinxiyaListView:destroyUI()
	XinxiyaListView.super.destroyUI(self)
end

function XinxiyaListView:buildUI()
	XinxiyaListView.super.buildUI(self)

	local viewBgGo = self:getGo("viewBgGo")

	self._closeBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "closeBtn")
end

function XinxiyaListView:onEnter()
	XinxiyaListView.super.onEnter(self)

	self._curViewDatas = {}

	self._tableview:ReloadData()
end

function XinxiyaListView:_getPath()
	return {
		cellPath = "viewBgGo/battleItem",
		viewPath = "viewBgGo/battleListSR"
	}
end

function XinxiyaListView:_cellSize()
	return 410, 65
end

function XinxiyaListView:_updateCell(view, cell, data)
	local arrowGo = goutil.findChild(cell, "arrowGo")
	local indexTxt = goutil.findChildTextComponent(cell, "indexTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local passBtnGo = goutil.findChild(cell, "passBtn")

	GameUtil.asBtn(passBtnGo):RemoveClickListener()
	GameUtil.SetActive(arrowGo, false)

	indexTxt.text = tostring(cell.data)
	descTxt.text = data.desc .. "   " .. data.power

	GameUtil.asBtn(passBtnGo):AddClickListener(function()
		XinxiyaMirrorController.instance:csMirrorChallengeReq(self._stageInfo.stageId)
		self:close()
	end, self)
end

return XinxiyaListView
