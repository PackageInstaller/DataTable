-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyInstructionView.lua

module("logic.extensions.newfamily.view.FamilyInstructionView", package.seeall)

local FamilyInstructionView = class("FamilyInstructionView", ViewComponent)

function FamilyInstructionView:ctor()
	FamilyInstructionView.super.ctor(self)
end

function FamilyInstructionView:unbindEvents()
	FamilyInstructionView.super.unbindEvents(self)
	GameUtil.asBtn(self._closeBtn):RemoveClickListener()
end

function FamilyInstructionView:bindEvents()
	FamilyInstructionView.super.bindEvents(self)
	GameUtil.asBtn(self._closeBtn):AddClickListener(self._close, self)
end

function FamilyInstructionView:onExit()
	FamilyInstructionView.super.onExit(self)
end

function FamilyInstructionView:buildUI()
	FamilyInstructionView.super.buildUI(self)

	self._imgIcon = self:getGo("Nego_Content/Nego_Top/ImgC_Con/icon")
	self._modelNameTxt = self:getTxt("Nego_Content/Nego_Top/TxtC_Name")
	self._modelDescTxt = self:getTxt("Nego_Content/Nego_Bottom/view/TxtC_Desc_1")
	self._Nego_Content = self:getGo("Nego_Content")
	self._adjustPosition = self._Nego_Content:GetComponent("UIAdjustPosition")
	self._closeBtn = self.mainGO:GetComponent("Button")
end

function FamilyInstructionView:onEnter()
	FamilyInstructionView.super.onEnter(self)

	local params = self:getOpenParam()

	self:_initTips(params)
end

function FamilyInstructionView:_close()
	self:close()
end

function FamilyInstructionView:_initTips(params)
	local medalId = params[1]
	local iconGo = params[2]
	local cfg = FamilyHonorConfig.instance:getFamilyMedalCfg(medalId)
	local iconPath = "ui/bigbg/familycallorder/" .. cfg.icon .. ".png"

	self._modelNameTxt.text = cfg.name
	self._modelDescTxt.text = cfg.desc

	uGuiUtil.setSpriteToImage(self._imgIcon, uGuiUtil.SpriteType.BigBg, iconPath)
	self:_setTipsPos(iconGo)
end

function FamilyInstructionView:_setTipsPos(goOrPos)
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

return FamilyInstructionView
