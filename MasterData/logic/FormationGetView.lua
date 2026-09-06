-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/FormationGetView.lua

module("logic.extensions.itemget.FormationGetView", package.seeall)

local FormationGetView = class("FormationGetView", ViewComponent)

function FormationGetView:ctor()
	FormationGetView.super.ctor(self)
end

function FormationGetView:bindEvents()
	return
end

function FormationGetView:unbindEvents()
	return
end

function FormationGetView:buildUI()
	self._Txt_Name = goutil.findChildTextComponent(self.mainGO, "Txt_Name")
	self._formIcon = self:getGo("ImgIcon"):GetComponent("UIImageSpriteChange")
end

function FormationGetView:destroyUI()
	return
end

function FormationGetView:onEnter()
	self._openParam = self._viewPresentor._openParam

	local form = self._openParam[1].tabForm[1]
	local simpleForm = form.simpleForm
	local formId = simpleForm.formId

	self._formIcon:SetState(formId - 1)

	self._Txt_Name.text = form.tabName
end

function FormationGetView:_SetFormationName(id)
	self._Txt_Name.text = self:_GetFormationName(id)
end

function FormationGetView:_GetFormationName(formId)
	return ""
end

function FormationGetView:_onReloadFinish()
	return
end

function FormationGetView:onEnterFinished()
	return
end

function FormationGetView:onExit()
	return
end

function FormationGetView:onExitFinished()
	return
end

function FormationGetView:onClickOutside()
	return
end

return FormationGetView
