-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nvdi/view/NvdiextView.lua

module("logic.extensions.nvdi.view.NvdiextView", package.seeall)

local NvdiextView = class("NvdiextView", ViewComponent)

function NvdiextView:ctor()
	NvdiextView.super.ctor(self)

	self._yPos = 80
	self._xHide = 400
	self._xShow = -112
end

function NvdiextView:buildUI()
	NvdiextView.super.buildUI(self)

	self._btnHide = self:getBtn("btnHide")
	self._btnSure = self:getBtn("moveNode/btnSure")
	self._btnArrow = self:getBtn("moveNode/btnArrow")
	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")
	self._txtDesc = self:getTxt("moveNode/txtDesc")
	self._tableview = self:getGo("moveNode/tableview")
	self._cell = self:getGo("moveNode/cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function NvdiextView:bindEvents()
	NvdiextView.super.bindEvents(self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self._btnSure:AddClickListener(self._onClickHide, self)
	self._btnArrow:AddClickListener(self._onClickArrow, self)
end

function NvdiextView:unbindEvents()
	NvdiextView.super.unbindEvents(self)
	self._btnHide:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnArrow:RemoveClickListener()
end

function NvdiextView:onEnter()
	NvdiextView.super.onEnter(self)

	local fmtMo = self:getFirstParam() or {}

	self._fmtMo = fmtMo

	self:_onClickArrow()

	local info = NvdiChallengeModel.instance:getInfo(fmtMo.activityId) or {}
	local buffList = NvdiChallengeConfig.instance:getBuffCfgList(fmtMo.activityId) or {}

	buffList = clone(buffList)
	self.buffIdUsed = fmtMo.buffIdUsed
	self.usingBuffMap = {}

	for i, v in ipairs(info.extremeClgStageInfo or {}) do
		self.usingBuffMap[v.buffIdUsed] = true
	end

	ArraySort.sortOn(buffList, {
		function(v)
			if self.usingBuffMap[v.buffId] then
				return 1
			else
				return 0
			end
		end,
		"buffId"
	}, {
		ArraySort.NUMERIC,
		ArraySort.NUMERIC
	})
	self._scrollList:reloadData(buffList)
	self:_updateDesc()
end

function NvdiextView:onExit()
	NvdiextView.super.onExit(self)
	self._scrollList:dispose()
end

function NvdiextView:_updateCell(view, cell, data, tag)
	local icon = goutil.findChild(cell, "icon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local tag = goutil.findChild(cell, "tag")
	local selected = goutil.findChild(cell, "selected")
	local cfg = NvdiChallengeConfig.instance:getBuffCfgById(self._fmtMo.activityId, data.buffId) or {}

	uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.icon))

	txtName.text = tostring(cfg.name)

	GameUtil.SetActive(tag, self.usingBuffMap[data.buffId])
	GameUtil.SetActive(selected, data.buffId == self._fmtMo.buffIdUsed)
	GameUtil.addClickHandler(cell, function()
		if self.usingBuffMap[data.buffId] == nil then
			self._fmtMo.buffIdUsed = data.buffId

			self._scrollList:refresh()
			self:_updateDesc()
		else
			TipsFacade.instance:openCommonTips("已使用过的命途不能选择")
		end
	end)
end

function NvdiextView:_updateDesc()
	local cfg = NvdiChallengeConfig.instance:getBuffCfgById(self._fmtMo.activityId, self._fmtMo.buffIdUsed) or {}

	self._txtDesc.text = cfg.desc
end

function NvdiextView:clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
end

function NvdiextView:_onClickHide()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(self._xShow, self._yPos, 0), Vector3.New(self._xHide, self._yPos, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	end
end

function NvdiextView:_onClickArrow()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(self._xShow, self._yPos, 0), Vector3.New(self._xHide, self._yPos, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	else
		self._isPopupState = true

		goutil.setActive(self._btnHide.gameObject, true)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(self._xHide, self._yPos, 0), Vector3.New(self._xShow, self._yPos, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 180), Vector3.New(0, 0, 0), 0.2)
	end
end

return NvdiextView
