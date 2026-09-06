-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilyRedpackRecordView.lua

module("logic.extensions.family.view.FamilyRedpackRecordView", package.seeall)

local FamilyRedpackRecordView = class("FamilyRedpackRecordView", TableViewComponent)

function FamilyRedpackRecordView:ctor()
	FamilyRedpackRecordView.super.ctor(self)

	self._curViewDatas = nil
end

function FamilyRedpackRecordView:onExit()
	FamilyRedpackRecordView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.Family_FailyRedpackRecordInfo, self._updataRedpackRecordSR, self)
end

function FamilyRedpackRecordView:unbindEvents()
	FamilyRedpackRecordView.super.unbindEvents(self)
	self._clickBtn:RemoveClickListener()
end

function FamilyRedpackRecordView:bindEvents()
	FamilyRedpackRecordView.super.bindEvents(self)
	self._clickBtn:AddClickListener(self.close, self)
end

function FamilyRedpackRecordView:buildUI()
	FamilyRedpackRecordView.super.buildUI(self)

	self._clickBtn = self:getBtn("clickBtn")
	self._descTxt = self:getTxt("recordcell/descGo/descTxt")
	self._emptyGo = self:getGo("recordcell/emptyGo")
	self._descTxt.text = ""

	GameUtil.SetActive(self._emptyGo, false)
end

function FamilyRedpackRecordView:onEnter()
	FamilyRedpackRecordView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.Family_FailyRedpackRecordInfo, self._updataRedpackRecordSR, self)
	self:_updataRedpackRecordSR()
	FamilyController.instance:csGetFamilyRedPacketGetGainRecordReq()
end

function FamilyRedpackRecordView:_updataRedpackRecordSR(list)
	self._curViewDatas = list or {}

	if self._curViewDatas then
		if not #self._curViewDatas then
			local count = 0

			if count > 1 then
				table.sort(self._curViewDatas, function(a, b)
					return a.gainTime > b.gainTime
				end)
			end

			self._descTxt.text = FamilyModel.instance:getCurrentRedpackCount()

			GameUtil.SetActive(self._emptyGo, count <= 0)
			self:reloadData()
		end
	end
end

function FamilyRedpackRecordView:_getPath()
	return {
		cellPath = "recordcell/recordItem",
		viewPath = "recordcell/itemListSR"
	}
end

function FamilyRedpackRecordView:_cellSize()
	return 300, 80
end

function FamilyRedpackRecordView:_updateCell(view, cell, data)
	local kingGo = goutil.findChild(cell, "kingGo")
	local getTxt = goutil.findChildTextComponent(cell, "getTxt")
	local getGo = goutil.findChild(cell, "getTxt/getGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local typeCfg = FamilyConfig.instance:getRedpackTypeCfg(data.packetType)

	GameUtil.SetActive(kingGo, data.isLucky)

	getTxt.text = tostring(data.num)

	MaterialMgr.updateItemByStr(getGo, typeCfg.prize)

	nameTxt.text = langPara("text_family_desc_18", data.headInfo.userName, typeCfg.name)
end

return FamilyRedpackRecordView
