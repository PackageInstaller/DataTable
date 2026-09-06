-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilytpdamagerankView.lua

module("logic.extensions.familyteamplay.view.FamilytpdamagerankView", package.seeall)

local FamilytpdamagerankView = class("FamilytpdamagerankView", TableViewComponent)

function FamilytpdamagerankView:ctor()
	FamilytpdamagerankView.super.ctor(self)
end

function FamilytpdamagerankView:buildUI()
	FamilytpdamagerankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "txtMyRank")
	self._emptyTipGo = goutil.findChild(self.mainGO, "emptyTip")
end

function FamilytpdamagerankView:bindEvents()
	FamilytpdamagerankView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function FamilytpdamagerankView:unbindEvents()
	FamilytpdamagerankView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function FamilytpdamagerankView:onEnter()
	FamilytpdamagerankView.super.onEnter(self)

	self._periodId = self:getFirstParam()

	GlobalDispatcher:addListener(GlobalNotify.UpdataTeamPlayDamageInfo, self._updateView, self)
	FamilyteamplayController.instance:csSendViewMemberDamageListReq(self._periodId)
	self:_updateView()
end

function FamilytpdamagerankView:onExit()
	FamilytpdamagerankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTeamPlayDamageInfo, self._updateView, self)
end

function FamilytpdamagerankView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function FamilytpdamagerankView:_cellSize(view, index)
	return 100, 100
end

function FamilytpdamagerankView:_updateCell(view, cell, data)
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRank")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtDamage = goutil.findChildTextComponent(cell.gameObject, "txtDamage")
	local headCon = goutil.findChild(cell.gameObject, "head")
	local imgRankComp = goutil.findChild(cell.gameObject, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local headInfo = data.headInfo

	HeadItemController.instance:setHeadCell(headCon, headInfo.headIconId, headInfo.headFrameId, headInfo.vipLv)
	goutil.setActive(imgRankComp.gameObject, cell.data <= 3)

	if cell.data <= 3 then
		imgRankComp:SetState(cell.data - 1)

		txtRank.text = ""
	else
		txtRank.text = cell.data
	end

	txtName.text = data.headInfo.userName
	txtDamage.text = data.damage
end

function FamilytpdamagerankView:_clearTableview(cell)
	local headCon = goutil.findChild(cell.gameObject, "head")

	HeadItemController.instance:resetHeadCell(headCon)
end

function FamilytpdamagerankView:_updateView()
	self._curViewDatas = FamilyteamplayModel.instance:getMemberDamageList() or {}

	table.sort(self._curViewDatas, function(a, b)
		if checknumber(a.damage) == checknumber(b.damage) then
			return checknumber(a.updateTimeMillis) < checknumber(b.updateTimeMillis)
		else
			return checknumber(a.damage) > checknumber(b.damage)
		end
	end)

	local myRank = 0

	if self._curViewDatas then
		for i, v in ipairs(self._curViewDatas) do
			if v.headInfo.userId == RoleModel.instance:getUserId() then
				myRank = i

				break
			end
		end
	end

	goutil.setActive(self._emptyTipGo, not self._curViewDatas or #self._curViewDatas <= 0)

	self._txtMyRank.text = myRank <= 0 and "未上榜" or string.format("第%s名", myRank)

	self:reloadData()
end

return FamilytpdamagerankView
