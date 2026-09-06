-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongzhu/view/OriginlongzhubuffView.lua

module("logic.extensions.originlongzhu.view.OriginlongzhubuffView", package.seeall)

local OriginlongzhubuffView = class("OriginlongzhubuffView", ViewComponent)

function OriginlongzhubuffView:ctor()
	OriginlongzhubuffView.super.ctor(self)
end

function OriginlongzhubuffView:unbindEvents()
	OriginlongzhubuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnOk)
end

function OriginlongzhubuffView:bindEvents()
	OriginlongzhubuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnOk, self.close, self)
end

function OriginlongzhubuffView:buildUI()
	OriginlongzhubuffView.super.buildUI(self)

	self._btnOk = self:getGo("btnGroup/btnOk")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginlongzhubuffView:onExit()
	OriginlongzhubuffView.super.onExit(self)
	self._scrollList:dispose()
end

function OriginlongzhubuffView:onEnter()
	OriginlongzhubuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	self.addGEvent(self, GlobalNotify.ORIGIN_LONGZHU_INFO_UPDATE, self._refreshUI, self)
	self:_refreshUI()
end

function OriginlongzhubuffView:_refreshUI()
	local info = OriginLongzhuModel.instance:getInfo(self._activityId) or {}

	if not info.stageInfos then
		local stageInfos = {}

		self._buffUseMap = {}

		for i, v in ipairs(stageInfos) do
			if v.typeScores then
				for j, ts in ipairs(v.typeScores) do
					self._buffUseMap[ts.left] = v.stageId
				end
			end
		end

		local cfgList = OriginLongzhuConfig.instance:getScoreTypeListCfgById(self._activityId)

		self._scrollList:reloadData(cfgList)
	end
end

function OriginlongzhubuffView:_updateCell(view, cell, data, tag)
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtUse = goutil.findChildTextComponent(cell, "txtUse")
	local pass = goutil.findChild(cell, "pass")
	local bg = goutil.findChild(cell, "bg")
	local imgNot = goutil.findChild(cell, "imgNot")
	local btnRest = goutil.findChild(cell, "btnRest")

	txtScore.text = data.scoreUnit
	txtDesc.text = data.desc
	txtUse.text = ""

	GameUtil.SetActive(bg, cell.index % 2 == 0)
	GameUtil.SetActive(imgNot, true)
	GameUtil.SetActive(pass, false)
	GameUtil.SetActive(btnRest, false)
	GameUtil.rmClickHandler(btnRest)

	local info = self._buffUseMap[data.scoreType]

	if info then
		GameUtil.SetActive(imgNot, false)
		GameUtil.SetActive(btnRest, true)
		GameUtil.SetActive(pass, true)

		txtUse.text = langPara("第%s关已选", info)

		GameUtil.addClickHandler(btnRest, GameUtil.handler(self._onClickReset, self, data))
	end
end

function OriginlongzhubuffView:_clearCell(cell)
	return
end

function OriginlongzhubuffView:_onClickReset(data)
	local info = OriginLongzhuModel.instance:getInfo(self._activityId) or {}

	if not info.stageInfos then
		local stageInfos = {}

		self._curStageDataMap = {}

		for i, v in ipairs(stageInfos) do
			self._curStageDataMap[v.stageId] = v
		end

		local stageId = self._buffUseMap[data.scoreType]

		if stageId then
			if not self._curStageDataMap[stageId] then
				local info = {}
				local buffScore = 0

				for i, v in ipairs(info.typeScores or {}) do
					buffScore = buffScore + v.right
				end

				local content = langPara("第%s关积分为：%s，是否重置，清空积分，解锁行为", stageId, checknumber(info.damageScore) + buffScore)

				TipsFacade.instance:openPopupWindow("提示", content, function()
					OriginLongzhuController.instance:sendResetFight(self._activityId, stageId)
				end)
			end
		end
	end
end

return OriginlongzhubuffView
