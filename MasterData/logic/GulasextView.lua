-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gulas/view/GulasextView.lua

module("logic.extensions.gulas.view.GulasextView", package.seeall)

local GulasextView = class("GulasextView", ViewComponent)

function GulasextView:ctor()
	GulasextView.super.ctor(self)
end

function GulasextView:unbindEvents()
	GulasextView.super.unbindEvents(self)
	self._btnHide:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnArrow:RemoveClickListener()
end

function GulasextView:bindEvents()
	GulasextView.super.bindEvents(self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self._btnSure:AddClickListener(self._onClickHide, self)
	self._btnArrow:AddClickListener(self._onClickArrow, self)
end

function GulasextView:buildUI()
	GulasextView.super.buildUI(self)

	self._btnHide = self:getBtn("btnHide")
	self._btnSure = self:getBtn("moveNode/btnSure")
	self._btnArrow = self:getBtn("moveNode/btnArrow")
	self._moveNode = self:getGo("moveNode")
	self._arrowRectTrans = self:getGo("moveNode/btnArrow/arrowTran")
	self._txtTop = self:getTxt("moveNode/txtTop")
	self._txtDescRight = self:getTxt("moveNode/txtDescRight")
	self._txtDescLeft = self:getTxt("moveNode/txtDescLeft")
	self._txtTopNot = self:getGo("moveNode/goTopNot")
	self._txtTopGet = self:getGo("moveNode/goTopGet")
end

function GulasextView:onExit()
	GulasextView.super.onExit(self)
end

function GulasextView:onEnter()
	GulasextView.super.onEnter(self)

	self._yPos = 80
	self._xHide = 500
	self._xShow = -600
	self._isPopupState = true

	local screenWidth, screenHeight = SceneResolution.Instance:GetOriginalResolution(0, 0)
	local _screenScale = screenWidth / screenHeight
	local _showMask = _screenScale > 2.23

	if _showMask then
		local _adaptWidth = _screenScale * 720 - 1600

		self._xHide = 500 - 0.5 * _adaptWidth
	end

	self:_onViewShowOrHide(self._isPopupState)

	if self._isPopupState then
		GameUtil.setAnchoredPos(self._moveNode, self._xShow, self._yPos)
		GameUtil.setLocalRotation(self._arrowRectTrans, 0, 0, 0)
	else
		GameUtil.setAnchoredPos(self._moveNode, self._xHide, self._yPos)
		GameUtil.setLocalRotation(self._arrowRectTrans, 0, 0, 180)
	end

	self._fmtMo = self:getFirstParam() or {}

	self.addGEvent(self, GlobalNotify.FormationPosChanged, self._onFormationChanged, self)
	self:_onFormationChanged()
end

function GulasextView:_onFormationChanged()
	local cfg = GulasConfig.instance:getPhaseCfgById(self._fmtMo.activityId, self._fmtMo.phaseId) or {}
	local stagePlanId = cfg.stagePlanId
	local groupCfg = GulasConfig.instance:getStageCfgById(stagePlanId, self._fmtMo.stageId) or {}

	self._txtDescLeft.text = groupCfg.ldesc
	self._txtDescRight.text = groupCfg.rdesc

	local fmo = self._fmtMo:getCurFormation()

	GameUtil.SetActive(self._txtTopGet, false)
	GameUtil.SetActive(self._txtTopNot, false)

	local boo = not fmo:isEmpty() and GameUtil.expScript(groupCfg.buffCondition, GameUtil.handler(self._onCalcFmtMo, self, self._fmtMo))

	if boo then
		GameUtil.SetActive(self._txtTopGet, true)
	else
		GameUtil.SetActive(self._txtTopNot, true)
	end
end

function GulasextView:_onCalcFmtMo(fmtMo, str)
	str = str:gsub("%s+", "")

	local parts = {}

	for part in string.gmatch(str, "[^<>!=]+") do
		table.insert(parts, part)
	end

	local op = ""

	for _op in string.gmatch(str, "([<>!=]=?)") do
		op = _op
	end

	local num = checknumber(parts[2])
	local arr = string.split(parts[1], "$")
	local type = arr[1]
	local count = 0
	local fmo = fmtMo:getCurFormation()

	for i, v in ipairs(fmo._positions) do
		local petMo = fmo:_getPet(v)

		if petMo then
			if type == "RaceType" then
				if PetSkinConfig.instance:checkHasEleAttr(petMo.curFaceId, arr[2]) then
					count = count + 1
				end
			elseif type == "Job" then
				local jobId = checknumber(GameEnum.JobZh[arr[2]])

				if PetSkinConfig.instance:checkHasJob(petMo.curFaceId, jobId) then
					count = count + 1
				end
			elseif type == "Gender" and PetSkinConfig.instance:checkIsSameGender(petMo.curFaceId, checknumber(arr[2])) then
				count = count + 1
			end
		end
	end

	if op == ">=" then
		return num <= count
	elseif op == "<=" then
		return count <= num
	elseif op == "==" then
		return count == num
	elseif op == ">" then
		return num < count
	elseif op == "<" then
		return count < num
	elseif op == "!=" or op == "~=" then
		return count ~= num
	end
end

function GulasextView:_onClickHide()
	self._isPopupState = false

	self:_onViewShowOrHide(self._isPopupState)
end

function GulasextView:_onClickArrow()
	self._isPopupState = not self._isPopupState

	self:_onViewShowOrHide(self._isPopupState)
end

function GulasextView:_onViewShowOrHide(boo)
	if not boo then
		goutil.setActive(self._btnHide.gameObject, false)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(self._xShow, self._yPos, 0), Vector3.New(self._xHide, self._yPos, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 0), Vector3.New(0, 0, 180), 0.2)
	else
		goutil.setActive(self._btnHide.gameObject, true)
		UnityTweens.TweenPosition.StartTween(self._moveNode, Vector3.New(self._xHide, self._yPos, 0), Vector3.New(self._xShow, self._yPos, 0), 0.2, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.Anchor)
		UnityTweens.TweenRotate.StartTween(self._arrowRectTrans, Vector3.New(0, 0, 180), Vector3.New(0, 0, 0), 0.2)
	end
end

return GulasextView
