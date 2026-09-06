-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongyanclg/view/OriginLongYanClgFmtExView.lua

module("logic.extensions.originlongyanclg.view.OriginLongYanClgFmtExView", package.seeall)

local OriginLongYanClgFmtExView = class("OriginLongYanClgFmtExView", ViewComponent)

function OriginLongYanClgFmtExView:ctor()
	OriginLongYanClgFmtExView.super.ctor(self)
end

function OriginLongYanClgFmtExView:unbindEvents()
	OriginLongYanClgFmtExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnHide)
	GameUtil.rmClickHandler(self._btnArrow)

	for i, fmtCell in ipairs(self._fmtCellList) do
		GameUtil.rmClickHandler(fmtCell.go)
	end
end

function OriginLongYanClgFmtExView:bindEvents()
	OriginLongYanClgFmtExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnHide, self._onClickHide, self)
	GameUtil.addClickHandler(self._btnArrow, self._onClickArrow, self)

	for i, fmtCell in ipairs(self._fmtCellList) do
		GameUtil.addClickHandler(fmtCell.go, function()
			self:_onClickFmtCell(i)
		end, self)
	end
end

function OriginLongYanClgFmtExView:buildUI()
	OriginLongYanClgFmtExView.super.buildUI(self)

	self._btnHide = self:getBtn("btnHide")
	self._btnArrow = self:getBtn("moveNode/btnArrow")
	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")
	self._fmtCellList = {}

	for i = 1, 9 do
		local fmtCell = {}

		fmtCell.go = self:getGo("moveNode/form/cell_" .. i)
		fmtCell.txt = goutil.findChildTextComponent(fmtCell.go, "txt")
		fmtCell.select = goutil.findChild(fmtCell.go, "select")
		fmtCell.changeGroup = fmtCell.go:GetComponent("UIChangeGroup")

		table.insert(self._fmtCellList, fmtCell)
	end

	self._txtPass = self:getTxt("moveNode/txtPass")
	self._txtTips = self:getTxt("moveNode/txtTips")
end

function OriginLongYanClgFmtExView:onExit()
	OriginLongYanClgFmtExView.super.onExit(self)
end

function OriginLongYanClgFmtExView:onEnter()
	OriginLongYanClgFmtExView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._isPopupState = true

	GameUtil.SetActive(self._btnHide, true)
	GameUtil.setAnchoredPos(self._moveNode, -110, 80)
	GameUtil.setLocalRotation(self._arrowRectTrans, 0, 0, 0)

	local stageId = self._fmtMo.stageId

	self._activityId = self._fmtMo.activityId

	local stageCfg = OriginLongYanClgConfig.instance:getStageCfgById(self._activityId, stageId)

	for i, fmtCell in ipairs(self._fmtCellList) do
		GameUtil.SetActive(fmtCell.go, false)
	end

	self._curSelectId = 0

	if not stageCfg.positionSignId then
		self._positionSignId = stageCfg.positionSignId

		for i, signId in ipairs(stageCfg.positionSignId) do
			local fmtCell = self._fmtCellList[i]
			local signCfg = OriginLongYanClgConfig.instance:getSignCfgById(self._activityId, signId)

			if signCfg then
				GameUtil.SetActive(fmtCell.go, true)

				fmtCell.txt.text = string.format("%s区", signCfg.signName or "")

				fmtCell.changeGroup:SetState(signCfg.showState - 1)

				if self._curSelectId == 0 then
					self._curSelectId = i
				end
			end
		end

		local passSignId = stageCfg.passSignId
		local passSignCfg = OriginLongYanClgConfig.instance:getSignCfgById(self._activityId, passSignId)

		self._txtPass.text = string.format("通关规则：本关需要注入%s意志", passSignCfg.signName or "未知")

		self:_onClickFmtCell(self._curSelectId)
	end
end

function OriginLongYanClgFmtExView:_onClickHide()
	if self._isPopupState then
		self._isPopupState = false

		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(-110, 80, 0), Vector3.New(400, 80, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	end
end

function OriginLongYanClgFmtExView:_onClickArrow()
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

function OriginLongYanClgFmtExView:_onClickFmtCell(index)
	self._curSelectId = index

	for i, fmtCell in ipairs(self._fmtCellList) do
		if i == self._curSelectId then
			fmtCell.select:SetActive(true)
		else
			fmtCell.select:SetActive(false)
		end
	end

	local signId = self._positionSignId[self._curSelectId]
	local signCfg = OriginLongYanClgConfig.instance:getSignCfgById(self._activityId, signId)

	self._txtTips.text = signCfg.triDesc or ""
end

return OriginLongYanClgFmtExView
