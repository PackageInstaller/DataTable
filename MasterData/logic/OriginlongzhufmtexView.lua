-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongzhu/view/OriginlongzhufmtexView.lua

module("logic.extensions.originlongzhu.view.OriginlongzhufmtexView", package.seeall)

local OriginlongzhufmtexView = class("OriginlongzhufmtexView", ViewComponent)

function OriginlongzhufmtexView:unbindEvents()
	OriginlongzhufmtexView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnArrow)
end

function OriginlongzhufmtexView:bindEvents()
	OriginlongzhufmtexView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnArrow, self._onClickArrow, self)
end

function OriginlongzhufmtexView:buildUI()
	OriginlongzhufmtexView.super.buildUI(self)

	self._btnHide = self:getBtn("btnHide")
	self._btnArrow = self:getBtn("moveNode/btnArrow")
	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")
	self._fmtCellList = {}

	for i = 1, 9 do
		table.insert(self._fmtCellList, self:getGo("tagView/cell" .. i))
	end

	self._txtTips = self:getTxt("moveNode/txtTips")
	self._tableview = self:getGo("moveNode/tableview")
	self._tablecell = self:getGo("moveNode/tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginlongzhufmtexView:onExit()
	OriginlongzhufmtexView.super.onExit(self)
	self._scrollList:dispose()
end

function OriginlongzhufmtexView:onEnter()
	OriginlongzhufmtexView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._isPopupState = true

	GameUtil.SetActive(self._btnHide, true)
	GameUtil.setAnchoredPos(self._moveNode, -110, 80)
	GameUtil.setLocalRotation(self._arrowRectTrans, 0, 0, 0)
	self:_refreshUI()
end

function OriginlongzhufmtexView:_refreshUI()
	self._activityId = self._fmtMo.activityId

	local stageId = self._fmtMo.stageId
	local creeps = self._fmtMo:getMonsterConfigList()

	for i, cell in ipairs(self._fmtCellList) do
		GameUtil.SetActive(cell, false)
	end

	local actCfg = OriginLongzhuConfig.instance:getActCfgById(self._activityId) or {}
	local buffDesc = actCfg.damageSignBuffId .. ":"

	for i, v in ipairs(creeps) do
		if v.posId and v.posId > 0 and v.extBuffs then
			local startPos, endPos = string.find(v.extBuffs, buffDesc, 1, true)

			if startPos then
				GameUtil.SetActive(self._fmtCellList[v.posId], true)
			end
		end
	end

	local stageCfg = OriginLongzhuConfig.instance:getStageCfgById(self._activityId, stageId) or {}

	self._selectScoreTypeCount = checknumber(stageCfg.selectScoreTypeCount)

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
		local list = {}

		for i, v in ipairs(cfgList) do
			table.insert(list, v)
		end

		ArraySort.sortOn(list, {
			function(a)
				if self._buffUseMap[a.scoreType] then
					return 1
				else
					return 0
				end
			end,
			"scoreType"
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})
		self._scrollList:reloadData(list)
		self:_updateTips()
	end
end

function OriginlongzhufmtexView:_updateCell(view, cell, data, tag)
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local toggle = goutil.findChild(cell, "toggle")
	local checkbox = goutil.findChild(cell, "toggle/checkbox")
	local img = goutil.findChild(cell, "img")
	local bg = goutil.findChild(cell, "bg")
	local txt = goutil.findChildTextComponent(cell, "img/txt")

	GameUtil.SetActive(bg, cell.index % 2 == 0)

	txtScore.text = data.scoreUnit
	txtDesc.text = data.desc

	GameUtil.SetActive(checkbox, self._fmtMo:getBuffSelect(data.scoreType))
	GameUtil.SetActive(img, false)
	GameUtil.rmClickHandler(toggle)

	local info = self._buffUseMap[data.scoreType]

	if info then
		GameUtil.SetActive(toggle, false)
		GameUtil.SetActive(img, true)

		txt.text = langPara("第%s关\n已选", info)
	else
		GameUtil.SetActive(toggle, true)
		GameUtil.addClickHandler(toggle, GameUtil.handler(self._onClickCell, self, data))
	end
end

function OriginlongzhufmtexView:_clearCell(cell)
	return
end

function OriginlongzhufmtexView:_onClickCell(data)
	if not self._fmtMo:getBuffSelect(data.scoreType) and self._fmtMo:getBuffCount() >= self._selectScoreTypeCount then
		TipsFacade.instance:openCommonTips(langPara("本关最多选择%s个行为", self._selectScoreTypeCount))

		return
	end

	self._fmtMo:setBuffSelect(data.scoreType)
	self._scrollList:refresh()
	self:_updateTips()
end

function OriginlongzhufmtexView:_updateTips()
	self._txtTips.text = langPara("战斗中，每执行一次所选行为，即可获得一次对应的行为积分，最多可选%s个（<color=#cd7800>%s</color>/%s）", self._selectScoreTypeCount, self._fmtMo:getBuffCount(), self._selectScoreTypeCount)
end

function OriginlongzhufmtexView:_onClickHide()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(-110, 80, 0), Vector3.New(400, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	end
end

function OriginlongzhufmtexView:_onClickArrow()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(-110, 80, 0), Vector3.New(400, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	else
		self._isPopupState = true

		goutil.setActive(self._btnHide.gameObject, true)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(400, 80, 0), Vector3.New(-110, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 180), Vector3.New(0, 0, 0), 0.2)
	end
end

return OriginlongzhufmtexView
