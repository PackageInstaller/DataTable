-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessresultView.lua

module("logic.extensions.drawandguess.view.DrawandguessresultView", package.seeall)

local DrawandguessresultView = class("DrawandguessresultView", ViewComponent)

function DrawandguessresultView:ctor()
	DrawandguessresultView.super.ctor(self)
end

function DrawandguessresultView:unbindEvents()
	DrawandguessresultView.super.unbindEvents(self)
end

function DrawandguessresultView:bindEvents()
	DrawandguessresultView.super.bindEvents(self)
end

function DrawandguessresultView:buildUI()
	DrawandguessresultView.super.buildUI(self)

	self._headItems = {}

	for i = 1, 5 do
		local go = goutil.findChild(self.mainGO, "head" .. i)
		local var_4_0 = {
			go = go,
			con = goutil.findChild(go, "con"),
			txtName = goutil.findChildTextComponent(go, "txtName"),
			goTag = goutil.findChild(go, "tag")
		}

		var_4_0.outlineEx = goutil.findChild(go, "txtName"):GetComponent(ComponentType.OutlineEx)
		var_4_0.scoreOutlineEx = goutil.findChild(go, "txtScore"):GetComponent(ComponentType.OutlineEx)
		var_4_0.txtScore = goutil.findChildTextComponent(go, "txtScore")

		table.insert(self._headItems, var_4_0)
	end
end

function DrawandguessresultView:onExit()
	DrawandguessresultView.super.onExit(self)

	for i, v in ipairs(self._headItems) do
		HeadItemController.instance:resetHeadCell(v.con)
	end
end

function DrawandguessresultView:onEnter()
	DrawandguessresultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FormTeamBeKick, self.close, self)

	self._gameEndMsg = self:getFirstParam()

	self:_updateHeads()
end

function DrawandguessresultView:_updateHeads()
	local list = {}
	local cnt = #self._gameEndMsg.players

	for i, v in ipairs(self._gameEndMsg.players) do
		table.insert(list, v)
	end

	table.sort(list, function(a, b)
		return a.score > b.score
	end)

	for i, item in ipairs(self._headItems) do
		goutil.setActive(item.go, i <= cnt)
	end

	for i, v in ipairs(list) do
		self:_updateHead(i, v)
	end
end

function DrawandguessresultView:_updateHead(idx, data)
	local item = self._headItems[idx]

	HeadItemController.instance:setHeadCellByInfo(item.con, data.headInfo)

	item.txtName.text = data.headInfo.userName
	item.txtScore.text = data.score

	local isMe = checknumber(data.headInfo.userId) == checknumber(RoleModel.instance:getUserId())

	goutil.setActive(item.goTag, isMe)

	if isMe then
		item.outlineEx:SetColorRGB(0.2, 0.6745098039215687, 0.4549019607843137)
		item.scoreOutlineEx:SetColorRGB(0.2, 0.6745098039215687, 0.4549019607843137)
	else
		item.outlineEx:SetColorRGB(0, 0, 0)
		item.scoreOutlineEx:SetColorRGB(0, 0, 0)
	end
end

return DrawandguessresultView
