-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/view/WuDiClgNorDetailView.lua

module("logic.extensions.wudiclg.view.WuDiClgNorDetailView", package.seeall)

local WuDiClgNorDetailView = class("WuDiClgNorDetailView", ViewComponent)

function WuDiClgNorDetailView:buildUI()
	WuDiClgNorDetailView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")

	local detailScrollerview = goutil.findChild(self.mainGO, "detailCol/detailScrollerview")
	local detailScrollercell = goutil.findChild(self.mainGO, "detailCol/detailScrollercell")

	self._detailScrollList = ScrollerList.create(detailScrollerview, detailScrollercell, GameUtil.handler(self._updateDetailCell, self), GameUtil.handler(self._clearDetailCell, self))
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
end

function WuDiClgNorDetailView:bindEvents()
	WuDiClgNorDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function WuDiClgNorDetailView:unbindEvents()
	WuDiClgNorDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function WuDiClgNorDetailView:onEnter()
	WuDiClgNorDetailView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._groupId = checknumber(params[2])
	self._dataBitId = checknumber(params[3])
	self._sureCallBack = params[4]

	self.addGEvent(self, GlobalNotify.WuDiClgNotifyNormalFightResultRes, self._onUpdate, self)
	self:_onUpdate()
end

function WuDiClgNorDetailView:onExit()
	WuDiClgNorDetailView.super.onExit(self)
	self:_clearDetailColUI()
end

function WuDiClgNorDetailView:_onUpdate()
	self._infoList = WuDiClgController.instance:getDetailInfoListOfNorClg(self._activityId, self._groupId, self._dataBitId)

	local cfg = WuDiClgConfig.instance:getWdcNorRuleCfg(self._activityId)

	self._detailScrollList:reloadData(cfg)
end

function WuDiClgNorDetailView:_clearDetailColUI()
	self._detailScrollList:dispose()
end

function WuDiClgNorDetailView:_updateDetailCell(view, cell, data, tag)
	local ruleId = data.ruleId
	local info = self:_getInfo(ruleId)
	local name = data.name

	if info then
		if not info.counter then
			local cond = 0

			if info then
				if not info.soulCount then
					local soulCount = 0
					local mainGo = cell.gameObject
					local txtName = goutil.findChildTextComponent(mainGo, "txtName")
					local txtCond = goutil.findChildTextComponent(mainGo, "txtCond")
					local txtSouilCount = goutil.findChildTextComponent(mainGo, "txtSouilCount")

					txtName.text = name
					txtCond.text = cond
					txtSouilCount.text = soulCount
				end
			end
		end
	end
end

function WuDiClgNorDetailView:_clearDetailCell(cell)
	return
end

function WuDiClgNorDetailView:_getInfo(ruleId)
	local info

	if self._infoList then
		for i, v in ipairs(self._infoList) do
			if v.ruleId == ruleId then
				info = v

				break
			end
		end
	end

	return info
end

function WuDiClgNorDetailView:_onClickBtnSure()
	self:close()
	GameUtil.callBack(self._sureCallBack)
end

return WuDiClgNorDetailView
