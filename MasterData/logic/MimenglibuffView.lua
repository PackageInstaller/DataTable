-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mimengli/view/MimenglibuffView.lua

module("logic.extensions.mimengli.view.MimenglibuffView", package.seeall)

local MimenglibuffView = class("MimenglibuffView", ViewComponent)

function MimenglibuffView:ctor()
	MimenglibuffView.super.ctor(self)
end

function MimenglibuffView:unbindEvents()
	MimenglibuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function MimenglibuffView:bindEvents()
	MimenglibuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function MimenglibuffView:buildUI()
	MimenglibuffView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._txtTip = self:getTxt("txtTip")
	self._buffScrollercell = self:getGo("buffCol/buffScrollercell")
	self._buffScrollerview = self:getGo("buffCol/buffScrollerview")
	self._scrollList = ScrollerList.create(self._buffScrollerview, self._buffScrollercell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function MimenglibuffView:onExit()
	MimenglibuffView.super.onExit(self)
	self._scrollList:dispose()
end

function MimenglibuffView:onEnter()
	MimenglibuffView.super.onEnter(self)

	self._activityId = MiMengLiController.instance:getActivityId()

	local actId = checknumber(self:getFirstParam())

	if actId > 0 then
		self._activityId = actId
	end

	local param = self:getOpenParam() or {}

	self._stageId = checknumber(param[2])

	self:_onRefreshUI()
end

function MimenglibuffView:_onRefreshUI()
	local info = MiMengLiModel.instance:getInfo(self._activityId) or {}

	if not info.clgInfo then
		local clgInfo = {}

		if not clgInfo.curStageSelectedTagType then
			local curStageSelectedTagType = {}

			self._curStageSelectedTagType = curStageSelectedTagType

			local list = MiMengLiConfig.instance:getBuffTagCfgList(self._activityId) or {}

			self._scrollList:reloadData(list)

			local cfg = MiMengLiConfig.instance:getStageCfgById(self._activityId, self._stageId) or {}

			self._maxSelectCount = checknumber(cfg.selectTagCount)
			self._txtTip.text = langPara("最多可选数量:%s/%s", #curStageSelectedTagType, self._maxSelectCount)
		end
	end
end

function MimenglibuffView:_onClickSure()
	MiMengLiController.instance:sendSelectTag(self._activityId, self._curStageSelectedTagType)
	self:close()
end

function MimenglibuffView:_updateCell(view, cell, data, tag)
	local btn = goutil.findChild(cell, "btn")
	local iconGo = goutil.findChild(cell, "iconGo")
	local select = goutil.findChild(cell, "select")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

	txtName.text = data.name
	txtDesc.text = data.desc

	GameUtil.setUIImageSpriteIdx(iconGo, data.tagType - 1)
	GameUtil.SetActive(select, table.indexof(self._curStageSelectedTagType, data.tagType) ~= false)
	GameUtil.addClickHandler(btn, GameUtil.handler(self._onCellClick, self, data))
end

function MimenglibuffView:_clearCell(cell)
	local iconGo = goutil.findChild(cell, "iconGo")

	uGuiUtil.clearImage(iconGo)
end

function MimenglibuffView:_onCellClick(data)
	local idx = table.indexof(self._curStageSelectedTagType, data.tagType)

	if idx == false then
		local count = #self._curStageSelectedTagType

		if count >= self._maxSelectCount then
			table.remove(self._curStageSelectedTagType, 1)
		end

		table.insert(self._curStageSelectedTagType, data.tagType)
	else
		table.remove(self._curStageSelectedTagType, idx)
	end

	self._scrollList:refresh()

	local cfg = MiMengLiConfig.instance:getStageCfgById(self._activityId, self._stageId) or {}

	self._txtTip.text = langPara("最多可选数量:%s/%s", #self._curStageSelectedTagType, checknumber(cfg.selectTagCount))
end

return MimenglibuffView
