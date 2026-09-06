-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiInstructionView.lua

module("logic.extensions.shenjichallenge.view.ShenJiInstructionView", package.seeall)

local ShenJiInstructionView = class("ShenJiInstructionView", ViewComponent)

function ShenJiInstructionView:ctor()
	ShenJiInstructionView.super.ctor(self)
end

function ShenJiInstructionView:buildUI()
	ShenJiInstructionView.super.buildUI(self)

	self._imgIcon = self:getGo("Nego_Content/Nego_Top/ImgC_Con/icon")
	self._modelNameTxt = self:getTxt("Nego_Content/Nego_Top/TxtC_Name")
	self._modelDescTxt = self:getTxt("Nego_Content/Nego_Bottom/view/TxtC_Desc_1")
	self._Nego_Content = self:getGo("Nego_Content")
	self._adjustPosition = self._Nego_Content:GetComponent("UIAdjustPosition")
	self._closeBtn = self.mainGO:GetComponent("Button")
end

function ShenJiInstructionView:bindEvents()
	ShenJiInstructionView.super.bindEvents(self)
	GameUtil.asBtn(self._closeBtn):AddClickListener(self.close, self)
end

function ShenJiInstructionView:unbindEvents()
	ShenJiInstructionView.super.unbindEvents(self)
	GameUtil.asBtn(self._closeBtn):RemoveClickListener()
end

function ShenJiInstructionView:onEnter()
	ShenJiInstructionView.super.onEnter(self)

	self._instructionMo = self:getFirstParam()

	self:_initTips()
end

function ShenJiInstructionView:onExit()
	ShenJiInstructionView.super.onExit(self)

	self._instructionMo.posGo = nil
	self._instructionMo = nil
end

function ShenJiInstructionView:_initTips()
	self._modelNameTxt.text = self._instructionMo.name
	self._modelDescTxt.text = self._instructionMo.desc

	uGuiUtil.setSpriteToImage(self._imgIcon, uGuiUtil.SpriteType.BigBg, self._instructionMo.iconPath)
	self:_setTipsPos(self._instructionMo.posGo)
end

function ShenJiInstructionView:_setTipsPos(goOrPos)
	local pos
	local sizeDelta = {
		0,
		0
	}

	if goOrPos and goOrPos.gameObject then
		local rect = goOrPos.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = goOrPos.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	if pos then
		GameUtil.SetActive(self.mainGO, false)
		settimer(0.1, function()
			GameUtil.SetActive(self.mainGO, true)
			Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
			self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
		end, nil, false)
	else
		Framework.TransformUtil.SetLocalPos(self._Nego_Content.transform, 0, 0, 0)
	end
end

return ShenJiInstructionView
