-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideHighLightView.lua

module("logic.extensions.guide.view.GuideHighLightView", package.seeall)

local GuideHighLightView = class("GuideHighLightView", GuideUIObjectBase)

function GuideHighLightView:ctor()
	GuideHighLightView.super.ctor(self)
end

function GuideHighLightView:bindEvents()
	return
end

function GuideHighLightView:unbindEvents()
	return
end

function GuideHighLightView:buildUI()
	self._finger = self:getGo("finger")
end

function GuideHighLightView:destroyUI()
	return
end

function GuideHighLightView:onEnter()
	return
end

function GuideHighLightView:onEnterFinished()
	GuideHighLightView.super.onEnterFinished(self)
	self:_startGuide_AMan_Temp()
end

function GuideHighLightView:_startGuide_AMan_Temp()
	self:_handleGuideWIdgrt()

	local params = self._currGuide:getGuideUIParams()

	if params then
		self._finger.gameObject:SetActive(false)
	end

	if self._saveWidget == nil then
		error("_saveWidget is nil")
	else
		local goPos = GameUtil.getPos(self._saveWidget.gameObject)

		Framework.TransformUtil.SetPos(self._finger.gameObject.transform, goPos.x, goPos.y, goPos.z)
	end

	local rotation = self._currGuide:getRotation()

	if rotation then
		Framework.TransformUtil.SetLocalRotation(self._finger.gameObject.transform, rotation[1], rotation[2], rotation[3])
	else
		Framework.TransformUtil.SetLocalRotation(self._finger.gameObject.transform, 0, 0, 0)
	end

	local ofs = self._currGuide:getWidgetOffset()
	local posX, posY, posZ = Framework.TransformUtil.GetLocalPos(self._finger.transform, nil, nil, nil)

	if ofs then
		posX = posX + (ofs[1] or 0)
		posY = posY + (ofs[2] or 0)
	end

	Framework.TransformUtil.SetLocalPos(self._finger.transform, posX, posY, posZ)

	if self._saveCanvas then
		self._finger.transform:SetParent(self._saveCanvas.transform)
	end

	self._finger.transform:SetAsLastSibling()
end

function GuideHighLightView:_endGuide_AMan_Temp()
	self._originStartGo = nil

	GuideHighLightView.super.onExitFinished(self)
	self._finger.transform:SetParent(self.mainGO.transform)
end

function GuideHighLightView:_startGuide_JingZhi()
	local params = self._currGuide:getGuideUIParams()

	printInfo(params)

	self._originStartGo = self._originStartGo or self:_getGuideWidget()

	if not self._originStartGo then
		return nil
	end

	if params then
		self._finger.gameObject:SetActive(false)
	else
		self:_handleClickEvent()
	end

	local userGuidance = self.mainGO:GetComponent("UserGuidance")
	local rect = self._originStartGo:GetComponent("RectTransform")
	local _ContentFix = self._currGuide:getContentFix()
	local offset_x, offset_y = 0, 0

	if _ContentFix then
		offset_y = _ContentFix[2]
		offset_x = _ContentFix[1]
	end

	printInfo(offset_x, offset_y)
	userGuidance:OnMaskRectShow(rect, offset_x, offset_y)

	local goPos = GameUtil.getPos(self._originStartGo.gameObject)

	Framework.TransformUtil.SetPos(self._finger.gameObject.transform, goPos.x, goPos.y, goPos.z)

	local rotation = self._currGuide:getRotation()

	if rotation then
		Framework.TransformUtil.SetLocalRotation(self._finger.gameObject.transform, rotation[1], rotation[2], rotation[3])
	else
		Framework.TransformUtil.SetLocalRotation(self._finger.gameObject.transform, 0, 0, 0)
	end

	local ofs = self._currGuide:getWidgetOffset()
	local posX, posY, posZ = Framework.TransformUtil.GetLocalPos(self._finger.transform, nil, nil, nil)

	if ofs then
		posX = posX + (ofs[1] or 0)
		posY = posY + (ofs[2] or 0)
	end

	Framework.TransformUtil.SetLocalPos(self._finger.transform, posX, posY, posZ)
end

function GuideHighLightView:_endGuide_JingZhi()
	self._originStartGo = nil

	GuideHighLightView.super.onExitFinished(self)
end

function GuideHighLightView:onExit()
	return
end

function GuideHighLightView:onExitFinished()
	self:_endGuide_AMan_Temp()
end

function GuideHighLightView:_handleClickEvent()
	if self._originStartGo == nil then
		return nil
	end

	if self:_checkPointer(self._originStartGo) then
		return nil
	end

	if self:_checkBtn(self._originStartGo) then
		return nil
	end

	local tableView = self._originStartGo:GetComponent("UITableviewForLua")

	if tableView then
		local go = self:_getObjectInTableView(tableView)
		local trs = go.transform
		local count = trs.childCount

		for i = count, 1, -1 do
			local child = trs:GetChild(i - 1)

			if self:_checkPointer(child) then
				return nil
			end

			if self:_checkBtn(child) then
				return nil
			end
		end
	end
end

function GuideHighLightView:_checkPointer(go)
	if go:GetComponent("PointerClickHandler") then
		self._clickHandler = PointerClickHandler.Get(go):AddLuaHandlerToTop(function()
			self:_onClick()
		end)

		return self._clickHandler
	end

	return nil
end

function GuideHighLightView:_checkBtn(go)
	self._saveButton = go:GetComponent("Framework.ButtonAdapter")

	if self._saveButton then
		self._saveTarget = self._saveButton:GetLuaTarget()
		self._saveCallback = self._saveButton:GetLuaHandle()

		self._saveButton:AddClickListener(self._onClick, self)
	end

	return self._saveButton
end

function GuideHighLightView:_onClick()
	local userGuidance = self.mainGO:GetComponent("UserGuidance")

	userGuidance:OnMaskRectHide()

	if self._clickHandler then
		PointerClickHandler.Get(self._originStartGo):AddRemoveLuaHandler(self._clickHandler)
	end

	if self._saveCallback then
		self._saveCallback(self._saveTarget)
		self._saveButton:GetComponent("Framework.ButtonAdapter"):AddClickListener(self._saveCallback, self._saveTarget)
	end

	GuideController.instance:finishGuide()
end

return GuideHighLightView
